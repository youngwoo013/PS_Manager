<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign in - PSM</title>
</head>
<body>
<form method = "post" action = "/psManager/account_servlet/signin.do">
아이디 <input type="text" name="userid"><br>
비밀번호 <input type="password" name="passwd"><br>
<input type="submit" value="확인">
</form>
<form method = "post" action = "/psManager/account/signup.jsp">
<input type="submit" value="회원가입">
</form>
${param.message }
</body>
</html>