<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	var check = {"PWD" : true, "EMAIL" : true, "BIRTH" : true};
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
		if(check['PWD'] == false){
			alert('비밀번호를 확인해 주세요.');
			return;
		}
		if(check['EMAIL'] == false){
			alert('이메일을 확인해 주세요.');
			return;
		}

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
		var photo= $('#photo').val();
		$.ajax({
			type : "POST",
			url : "../account_servlet/update.do",
			data : {
				userid : userid,
				passwd : passwd,
				name : name,
				phonenum : phonenum,
				email : email,
				birth : birth,
				photo : photo
			},
			success : function(result) {
				if(result!=null) window.location.href = result;
			}
		});
	}
	function validateID() {
		var userid = $('#userid').val();
		var regexID = /^[A-Za-z0-9]{6,15}/;
		var successAlert = $('#successID').alert();	//통과시 성공 문구
		var dangerAlert = $('#dangerID').alert();	//중복체크 검사 실패 문구
		var dangerAlert2 = $('#dangerID2').alert();	//정규표현식 검사 실패 문구
		if(regexID.test(userid) == false){
			successAlert.hide();
			dangerAlert.hide();
			dangerAlert2.show();
			check['ID'] = false;
			return;
		} 
		$.ajax({
			type : "POST",
			url : "../account_servlet/validateID.do",
			data : {
				userid : userid
			},
			success : function(result){
				if (result == 1){
					dangerAlert.hide();
					dangerAlert2.hide();
					successAlert.show();
					check['ID'] = true;
				}else if (result == 0){
					dangerAlert2.hide();
					successAlert.hide();
					dangerAlert.show();
					check['ID'] = false;
				}
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

				<h2 style="text-align: center; margin-bottom: 30px">프로필 수정</h2>
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
								value=<%=passwd%>
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
							<input type="text" class="form-control" placeholder="홍길동" value=<%=name %>
								id="name" maxlength="20">
						</div>
					</div>
				</div>
				<div class="form-group">
					<h4>&nbsp전화번호</h4>
					<div class="row">
						<div class="col-xs-7">
							<input type="text" class="form-control" placeholder="01000000000"
								id="phonenum" maxlength="11" value=<%=phonenum %>
								onkeyup="this.value=this.value.replace(/[^0-9]*/g,'');">
						</div>
					</div>
				</div>
				<div class="form-group">
					<h4>&nbsp이메일</h4>
					<div class="row">
						<div class="col-xs-7">
							<input type="email" class="form-control"
								placeholder="example@example.com" id="email" maxlength="20" value=<%=email %>
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
								id="year" maxlength="4" value=<%=birth/10000 %>
								onkeyup="this.value=this.value.replace(/[^0-9]*/g,'');">
						</div>
						<div class="row">
							<%int month= birth%10000/100;
								pageContext.setAttribute("month", month);
							%>
							<c:set var="birthmonth" value="${month}" />
							<div class="col-xs-3">
								<select id="month" class="form-control"> 
									<option value="NAN">월</option>
									<option value="01" <c:if test="${birthmonth==1}">selected</c:if>>1</option>
									<option value="02" <c:if test="${birthmonth==2}">selected</c:if>>2</option>
									<option value="03" <c:if test="${birthmonth==3}">selected</c:if>>3</option>
									<option value="04" <c:if test="${birthmonth==4}">selected</c:if>>4</option>
									<option value="05" <c:if test="${birthmonth==5}">selected</c:if>>5</option>
									<option value="06" <c:if test="${birthmonth==6}">selected</c:if>>6</option>
									<option value="07" <c:if test="${birthmonth==7}">selected</c:if>>7</option>
									<option value="08" <c:if test="${birthmonth==8}">selected</c:if>>8</option>
									<option value="09" <c:if test="${birthmonth==9}">selected</c:if>>9</option>
									<option value="10" <c:if test="${birthmonth==10}">selected</c:if>>10</option>
									<option value="11" <c:if test="${birthmonth==11}">selected</c:if>>11</option>
									<option value="12" <c:if test="${birthmonth==12}">selected</c:if>>12</option>
								</select>
							</div>
							<div class="col-xs-3">
								<input type="text" class="form-control" placeholder="일" id="day" value=<%=birth%100 %>
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
							<input type="text" class="form-control" placeholder="01000000000"
								id="photo" maxlength="11" value=<%=photo %> readonly="readonly">
								<img src="${pageContext.request.contextPath}/img/<%=photo%>"/>
								
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<button type='button' class="btn btn-primary form-control"
						onclick="submitFunction();" style="margin-top: 20px">확인</button>
				</div>
			</div>
		</div>

		<div class="col-lg-2"></div>
	</div>



</body>
</html>