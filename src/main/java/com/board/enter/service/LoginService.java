package com.board.enter.service;

import com.common.dto.enter.MemberDto;
import com.common.dto.enter.SignUpDto;

public interface LoginService {

    // 회원 가입
    public void registMember(SignUpDto signUpDto);

    // 아이디 중복 체크 || 로그인 아이디 체크(1:성공 0:실패)
    public int idChk(String id);

    // 회원 정보 가져오기
    MemberDto getMemberInfo(String id);
}
