<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>
<%@ page import="account.AccountDAO" %>
<%@ page import="java.sql.*" %>

<% //업로드 과정 
 request.setCharacterEncoding("euc-kr");
 String realFolder = "";
 String filename1 = "";
 int maxSize = 1024*1024*5;
 String encType = "euc-kr";
 String savefile = "img"; //저장될 폴더명 
 ServletContext scontext = getServletContext();
 realFolder = scontext.getRealPath(savefile); //정확히 뭘하는지모르겠음
 String userid=(String)session.getAttribute("userid");
 try{
  MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

  Enumeration<?> files = multi.getFileNames();
     String file1 = (String)files.nextElement();
     filename1 = multi.getFilesystemName(file1);
 } catch(Exception e) {
  e.printStackTrace();
 }
 
 String fullpath = realFolder + "\\" + filename1;
%>

<title>Insert title here</title>
</head>
<body>
	<img src="<%=fullpath%>" width=512 height=384></img>  <!-- 미리보긴데 외않될까 -->
	<%System.out.println(fullpath);
	AccountDAO dao= new AccountDAO();			//아이디에 따라 photo DB연결해줌
	dao.profile(userid, filename1);
	System.out.println(userid+filename1);
	
	%>
	<button type="button" onclick="location.href='/psManager/account/account_view.jsp' ">완료</button>
		
	
</body>
</html>

