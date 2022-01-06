package com.board.myPage.service;

import com.common.dao.Dao;
import com.common.dto.board.BoardDto;
import com.common.dto.enter.MemberDto;
import com.common.utils.AES256Util;
import com.common.utils.SHA256Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;

@Service
public class MyPageServiceImpl implements MyPageService {

    @Autowired
    private Dao dao;

    @Override
    public List<BoardDto> getMyPosts(int seq, String type) {

        BoardDto boardDto = new BoardDto();
        boardDto.setMember_seq(seq);
        boardDto.setContents_type(type);

        List<BoardDto> lostPosts = dao.getMyPosts(boardDto);

        return lostPosts;
    }

    @Override
    public void updatePassword(MemberDto memberDto) throws Exception {

        // 비밀번호 암호화
        memberDto.setSalt(SHA256Util.getSalt());
        memberDto.setPasswordNew(SHA256Util.SHA256Encrypt(memberDto.getPasswordNew(),memberDto.getSalt()));

        dao.updatePassword(memberDto);

    }

    @Override
    public void updateMyInfo(MemberDto memberDto, HttpSession session) throws UnsupportedEncodingException, GeneralSecurityException {

        // 연락처, 이메일 암호화
        AES256Util aes256Util = new AES256Util("1234123412341234");
        memberDto.setEmail(aes256Util.encrypt(memberDto.getEmail()));
        memberDto.setPhone(aes256Util.encrypt(memberDto.getPhone()));

        dao.updateMyInfo(memberDto);

        // 세션에 정보 업데이트
        MemberDto memberInfo = (MemberDto)session.getAttribute("memberAuthInfo");
        memberInfo.setEmail(memberDto.getEmail());
        memberInfo.setPhone(memberDto.getPhone());
        memberInfo.setName(memberDto.getName());

        session.setAttribute("memberAuthInfo", memberInfo);

    }
}
