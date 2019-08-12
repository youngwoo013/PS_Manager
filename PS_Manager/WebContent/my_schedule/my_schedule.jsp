<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<!-- fullcalendar -->
<link href='../Resources/fullcalendar/core/main.css' rel='stylesheet' />
<link href='../Resources/fullcalendar/daygrid/main.css' rel='stylesheet' />

<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			plugins : [ 'dayGrid' ]
		});

		calendar.render();
	});
</script>

<!-- modal입력 받게 백그라운드 처리 -->
<style type="text/css">
.modal-backdrop {
	/* bug fix - no overlay */
	display: none;
}
</style>

<!-- header -->
<jsp:include page="/include/header.jsp" />

<title>Welcome - PSM</title>

</head>

<%@  include file="/include/session_check.jsp"%>

<body>

	<!-- nav -->
	<jsp:include page="/include/nav_login.jsp" />

	<!-- 사이드바 -->
	<div class="sidebar col-md-2">
		<div class="panel panel-info">
			<div class="panel-heading">
				<h4>프로젝트 목록</h4>
			</div>
		</div>
		<ul class="list-group">
			<li class="list-group-item"><a href="#">~~</a></li>
		</ul>
	</div>
	<div class="col-md-10">

		<div class="container">

			<!-- 프로젝트 생성 -->
			<!-- modal 구동 버튼(트리거) -->
			<button type="button" class="btn btn-secondary" data-toggle="modal"
				data-target="#create_pjt">프로젝트 생성</button>

			<!-- modal -->
			<div class="modal fade" id="create_pjt" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title">프로젝트 생성</h4>
						</div>

						<div class="modal-body">
							<form>
								<div class="form-group">
									<input type="text" class="form-control" placeholder="프로젝트 명"
										id="pname" name="pname" maxlength="20">
								</div>
								<div class="form-group">
									<input type="text" class="form-control" placeholder="프로젝트 매니저"
										id="pmanager" name="pmanager" maxlength="20">
								</div>
								<div class="form-group">
									<input type="text" class="form-control" placeholder="프로젝트 설명"
										id="pdescription" name="pdescription" maxlength="20">
								</div>
							</form>
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">닫기</button>
							<button type="submit" id="submit_pjt_info"
								class="btn btn-primary">생성</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 생성 버튼 누르면 정보 저장 후 modal 닫기 -->
			<script type="text/javascript">
				$(function() {
					$('#submit_pjt_info').click(function(e) {

						var pjt_info = {
							pname : $('#pname').val(),
							pmanager : $('#pmanager').val(),
							pdescription : $('#pdescription').val()
						};
						$.ajax({
							type : "POST",
							url : "../project_servlet/createPjt.do",
							// 						datatype : "json",
							data : pjt_info,
							success : function(result) {
								if (result == 0)
									alert("필수항목을 기입해주세요");
								else
									alert($('#pname').val() + " 프로젝트가 생성되었습니다");

							},
							error : function(e) {
								alert("문제가 발생했습니다");
							}
						});
						e.preventDefault();
						$('#create_pjt').modal('hide')
					});
				});
			</script>

			<!-- 프로젝트 삭제 -->
			<!-- modal 구동 버튼(트리거) -->
			<button type="button" class="btn btn-secondary" data-toggle="modal"
				data-target="#delete_pjt">프로젝트 삭제</button>

			<!-- modal -->
			<div class="modal fade" id="delete_pjt" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title">프로젝트 삭제</h4>
						</div>

						<div class="modal-body">
							<!-- 프로젝트 목록 보여주기 -->
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">닫기</button>
							<button type="submit" id="submit_pjt_info"
								class="btn btn-primary">생성</button>
						</div>
					</div>
				</div>
			</div>

			<div id="calendar" style="width: 90%"></div>

		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="../Resources/js/bootstrap.min.js"></script>
	<script src='../Resources/fullcalendar/core/main.js'></script>
	<script src='../Resources/fullcalendar/daygrid/main.js'></script>
</body>
</html>