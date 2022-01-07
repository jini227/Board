package com.board.board.service;

import com.common.dto.board.BoardCommentDto;
import com.common.dto.board.BoardDto;
import com.common.dto.paging.SearchCriteriaMainBoard;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;

public interface BoardService {

    // 리스트페이지 호출
    public List<BoardDto> getBoardList(SearchCriteriaMainBoard cri, BoardDto boardDto);

    // 게시물 등록
    public void registBoard(String contentsType, BoardDto boardDto, HttpSession session, MultipartHttpServletRequest request);

    // 상세페이지 호출
    public BoardDto getBoardDetail(int seq) throws UnsupportedEncodingException, GeneralSecurityException;

    // 수정 페이지 호출 시 필요한 DB 불러오기
    public BoardDto getBoardModify(int seq);

    // 게시물 수정
    public void updateBoard(BoardDto boardDto, MultipartHttpServletRequest request) throws IOException;

    // 상세페이지 - 게시물 삭제
    public void deleteBoard(int seq);

    // 상세페이지 - 발견/미발견
    public void updateState(BoardDto boardDto);

    // 상세페이지 - 후기 작성
    public void updateReview(BoardDto boardDto);

    // 상세페이지 - 댓글 작성
    public void writeComment(BoardCommentDto comment);

    // 상세페이지 - 댓글 목록 조회
    List<BoardCommentDto> getCommentList(int boardSeq);

    // 상세페이지 - 댓글 수정
    void modifyComment(BoardCommentDto comment);

    // 상세페이지 - 댓글 삭제
    void deleteComment(int seq);

}
