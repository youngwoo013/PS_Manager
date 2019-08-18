<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../include/header.jsp" />
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Resources/css/chatbox.css">
<script src="../Resources/js/bootstrap.js"></script>
<style type="text/css">
textarea {
	resize: none;
}
</style>
</head>
<script>
	var lastID = 0;
	function submitFunction(){
		var chatName = $('#chatName').val();
		var chatContent = $('#chatContent').val();
		$.ajax({
			type: "POST",
			url: "/psManager/chat_servlet/submit.do",
			data : {
				chatName : chatName,
				chatContent : chatContent
			},
			success : function(result){
				if(result ==1){ //데이터가 성공적을 들어갈 시 성공 메세지
					autoClosingAlert('#successMessage', 2000);
				}
				else if(result == 0) //데이터 입력값 오류
					autoClosingAlert('#dangerMessage', 2000);
				else  //데이터베이스 오류
					autoClosingAlert('#warningMessage', 2000);
			}
		});
		$('#chatContent').val(''); 
	}	
	function autoClosingAlert(selector, delay){
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function(){alert.hide()}, delay);
	}
	function chatListFunction(type){ //ajax를 이용하여 채팅 목록을 가져온다. type이 today 일시 오늘 채팅을 가져옴 -> 현재 안씀, ten일 시 최근 10개를 가져옴 -> 맨 처음 사용,
									 //숫자가 오면 lastID이므로 lastID보다 큰 chatID의 채팅을 1초마다 갱신 
		$.ajax({
			type: "POST",
			url: "/psManager/chat_servlet/show.do",
			data : {
				listType: type
			},
			success : function(data){
				if(data=="") return;
				var parsed = JSON.parse(data); //json을 파싱한 후 parsed에 저장
				var result = parsed.result;  //result객체에 채팅 정보가 담겨있음
				for(var i =0; i< result.length; i++){
					addChat(result[i][0].value, result[i][1].value, result[i][2].value);
				}
				lastID = Number(parsed.last);  //last에는 lastID가 담겨있음
			}
		});		
	}
	function addChat(chatName, chatContent, chatTime){ //채팅창에 추가되는 함수, ****img부분을 개인정보의 사진과 연동해야할 필요성이 있다
		$('#chatList').append(
					'<div class="row">' +
					'<div class="col-lg-12">' +
					'<div class="media">' +
					'<a class="pull-left" href="#">' +
					'<img class="media-object img-circle img-chat" src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="">' +
					'</a>' +
					'<div class="media-body">' +
					'<h4 class="media-heading">'+chatName +
					'<span class="small pull-right">'+chatTime+'</span>' +
					'</h4>' +
					'<p>' + chatContent + '</p>' +
					'</div>' +
					'</div>' +
					'</div>' +
					'</div>' +
					'<hr>'
				);
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
	}
	function getInfiniteChat(){
		setInterval(function(){
			chatListFunction(lastID);
		}, 1000);
	}
</script>

<body>
	<%
		String cur_day = new SimpleDateFormat("yyyy년 MM월 dd일").format(new Date());
	%>
	<!-- nav -->
	<jsp:include page="/include/nav.jsp" />
	<div class="container">
		<div class="container bootstrap snippet">
			<div class="row">
				<div class="col-xs-12" style="max-height: 600px;">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h4>
									<i class="fa fa-circle text-green"></i>실시간 채팅방
								</h4>
							</div>
							<div class="clearfix"></div>
						</div>
						<div id="chat" class="panel-collapse collapse in">
							<div id="chatList" class="portlet-body chat-widget"
								style="overflow-y: auto; width: auto; height: 350px;"></div>
							<div class="row">
								<div class="col-lg-12">
									<p class="text-center text-muted small"><%=cur_day%></p>
									<!-- 현재 날짜를 입력해야함 -->
								</div>
							</div>
							<div class="portlet-footer">
								<div class="row">
									<div class="form-group col-xs-4">
										<input style="height: 40px;" type="text" id="chatName"
											class="form-control" placeholder="이름" maxlength="8">
									</div>
								</div>
								<div class="row" style="height: 90px">
									<div class="form-group col-offset-xs-1 col-xs-10">
										<textarea style="height: 80px;" id="chatContent"
											class="form-control" placeholder="메세지를 입력하세요."
											maxlength="100"></textarea>
									</div>
									<div class="form-group col-xs-2">
										<button type="button" class="btn btn-default pull-right"
											onclick="submitFunction();">전송</button>
									</div>
									<div class="clearfix"></div>
								</div>

							</div>
						</div>
					</div>
				</div>
				<!-- /.col-md-4 -->
			</div>
		</div>
		<div class="alert alert-success" id="successMessage"
			style="display: none">
			<strong>메세지 전송에 성공하였습니다.</strong>
		</div>
		<div class="alert alert-danger" id="dangerMessage"
			style="display: none;">
			<strong>이름과 내용을 모두 입력해주세요.</strong>
		</div>
		<div class="alert alert-warning" id="warningMessage"
			style="display: none;">
			<strong>데이터베이스 오류가 발생했습니다.</strong>
		</div>
	</div>
	<script>
		$(document).ready(function(){ //문서가 불러오면 실행됨
			chatListFunction('ten'); //최근 10개만 불러온다
			getInfiniteChat(); //1초마다 최신 채팅을 받아오는 함수 실행
		});
	</script>
</body>
</html>