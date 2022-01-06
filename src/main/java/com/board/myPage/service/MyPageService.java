package com.board.myPage.service;

import com.common.dto.board.BoardDto;
import com.common.dto.enter.MemberDto;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;

public interface MyPageService {

    // 마이페이지 작성한 게시글 가져오기
    List<BoardDto> getMyPosts(int seq, String type);

    // 비밀번호 변경
    void updatePassword(MemberDto memberDto) throws Exception;

    void updateMyInfo(MemberDto memberDto, HttpSession session) throws UnsupportedEncodingException, GeneralSecurityException;
}
