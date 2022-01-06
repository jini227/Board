<%--
  Created by IntelliJ IDEA.
  User: weaverloft-NB-000
  Date: 2021-12-26
  Time: 오후 9:37
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
    <title>${contentsType} | 글 등록</title>
</head>
<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<div class="wrapboardPage">

    <div class="contentsTitleDetailPage">
        <h3 class="contentsTitle">게시글 등록</h3>
        <div class="titleLine"></div>
    </div>

    <div class="wrapWritePage">
        <%--@elvariable id="boardDto" type="CertificateTest"--%>
        <form:form commandName="boardDto" enctype="multipart/form-data" method="POST" id="form">
            <table id="input-lostPageWrite"> <!-- 입력칸 부분 -->
                <tr>
                    <td><strong>*</strong>게시판</td>
                    <td>
                         ${contentsType}
                    </td>
                </tr>
                <tr>
                    <td><strong>*</strong>글제목</td>
                    <td>
                        <form:input path="title" placeholder="글제목" id="title"/>
                        <form:errors path="title"/>
                    </td>
                </tr>
                <tr>
                    <td>동물이름</td>
                    <td>
                        <form:input path="pet_name" placeholder="동물이름 ex.마루, 초코..."/>
                        <form:errors path="pet_name"/>
                    </td>
                </tr>
                <tr>
                    <td>종류</td>
                    <td>
                        <form:input path="pet_type" placeholder="종류"/>
                        <form:errors path="pet_type"/>
                    </td>
                </tr>
                <tr>
                    <td>성별</td>
                    <td>
                        <form:input path="pet_gender" placeholder="남아/여아(중성화수술 여부 까지 적어주세요)"/>
                        <form:errors path="pet_gender"/>
                    </td>
                </tr>
                <tr>
                    <td>실종위치</td>
                    <td>
                        <form:input path="pet_location" placeholder="실종위치"/>
                        <form:errors path="pet_location"/>
                    </td>
                </tr>
                <tr>
                    <td>실종시각</td>
                    <td>
                        <form:input path="pet_time" placeholder="실종시각"/>
                        <form:errors path="pet_time"/>
                    </td>
                </tr>
                <tr>
                    <td>상세내용</td>
                    <td>
                        <form:textarea path="pet_memo" rows="10" cols="60"/><br>
                        <span id="byteInfo">0</span> / 2000bytes
                        <form:errors path="pet_memo"/>
                    </td>
                </tr>
                <tr>
                    <td><strong>*</strong>사진첨부</td>
                    <td id="lastTd">
                        <br><p name="add"><i class="fas fa-plus"></i> 파일추가 (jpg, jpeg, png)</p>
                    </td>
                    <!-- accept 성질 -->
                </tr>
            </table>
            <br>
            <div> <!-- 약관 -->
                <div class="writeTerms">
                    <label class="checkbox"><input type="checkbox" name="term" id="term" value="agree" class="AllOkay"><span class="icon"></span><span class="text">전체동의</span></label><br>
                    <label class="checkbox"><input type="checkbox" name="term" id="term" value="phoneAgree" class="okay"><span class="icon"></span><span class="text">연락처 노출 동의
									(회원가입 시 등록 한 연락처를 연락받을 번호로 기재 합니다. <br><span style="color: red; font-size: 20px;">*</span>해당 체크박스 미체크시 별도의 연락수단 상세내용에 기재 요망)<br> </span></label>
                    <label class="checkbox"><input type="checkbox" name="term" id="term" value="emailAgree" class="okay"><span class="icon"></span><span class="text">이메일 노출 동의
									(회원가입 시 등록 한 이메일을 연락받을 메일로 기재 합니다.)</span></label>
                </div>
            </div>
            <div > <!-- 작성완료 버튼 -->
                <input type="submit" value="작성완료" class="completeBtn" onclick="vaildation()">
            </div>
        </form:form>
    </div>
</div>

<script>
    $(function(){
        $("[type=checkbox][name=term]").on("change", function(){
            var check = $(this).prop("checked");
            //전체 체크
            if($(this).hasClass("AllOkay")){
                $("[type=checkbox][name=term]").prop("checked", check);

                //단일 체크
            }else{ //3
                var all = $("[type=checkbox][name=term].AllOkay");
                var allcheck = all.prop("checked")
                if(check != allcheck){
                    var len = $("[type=checkbox][name=term]").not(".AllOkay").length;
                    var ckLen = $("[type=checkbox][name=term]:checked").not(".AllOkay").length;
                    if(len === ckLen){
                        all.prop("checked", true);
                    }else{
                        all.prop("checked", false);
                    }
                }
            }
        });

        // 파일 추가 버튼
        $("table").on("click", "p[name='add']", function () {
            var imgCount = $('input[type="file"]').length;
            console.log(imgCount)

            if(imgCount==3){
                alert('파일은 3개까지 등록할 수 있습니다.');
            } else{
                var addForm = "<tr>";
                addForm += "<td></td>";
                addForm += "<td>";
                addForm += '<input type="file" class="img" name="img" accept=".jpg, .jpeg, .png"/>'
                addForm += '<a class="del"><i class="fas fa-trash-alt"></i></a><br>';
                addForm += "</td>";
                addForm += "</tr>";
                $("table").append(addForm);
            }
        });

        // 등록 파일 제거
        $('table').on("click",".del",function(){
            $(this).parent().parent().remove();
        });

    });

    function vaildation(){
        var img = document.getElementsByClassName('img');
        var title = document.getElementById('title');

        if (title.value == '') {
            alert('제목은 필수사항 입니다.');
            return false;
        }
        if (img.length == 0) {
            alert('첨부파일은 필수사항 입니다.');
            return false;
        }
        if (img.length != 0) {
            for (var i = 0; i < img.length; i++) {
                if (img[i].files.length == 0) {
                    alert('파일을 선택해주세요.');
                    return false;
                }
            }
        }
        document.getElementById('form').action = "<c:url value='/board/boardWrite/${contentsType}'/>";
        document.getElementById('form').submit();
    };
</script>
</body>
</html>
