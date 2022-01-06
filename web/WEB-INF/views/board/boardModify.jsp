<%--
  Created by IntelliJ IDEA.
  User: weaverloft-NB-000
  Date: 2022-01-03
  Time: 오전 11:21
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
    <title>${detail.contents_type} | 글 수정</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<div class="wrapboardPage">

    <div class="contentsTitleDetailPage">
        <h3 class="contentsTitle">게시글 수정</h3>
        <div class="titleLine"></div>
    </div>

    <div class="wrapWritePage">
        <%--@elvariable id="boardDto" type="CertificateTest"--%>
        <form:form commandName="boardDto" enctype="multipart/form-data">
            <table id="input-lostPageWrite">
                <tr>
                    <td><strong>*</strong>게시판</td>
                    <td>
                            ${detail.contents_type}
                    </td>
                </tr>
                <tr>
                    <td><strong>*</strong>글제목</td>
                    <td>
                        <form:input path="title" value="${detail.title}" class="checkBlank"/>
                        <form:errors path="title"/>
                    </td>
                </tr>
                <tr>
                    <td><strong></strong>동물이름</td>
                    <td>
                        <form:input path="pet_name" value="${detail.pet_name}"/>
                        <form:errors path="pet_name"/>
                    </td>
                </tr>
                <tr>
                    <td><strong></strong>품종</td>
                    <td>
                        <form:input path="pet_type" value="${detail.pet_type}"/>
                        <form:errors path="pet_type"/>
                    </td>
                </tr>
                <tr>
                    <td><strong></strong>성별</td>
                    <td>
                        <form:input path="pet_gender" value="${detail.pet_gender}"/>
                        <form:errors path="pet_gender"/>
                    </td>
                </tr>
                <tr>
                    <td><strong></strong>실종위치</td>
                    <td>
                        <form:input path="pet_location" value="${detail.pet_location}"/>
                        <form:errors path="pet_location"/>
                    </td>
                </tr>
                <tr>
                    <td><strong></strong>연락처</td>
                    <td><form:input path="phone_public" id="phone_public" value="${detail.phone_public}" readonly="true"/>
                        <form:errors path="phone_public"/>
                        <span class="commentBtn commentModFin" id="phonePublicBtn" style="left: 50px; top: 0px;">
                            <i class="fas fa-comment"></i>
                        </span>
                        <span class="commentBtn commentModFin" id="phoneNotPublicBtn" style="left: 10px; top: 0px;">
                            <i class="fas fa-comment-slash"></i>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td><strong></strong>이메일</td>
                    <td><form:input path="email_public" id="email_public" value="${detail.email_public}" readonly="true"/>
                        <form:errors path="email_public"/>
                        <span class="commentBtn commentModFin" id="emailPublicBtn" style="left: 50px; top: 0px;">
                            <i class="fas fa-comment"></i>
                        </span>
                        <span class="commentBtn commentModFin" id="emailNotPublicBtn" style="left: 10px; top: 0px;">
                            <i class="fas fa-comment-slash"></i>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td><strong></strong>실종시각</td>
                    <td><form:input path="pet_time" value="${detail.pet_time}" />
                        <form:errors path="pet_time"/>
                    </td>
                </tr>
                <tr>
                    <td><strong style="color: white;">*</strong>상세내용</td>
                    <td>
                        <textarea id="pet_memo" name="pet_memo" rows="10" cols="65">${detail.pet_memo}</textarea><br>
                        <span id="byteInfo">0</span> / 2000bytes
                        <form:errors path="pet_memo"/>
                    </td>
                </tr>
                <tr>
                    <td><strong></strong>사진첨부</td>
                    <td>
                        <p name="add"><i class="fas fa-plus"></i> 파일추가 (jpg / png / jpeg)</p>
                    </td>
                </tr>
                <c:forEach var="i" items="${detail.images}" varStatus="statusNum">
                    <tr>
                        <td></td>
                        <td>
                            <input type="hidden" name="modifyFile" id="modifyFile" value="${i.stored_file_name}"/>
                            <label for="img">
                                등록된 파일 : ${i.original_file}
                            </label>
                            <a class="del" style="cursor:pointer">
                                <i class="far fa-trash-alt"></i><br>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <div > <!-- 수정완료 버튼 -->
                <input type="submit" value="수정완료" class="completeBtn" onclick="return imgCheck()">
            </div>
        </form:form>
    </div>
</div>

<button class="jellybutton topbtn" type="button" onclick="goTop()">TOP</button>
<!-- Service Center 버튼 -->
<!-- 내용 미정 -->
<div class="centerbtn">
    <div class="jellybutton centerHiddenContents guideHiddenContents" name="centerHidden" id="centerHidden">
        <p>GUIDE<BR>1. '*'는 필수 입력 사항 입니다.
            <br>2. 실종 위치 및 시각은 최대한
            <BR>구체적으로 적어주세요.
            <br>ex) 15시 20분경 경기대 후문
            <br>3. 내용은 자유롭게 기재 하되,
            <BR>최대한 많은 내용을 기재 해 주셔야 발견 될 확률이 높습니다.
        </p>
    </div>
    <button class="jellybutton sidebtn1" name="center" id="center">GUIDE</button>
</div>

<script>

    $("#emailPublicBtn").on("click", function () {
        document.getElementById("email_public").value = '공개';
    });

    $("#emailNotPublicBtn").on("click", function () {
        document.getElementById("email_public").value = '비공개';
    });

    $("#phonePublicBtn").on("click", function () {
        document.getElementById("phone_public").value = '공개';
    });

    $("#phoneNotPublicBtn").on("click", function () {
        document.getElementById("phone_public").value = '비공개';
    });



    $(function(){
        // 파일 추가 버튼
        $("table").on("click", "p[name='add']", function (){
            var imgCount = ($('input[type="file"]').length) + ($('input[type="hidden"]').length);
            if(imgCount==3){
                alert('파일은 3개까지 등록할 수 있습니다.');
            } else{
                var addForm = "<tr>";
                addForm += "<td></td>";
                addForm += "<td>";
                addForm += '<input type="file" class="newImg" id="img" name="img" accept=".jpg, .jpeg, .png"/>';
                addForm += '<a class="del" style="cursor:pointer">';
                addForm += '<i class="far fa-trash-alt"></i><br>';
                addForm += "</a>";
                addForm += "</td></tr>";
                $("table").append(addForm);
            }
        });

        // 등록 파일 제거
        $('table').on("click",".del",function(){
            $(this).parent().parent().remove();
        });
    });

    // 첨부파일 null 체크
    function imgCheck(){
        var num = $("table").find("tr").length;
        if(num==9){
            alert("첨부파일 최소 한개를 등록해주세요.");
            return false;
        }

        var ex = document.getElementsByClassName('newImg');
        if(ex.length!=0){
            for(var i=0;i<ex.length;i++){
                if(ex[i].files.length==0){
                    alert('파일을 선택해주세요.');
                    return false;
                }
            }
        }

        for(var i=0;i<10;i++){
            var context = document.getElementsByClassName('checkBlank')[i].value;
            if(!context){
                alert('필수사항을 입력해주세요.');
                return false;
            }
        }

        document.getElementById('form').submit();
    };

</script>
</body>
</html>
