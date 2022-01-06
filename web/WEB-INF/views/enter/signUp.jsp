<%--
  Created by IntelliJ IDEA.
  User: weaverloft-NB-000
  Date: 2021-12-30
  Time: 오전 9:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="../../resources/css/style.css">
    <script src="../../resources/script/script.js" defer></script>
    <title>회원가입</title>
</head>
<body>
<jsp:include page="../include/header.jsp"/>
<section class="sectionSignUp">
    <div class="signUpInner">
        <h3 class="signUpTitle">회원가입</h3>
        <div class="signUpBox">
            <form:form commandName="signUpDto" class="signUpCommand">
                <div class="signUpCommandWrap">
                    <div class="signUpCommandTitle">
                        <p><strong>*</strong> 아이디</p>
                        <p><strong>*</strong> 비밀번호</p>
                        <p><strong>*</strong> 비밀번호 확인</p>
                        <p><strong>*</strong> 이름</p>
                        <p><strong> </strong> 연락처</p>
                        <p><strong> </strong> 이메일</p>
                    </div>
                    <div class="signUpCommandBox">
                        <p>
                            <form:input path="id" placeholder="아이디" check_result="success" requried="requried"/>
                            <form:errors path="id"/>
                            <br>
                            <a class="idChk" onclick="idChk()" style="cursor:pointer; display:none">중복 체크</a>
                            <i class="fas fa-check" id="idOk" style="display:none"> 완료</i>
                        </p>
                        <p>
                                <form:password path="password" placeholder="비밀번호(영문,숫자,특수문자 조합 6~15자리)"/>
                        <p style="height:0;"><form:errors path="password"/></p>
                        <p>
                            <form:password path="pwdChk" placeholder="비밀번호 확인"/>
                            <form:errors path="pwdChk"/>
                        </p>
                        <p>
                            <form:input path="name" placeholder="이름" requried="requried"/>
                            <form:errors path="name"/>
                        </p>
                        <p>
                            <form:input path="phone" placeholder="-(하이픈)을 포함한 전체 전화번호를 입력해주세요"/>
                            <form:errors path="phone"/>
                        </p>
                        <p>
                            <form:input path="email" type="email" placeholder="@를 포함한 이메일 주소를 입력해주세요"/>
                            <form:errors path="email"/>
                        </p>
                    </div>
                </div>

                <div class="signUpTerms">

                    <label class="checkbox" for="ageAgree">
                        <input type="checkbox" name="term" id="ageAgree" value="ageAgree" required="required">
                        <span class="icon"></span>
                        <span class="text">만 14세 이상입니다.(필수)</span>
                    </label>
                    <label class="checkbox" for="infoAgree">
                        <input type="checkbox" name="term" id="infoAgree" value="infoAgree" required="required">
                        <span class="icon"></span>
                        <span class="text">개인정보 수집 이용 동의 (필수)</span>
                    </label>

                </div>
                <div class="signUpBoxbtn">
                    <input type="submit" value="회원가입" onclick="signUpChk(event)">
                </div>
            </form:form>
        </div>
    </div>
</section>

<script type="text/javascript">
    $(document).ready(function () {
        if ($("id").val()) {
            alert($("id").val());
            $('#id').attr("check_result", "success");
        }
    });

    $(".signUpCommandBox").on("change", "#id", function () {
        $('#idOk').hide();
        $('.idChk').show();
        $('#id').attr("check_result", "fail");
    });

    function idChk() {
        var id = $("#id").val();
        console.log(id)
        if (id) {
            $.ajax({
                type: "GET",
                url: "signUpIdChk",
                data: {"id": id},
                success: function (result) {
                    var msg;
                    console.log("result : " + result);

                    switch (result) {
                        case 1 : //동일 아이디 존재
                            msg = "아이디가 이미 존재합니다.";
                            break;
                        case 0 : //아이디 사용 가능
                            msg = "해당 아이디는 사용 가능합니다.";
                            $(".idChk").hide();
                            $('#idOk').show();
                            $('#id').attr("check_result", "success");
                            break;
                    }
                    alert(msg);
                },
                error: function () {
                    console.log("ajax 통신 실패")
                }
            });
        } else {
            alert('아이디를 입력해주세요.');
        }
    };

    function signUpChk(event) {
        var ageAgree = document.getElementById("ageAgree");
        var infoAgree = document.getElementById("infoAgree");
        var chk = $('#id').attr('check_result');

        if (!ageAgree.checked) {
            alert("필수사항(만 14세 이상)을 체크해주세요");
            return false;
        }
        if (!infoAgree.checked) {
            alert("필수사항(개인정보 동의)을 체크해주세요");
            return false;
        }
        if (chk === 'fail') {
            alert("아이디 중복체크를 해주세요.");
            event.preventDefault();
            // return false;
        }
        document.getElementById('signUpCommand').submit();
    }


</script>
</body>
</html>
