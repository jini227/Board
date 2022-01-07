<%--
  Created by IntelliJ IDEA.
  User: weaverloft-NB-000
  Date: 2021-12-31
  Time: 오후 9:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script src="https://kit.fontawesome.com/2d323a629b.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="../../resources/css/style.css">
    <script src="../../resources/script/script.js" defer></script>
    <link rel="shortcut icon" href="#">
    <title>${detail.title}</title>
</head>
<body>
<jsp:include page="../include/header.jsp"/>

<div class="wrapboardPage">

    <div class="contentsTitleDetailPage">
        <h3 class="contentsTitle">(${detail.contents_type}) ${detail.title}</h3>
        <div class="boardDetailPageLine"></div>
    </div>

    <div class="wrap-lostPage">

        <div class="boardPage-contents">
            <ul>
                <c:if test="${empty detail.images}">
                    <li class="post-photo-top">
                        <img src="../../resources/img/defaultImg.png" style="cursor:pointer"/>
                    </li>
                </c:if>
                <c:forEach var="i" items="${detail.images}">
                    <li class="post-photo-top">
                        <img src="../../resources/imgUpload/${i.stored_file_name}" style="cursor:pointer"/>
                    </li>
                </c:forEach>
            </ul>
            <div class="post-contents-bottom">
                <!-- 게시글 내용 나오는 부분 -->
                <span id="pet-meet">
                <c:if test="${detail.pet_meet==1}">
                <div>
                    <p class="finishText">발견완료</p>
                </div>
                </c:if>
                <c:if test="${detail.pet_meet!=1}">
                <div>
                    <p class="finishText" style="color: silver;">미발견</p>
                </div>
                </c:if>
                </span>
                <div class="userid-writetime-anumber-view">
                    <p>작성자 ${detail.writer}님 | ${detail.reg_date}</P>
                </div>
                <div class="userid-writetime-anumber-view">
                    <p>등록번호 ${detail.seq} | 조회수 ${detail.hit}</P>
                </div>
                <div class="animalName">
                    <p>이름 | ${detail.pet_name}</p>
                </div>
                <div class="kind">
                    <p>종류 | ${detail.pet_type}</p>
                </div>
                <div class="gender">
                    <p>성별 | ${detail.pet_gender}</p> <!-- ex)남아 중성화수술 함 -->
                </div>
                <div class="location">
                    <p>실종 위치 | ${detail.pet_location}</p>
                </div>
                <div class="lostDate">
                    <p>실종 시각 | ${detail.pet_time}</p>
                </div>
                <div class="phone" id="public">
                    <p>연락처 |
                        <c:if test="${detail.phone_public eq '비공개'}">비공개 </c:if>
                        <c:if test="${detail.phone_public eq '공개'}">${detail.phone} </c:if>
                    </p>
                </div>
                <div class="email" id="public">
                    <p>이메일 |
                        <c:if test="${detail.email_public eq '비공개'}">비공개 </c:if>
                        <c:if test="${detail.email_public eq '공개'}">${detail.email}</c:if>
                    </p>
                </div>
                <div class="memo">
                    <p style="white-space: pre-line;">${detail.pet_memo}</p>
                </div>

                <div class="reviewContents">
                    <p style="white-space: pre-line;">
                        <c:if test="${not empty detail.review}">
                        <i class="fas fa-quote-left"></i><span class="reviewText">${detail.review}</span><i class="fas fa-quote-right"></i>
                        </c:if>
                    </p>
                </div>
            </div>
        </div>

        <div class="wrap-btns">
            <!-- 버튼들 모음 -->
            <!-- 로그인한 사람이 본인 글에 들어왔을때만 보이는 버튼들 추가 -->
            <button class="btn btn-swap" name="toList" id="toList" onclick="location='<c:url value="/board/boardList/${detail.contents_type}"/>'">LIST<span>목록으로 >></span></button>
            <c:if test="${memberAuthInfo.id eq detail.writer}">
                <button class="btn btn-swap" name="delete" id="delete" onclick="del()">DELETE<span>글삭제 >></span></button>
                <button class="btn btn-swap" name="modify" id="modify"
                        onclick="location='<c:url value="/board/boardModify/${detail.seq}"/>'">MODIFY<span>글수정 >></span>
                </button>
                <button class="btn btn-swap" name="meet" id="meetBtn">STATE<span>변경 >></span></button>
            </c:if>
        </div>

        <div class="review" id="review_area">
            <form method="POST" action="/board/updateReview/${detail.seq}">
                <h2>후기를 남겨주세요! 찾은 장소나 위치, 그리고 찾게 된 경로 등을 상세히 적어 주시면 많은 도움이 됩니다.</h2>
                <input type="hidden" name="boardNum" value="${detail.seq}"/>
                <textarea name="review" rows="10" cols="30">${detail.review}</textarea>
                <!-- 					<span id="byteInfo">0</span> / 2000bytes -->
                <input type="submit" value="작성완료" class="completeBtn">
            </form>
        </div>

        <div class="wrap-comment">
            <div class="lostPage-comment-top">
                <h4>댓글을 남겨주세요 !</h4>
                <p>*댓글을 남겨주세요! 여러분의 작은 관심이 희망의 끈이 됩니다. 욕설/명예훼손의 글은 동의 없이 삭제됩니다.</p>
            </div>

            <!-- 댓글 리스트 -->
            <div class="lostPage-comment-bottom">
                <div id="lostPage-comment-bottom">
                    <ul>
                        <c:forEach var="c" items="${detail.comments}">
                            <li>
                                <p class="con">${c.memo}</p>
                                <p>${c.writer} | ${c.reg_date}</p>
                            </li>
                            <input type="hidden" class="cNum" value="${c.seq}">
                            <c:if test="${c.writer eq loginId}">
                                <button class="commentBtn commentMod"><i class="fas fa-pencil-alt"></i>
                                    <p>수정</p></button>
                                <button class="commentBtn commentDel"><i class="fas fa-trash-alt"></i>
                                    <p>삭제</p></button>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>

                <!-- 댓글 변경 영역 -->
                <div id="comment-modify" style="display:none; width:90%">
                    <input type="text" id="modifyContent" style="width:110%"></input>
                    <button class="commentBtn commentModFin" id="commentModFin" style="display:none"><i
                            class="fas fa-check"></i>
                        <p>완료</p></button>
                </div>

                <!-- 댓글 등록 영역 -->
                <div>
                    <textarea rows="10" cols="10" id="content"></textarea>
                </div>
                <div class="mainMore">
                    <!-- 댓글등록 버튼 -->

                    <a class="btn btn-swap" name="uploadComment" id="uploadComment">
                        upload <span>등록 </span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<button class="jellybutton topbtn" type="button" onclick="goTop()">TOP</button>
