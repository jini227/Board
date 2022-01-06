<%--
  Created by IntelliJ IDEA.
  User: weaverloft-NB-000
  Date: 2022-01-05
  Time: 오후 3:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
    <script src="https://kit.fontawesome.com/2d323a629b.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="../../resources/css/style.css">
    <script src="../../resources/script/script.js" defer></script>
    <title>마이페이지</title>
</head>
<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<section class="myInfoUpdatePage myPage">
    <h1>비밀번호 수정</h1>


    <div class=myInfoDetail>
        <div class="changePassword">
            <div class="changePasswordContents">
                <%--@elvariable id="memberDto" type="CertificateTest"--%>
                <form:form commandName="memberDto" method="POST" onsubmit="return pwdcheck()">
                    <div>
                        현재 비밀번호
                        <form:input type="password" path="password" value="" id="password"/>
                        <br><form:errors path="password"/>
                    </div>
                    <div>
                        변경 비밀번호
                        <form:input type="password" path="passwordNew" value="" id="passwordNew" />
                        <br><form:errors path="passwordNew"/>
                    </div>
                    <div>
                        비밀번호 확인
                        <input type="password" value="" id="passwordNewConfirm" />
                        <br>
                    </div>
                    <div>
                        <input type="submit" value="비밀번호 변경" class="changePasswordBtn">
                    </div>
                </form:form>
            </div>
        </div>


        <div class="myPasswordUpdatePageBtn">
            <a href="<c:url value='/myPage/myInfo/${loginSeq}'/>" class="changeInfoBtn"><span class="clickText">click</span><i class="fas fa-user-edit editIcon"></i>나의정보 변경</a>
            <a href="<c:url value='/myPage/${loginSeq}'/>" class="changeInfoBtn"><i class="fas fa-user-alt editIcon"></i>마이페이지<span class="clickText">click</span></a>
        </div>
    </div>

</section>

<button class="jellybutton topbtn" type="button" onclick="goTop()">TOP</button>
</body>
<script>

    if('${msg}'){
        var message="${msg}";
        alert(message);
    };

    function pwdcheck(){
        var current = document.getElementById("password");
        var newPwd = document.getElementById("passwordNew");
        var newConfirm = document.getElementById("passwordNewConfirm");

        if(current.value==""){
            alert("현재 비밀번호를 입력해주세요.");
            return false;
        }
        if(newPwd.value==""){
            alert("변경하실 비밀번호를 입력해주세요.");
            return false;
        }
        if(newConfirm.value==""){
            alert("비밀번호 확인란을 입력해주세요.");
            return false;
        }
        if(newPwd.value != newConfirm.value){
            alert("변경할 비밀번호가 일치하지 않습니다.");
            return false;
        }

        var pwdRule =/^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{6,15}$/;
        if(!pwdRule.test(document.getElementById("passwordNew").value)){
            alert("영문, 숫자, 특수문자 포함 6~15자로 만들어주세요.");
            return false;
        }
    }
</script>
</html>
