<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 네비게이션  -->

<nav class="navbar navbar-default">
	<div class="navbar-header">

		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expaned="false"></button>

		<a class="navbar-brand" href="/psManager/index.jsp">JSP 게시판</a>

	</div>

	<div class="collapse navbar-collapse"
		id="#bs-example-navbar-collapse-1">

		<ul class="nav navbar-nav">
			<li><a href="/psManager/memo/memo.jsp">한줄 메모장</a></li>
			<li><a href="/psManager/my_schedule/my_schedule.jsp">일정 관리</a></li>
			<li><a href="/psManager/chatting/chatroom.jsp">채팅</a>
			<li><a href="/psManager/agora.jsp">정보광장</a>
		</ul>
	</div>
</nav>