<!-- 글쓰기 버튼 -->
<!-- 예정) 로그인안한 회원은 로그인 페이지로 연결되도록 수정할 예정 -->
<c:if test="${memberAuthInfo.id == null }">
    <div class="centerbtn">
        <div class="jellybutton centerHiddenContents" name="centerHidden" id="centerHidden">
            <p>
                INFO<br>! 로그인 후 글쓰기 가능 합니다.<br>
                ! 아이디 | 비밀번호 분실 시 로그인<br>
                페이지 하단의 찾기 버튼 클릭
            </p>
        </div>
        <button class="jellybutton sidebtn1" name="write" id="write">WRITE</button>
    </div>
</c:if>
<c:if test="${memberAuthInfo.id != null }">
    <c:if test="${detail.contents_type eq 'lost'}">
        <button class="jellybutton sidebtn1" name="write" id="write"
                onclick="location='<c:url value="/board/boardWrite/lost"/>'">WRITE
        </button>
    </c:if>
    <c:if test="${detail.contents_type eq 'find'}">
        <button class="jellybutton sidebtn1" name="write" id="write"
                onclick="location='<c:url value="/board/boardWrite/find"/>'">WRITE
        </button>
    </c:if>
</c:if>

<!-- 리뷰버튼 -->
<c:if test="${memberAuthInfo.id eq detail.writer}">
    <div class="centerbtn reviewBtnToggle">
        <div class="jellybutton centerHiddenContents reviewHiddenContents" name="centerHiddenContents"
             id="centerHiddenContents">
            <p>
                INFO<br>! 리뷰를 작성해주세요 <br>
                ! 리뷰 버튼 클릭 시 리뷰 작성 혹은 수정 가능 합니다.
            </p>
        </div>
        <button class="jellybutton sidebtn7 reviewToggleBtn" name="review" id="review" onclick="window.scrollTo(800,800)">REVIEW
        </button>
    </div>
