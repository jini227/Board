package com.board.myPage.controller;

import com.board.myPage.service.MyPageService;
import com.common.dto.board.BoardDto;
import com.common.dto.enter.MemberDto;
import com.common.utils.AES256Util;
import com.common.utils.SHA256Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;

@Controller
public class MyPageController {

    @Autowired
    public MyPageService myPageService;

    // 마이페이지 호출
    @RequestMapping(value="myPage/{loginSeq}", method= RequestMethod.GET)
    public String myPage(@PathVariable("loginSeq") int seq, Model model, HttpSession session) throws UnsupportedEncodingException, GeneralSecurityException {

        MemberDto memberInfo = (MemberDto)session.getAttribute("memberAuthInfo");

        try {
            // 연락처, 이메일 복호화
            AES256Util aes256util = new AES256Util("1234123412341234");
            String phone = (aes256util.decrypt(memberInfo.getPhone()));
            String email = (aes256util.decrypt(memberInfo.getEmail()));
            model.addAttribute("phone",phone);
            model.addAttribute("email",email);

            List<BoardDto> lostPosts = myPageService.getMyPosts(seq, "lost");
            model.addAttribute("lostPosts", lostPosts);

            List<BoardDto> findPosts = myPageService.getMyPosts(seq, "find");
            model.addAttribute("findPosts", findPosts);

        } catch (Exception e) {
            System.out.println("MyPageController 마이페이지 호출 로직 실행 중 error : " + e.getMessage());
            return "index";
        }

        return "myPage/myPage";
    }

    // 비밀번호 변경 페이지 호출
    @RequestMapping(value="myPage/password/{loginSeq}", method= RequestMethod.GET)
    public String passwordPage(@PathVariable("loginSeq") int seq, HttpSession session, MemberDto memberDto) {

        return "myPage/passwordModify";
    }

    // 비밀번호 변경
    @RequestMapping(value="myPage/password/{loginSeq}", method= RequestMethod.POST)
    public String updatePassword(@PathVariable("loginSeq") int seq, HttpSession session, MemberDto memberDto, Model model) {

        MemberDto memberInfo = (MemberDto)session.getAttribute("memberAuthInfo");

        try {
            String salt = memberInfo.getSalt(); // salt 값 가져오기
            String pwd = memberDto.getPassword(); // 입력한 현재 비밀번호 값 가져오기
            String userPwd = SHA256Util.SHA256Encrypt(pwd, salt);

            if (memberInfo.getPassword().equals(userPwd)) {
                memberDto.setSeq(seq);
                myPageService.updatePassword(memberDto);
                model.addAttribute("msg", "비밀번호가 변경 되었습니다.");
            } else {
                model.addAttribute("msg", "현재 비밀번호가 일치하지 않습니다.");
                return "myPage/passwordModify";
            }

        } catch (Exception e) {
            System.out.println("MyPageController 비밀번호 변경 로직 실행 중 error : " + e.getMessage());
            return "myPage/passwordModify";
        }

        return "redirect:/myPage/"+seq;
    }

    // 정보 변경 페이지 호출
    @RequestMapping(value="myPage/myInfo/{loginSeq}", method= RequestMethod.GET)
    public String myInfoPage(@PathVariable("loginSeq") int seq, HttpSession session, Model model, MemberDto memberDto) {

        MemberDto memberInfo = (MemberDto)session.getAttribute("memberAuthInfo");

        try {
            // 연락처, 이메일 복호화
            AES256Util aes256util = new AES256Util("1234123412341234");
            String phone = (aes256util.decrypt(memberInfo.getPhone()));
            String email = (aes256util.decrypt(memberInfo.getEmail()));
            model.addAttribute("phone",phone);
            model.addAttribute("email",email);

        } catch (Exception e) {
            System.out.println("MyPageController 비밀번호 변경 로직 실행 중 error : " + e.getMessage());
            return "redirect:/myPage/"+seq;
        }

        return "myPage/myInfoModify";
    }

    // 정보 변경
    @RequestMapping(value="myPage/myInfo/{loginSeq}", method= RequestMethod.POST)
    public String updateMyInfo(@PathVariable("loginSeq") int seq, HttpSession session, MemberDto memberDto) {

        try {
            myPageService.updateMyInfo(memberDto, session);

        } catch (Exception e) {
            System.out.println("MyPageController 비밀번호 변경 로직 실행 중 error : " + e.getMessage());
            return "redirect:/myPage/myInfo/"+seq;
        }

        return "redirect:/myPage/"+seq;
    }


}
