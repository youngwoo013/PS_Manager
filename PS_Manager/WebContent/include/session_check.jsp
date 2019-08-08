<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String userid = (String) session.getAttribute("userid");
	if (userid == null) {
%>
<script>
	alert("먼저 로그인을 해주세요.");
	location.href = "/psManager/account/signin.jsp";
	
</script>
<%
	}
%>