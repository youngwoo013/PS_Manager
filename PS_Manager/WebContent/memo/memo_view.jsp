<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/session_check.jsp"/>
<link rel="stylesheet" href="/psManager/Resources/css/chatbox.css">
<script src="../Resources/js/bootstrap.js"></script>
<style type="text/css">
textarea {
	resize: none;
}
</style>
<script>
$(function(){
	$("#btnUpdate").click(function(){
		var writer=$("#writer");
		var memo=$("#memo");
		
						
		if(memo.val()==""){
			alert("메모를 입력하세요.");
			writer.focus();
			return;
			
		}
		document.form1.action="../memo_servlet/update.do";
		document.form1.submit();
	});
});

$(function(){
	$("#btnDelete").click(function(){
		if(confirm("삭제하겠습니까? 되돌릴수없습니다.")){
			document.form1.action="../memo_servlet/delete.do";	
			document.form1.submit();	
		}
	});
});
</script>
</head>
<body>
<h2>메모 수정</h2>
<jsp:include page="/include/nav_login.jsp" />
<%String userid=(String)session.getAttribute("userid"); %>

<form name="form1" id="form1" method="post">
<table border="1" style="width:350px">
	<tr>
		<td>이름</td>
		<c:if test="${birthmonth==1}">selected</c:if>
		<td><input type="text" name="writer" id="writer" value="${dto.writer}" readonly="readonly"></td>
		<c:set var="writer" value="${dto.writer}" />
		<c:set var="userid" value="${userid }" />
		<c:if test="${writer!=userid}">
			<script>
				alert("권한이 없습니다.");
				document.location.href="/psManager/memo/memo.jsp"
			</script> 
			
		</c:if>
	</tr>
	<tr>
		<td>메모</td>
		<td><input type="text" name="memo" id="memo" value="${dto.memo}"></td>
	</tr>
	<tr align="center">
		<td colspan="2">
			<input type="hidden" name="idx" id="idx" value="${dto.idx}">
			<input type="button" value="수정" id="btnUpdate">
			<input type="button" value="삭제" id="btnDelete">
		</td>
		</tr>
</table>

</form>
</body>
</html>