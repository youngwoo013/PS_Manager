<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- header -->
<jsp:include page="/include/header.jsp" />
<style>
.alert {
	padding: 6px;
	margin-bottom: 0px;
}
</style>
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
		if(check['ID'] == false){
			alert('아이디를 확인해 주세요.');
			return;
		}
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
		$.ajax({
			type : "POST",
			url : "../account_servlet/signup.do",
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
<title>Sign up -PSM</title>
</head>
<body>
	<!-- nav -->
	<jsp:include page="/include/nav.jsp" />

	<div class="container">
		<div class="col-lg-2"></div>

		<div class="col-lg-8">

			<!-- 점보트론 -->
			<div class="jumbotron" style="padding-top: 20px;">

				<h2 style="text-align: center; margin-bottom: 30px">회원가입</h2>
				<div class="form-group">
					<h4>&nbsp아이디</h4>
					<div class="row">
						<div class="col-xs-5">
							<input type="text" class="form-control" id="userid"
								placeholder="영문.숫자  6~15자 이내" maxlength="15">
						</div>
						<div class="col-xs-2">
							<button type="button" class="btn btn-default pull-right"
								onclick="validateID();">중복체크</button>
						</div>
						<div class="col-xs-5">
							<div class="alert alert-danger" id="dangerID"
								style="display: none">
								<strong>중복된 아이디입니다.</strong>
							</div>
							<div class="alert alert-danger" id="dangerID2"
								style="display: none">
								<strong>아이디 형식이 올바르지 않습니다.</strong>
							</div>
							<div class="alert alert-success" id="successID"
								style="display: none">
								<strong>사용가능한 아이디입니다.</strong>
							</div>
						</div>

					</div>
				</div>
				<div class="form-group">
					<h4>&nbsp비밀번호</h4>
					<div class="row">
						<div class="col-xs-5">
							<input type="password" class="form-control"
								placeholder="특문.숫자.영문포함 8~15자" id="passwd" maxlength="15"
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
							<input type="text" class="form-control" placeholder="홍길동"
								id="name" maxlength="20">
						</div>
					</div>
				</div>
				<div class="form-group">
					<h4>&nbsp전화번호</h4>
					<div class="row">
						<div class="col-xs-7">
							<input type="text" class="form-control" placeholder="01000000000"
								id="phonenum" maxlength="11"
								onkeyup="this.value=this.value.replace(/[^0-9]*/g,'');">
						</div>
					</div>
				</div>
				<div class="form-group">
					<h4>&nbsp이메일</h4>
					<div class="row">
						<div class="col-xs-7">
							<input type="email" class="form-control"
								placeholder="example@example.com" id="email" maxlength="20"
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
								id="year" maxlength="4"
								onkeyup="this.value=this.value.replace(/[^0-9]*/g,'');">
						</div>
						<div class="row">
							<div class="col-xs-3">
								<select id="month" class="form-control">
									<option value="NAN">월</option>
									<option value="01">1</option>
									<option value="02">2</option>
									<option value="03">3</option>
									<option value="04">4</option>
									<option value="05">5</option>
									<option value="06">6</option>
									<option value="07">7</option>
									<option value="08">8</option>
									<option value="09">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
								</select>
							</div>
							<div class="col-xs-3">
								<input type="text" class="form-control" placeholder="일" id="day"
									maxlength="2"
									onkeyup="this.value=this.value.replace(/[^0-9]*/g,'');">
								<!-- 숫자만 입력 가능 -->
							</div>
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

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

	<script src="../Resources/js/bootstrap.min.js"></script>

</body>
</html>