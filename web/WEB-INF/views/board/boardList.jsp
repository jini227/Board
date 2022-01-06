<%--
  Created by IntelliJ IDEA.
  User: weaverloft-NB-000
  Date: 2021-12-26
  Time: 오후 8:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script src="https://kit.fontawesome.com/2d323a629b.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="../../resources/css/style.css">
    <script src="../../resources/script/script.js" defer></script>
    <title>${contentsType}</title>
</head>
<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<div class="wrapboardPage">
    <div id="contentsTitle">
        <div>
            <h3 class="contentsTitle">${contentsType}</h3>
            <div class="titleLine"></div>
        </div>
        <%--@elvariable id="boardDto" type="CertificateTest"--%>
        <form:form commandName="boardDto" modelAttribute="boardDto" method="get" action="/board/boardList/${contentsType}">
            <div id="contentsMenu">
                <span>전체 <input type="checkbox" class="AllOkay" name="state" value="2" path="pet_meet"></span>
                <span>미발견 <input type="checkbox" class="okay" name="state" value="0" path="pet_meet"></span>
                <span>발견완료 <input type="checkbox" class="okay" name="state" value="1" path="pet_meet"></span> |
                <form:select path="searchOption">
                    <form:option value="title">제목</form:option>
                    <form:option value="name">이름</form:option>
                    <form:option value="writer">작성자</form:option>
                </form:select>
                <form:input type="text" name="searchkeyword" id="searchkeyword" path="searchKeyword"/>
                <input type="submit" value="검색">
            </div>
        </form:form>
    </div>
    <c:if test="${boardDto.searchOption != null}">
        <div class="search-result" style="background-color: whitesmoke; text-align: center; line-height: 40px; height: 40px;">
            <p>
                검색 결과 [${posts.size()}] 개 입니다.  (
                검색조건 :
                <c:if test="${boardDto.searchOption == 'title'}">제목</c:if>
                <c:if test="${boardDto.searchOption == 'name'}">이름</c:if>
                <c:if test="${boardDto.searchOption == 'writer'}">작성자</c:if>  |
                검색어  : "${boardDto.searchKeyword}"  |
                발견여부 :
                <c:if test="${boardDto.state == '1'}">발견완료</c:if>
                <c:if test="${boardDto.state == '0'}">미발견</c:if>
                <c:if test="${boardDto.state != '0' && boardDto.state != '1'}">전체</c:if>)
            </p>
        </div>
    </c:if>

    <div class="wrapBoardlist">
        <!-- 게시글이 존재하지 않을 때 -->
        <c:if test="${empty posts}">
            <ul>
                <li>게시물이 없습니다.</li>
            </ul>
        </c:if>
        <!-- 게시글이 1개 이상 존재할 때 -->
        <ul>
            <!-- 게시물 li로 나열  -->
            <c:forEach var="post" items="${posts}">
                <li><a href="/board/boardDetail/${post.seq}">
                    <div class="post-photo-top"> <!-- 게시글 사진 나오는 부분 -->
                        <div class="img_box">
                            <img src="../../resources/imgUpload/${post.thumbnail_file_name}" width="200" height="250"/>
                        </div>
                    </div>
                    <div class="post-contents-bottom"> <!-- 게시글 내용 나오는 부분 -->
                        <!-- 작성자가 본인 글에서 발견 버튼 클릭 시에만 생성 -->
                        <c:if test="${post.pet_meet==1}">
                            <div>
                                <p class="finishText">발견완료</p>
                            </div>
                        </c:if>
                        <c:if test="${post.pet_meet!=1}">
                            <div><p><br>
                                <p></div>
                        </c:if>
                        <div>
                            <p>제목 : ${post.title}</P>
                        </div>
                        <div>
                            <p>이름 : ${post.pet_name}</P>
                        </div>
                        <div>
                            <p>잃어버린 위치 : ${post.pet_location}</p>
                        </div>
                        <div>
                            <p>실종 시각 : ${post.pet_time}</p>
                        </div>
                        <div>
                            <p>종류 : ${post.pet_type}</p>
                        </div>
                    </div>
                </a>
                </li>
            </c:forEach>
        </ul>
    </div>
    <div class="paging">
        <ul>
            <c:if test="${pageMaker.prev}">
                <li><a href="${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
            </c:if>
            <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
                <li><a href="${pageMaker.makeQuery(idx)}">${idx}</a></li>
            </c:forEach>
            <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
                <li><a href="${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
            </c:if>
        </ul>
    </div>
</div>

<button class="jellybutton topbtn" type="button" onclick="goTop()">TOP</button>

<c:if test="${memberAuthInfo == null }">
    <div class="centerbtn">
        <div class="jellybutton centerHiddenContents" name="centerHidden" id="centerHidden"><p>INFO<br>! 로그인 후 글쓰기 가능
            합니다.<br>! 아이디 | 비밀번호 분실 시 로그인<br>페이지 하단의 찾기 버튼 클릭</p></div>
        <button class="jellybutton sidebtn1" name="write" id="write">WRITE</button>
    </div>
</c:if>
<c:if test="${memberAuthInfo != null }">
    <c:if test="${contentsType eq 'lost'}">
        <button class="jellybutton sidebtn1" name="write" id="write"
                onclick="location='<c:url value="/board/boardWrite/lost"/>'">WRITE
        </button>
    </c:if>
    <c:if test="${contentsType eq 'find'}">
        <button class="jellybutton sidebtn1" name="write" id="write"
                onclick="location='<c:url value="/board/boardWrite/find"/>'">WRITE
        </button>
    </c:if>
</c:if>
<script>
    $(function(){
        $("[type=checkbox][name=state]").on("change", function(){
            var check = $(this).prop("checked");
            //전체 체크
            if($(this).hasClass("AllOkay")){
                $("[type=checkbox][name=state]").prop("checked", check);

                //단일 체크
            }else{ //3
                var all = $("[type=checkbox][name=state].AllOkay");
                var allcheck = all.prop("checked")
                if(check != allcheck){
                    var len = $("[type=checkbox][name=state]").not(".AllOkay").length;
                    var ckLen = $("[type=checkbox][name=state]:checked").not(".AllOkay").length;
                    if(len === ckLen){
                        all.prop("checked", true);
                    }else{
                        all.prop("checked", false);
                    }
                }
            }
        });
    });

</script>
</body>
</html>
