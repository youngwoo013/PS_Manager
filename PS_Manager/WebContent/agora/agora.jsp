<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/session_check.jsp"/>

<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/psManager/Resources/css/chatbox.css">
<script src="../Resources/js/bootstrap.js"></script>
<style type="text/css">
textarea {
	resize: none;
}
</style>
</head>
<body>
	<jsp:include page="/include/nav_login.jsp" />
	<a href="/psManager/memo/memo.jsp">한줄 메모장</a>
</body>
</html>