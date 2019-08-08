<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="/include/session_check.jsp" %>
 
</head>
<body>
<h2><%=session.getAttribute("message") %></h2>
접속중인 아이디 : <%=session.getAttribute("userid") %><br>

<a href="/ch02_servlet/logout.do">로그아웃</a>
</body>
</html>