<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="config.DB"%>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="account.AccountDTO" %>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>

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


<%
	String cur = new SimpleDateFormat("yyyy").format(new Date());
%>
<script>
	var check = { "ID" : false, "PWD" : false, "EMAIL" : false, "BIRTH" : true};
	var test = 1;
	function regex(regex ,value, type){
		var successAlert = $('#success'+type).alert();
		var dangerAlert = $('#danger'+type).alert();
		if(!regex.test(value)){
			check[type] = false;
			successAlert.hide();
			dangerAlert.show();
		}
		else{
			check[type] = true;
			dangerAlert.hide();
			successAlert.show();
		}

		
	}
	function submitFunction() {

		var year = Number($('#year').val());
		var month = $('#month').val();		//month는 select 이므로 이미 완성
		var day = Number($('#day').val());
		var cur_year = <%=cur%>;
		
		if(year<1900 || year>cur_year) check["BIRTH"] = false;
		else if(month == 'NAN') check["BIRTH"] = false;
		else if(day<1 || day >31) check["BIRTH"] = false;
		
		if(check['BIRTH'] == false){
			alert('생년월일을 확인해 주세요.');
			return;
		}
		if(day>=1 && day <=9) day = "0"+ day;		//형식에 맞춰서 0을 집어 넣는다

		var userid = $('#userid').val();
		var passwd = $('#passwd').val();
		var name = $('#name').val();
		var phonenum = $('#phonenum').val();
		var email = $('#email').val();
		var birth = ""+year+month+day;
		$.ajax({
			type : "POST",
			url : "../account_servlet/update.do",
			data : {
				userid : userid,
				passwd : passwd,
				name : name,
				phonenum : phonenum,
				birth : birth
			},
			success : function(result) {
				if(result!=null) window.location.href = result;
			}
		});
	}

</script>
<title>Insert title here</title>

<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/session_check.jsp"/>

<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/psManager/Resources/css/chatbox.css">
<script src="../Resources/js/bootstrap.js"></script>
<style type="text/css">
textarea {
	resize: none;
}
		
img { display: block; margin: 0px auto; }
	
</style>

</head>
<body>
<jsp:include page="/include/nav_login.jsp" />
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
<div class="container">
		<div class="col-lg-2"></div>

		<div class="col-lg-8">

			<!-- 점보트론 -->
			<div class="jumbotron" style="padding-top: 20px;">

				<h2 style="text-align: center; margin-bottom: 30px">마이페이지</h2>
				<div class="form-group">
					<h4>&nbsp아이디</h4>
					<div class="row">
						<div class="col-xs-5">
							<input type="text" class="form-control" id="userid" value=<%=userid %> readonly="readonly">
						</div>

					</div>
				</div>
				<div class="form-group">
					<h4>&nbsp비밀번호</h4>
					<div class="row">
						<div class="col-xs-5">
							<input type="password" class="form-control" 
								placeholder="특문.숫자.영문포함 8~15자" id="passwd" maxlength="15"
								value=<%=passwd%> readonly="readonly"
								onkeyup="regex(/(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$/, this.value, 'PWD');">
						</div>
						<div class="col-xs-7">
							<div class="alert alert-success" id="successPWD"
								style="display: none">
								<strong>사용가능한 패스워드입니다.</strong>
							</div>
							<div class="alert alert-danger" id="dangerPWD"
								style="display: none">
								<strong>패스워드 형식이 올바르지 않습니다.</strong>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<h4>&nbsp이름</h4>
					<div class="row">
						<div class="col-xs-5">
							<input type="text" class="form-control" placeholder="홍길동" value=<%=name %> readonly="readonly"
								id="name" maxlength="20">
						</div>
					</div>
				</div>
				<div class="form-group">
					<h4>&nbsp전화번호</h4>
					<div class="row">
						<div class="col-xs-7">
							<input type="text" class="form-control" placeholder="01000000000"
								id="phonenum" maxlength="11" value=<%=phonenum %> readonly="readonly"
								onkeyup="this.value=this.value.replace(/[^0-9]*/g,'');">
						</div>
					</div>
				</div>
				<div class="form-group">
					<h4>&nbsp이메일</h4>
					<div class="row">
						<div class="col-xs-7">
							<input type="email" class="form-control"
								placeholder="example@example.com" id="email" maxlength="20" value=<%=email %> readonly="readonly"
								onkeyup="regex(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i, this.value, 'EMAIL');">
						</div>
						<div class="col-xs-5">
							<div class="alert alert-danger" id="dangerEMAIL"
								style="display: none">
								<strong>이메일 형식이 올바르지 않습니다.</strong>
							</div>
							<div class="alert alert-success" id="successEMAIL"
								style="display: none">
								<strong>사용가능한 이메일입니다.</strong>
							</div>
						</div>
					</div>
				</div>

				<div class="form-group">
					<h4>&nbsp생년월일</h4>
					<div class="row">
						<div class="col-xs-3">
							<input type="text" class="form-control" placeholder="년도(4자)"
								id="year" maxlength="4" value=<%=birth/10000%> readonly="readonly"
								onkeyup="this.value=this.value.replace(/[^0-9]*/g,'');">
						</div>
						<div class="row">
							<div class="col-xs-3">
								<input type="text" class="form-control" placeholder="월(2자)"
								id="month" maxlength="4" value=<%=birth%10000/100%> readonly="readonly">
							</div>
							<div class="col-xs-3">
								<input type="text" class="form-control" placeholder="일" id="day" value=<%=birth%100 %> readonly="readonly"
									maxlength="2"
									onkeyup="this.value=this.value.replace(/[^0-9]*/g,'');">
								<!-- 숫자만 입력 가능 -->
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<h4>&nbsp프로필사진</h4>
					<div class="row">
						<div class="col-xs-7">
							<%if(photo!=null) {%>
								<input type="text" class="form-control" placeholder="01000000000"
								id="photo" maxlength="11" value=<%=photo %> readonly="readonly"> <br>
								<img src="${pageContext.request.contextPath}/img/<%=photo%>" width="300" height="200"/>
								
							
							<%} 
							else{
							%>
							<input type="text" class="form-control" placeholder="01000000000"
								id="photo" maxlength="11" value="프로필 사진을 등록해 주세요" readonly="readonly"> <br>
								<img src="${pageContext.request.contextPath}/img/default.png" width="300" height="200" />
								
							<%} %>	
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<button type='button' class="btn btn-primary form-control"
						onclick="location.href='/psManager/Upload/uploadForm.jsp';">프로필사진 관리 </button>
				
				</div>
				<div class="form-group">
					<button type='button' class="btn btn-primary form-control"
						onclick="location.href='/psManager/account/account_update.jsp';" style="margin-top: 20px">수정하기</button>
				</div>
				<div class="form-group">
					<button type='button' class="btn btn-primary form-control"
						onclick="location.href='/psManager/index.jsp';" style="margin-top: 20px">확인</button>
				</div>
			</div>
		</div>

		<div class="col-lg-2"></div>
	</div>
<form action="/psManager/account_servlet/update.do" method="post">
	
</form>


</body>
</html>