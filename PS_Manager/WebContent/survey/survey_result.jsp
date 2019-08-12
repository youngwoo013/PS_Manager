<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>g
<h2>설문조사 결과</h2>
<table border="1">
	<tr align="center">
		<th>문항</th>
		<th>응답수</th>
		<th>응답률</th>
	</tr>
<c:forEach var="dto" items="${list}">
	<tr>
		<td>${dto.num}</td>
		<td>${dto.sum_num}</td>
		<td>${dto.rate}%</td>
	</tr>
</c:forEach>
</table>
<a href="../survey_servlet/input.do">설문 메인화면</a>

</body>
</html>