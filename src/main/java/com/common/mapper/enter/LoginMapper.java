package com.common.mapper.enter;

import com.common.dto.enter.MemberDto;
import com.common.dto.enter.SignUpDto;

public interface LoginMapper {

    // 회원 가입
    void insertMember(SignUpDto signUpMemberDto);

    // 아이디 중복 체크 || 로그인 아이디 체크
    int idChk(String id);

    // 회원 정보 가져오기
    MemberDto getMemberInfo(String id);
}
