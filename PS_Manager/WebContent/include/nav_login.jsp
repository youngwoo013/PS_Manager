<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 네비게이션  -->

<nav class="navbar navbar-default">
	<div class="navbar-header">

		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expaned="false">

			<span class="icon-bar"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span>

		</button>

		<a class="navbar-brand" href="main.jsp">JSP 게시판</a>

	</div>

	<div class="collapse navbar-collapse"
		id="#bs-example-navbar-collapse-1">

		<ul class="nav navbar-nav">

			<li><a href="main.jsp">메인</a></li>
			<li><a href="bbs.jsp">한줄 메모장</a></li>
			<li><a href="bbs.jsp">프로젝트</a></li>
			<li><a href="/psManager/chatting/chatroom.jsp">채팅</a>
		</ul>

		<div class="nav navbar-nav navbar-right">

			<span class="navbar-text">${sessionScope.userid } 님 환영합니다</span> <a
				class="navbar-text" href="/psManager/account_servlet/signout.do">로그아웃</a>

		</div>


	</div>
</nav>