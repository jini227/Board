package com.common.mapper.board;

import com.common.dto.board.BoardCommentDto;
import com.common.dto.board.BoardDto;
import com.common.dto.board.BoardImgDto;

import java.util.List;

public interface BoardMapper {

    // 페이징
    int searchLostCount(BoardDto boardDto);

    // 게시물 리스트 조회
    List<BoardDto> getBoardList(BoardDto boardDto);

    // 게시물 등록
    int insertBoard(BoardDto boardDto);

    // 등록한 게시물 첨부파일 DB 등록
    void insertBoardImg(BoardImgDto uVo);

    // 게시물 썸네일 DB 등록
    void updateThumbnailFile(BoardDto boardDto);

    // 조회수 증가
    void updateHits(int seq);

    // 게시물 상세 정보 조회 - board
    BoardDto getBoardDetail(int seq);

    // 게시물 상세 정보 조회 - image
    List<BoardImgDto> getBoardDetailImages(int seq);

    // 게시물 상세 정보 조회 - comments
    List<BoardCommentDto> getBoardDetailComments(int seq);

    // 게시물 수정
    void updateBoard(BoardDto boardDto);

    // 게시물 img DB 삭제
    void deleteImg(int seq);

    // 전체 이미지 DB 삭제
    void deleteAllImg(int seq);

    // 게시물 전체 댓글 삭제
    void deleteAllComment(int seq);

    // 게시물 DB 삭제
    void deleteBoard(int seq);

    // 발견완료/미발견 상태변경
    void updateState(BoardDto boardDto);

    // 후기 추가
    void updateReview(BoardDto boardDto);

    // 댓글 추가
    void writeComment(BoardCommentDto comment);

    // 댓글 수정
    void modifyComment(BoardCommentDto comment);

    // 댓글 삭제
    void deleteComment(int seq);

}
