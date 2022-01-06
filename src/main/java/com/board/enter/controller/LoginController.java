package com.board.enter.controller;

import com.board.enter.service.LoginService;
import com.common.dto.enter.MemberDto;
import com.common.dto.enter.SignUpDto;
import com.common.utils.SHA256Util;
import com.common.vaildation.signup.SignUpValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    public LoginService loginService;

    // 회원가입 페이지 불러오기
    @RequestMapping(value = "/enter/signUp", method = RequestMethod.GET)
    public String signUpPage(Model model, SignUpDto signUpDto) {
        model.addAttribute("signUpDto", new SignUpDto());

        return "enter/signUp";
    }

    // 회원 가입
    @RequestMapping(value = "/enter/signUp", method = RequestMethod.POST)
    public String handlerStep(@ModelAttribute("signUpDto") SignUpDto signUpDto, Errors errors) {

        try {
            new SignUpValidator().validate(signUpDto, errors);
            if (errors.hasErrors()) {
                return "enter/signUp";
            }

            loginService.registMember(signUpDto);

        } catch (Exception e) {
            System.out.println("[error] 회원가입 중 에러 발생 : " + e);

            return "enter/signUp";
        }

        return "redirect:/";
    }

    // 아이디 중복 체크 || 로그인 아이디 체크
    @ResponseBody
    @RequestMapping(value = "/enter/signUpIdChk", method = RequestMethod.GET)
    public int idChk(@RequestParam("id") String id) {
        int result = 0;
        result = loginService.idChk(id);
        return result;
    }

    // 로그인 페이지 불러오기
    @RequestMapping(value = "/enter/login", method = RequestMethod.GET)
    public String form(MemberDto memberDto) {

        return "enter/login";
    }

    // 로그인
    @RequestMapping(value = "/enter/login", method = RequestMethod.POST)
    public String submit(MemberDto memberDto, HttpServletRequest req, Model model) throws Exception {

        try {
            int member = loginService.idChk(memberDto.getId()); //로그인 아이디 체크(1:성공 0:실패)

            if (member == 0) {
                model.addAttribute("msg", "등록되지 않은 아이디 입니다.");
                return "enter/login";
            } else {
                // 회원 정보 가져오기
                MemberDto memberInfo = loginService.getMemberInfo(memberDto.getId());

                String pwd = memberDto.getPassword();
                String salt = memberInfo.getSalt(); // salt값 가져오기
                String userPwd = SHA256Util.SHA256Encrypt(pwd, salt);

                if (memberInfo.getPassword().equals(userPwd)) {

                    // session에 로그인 SEQ 저장
                    HttpSession session = req.getSession();
                    session.setAttribute("memberAuthInfo", memberInfo);
                    session.setAttribute("loginSeq", memberInfo.getSeq());
                    session.setAttribute("loginId", memberInfo.getId());

                    System.out.println("로그인 성공 : " + memberInfo.getSeq() + " | " + memberInfo.getId() + " | " + memberInfo.getName());
                } else {
                    model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
                    return "enter/login";
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());

            return "enter/login";
        }

        return "redirect:/";
    }

    // 로그아웃
    @RequestMapping(value = "/enter/logout")
    public String logout(HttpSession session) {
        session.invalidate();

        return "redirect:/";
    }

}



