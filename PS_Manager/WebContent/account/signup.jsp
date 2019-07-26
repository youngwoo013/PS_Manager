<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- header -->
<jsp:include page="/include/header.jsp" />
<title>Sign up -PSM</title>
</head>
<body>
	<!-- nav -->
	<jsp:include page="/include/nav.jsp" />

	<div class="container">
		<div class="col-lg-4"></div>

		<div class="col-lg-4">

			<!-- 점보트론 -->
			<div class="jumbotron" style="padding-top: 20px;">
			
				<form method="post" action="/psManager/account_servlet/signup.do">
					<h3 style="text-align: center">회원가입</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디"
							name="userid" maxlength="20">
					</div>

					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호"
							name="passwd" maxlength="20">
					</div>

					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름"
							name="name" maxlength="20">
					</div>

					<div class="form-group">
						<input type="text" class="form-control"
							placeholder="전화번호(00000000000)" name="phonenum" maxlength="20">
					</div>
					
					<div class="form-group">
						<input type="email" class="form-control" placeholder="email(email@email.com)"
							name="email" maxlength="20">
					</div>

					<div class="form-group">
						<input type="text" class="form-control"
							placeholder="생년월일(960101)" name="birth" maxlength="20">
					</div>

					<div class="form-group">
						<input type="submit" class="btn btn-primary form-control"
							value="확인">
					</div>
				</form>
			</div>
		</div>

		<div class="col-lg-4"></div>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

	<script src="js/bootstrap.min.js"></script>

</body>
</html>