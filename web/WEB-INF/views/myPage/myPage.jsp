<%--
  Created by IntelliJ IDEA.
  User: weaverloft-NB-000
  Date: 2022-01-05
  Time: 오전 11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<section class="myPage">

    <h1>마이페이지</h1>
    <div class="wrapMyInfo">
        <div class="myInfo">
            <div class="myGrade">
                <div>
                    <i class="fas fa-dove"></i>
                </div>
                <div>
                    <p>${memberAuthInfo.getId()}님 환영합니다.</p>
                    <p class="changeMyInfodToggle">나의 정보 확인 & 변경 >><span class="clickText">click</span></p>
                </div>
            </div>
            <div class="myActivities">
                <div class="myActivitiesTitle">
                    <p>나의 활동</p>
                </div>
                <div class="wrapMyActivitiesContents">
                    <div class="myActivitiesContents">
                        <p>찾아가세요<br>
                            <c:if test="${empty findPosts.size()}">0개</c:if>
                            <c:if test="${!empty findPosts.size()}">${findPosts.size()}개</c:if>
                        </p>
                        <p>나의 연락처<br>
                            <c:if test="${!empty memberAuthInfo.getPhone()}"><span> 등록완료 </span> </c:if>
                            <c:if test="${empty memberAuthInfo.getPhone()}"><span style="color: #ed4848;"> 미등록 </span> </c:if>
                        </p>
                    </div>
                    <div class="myActivitiesContents">
                        <p>찾아주세요<br>
                            <c:if test="${empty lostPosts.size()}">0개</c:if>
                            <c:if test="${!empty lostPosts.size()}">${lostPosts.size()}개</c:if>
                        </p>
                        <p>나의 이메일<br>
                            <c:if test="${!empty memberAuthInfo.getEmail()}"><span> 등록완료 </span> </c:if>
                            <c:if test="${empty memberAuthInfo.getEmail()}"><span style="color: #ed4848;"> 미등록</span> </c:if>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="wrapMyInfoDetail">
        <h3>내 정보</h3>
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
        </div>
        <div>
            <a href="<c:url value='/myPage/password/${memberAuthInfo.getSeq()}'/>" class="changeInfoBtn"><span class="clickText">click</span><i class="fas fa-unlock-alt editIcon"></i>비밀번호 변경</a>
            <a href="<c:url value='/myPage/myInfo/${memberAuthInfo.getSeq()}'/>" class="changeInfoBtn"><i class="fas fa-user-edit editIcon"></i>나의정보 수정<span class="clickText">click</span></a>
        </div>
    </div>

    <div class="wrapMyPost">
        <h3>내가 작성한 글<span>찾아주세요</span></h3>
        <div class="myPost">
            <div class="myPostBx">
                <div>
                    <c:if test="${!empty lostPosts}">
                        <c:forEach var="p" items="${lostPosts}">
                            <div>
                                <p>
                                    <c:if test="${p.pet_meet == 1}"><i class="fas fa-stamp" style="color: gray;"></i></c:if>
                                    <c:if test="${p.pet_meet == 0}"><i class="fas fa-stamp" style="color: #ed4848;"></i></c:if>
                                </p>
                                <p class="myPostTitle"><a href="<c:url value="/board/boardDetail/${p.seq}"/>">${p.title} (${p.commentNum})<span class="clickText">click</span></a></p>
                                <p>${p.reg_date}</p>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty lostPosts}">
                        <div>
                            <p></p>
                            <p>찾아주세요 게시글이 없습니다.</p>
                            <p></p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <h3>내가 작성한 글<span>찾아가세요</span></h3>
        <div class="myPost">
            <div class="myPostBx">
                <div>
                    <c:if test="${!empty findPosts}">
                        <c:forEach var="p" items="${findPosts}">
                            <div>
                                <p>
                                    <c:if test="${p.pet_meet == 1}"><i class="fas fa-stamp" style="color: gray;"></i></c:if>
                                    <c:if test="${p.pet_meet == 0}"><i class="fas fa-stamp" style="color: #ed4848;"></i></c:if>
                                </p>
                                <p class="myPostTitle"><a href="<c:url value="/board/boardDetail/${p.seq}"/>">${p.title} (${p.commentNum})<span class="clickText">click</span></a></p>
                                <p>${p.reg_date}</p>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty findPosts}">
                        <div>
                            <p></p>
                            <p>찾아가세요 게시글이 없습니다.</p>
                            <p></p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</section>

<button class="jellybutton topbtn" type="button" onclick="goTop()">TOP</button>
</body>
</html>
