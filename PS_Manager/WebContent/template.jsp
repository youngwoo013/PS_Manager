<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- header -->
<jsp:include page="/include/header.jsp" />

<title>Welcome - PSM</title>
</head>
<%@  include file="/include/session_check.jsp"%>
<body>
	<!-- nav -->
	<jsp:include page="/include/nav_login.jsp" />

	<div class="container">
		${sessionScope.message } <br> 접속중인 아이디 : ${sessionScope.userid }<br>

		<a href="/psManager/account_servlet/signout.do">로그아웃</a>
	</div>


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

	<script src="../Resources/js/bootstrap.min.js"></script>
</body>
</html>