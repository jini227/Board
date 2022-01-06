package com.common.vaildation.signup;

import com.common.dto.enter.SignUpDto;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.regex.Pattern;

public class SignUpValidator implements Validator {

    // 비밀번호 vaildation
    private static final String PWD_EXP =
            "^.*(?=^.{6,15}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$";
    private Pattern pattern;

    public SignUpValidator() {
        pattern = Pattern.compile(PWD_EXP);
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return SignUpDto.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        SignUpDto command = (SignUpDto)target;

        if(!command.getPassword().isEmpty()) {
            boolean matcher = Pattern.matches(PWD_EXP,command.getPassword());
            if(matcher != true) {
                errors.rejectValue("password", "wrong", "비밀번호는 한글과 영문, 특수문자를 포함한 6-15자리 입니다.");
            }else if(!command.isPasswordEqual()) {
                errors.rejectValue("password","nomatch","비밀번호가 일치하지 않습니다.");
            }
        }

        ValidationUtils.rejectIfEmpty(errors, "password", "required", "비밀번호는 필수 입니다.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "required", "이름은 필수 입니다.");


    }
}
