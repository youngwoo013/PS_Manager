<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
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
<script>
$(function(){
	list();
	$("#btnSave").click(function(){
		insert();
	});
});

function insert(){
	var writer=$("#writer").val();
	var memo=$("#memo").val();
	var param="writer="+writer+"&memo="+memo;
	$.ajax({
		type: "post",
		url:"../memo_servlet/insert.do",
		data: param,
		success: function(){
			list();
			$("#writer").val("");
			$("#memo").val("");	
		}
	});	
}

function list(){
	$.ajax({
		url:"../memo_servlet/list.do",
		success: function(result){
			$("#result").html(result);
			
		}
	})
	
}

</script>
</head>
<body>
<jsp:include page="/include/nav_login.jsp" />
<h2>한줄메모장</h2>
<%String userid=(String)session.getAttribute("userid");%>

이름 : <input type="text" id="writer" size="20" value=<%=userid %> readonly="readonly"/> <br>
메모 : <input type="text" id="memo" size="40">
<input type="button" id="btnSave" value="확인" onClick="window.location.reload()" >
<div id="result"></div>

</body>
</html>