<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>


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
<h2>한줄메모장</h2>

이름 : <input type="text" id="writer" size="10"><br>
메모 : <input type="text" id="memo" size="40">
<input type="button" id="btnSave" value="확인">

<div id="result"></div>
</body>
</html>