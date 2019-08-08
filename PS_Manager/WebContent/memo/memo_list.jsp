<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table border="1">
	<tr>
		<th>ID</th>
		<th width="150">이름</th>
		<th width="350">메모</th>
		<th width="180">날짜</th>
	</tr>
<c:forEach var="row" items="${list}">
	<tr>
		<td>${row.idx}</td>
		<td>${row.writer}	</td>
		<td><a href="/memo_servlet/view.do?idx=${row.idx}">${row.memo}</a></td>
		<td>${row.post_date}	</td>
	
	</tr>
</c:forEach>
	
</table>

</body>
</html>