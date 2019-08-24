<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<!-- header -->
<jsp:include page="/include/header.jsp" />

<!-- fullcalendar -->
<link href='../Resources/fullcalendar/core/main.css' rel='stylesheet' />
<link href='../Resources/fullcalendar/daygrid/main.css' rel='stylesheet' />
<link href='../Resources/fullcalendar/timegrid/main.css' rel='stylesheet' />
<link href='../Resources/fullcalendar/timeline/main.css' rel='stylesheet' />
<link href='../Resources/fullcalendar/resource-timeline/main.css' rel='stylesheet' />
<script src='../Resources/fullcalendar/core/main.js'></script>
<script src='../Resources/fullcalendar/interaction/main.js'></script>
<script src='../Resources/fullcalendar/daygrid/main.js'></script>
<script src='../Resources/fullcalendar/timegrid/main.js'></script>
<script src='../Resources/fullcalendar/timeline/main.js'></script>
<script src='../Resources/fullcalendar/resource-common/main.js'></script>
<script src='../Resources/fullcalendar/resource-timeline/main.js'></script>


<script type="text/javascript">

	//fullcalendar
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			plugins : [ 'interaction', 'dayGrid' ],

			header : {
				left : 'prev,next today',
				center : 'title',
				right : 'addEventBtn'
			},
			defaultView : 'dayGridMonth',
			selectable : true,

			dateClick : function(info) {
				var pnum = <%=request.getParameter("pnum")%>;
				if(pnum===null){
					alert("프로젝트를 선택해주세요");
					return;
				
				}
				var schedule = prompt(info.dateStr + '의 일정을 입력하세요');

				if (schedule) {
					calendar.addEvent({
						title : schedule,
						start : info.dateStr
					});
					// 일정추가
					$.ajax({
						type : "POST",
						url : "../schedule_servlet/add_pjtSchedule.do",
						data : {
							userid : "<%=session.getAttribute("userid")%>",
							pnum : <%=request.getParameter("pnum")%>,
							description : schedule,
							sday : info.dateStr,
							eday : info.dateStr
						},
						sucess : function(res) {
							console.log(res)
						},
						error : function() {
							alert("일정을 추가하는 데 문제가 발생했습니다")
						}
					
					});
				} else {
					alert('일정을 입력하세요');
				}
			}
		});

		calendar.render();
	});
	
	// 프로젝트 보여줌
	$(document).ready(function() { //문서가 불러오면 실행됨
		showPjt();
	});
	
	function showPjt(){
		$.ajax({
			type:"GET",
			url:"../project_servlet/showPjt.do",
			data : {
				userid : "<%=session.getAttribute("userid")%>"
			},
// 			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(res){
				console.log("pjtInfo = " + res);
				var pnum = "";
				var pname = "";
				$("#pjt_list").empty();
				$(res).find('pjtInfo').each(function(){
					
	                pnum = $(this).find('pnum').text();
	                pname = $(this).find('pname').text();
	                
	                $('#pjt_list').append("<li class='list-group-item'><a href='/psManager/schedule/pjt_schedule.jsp?pnum="
	                		+ pnum +"'>" +pname+"</a></li>");
	                });
                 
           } , 
           error : function(){ 
                        alert('프로젝트 로드에 실패했습니다'); 
                   }
           });
	}
	
	
</script>


<title>Welcome - PSM</title>

</head>

<%@  include file="/include/session_check.jsp"%>

<!-- modal입력 받게 백그라운드 처리 -->
<style type="text/css">
.modal-backdrop {
	/* bug fix - no overlay */
	display: none;
}
</style>

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
		<ul class="list-group" id="pjt_list">

			<!-- 프로젝트 보여주는 곳 -->
		</ul>
	</div>
	<div class="col-md-10">

		<div class="container">

			<!-- 팀원 추가 -->
			<!-- modal 구동 버튼(트리거) -->
			<button type="button" class="btn btn-secondary" data-toggle="modal"
				data-target="#add_coworker">팀원 추가</button>

			<!-- modal -->
			<div class="modal fade" id="add_coworker" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title">팀원 추가</h4>
						</div>

						<div class="modal-body">
							<form>
								<div class="form-group" id="insert_div">
								<input type="text" class="form-control" placeholder="팀원 아이디"
								id="coworker"  maxlength="20"></div>
							</form>
						</div>

						<div class="modal-footer">
							<button type="button" id="add_input"
								class="btn btn-primary">추가</button>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">닫기</button>
							<input type="submit" id="submit_coworker" value="저장"
								class="btn btn-success"/>
						</div>
					</div>
				</div>
			</div>

			<!-- 생성 버튼 누르면 정보 저장 후 modal 닫기 -->
			<script type="text/javascript">
				$(function() {
					$('#submit_coworker').click(
							function(e) {

// 								var cowork_info = {
// 									cowork_id : $('#').val()
// 									};
								$.ajax({
									type : "POST",
									url : "../project_servlet/addCoworker.do",
// 									data : cowork_info,
									success : function(result) {
										if (result == 0)
											alert("필수항목을 기입해주세요");
										else
											alert("팀원이 추가되었습니다");

									},
									error : function(e) {
										alert("문제가 발생했습니다");
									}
								});
								e.preventDefault();
								$('#add_coworker').modal('hide')
							});
				});
			</script>

		</div>
		
		<div id="calendar" style="width: 90%"></div>
		
		
	</div>

	<script>
	//추가 버튼
	$('#add_input').on("click", function() {
		
		var addCoworker = '<div class="form-group" id="div_input">'
		+ '<input type="text" class="form-control" placeholder="팀원 아이디"'
		+'id="coworker"  maxlength="20"></div>';
		
		var divHtml = $("#insert_div:last"); //last를 사용하여 div_input라는 명을 가진 마지막 태그 호출
		divHtml.after(addCoworker); //마지막 divHtml명 뒤에 붙인다.
		});

// 		//삭제 버튼
// 		$(document).on("click", "button[name=delStaff]", function() {

// 			var trHtml = $(this).parent().parent();

// 			trHtml.remove(); //tr 테그 삭제

// 		});
	</script>

	
	
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="../Resources/js/bootstrap.min.js"></script>
	
</body>
</html>