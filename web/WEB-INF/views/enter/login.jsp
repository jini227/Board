<%--
  Created by IntelliJ IDEA.
  User: weaverloft-NB-000
  Date: 2021-12-30
  Time: 오후 1:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/css/style.css">
    <script src="../../resources/script/script.js" defer></script>
    <title>로그인</title>
</head>
<body>
<jsp:include page="../include/header.jsp" />
<section class="sectionLogin">
    <div class="loginInner">
        <h3 class="loginTitle"><!-- 로그인 --></h3>
        <div class="loginBox">
            <%--@elvariable id="memberDto" type="CertificateTest"--%>
            <form:form commandName="memberDto" onsubmit="return loginChk()">
                <form:input path="id" id="id" placeholder="아이디" />
                <form:password path="password" id="password" placeholder="비밀번호" />
                <input type="submit" value="로그인" class="loginBoxbtn">
            </form:form>
        </div>
        <div class="loginBoxLower">
            <p>
                <a href="<c:url value='/enter/signUp'/>" class="loginBoxLowerText">아직 회원이 아니신가요?</a>
            </p>
        </div>
    </div>
</section>

</body>
<script type="text/javascript">

    if('${msg}'){
        var message="${msg}";
        alert(message);
    };

    function loginChk(){
        if(document.getElementById("id").value ==""){
            alert("아이디를 입력해주세요.");
            return false;
        }
        if(document.getElementById("password").value ==""){
            alert("비밀번호를 입력해주세요.");
            return false;
        }
    }

</script>
</html>