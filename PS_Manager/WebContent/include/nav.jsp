<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 네비게이션  -->

<nav class="navbar navbar-default">
	<div class="navbar-header">

		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expaned="false"></button>

		<a class="navbar-brand" href="main.jsp">JSP 게시판</a>

	</div>

	<div class="collapse navbar-collapse"
		id="#bs-example-navbar-collapse-1">

		<ul class="nav navbar-nav">

			<li><a href="/psManager/index.jsp">메인</a></li>
			<li><a href="/psManager/memo/memo.jsp">한줄 메모장</a></li>
			<li><a href="/psManager/schedule/my_schedule.jsp">일정 관리</a></li>
			<li><a href="/psManager/chatting/chatroom.jsp">채팅</a>
		</ul>
	</div>
</nav>