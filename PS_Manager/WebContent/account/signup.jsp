<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign up -PSM</title>
</head>
<body>
<form method = "post" action = "/psManager/account_servlet/signup.do">
아이디 : <input type = "text" name="userid"><br>
비밀번호 : <input type = "password" name = "passwd"><br>
이름 : <input type ="text" name = "name"><br>
전화번호 : <input type = "text" name = "phonenum"><br>
이메일 : <input type = "text" name = "email"><br>
생일 : <input = "text" name = "birth"><br>
<input type="submit" value="확인">
</form>
</body>
</html>