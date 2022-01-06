<%--
  Created by IntelliJ IDEA.
  User: weaverloft-NB-000
  Date: 2022-01-05
  Time: 오후 4:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    <h1>회원 정보 수정</h1>


    <div class=myInfoDetail>
        <div class="myInfoDetailContents">
            <div>
                <div>
                    <p>아이디</p>
                    <p>이름</p>
                    <p>연락처</p>
                    <p>이메일</p>
                </div>
            </div>
            <div>
                <div>
                    <p>${memberAuthInfo.getId()}</p>
                    <p>${memberAuthInfo.getName()}</p>
                    <p>${phone}</p>
                    <p>${email}</p>
                </div>
            </div>
        </div>

        <div class="myInfoUpdate">
            <%--@elvariable id="memberDto" type="CertificateTest"--%>
            <form:form commandName="memberDto" enctype="multipart/form=data" method="POST">
                <table>
                    <tr>
                        <td><i class="fas fa-user myInfoUpdateIcon"></i>이름</td>
                        <td><form:input path="name" value="${memberAuthInfo.getName()}" />
                            <form:input path="seq" value="${loginSeq}" type="hidden" />
                        </td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-mobile-alt myInfoUpdateIcon"></i>연락처</td>
                        <td><form:input path="phone" value="${phone}" /></td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-mail-bulk myInfoUpdateIcon"></i>이메일</td>
                        <td><form:input path="email" value="${email}" /></td>
                    </tr>
                </table>

                <button class="btn btn-swap" type="submit"> EDIT <span>수정완료 >></span> </button>
            </form:form>
        </div>

        <div class="myInfoUpdatePageBtn">
            <a href="<c:url value='/myPage/password/${loginSeq}'/>" class="changeInfoBtn"><span class="clickText">click</span><i class="fas fa-unlock-alt editIcon"></i>비밀번호 변경</a>
            <a href="<c:url value='/myPage/${loginSeq}'/>" class="changeInfoBtn"><i class="fas fa-user-alt editIcon"></i>마이페이지<span class="clickText">click</span></a>
        </div>

        <div class="myInfoUpdateNotice">
            <h3>NOTICE</h3>
            <p><i class="fas fa-info"></i>아이디는 수정 불가 합니다.</p>
            <p><i class="fas fa-info"></i>연락처 오기재시 연결이 어려우니 필히 재확인 부탁드립니다.</p>
            <p><i class="fas fa-info"></i>이름은 자유롭게 기재 가능 합니다(실명이 아니어도 가능 합니다.)</p>
        </div>
    </div>

</section>

<button class="jellybutton topbtn" type="button" onclick="goTop()">TOP</button>

</body>
</html>
