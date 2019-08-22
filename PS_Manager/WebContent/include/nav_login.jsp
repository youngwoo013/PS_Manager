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

		<a class="navbar-brand" href="/psManager/index.jsp">JSP 게시판</a>

	</div>

	<div class="collapse navbar-collapse"
		id="#bs-example-navbar-collapse-1">

		<ul class="nav navbar-nav">
			<li><a href="/psManager/memo/memo.jsp">한줄 메모장</a></li>
			<li><a href="/psManager/pjt_schedule/pjt_schedule.jsp">프로젝트</a></li>
			<li><a href="/psManager/chatting/chatroom.jsp">채팅</a>
			<li><a href="/psManager/agora.jsp">정보광장</a>
		</ul>

		<div class="nav navbar-nav navbar-right">

			<a class="navbar-text" href="/psManager/account/account_view.jsp"> ${sessionScope.userid } 님 환영합니다 </a>  <!-- 로그인 후 자기아이디 클릭하면 내정보로 넘어감 -->
			<a
				class="navbar-text" href="/psManager/account_servlet/signout.do">로그아웃</a>

		</div>


	</div>
</nav>