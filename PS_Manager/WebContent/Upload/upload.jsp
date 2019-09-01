<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>
<%@ page import="account.AccountDAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.multipart.FileRenamePolicy" %>
<%@ page import="java.io.*" %>
<%@ page import="upload.FileUploadRename" %>

<% //업로드 과정 
 
request.setCharacterEncoding("euc-kr");
String realFolder = "";
String filename1 = "";
int maxSize = 1024*1024*5;
String encType = "euc-kr";
String savefile = "img"; //저장될 폴더명 내컴은 C:\Users\37-909\eclipse-workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\psManager\img
						 //tomcat 서버 설정에 기본 경로 나와있음, img 폴더가 미리 있어야함.  
ServletContext scontext = getServletContext();
realFolder = scontext.getRealPath(savefile); 
String userid=(String)session.getAttribute("userid");
String save_file_name=userid;
MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new FileUploadRename(save_file_name)); 
//fileuploadrename class 이용해 파일명을 userid로 바꿔버리고 새로 넣으면 자동으로 새것으로 수정되버림.  

Enumeration<?> files = multi.getFileNames();
String file1 = (String)files.nextElement();
filename1 = multi.getFilesystemName(file1);     
String fullpath = realFolder + "\\" + filename1;

%>

<title>Insert title here</title>
</head>
<body>
	
	
	
	
	<%System.out.println(fullpath);
	System.out.println(filename1);
	AccountDAO dao= new AccountDAO();			//아이디에 따라 photo DB연결해줌
	dao.profile(userid, filename1);
	System.out.println(userid+filename1);
	%>
	<script>
	alert('요청 처리 완료');
	location.href="/psManager/account/account_view.jsp";
	
	</script>
	
		
	
</body>
</html>

