package com.common.mapper.myPage;

import com.common.dto.board.BoardDto;
import com.common.dto.enter.MemberDto;

import java.util.List;

public interface MyPageMapper {

    List<BoardDto> getMyPosts(BoardDto boardDto);

    void updatePassword(MemberDto memberDto);

    void updateMyInfo(MemberDto memberDto);
}
