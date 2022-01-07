package com.board.board.controller;

import com.board.board.service.BoardService;
import com.common.dto.board.BoardCommentDto;
import com.common.dto.board.BoardDto;
import com.common.dto.paging.PageMakerMainBoard;
import com.common.dto.paging.SearchCriteriaMainBoard;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class BoardController {

    @Autowired
    public BoardService boardService;

    // 검색 ajax
    @ResponseBody
    @RequestMapping(value = "/board/boardList/search", method = RequestMethod.POST)
    public List<BoardDto> methodName(@ModelAttribute BoardDto boardDto, SearchCriteriaMainBoard cri) throws Exception {

        List<BoardDto> posts = boardService.getBoardList(cri, boardDto);

        return posts;
    }

    // 게시판 리스트페이지 호출
    @RequestMapping(value = "/board/boardList/{contentsType}", method = RequestMethod.GET)
    public String listPage(@PathVariable("contentsType") String contentsType, BoardDto boardDto,
                           @ModelAttribute("cri") SearchCriteriaMainBoard cri, Model model) {

        try {
            boardDto.setContents_type(contentsType);
            List<BoardDto> posts = boardService.getBoardList(cri, boardDto);
            model.addAttribute("posts", posts);

            PageMakerMainBoard pageMaker = new PageMakerMainBoard();
            pageMaker.setCri(cri);
            pageMaker.setTotalCount(posts.size());
            model.addAttribute("pageMaker", pageMaker);

            return "board/boardList";
        } catch (Exception e) {
            System.out.println("BoardController 리스트페이지 호출 로직 실행 중 error : " + e.getMessage());
            return "index";
        }
    }

    // 게시판 글작성 페이지 호출
    @RequestMapping(value = "/board/boardWrite/{contentsType}", method = RequestMethod.GET)
    public String WritePage(@PathVariable String contentsType, BoardDto boardDto) {

        return "board/boardWrite";
    }

    // 게시물 등록
    @RequestMapping(value = "/board/boardWrite/{contentsType}", method = RequestMethod.POST)
    public String registBoard(@PathVariable String contentsType, BoardDto boardDto, HttpSession session, MultipartHttpServletRequest request) {

        try {
            boardService.registBoard(contentsType, boardDto, session, request);
        } catch (Exception e) {
            System.out.println("BoardController 등록 로직 실행 중 error : " + e.getMessage());

            return "board/boardWrite";
        }

        return "redirect:/board/boardList/" + contentsType;
    }

    // 상세페이지 호출
    @RequestMapping(value = "board/boardDetail/{seq}", method = RequestMethod.GET)
    public String getBoardDetail(@PathVariable("seq") int seq, Model model, HttpSession session) {

        try {
            // 상세페이지 DB 가져오기 - board, image, comments
            BoardDto detail = boardService.getBoardDetail(seq);
            model.addAttribute("detail", detail);
        } catch (Exception e) {
            System.out.println("BoardController 상세페이지 호출 로직 실행 중 error : " + e.getMessage());
        }
        return "board/boardDetail";
    }

    // 게시물 수정 페이지 호출
    @RequestMapping(value = "board/boardModify/{seq}", method = RequestMethod.GET)
    public String getBoardModify(@PathVariable("seq") int seq, BoardDto boardDto, Model model) {
        try {
            BoardDto detail = boardService.getBoardModify(seq);
            model.addAttribute("detail", detail);
        } catch (Exception e) {
            System.out.println("BoardController 게시물 수정 페이지 호출 로직 실행 중 error : " + e.getMessage());
        }

        return "board/boardModify";
    }

    // 게시물 수정
    @RequestMapping(value = "board/boardModify/{seq}", method = RequestMethod.POST)
    public String updateBoard(@PathVariable("seq") int seq, BoardDto boardDto, MultipartHttpServletRequest request) {
        try {
            // 이미지 변경을 위한 기존 이미지 DB 세팅
            BoardDto detail = boardService.getBoardModify(seq);
            boardDto.setImages(detail.getImages());

            boardService.updateBoard(boardDto, request);
        } catch (Exception e) {
            System.out.println("BoardController 게시물 수정 로직 실행 중 error : " + e.getMessage());
        }

        return "redirect:/board/boardDetail/" + seq;
    }

    // 게시물 삭제
    @RequestMapping(value = "board/boardDelete/{seq}&{contentsType}", method = RequestMethod.GET)
    public String deleteBoard(@PathVariable("seq") int seq, @PathVariable("contentsType") String contentsType) {
        try {
            boardService.deleteBoard(seq);
        } catch (Exception e) {
            System.out.println("BoardController 게시물 삭제 로직 실행 중 error : " + e.getMessage());
        }

        return "redirect:/board/boardList/" + contentsType;
    }

    // 발견완료/미발견 상태 변경 ajax
    @ResponseBody
    @RequestMapping(value = "board/boardDetail/updateState", method = RequestMethod.GET)
    public int methodName(@ModelAttribute BoardDto boardDto) throws Exception {

        int result = boardDto.getPet_meet();
        boardService.updateState(boardDto);

        return result;
    }

    // 후기 추가
    @RequestMapping(value = "board/updateReview/{seq}", method = RequestMethod.POST)
    public String updateReview(@PathVariable("seq") int seq, BoardDto boardDto) {
        try {
            boardService.updateReview(boardDto);
        } catch (Exception e) {
            System.out.println("BoardController 후기 등록 로직 실행 중 error : " + e.getMessage());
        }
        return "redirect:/board/boardDetail/" + seq;
    }

    // 댓글 추가
    @ResponseBody
    @RequestMapping(value = "board/boardDetail/writeComment", method = RequestMethod.POST)
    public int writeReview(@RequestParam("loginSeq") int loginSeq, @RequestParam("boardSeq") int boardSeq, @RequestParam("text") String memo) {

        int result = 0;

        BoardCommentDto comment = new BoardCommentDto();
        comment.setMember_seq(loginSeq);
        comment.setBoard_seq(boardSeq);
        comment.setMemo(memo);

        try {
            boardService.writeComment(comment);
            result = 1;
        } catch (Exception e) {
            System.out.println("BoardController 댓글 등록 로직 실행 중 error : " + e.getMessage());
        }
        return result;
    }

    // 댓글 목록 조회
    @ResponseBody
    @RequestMapping(value = "board/boardDetail/commentList", method = RequestMethod.POST)
    public List<BoardCommentDto> getCommentList(@RequestParam("boardSeq") int boardSeq) {

        List<BoardCommentDto> comments = boardService.getCommentList(boardSeq);

        return comments;
    }

    // 댓글 수정
    @ResponseBody
    @RequestMapping(value = "board/boardDetail/modifyComment", method = RequestMethod.POST)
    public int modifyComment(@RequestParam("seq") int seq, @RequestParam("memo") String memo) {
        int result = 0;

        BoardCommentDto comment = new BoardCommentDto();
        comment.setSeq(seq);
        comment.setMemo(memo);

        try {
            boardService.modifyComment(comment);
            result = 1;
        } catch (Exception e) {
            System.out.println("BoardController 댓글 수정 로직 실행 중 error : " + e.getMessage());
        }

        return result;
    }

    // 댓글 삭제
    @ResponseBody
    @RequestMapping(value = "board/boardDetail/deleteComment", method = RequestMethod.GET)
    public int deleteComment(@RequestParam("seq") int seq) {
        int result = 0;

        try {
            boardService.deleteComment(seq);
            result = 1;
        } catch (Exception e) {
            System.out.println("BoardController 댓글 수정 로직 실행 중 error : " + e.getMessage());
        }

        return result;
    }

}

