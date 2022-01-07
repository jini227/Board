package com.common.dao;

import com.common.dto.board.BoardCommentDto;
import com.common.dto.board.BoardDto;
import com.common.dto.board.BoardImgDto;
import com.common.dto.enter.MemberDto;
import com.common.dto.enter.SignUpDto;
import com.common.dto.main.MainDto;
import com.common.mapper.board.BoardMapper;
import com.common.mapper.enter.LoginMapper;
import com.common.mapper.main.MainMapper;
import com.common.mapper.myPage.MyPageMapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class Dao {

    @Autowired
    private SqlSession sqlSession;



    /* BOARD - MAIN */
    // 메인페이지 불러오기
    public MainDto selectMain() {
        MainMapper mapper = sqlSession.getMapper(MainMapper.class);
        MainDto mainDto = mapper.selectMain();

        return mainDto;
    }

    /* BOARD - ENTER */
    // 회원 가입
    public void registMember(SignUpDto signUpMemberDto) {
        LoginMapper mapper = sqlSession.getMapper(LoginMapper.class);
        mapper.insertMember(signUpMemberDto);
    }

    // 아이디 중복 체크 || 로그인 아이디 체크
    public int idChk(String id) {
        LoginMapper mapper = sqlSession.getMapper(LoginMapper.class);
        int result = mapper.idChk(id);

        return result;
    }

    // 회원 정보 가져오기
    public MemberDto getMemberInfo(String id) {
        LoginMapper mapper = sqlSession.getMapper(LoginMapper.class);
        MemberDto memberInfo = mapper.getMemberInfo(id);

        return memberInfo;
    }

    /* BOARD - BOARD */

    // 게시판 리스트 페이지 불러오기
    public List<BoardDto> getBoardList(BoardDto boardDto) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);

        return mapper.getBoardList(boardDto);
    }

    // 게시물 등록
    public int registBoard(BoardDto boardDto) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
        mapper.insertBoard(boardDto);

        return boardDto.getSeq();
    }

    // 등록한 게시물 첨부파일 DB 등록
    public void registBoardImg(BoardImgDto uVo) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
        mapper.insertBoardImg(uVo);
    }

    // 썸네일 등록
    public void updateThumnailFile(BoardDto boardDto) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
        mapper.updateThumbnailFile(boardDto);
    }

    // 조회수 증가
    public void updateHits(int seq) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
        mapper.updateHits(seq);
    }

    // 상세페이지 DB 가져오기 - board
    public BoardDto getBoardDetail(int seq) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);

        return mapper.getBoardDetail(seq);
    }

    // 상세페이지 DB 가져오기 - image
    public List<BoardImgDto> getBoardDetailImages(int seq) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);

        return mapper.getBoardDetailImages(seq);
    }

    // 상세페이지 DB 가져오기 - comment
    public List<BoardCommentDto> getBoardComments(int seq) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);

        return mapper.getBoardDetailComments(seq);
    }

    // 게시글 DB 수정
    public void updateBoard(BoardDto boardDto) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
        mapper.updateBoard(boardDto);
    }

    // 게시글 img DB 삭제
    public void deleteImg(int seq) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
        mapper.deleteImg(seq);
    }

    // 게시글 전체 img DB 삭제
    public void deleteAllImg(int seq) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
        mapper.deleteAllImg(seq);
    }

    // 게시글 전체 댓글 삭제
    public void deleteAllComment(int seq) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
        mapper.deleteAllComment(seq);
    }

    // 게시글 DB 삭제
    public void deleteBoard(int seq) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
        mapper.deleteBoard(seq);
    }

    // 발견완료/미발견 상태 변경
    public void updateState(BoardDto boardDto) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
        mapper.updateState(boardDto);
    }

    // 후기 추가
    public void updateReview(BoardDto boardDto) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
        mapper.updateReview(boardDto);
    }

    // 댓글 추가
    public void writeComment(BoardCommentDto comment) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
        mapper.writeComment(comment);
    }

    // 댓글 수정
    public void modifyComment(BoardCommentDto comment) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
        mapper.modifyComment(comment);
    }

    // 댓글 삭제
    public void deleteComment(int seq) {
        BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
        mapper.deleteComment(seq);
    }

    // 마이페이지 게시글 가져오기
    public List<BoardDto> getMyPosts(BoardDto boardDto) {
        MyPageMapper mapper = sqlSession.getMapper(MyPageMapper.class);

        return mapper.getMyPosts(boardDto);
    }

    // 마이페이지 비밀번호 변경
    public void updatePassword(MemberDto memberDto) {
        MyPageMapper mapper = sqlSession.getMapper(MyPageMapper.class);
        mapper.updatePassword(memberDto);
    }

    // 마이페이지 정보 변경
    public void updateMyInfo(MemberDto memberDto) {
        MyPageMapper mapper = sqlSession.getMapper(MyPageMapper.class);
        mapper.updateMyInfo(memberDto);
    }

}
