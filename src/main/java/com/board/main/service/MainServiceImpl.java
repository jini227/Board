package com.board.main.service;

import com.common.dao.Dao;
import com.common.dto.main.MainDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MainServiceImpl implements MainService {

    @Autowired
    private Dao dao;

    public MainDto selectMain() {
        MainDto mainDto = dao.selectMain();

        return mainDto;
    }

}
