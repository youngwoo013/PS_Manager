<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>설문조사</h2>

<!-- 원래는 import DTO, dto=(SurveyDTO)request.getAttribute 해서 직접 get-->
<h3>${dto.question}</h3>
<form method="post" action="/survey_servlet/insert.do">
	<input type="radio" name="num" value="1" checked>${dto.ans1}<br>
	<input type="radio" name="num" value="2" checked>${dto.ans2}<br>
	<input type="radio" name="num" value="3" checked>${dto.ans3}<br>
	<input type="radio" name="num" value="4" checked>${dto.ans4}<br>
	<input type="hidden" name="survey_idx" value="${dto.survey_idx }">
	<input type="submit" value="투표">
</form>
</body>
</html>