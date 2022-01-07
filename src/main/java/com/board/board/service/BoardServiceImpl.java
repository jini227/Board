package com.board.board.service;

import com.common.dao.Dao;
import com.common.dto.board.BoardCommentDto;
import com.common.dto.board.BoardDto;
import com.common.dto.board.BoardImgDto;
import com.common.dto.paging.SearchCriteriaMainBoard;
import com.common.utils.AES256Util;
import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.UUID;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private Dao dao;

    @Override
    public List<BoardDto> getBoardList(SearchCriteriaMainBoard cri, BoardDto boardDto) {

        boardDto.setRowStart(cri.getRowStart());
        boardDto.setRowEnd(cri.getRowEnd());

        List<BoardDto> posts = dao.getBoardList(boardDto);

        return posts;
    }

    @Override
    public void registBoard(String contentsType, BoardDto boardDto, HttpSession session, MultipartHttpServletRequest request) {

        try {
            // session에 있는 로그인 seq 가져오기
            int seq = (int) session.getAttribute("loginSeq");

            String term = boardDto.getTerm();
            String phone_public = "공개";
            String email_public = "공개";

            if (term == null) {
                phone_public = "비공개";
                email_public = "비공개";
            } else if (term.equals("phoneAgree")) { // 연락처만 공개
                email_public = "비공개";
            } else if (term.equals("emailAgree")) { // 이메일만 공개
                phone_public = "비공개";
            }

            boardDto.setMember_seq(seq); // 글 작성자 member 테이블의 seq
            boardDto.setContents_type(contentsType);
            boardDto.setPhone_public(phone_public);
            boardDto.setEmail_public(email_public);

            int boardSeq = dao.registBoard(boardDto);
            System.out.println("[LOG] DB 등록 완료 | SEQ : " + boardSeq);

            MultipartFile[] imgs = boardDto.getImg();
            String originalFile = null;
            String originalFileExtension = null;
            String storedFileName = null;
            String filePath = null;

            int thumb = 0;
            int num = imgs.length;
            filePath = request.getSession().getServletContext().getRealPath("resources/imgUpload");

            for (MultipartFile f : imgs) {
                BoardImgDto uVo = new BoardImgDto();
                originalFile = f.getOriginalFilename();
                originalFileExtension = originalFile.substring(originalFile.lastIndexOf("."));
                storedFileName = UUID.randomUUID().toString().replace("-", "") + originalFileExtension;
                File file = new File(filePath, storedFileName);
                f.transferTo(file);

                uVo.setBoard_seq(boardSeq);
                uVo.setOriginal_file(originalFile);
                uVo.setOriginal_file_extension(originalFileExtension);
                uVo.setStored_file_name(storedFileName);
                dao.registBoardImg(uVo);
                System.out.println("[LOG] 첨부파일 DB 저장 | 파일명 : " + originalFile);

                if (thumb == 0) {
                    String thumbnailName = createThumbnail(filePath, storedFileName);
                    boardDto.setSeq(boardSeq);
                    boardDto.setThumbnail_file_name(thumbnailName);
                    dao.updateThumnailFile(boardDto);
                    System.out.println("[LOG] 썸네일 DB 등록 완료");
                }
                thumb = 1;
            }
            System.out.println("[LOG] 첨부파일 DB 등록 완료");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public BoardDto getBoardDetail(int seq) throws UnsupportedEncodingException, GeneralSecurityException {

        // 조회수 증가
        dao.updateHits(seq);

        // 상세페이지 DB 불러오기(board, image, comments)
        BoardDto detail = dao.getBoardDetail(seq);
        detail.setImages(dao.getBoardDetailImages(seq));
        detail.setComments(dao.getBoardComments(seq));

        // 연락처, 이메일 복호화
        AES256Util aes256util = new AES256Util("1234123412341234");
        detail.setPhone(aes256util.decrypt(detail.getPhone()));
        detail.setEmail(aes256util.decrypt(detail.getEmail()));

        return detail;
    }

    @Override
    public BoardDto getBoardModify(int seq) {

        // 수정페이지 DB 불러오기(board, image)
        BoardDto detail = dao.getBoardDetail(seq);
        detail.setImages(dao.getBoardDetailImages(seq));

        return detail;
    }

    @Override
    public void updateBoard(BoardDto boardDto, MultipartHttpServletRequest request) throws IOException {

        // board DB 수정
        dao.updateBoard(boardDto);

        // image DB 수정 (boardDto.getImg() : 신규 이미지 DB | boardDto.getImages() 기존 이미지 DB)
        if (boardDto.getImg() != null || boardDto.getModifyFile().length != boardDto.getImages().size()) {
            int seq = boardDto.getSeq();

            // 첨부파일 삭제
            List<BoardImgDto> prevImg = boardDto.getImages();
            String[] modifyImg = boardDto.getModifyFile();
            String chkImg = "";

            if (modifyImg == null) { // 기존 첨부파일 전체 삭제
                for (BoardImgDto prev : prevImg) {
                    int prevSeq = prev.getSeq();
                    dao.deleteImg(prevSeq);
                    System.out.println("[LOG] 첨부파일 DB 전체 삭제 | SEQ : " + prevSeq);
                }
            } else { // 기존 첨부파일 일부 삭제
                for (BoardImgDto prev : prevImg) {
                    String prevName = prev.getStored_file_name();
                    for (String modifyName : modifyImg) {
                        if (prevName.equals(modifyName)) {
                            chkImg = "same";
                            break;
                        } else {
                            chkImg = "";
                        }
                    }
                    if (!chkImg.equals("same")) {
                        int prevSeq = prev.getSeq();
                        dao.deleteImg(prevSeq);
                        System.out.println("[LOG] 첨부파일 DB 일부 삭제 | SEQ : " + prevSeq);
                    }
                }
            }

            // 첨부파일 저장 및 썸네일 설정
            if (boardDto.getImg() != null) {
                MultipartFile[] imgs = boardDto.getImg();
                String originalFile = null;
                String originalFileExtension = null;
                String storedFileName = null;
                String filePath = null;

                int thumb = 0;
                int num = imgs.length;
                filePath = request.getSession().getServletContext().getRealPath("resources/imgUpload");

                for (MultipartFile f : imgs) {
                    BoardImgDto uVo = new BoardImgDto();
                    originalFile = f.getOriginalFilename();
                    originalFileExtension = originalFile.substring(originalFile.lastIndexOf("."));
                    storedFileName = UUID.randomUUID().toString().replace("-", "") + originalFileExtension;
                    File file = new File(filePath, storedFileName);
                    f.transferTo(file);

                    uVo.setBoard_seq(seq);
                    uVo.setOriginal_file(originalFile);
                    uVo.setOriginal_file_extension(originalFileExtension);
                    uVo.setStored_file_name(storedFileName);
                    dao.registBoardImg(uVo);
                    System.out.println("[LOG] 첨부파일 DB 저장 | BOARD_SEQ : " + seq);

                    if (thumb == 0) {
                        String thumbnailName = createThumbnail(filePath, storedFileName);
                        boardDto.setSeq(seq);
                        boardDto.setThumbnail_file_name(thumbnailName);
                        dao.updateThumnailFile(boardDto);
                        System.out.println("[LOG] 썸네일 DB 등록 완료");
                    }
                    thumb = 1;
                }
            } else {
                System.out.println("[LOG] 추가 된 첨부파일 없음");
            }
        } else {
            System.out.println("[LOG] 첨부파일 변동사항 없음");
        }
    }

    @Override
    public void deleteBoard(int seq) {

        // 첨부파일 DB 삭제
        dao.deleteAllImg(seq);
        System.out.println("[LOG] 첨부파일 DB 삭제 완료");

        // 댓글 DB 삭제
        dao.deleteAllComment(seq);
        System.out.println("[LOG] 댓글 DB 삭제 완료");

        // 게시글 DB 삭제
        dao.deleteBoard(seq);
        System.out.println("[LOG] DB 삭제 완료");
    }

    @Override
    public void updateState(BoardDto boardDto) {

        dao.updateState(boardDto); // 발견/미발견 상태변경

    }

    @Override
    public void updateReview(BoardDto boardDto) {

        dao.updateReview(boardDto);
    }

    @Override
    public void writeComment(BoardCommentDto comment) {

        dao.writeComment(comment);
    }

    @Override
    public List<BoardCommentDto> getCommentList(int boardSeq) {

        List<BoardCommentDto> comments = dao.getBoardComments(boardSeq);

        return comments;
    }

    @Override
    public void modifyComment(BoardCommentDto comment) {

        dao.modifyComment(comment);
    }

    @Override
    public void deleteComment(int seq) {

        dao.deleteComment(seq);
    }


    // 썸네일 만들기
    private String createThumbnail(String filePath, String storedFileName) throws IOException {

        BufferedImage sourceImg = ImageIO.read(new File(filePath, storedFileName)); // 저장된 원본파일로부터 BufferedImage 객체를 생성
        BufferedImage destImg = Scalr.resize(sourceImg, 200, 250); // 썸네일 높이(250), 너비(200) 리사이징

        String thumbnailName = "s_" + storedFileName; // db에 저장될 썸네일파일명
        String thumbnailPath = filePath + File.separator + "s_" + storedFileName; // 썸네일 저장(이미지 이름 앞에 "s_" 붙임)
        File newFile = new File(thumbnailPath);
        String formatName = storedFileName.substring(storedFileName.lastIndexOf(".") + 1); // 썸네일 파일 형식

        ImageIO.write(destImg, formatName.toUpperCase(), newFile);
        thumbnailPath.substring(filePath.length()).replace(File.separatorChar, '/');

        return thumbnailName;
    }
}
