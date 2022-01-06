<%--
  Created by IntelliJ IDEA.
  User: weaverloft-NB-000
  Date: 2021-12-23
  Time: 오후 7:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script src="https://kit.fontawesome.com/2d323a629b.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="../resources/css/style.css">
    <script src="../resources/script/script.js" defer></script>
    <title>:: MAIN ::</title>
</head>
<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>


    현재 로그인 아이디 : ${memberAuthInfo.id}


</body>
<script type="text/javascript">

    if('${msg}'){
        var message="${msg}";
        alert(message);
    };

</script>
</html>
