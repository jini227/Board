package com.board.main.controller;

import com.board.main.service.MainService;
import com.common.dto.main.MainDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class MainController {

    @Autowired
    public MainService mainService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String main(Model model, HttpServletRequest request) {

        MainDto dto = mainService.selectMain();
        model.addAttribute("member", dto);

        return "index";
    }
}
