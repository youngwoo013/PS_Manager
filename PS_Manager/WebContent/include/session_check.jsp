<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String userid=(String)session.getAttribute("userid");
if(userid==null){
	%>
	<script>
		alert("먼저 로그인해라");
		location.href="login.jsp";
	
	</script>
	<%
}

%>