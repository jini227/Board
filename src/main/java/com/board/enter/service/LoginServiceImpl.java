package com.board.enter.service;

import com.common.dao.Dao;
import com.common.dto.enter.MemberDto;
import com.common.dto.enter.SignUpDto;
import com.common.utils.AES256Util;
import com.common.utils.SHA256Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private Dao dao;

    @Override
    public void registMember(SignUpDto signUpDto) {
        // 암호화를 위한 salt 생성
        String salt = SHA256Util.getSalt();

        try {
            // 비밀번호 SHA-256
            signUpDto.setPassword(SHA256Util.SHA256Encrypt(signUpDto.getPassword(), salt));

            // 연락처, 이메일 AES-256
            AES256Util aes256util = new AES256Util("1234123412341234");
            signUpDto.setEmail(aes256util.encrypt(signUpDto.getEmail()));
            signUpDto.setPhone(aes256util.encrypt(signUpDto.getPhone()));

            SignUpDto signUpMemberDto = new SignUpDto(
                    signUpDto.getId(),
                    signUpDto.getPassword(),
                    signUpDto.getName(),
                    signUpDto.getPhone(),
                    signUpDto.getEmail(),
                    salt);

            dao.registMember(signUpMemberDto);

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    @Override
    public int idChk(String id) {
        int result = dao.idChk(id);

        return result;
    }

    @Override
    public MemberDto getMemberInfo(String id) {
        MemberDto memberInfo = dao.getMemberInfo(id);

        return memberInfo;
    }


}
