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
<link href='../Resources/fullcalendar/timegrid/main.css'
	rel='stylesheet' />
<link href='../Resources/fullcalendar/timeline/main.css'
	rel='stylesheet' />
<link href='../Resources/fullcalendar/resource-timeline/main.css'
	rel='stylesheet' />
<script src='../Resources/fullcalendar/core/main.js'></script>
<script src='../Resources/fullcalendar/interaction/main.js'></script>
<script src='../Resources/fullcalendar/daygrid/main.js'></script>
<script src='../Resources/fullcalendar/timegrid/main.js'></script>
<script src='../Resources/fullcalendar/timeline/main.js'></script>
<script src='../Resources/fullcalendar/resource-common/main.js'></script>
<script src='../Resources/fullcalendar/resource-timeline/main.js'></script>

<script type="text/javascript">
	var calendarEl = null;
	var calendar = null;
	
	//fullcalendar
	document.addEventListener('DOMContentLoaded', function() {
 		var calendarEl = document.getElementById('calendar');
		calendar = new FullCalendar.Calendar(calendarEl, {
			plugins : [ 'interaction', 'dayGrid', 'timeGrid' ],
			
			header: {
				left : 'prev,next today',
				center: 'title',
				right: 'addEventBtn'
			},
			defaultView: 'dayGridMonth',
			selectable: true,
			width : 'parent',
			
			dateClick : function(info) {
				var schedule = prompt(info.dateStr + '의 일정을 입력하세요');

				if (schedule) {
					calendar.addEvent({
						title : schedule,
						start : info.dateStr
					});
					
					// 개인 일정추가
					$.ajax({
						type : "POST",
						url : "../schedule_servlet/add_mySchedule.do",
						data : {
							userid : "<%=session.getAttribute("userid")%>",
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
	
	//문서가 불러오면 실행됨
	$(document).ready(function() { 
		
		showPjt();
		
		$.ajax({
			type : "GET",
			url : "../schedule_servlet/show_Myschedule.do",
			data : {
				userid : "<%=session.getAttribute("userid")%>"
			},
			success : function(res) {
				console.log("my_scheduleInfo = " + res);
				var sday = "",
					eday = "",
					description = "";
				$(res).find('scheduleInfo').each(function(){
					
	                sday = $(this).find('sday').text().replace(/\//g,"-");
	                eday = $(this).find('eday').text().replace(/\//g,"-");
	                description = $(this).find('description').text();
	                
	                calendar.addEvent({
						title : description,
						start : sday
					});
	               
	                calendar.render();
				});
                 
			},
			error : function() {
				alert("스케쥴을 불러오는 데 문제가 발생했습니다")
			}
			
		});
	});
	
	function showPjt(){
		$.ajax({
			type:"GET",
			url:"../project_servlet/showPjt.do",
			data : {
				userid : "<%=session.getAttribute("userid")%>"
			},
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
	

	// 생성 버튼 누르면 정보 저장 후 modal 닫기
	$(function() {
		$('#submit_pjt_info').click(function(e) {
			var pjt_info = {
				pname : $('#pname').val(),
				pmanager :  "<%=session.getAttribute("userid")%>",
								pdescription : $('#pdescription').val()
				};
			$.ajax({
				type : "POST",
				url : "../project_servlet/createPjt.do",
				data : pjt_info,
				success : function(result) {
					if (result == 0) {
						alert("필수항목을 기입해주세요");
					} else {
						alert($('#pname').val() + " 프로젝트가 생성되었습니다");
						showPjt();
					}
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

<!-- modal입력 받게 백그라운드 처리 -->
<style type="text/css">
.modal-backdrop {
	/* bug fix - no overlay */
	display: none;
}
</style>


<title>Welcome - PSM</title>

</head>

<%@  include file="/include/session_check.jsp"%>

<body>
	
	<div class="container-fluid" style="margin-left:10px;margin-right:10px">
		
		<!-- nav -->
		<jsp:include page="/include/nav_login.jsp" />
		
		<div class="row">
			
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
				
				<div class = "row">
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
				</div>
				
				<div id="calendar"></div>
			</div>
		</div>
	</div>
		


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="../Resources/js/bootstrap.min.js"></script>

</body>
</html>