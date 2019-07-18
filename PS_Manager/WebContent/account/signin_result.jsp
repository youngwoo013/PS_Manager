<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome - PSM</title>
</head>
<%@  include file = "/include/session_check.jsp" %>
<body>
${sessionScope.message }<br>
접속중인 아이디 : ${sessionScope.userid }<br>
<a href = "/psManager/account_servlet/signout.do">로그아웃</a>
</body>
</html>