</c:if>


<script>
    $(document).ready(function () {

        // 리뷰 내용, 리뷰 버튼 변수 세팅
        var reviewContents = document.querySelector('.reviewContents');
        var reviewBtnToggle = document.querySelector('.reviewBtnToggle');

        meetToggle(); // 페이지 첫 진입 시 미발견일 경우만 if문 통해 리뷰내용과 버튼이 안보이도록 세팅

        function meetToggle() {
            var state = $(".finishText").text();
            if (state != '발견완료') {
                console.log('log. state is not found.')
                reviewContents.classList.toggle('active');
                reviewBtnToggle.classList.toggle('active');
            }
        }

        // 발견상태 변경 버튼 클릭 시
        $("#meetBtn").on("click", function () {
            var state = $(".finishText").text();
            var chk = true;
            var seq = ${detail.seq};
            var pet_meet = 0;

            if (state == '발견완료') {
                chk = confirm("'미발견'으로 변경 하시겠습니까?");
                pet_meet = 0;
            } else if (state == '미발견') {
                chk = confirm("'발견완료'로 변경 하시겠습니까?");
                pet_meet = 1;
            }

            if (chk) {
                $.ajax({
                    type: "GET",
                    url: "updateState",
                    data: {
                        "seq": seq,
                        "pet_meet": pet_meet
                    },
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        if(result == 1) {
                            var output = "<div>";
                            output += '<p class="finishText">발견완료</p>';
                            output += "</div>";
                            $("#pet-meet").html(output);
                            reviewContents.classList.toggle('active');
                            reviewBtnToggle.classList.toggle('active');
                        } else if (result == 0) {
                            var output = "<div>";
                            output += '<p class="finishText" style="color: silver">미발견</p>';
                            output += "</div>";
                            $("#pet-meet").html(output);
                            reviewContents.classList.toggle('active');
                            reviewBtnToggle.classList.toggle('active');
                        }
                    },
                    error: function () {
                        console.log("ajax 통신 실패");
                    }
                });
            }
        });

        // 댓글 쓰기 버튼 클릭 시
        $("#uploadComment").on("click", function () {
            if (!'${memberAuthInfo.id}') {
                alert("로그인 후 이용가능합니다.");
            } else {
                var text = $("#content").val();
                if (!text) {
                    alert('내용을 입력해주세요.')
                } else {
                    var boardSeq = ${detail.seq};
                    var loginSeq = "${loginSeq}";
                    $.ajax({
                        type: "POST",
                        url: "writeComment",
                        data: {
                            "loginSeq": loginSeq,
                            "boardSeq": boardSeq,
                            "text": text
                        },
                        success: function (result) {
                            if (result == 1) {
                                alert("댓글이 등록 되었습니다.");
                                $("#content").val("");
                                selectRlist();
                            } else {
                                alert("댓글 등록에 실패했습니다.");
                            }
                        },
                        error: function () {
                            console.log("ajax 통신 실패");
                        }
                    });
                }
            }
        });
        // 댓글 수정
        $("#lostPage-comment-bottom").on("click", ".commentMod", function modifyClick() {
            var div = $("#comment-modify");
            var num = div.children().length;
            var li = $(this).prev().prev();
            var cArea = $("#modifyContent");
            var fin = $("#commentModFin");
            var con = li.children('.con').text();
            var p = li.children('p');
            // 수정작업 중 다른 수정 버튼 클릭 시
            if (num == 0) {
                // 이전에 체크된 부분탐색
                var ul = li.parent();
                var mod_con = ul.find("#modifyContent");
                var move = ul.find("#commentModFin");
                var prevBtn = move.prev();
                var prevP = mod_con.nextAll('p');
                li.prepend(cArea);
                $(this).after(fin);
                prevP.show();
                prevBtn.show();
                p.hide();
                $(this).hide();
                cArea.val(con);
            }
            // 정상적인 경로
            if (num == 2) {
                li.prepend(cArea);
                $(this).after(fin);
                fin.show();
                cArea.show();
                p.hide();
                $(this).hide();
                cArea.val(con);
            }
        });
        $("#lostPage-comment-bottom").on("click", ".commentModFin", function () {
            var memo = $('#modifyContent').val();
            var input = $(this).prev().prev();
            var seq = input.val();
            var c = $("#modifyContent");
            var div = $("#comment-modify");
            var but = $("#commentModFin");
            $.ajax({
                type: "POST",
                url: "modifyComment",
                data: {
                    "seq": seq,
                    "memo": memo
                },
                success: function (result) {
                    if (result == 1) {
                        alert("댓글이 수정 되었습니다");
                        div.prepend(c);
                        div.prepend(but);
                        selectRlist();
                    } else {
                        alert("댓글이 수정에 실패했습니다.");
                    }
                },
                error: function () {
                    console.log("ajax 통신 실패");
                }
            });
        });
        // 댓글 삭제
        $("#lostPage-comment-bottom").on("click", ".commentDel", function () {
            var chk = confirm("해당 댓글을 정말 삭제하시겠습니까?");
            if (chk) {
                var input = $(this).prev().prev();
                var seq = input.val();
                $.ajax({
                    type: "GET",
                    url: "deleteComment",
                    data: {"seq": seq},
                    success: function (result) {
                        if (result == 1) {
                            alert("삭제 되었습니다.");
                            selectRlist();
                        }
                    }
                });
            }
        });
        // 댓글 목록 조회 함수
        function selectRlist() {
            var boardSeq = "${detail.seq}";
            $.ajax({
                url: "commentList",
                type: "POST",
                data: {"boardSeq": boardSeq},
                dataType: "json",
                success: function (comments) {
                    var output = "<ul>";
                    for (var i in comments) {
                        output += "<li>";
                        output += "<p class='con'>" + comments[i].memo + "</p>";
                        output += "<p>" + comments[i].writer + " | " + comments[i].reg_date + "</p>";
                        output += "</li>";
                        output += '<input type="hidden" value="' + comments[i].seq + '">'
                        if (comments[i].writer == "${memberAuthInfo.id}") {
                            output += '<button class="commentBtn commentMod"><i class="fas fa-pencil-alt"></i><p>수정</p></button>';
                            output += '<button class="commentBtn commentDel"><i class="fas fa-trash-alt"></i><p>삭제</p></button>';
                        }
                    }
                    output += "</ul>";
                    $("#lostPage-comment-bottom").html(output);
                },
                error: function () {
                    console.log("댓글 목록 조회 ajax 통신 실패");
                }
            });
        }
    });

    ///////////////////////////////////////////////////////////

    // 게시글 삭제
    function del() {
        var chk = confirm("정말 삭제하시겠습니까?");
        if (chk) {
            location.href = "<c:url value='/board/boardDelete/${detail.seq}&${detail.contents_type}'/>";
            alert("게시글이 삭제되었습니다.");
        }
    }

    // 이미지 클릭시 원본 크기로 팝업 보기
    var img = document.getElementsByTagName("img");
    for (var x = 0; x < img.length; x++) {
        img.item(x).onclick = function () {
            window.open(this.src)
        };
    }
</script>
</body>

</html>