<%--
  Created by IntelliJ IDEA.
  User: weaverloft-NB-000
  Date: 2021-12-26
  Time: 오전 1:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<header>
    <div class="headerTop">
        <div class="enter">
            <p>
                <c:if test="${empty memberAuthInfo.id}">
                    <a href="<c:url value='/enter/login'/>">로그인</a>
                    <a>|</a>
                    <a href="<c:url value='/enter/signUp'/>">회원가입</a>
                </c:if>
                <c:if test="${!empty memberAuthInfo.id}">
                    <a href="<c:url value='/myPage/${loginSeq}'/>">${memberAuthInfo.id}님 마이페이지</a>
                    <a>|</a>
                    <a href="<c:url value='/enter/logout'/>">로그아웃</a>
                </c:if>
            </p>
        </div>

    </div>
    <div class="headerbottom">
        <div class="mainTitle">
            <i class="fab fa-accusoft"></i>
            <p><a href="<c:url value='/'/>">수원시 분실동물 찾기 서비스</a></p>
        </div>
    </div>


    <nav>
        <div class="navInner">
            <div class="mainMenu">
                <ul>
                    <a href="/board/boardList/lost"><li>찾아주세요</li></a>
                    <a href="/board/boardList/find"><li>찾아가세요</li></a>
                </ul>
            </div>
            <a href="#" class="navToggleBtn"> <i class="fas fa-bars"></i></a>
        </div>
    </nav>

</header>
