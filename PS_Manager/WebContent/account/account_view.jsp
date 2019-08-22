<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="config.DB"%>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="account.AccountDTO" %>
<%!
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	String userid, passwd, name, phonenum, email, photo;
	int birth;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	
	userid=(String)session.getAttribute("userid");		//DB연결 내가 하던거랑 다름 근데 되긴됨 
	String sql = "select * from account where userid= ? ";
	conn=DB.dbConn();
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, userid);
	rs=pstmt.executeQuery();
	
	
	while(rs.next()) {
		passwd=rs.getString("passwd");
		name=rs.getString("name");
		phonenum=rs.getString("phonenum");
		email=rs.getString("email");
		birth=rs.getInt("birth");
		photo=rs.getString("photo");
		System.out.println(userid);
		System.out.println(passwd);
		System.out.println(email);
		System.out.println(birth);
		System.out.println(photo);
		
	}

%>

<form action="/psManager/account_servlet/update.do" method="post">
	아이디 : <input type="text" name="userid" size="20" value=<%=userid %> readonly="readonly"/> <br>
	패스워드: <input type="password" name="passwd" size="20" value=<%=passwd%>><br>
	이름 : <input type="text" name="name" size="20" value=<%=name%>><br>
	전화번호 : <input type="text" name="phonenum" size="20" value=<%=phonenum%>><br>
	이메일 : <input type="text" name="email" size="20" value=<%=email%>><br>
	생년월일 : <input type="text" name="birth" size="20" value=<%=birth%>><br>
	프로필사진 : <input type="text" name="photo" size="20" value=<%=photo%> readonly="readonly"/><br> 
	<a class="text" href="/psManager/Upload/uploadForm.jsp"> 프로필 사진 올리기 </a><br>
	<input type="submit" value="정보수정">	
</form>


</body>
</html>