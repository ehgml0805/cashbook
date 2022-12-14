<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="vo.*"%>

<%
request.setCharacterEncoding("utf-8");
String msg = request.getParameter("msg");

int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
int rowPerPage = 5;
int beginRow = (currentPage - 1) * rowPerPage;

NoticeDao noticeDao = new NoticeDao();
ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
int selectNoticeCount = noticeDao.selectNoticeCount();//전체 행의 개수 가져오기
//System.out.println(selectNoticeCount);
//last page 구하기
int lastPage = selectNoticeCount / rowPerPage;
//System.out.println(lastPage);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="apple-touch-icon" sizes="76x76"
	href="resource/assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="resource/assets/img/favicon.png">
<title>LOGIN</title>
<!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700"
	rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css"
	rel="stylesheet">
<!-- Nucleo Icons -->
<link href="resource/assets/css/nucleo-icons.css" rel="stylesheet" />
<link href="resource/assets/css/nucleo-svg.css" rel="stylesheet" />
<!-- Font Awesome Icons -->
<link href="resource/assets/css/font-awesome.css" rel="stylesheet" />
<link href="resource/assets/css/nucleo-svg.css" rel="stylesheet" />
<!-- CSS Files -->
<link href="resource/assets/css/argon-design-system.css?v=1.2.2"
	rel="stylesheet" />
</head>

<body class="login-page">

	<section class="section section-shaped section-lg">
		<div class="shape shape-style-1 bg-gradient-default">
			<!-- 배경 -->
			<span></span>
			<!--땡땡이 무늬-->
			<span></span> <span></span> <span></span> <span></span> <span></span>
			<span></span> <span></span>
		</div>
		<div class="container pt-lg-1"><!-- 배경 상단 높이 -->
			<div class="row justify-content-center">
				<div class="col-lg-5"><!-- 하얀부분 가로  -->
					<div class="card bg-secondary shadow border-0">
						<div class="card-header bg-white pb-3">
							<div class="text-muted text-center mb-3">
								<small>Sign in with</small>
							</div>
							<div class="btn-wrapper text-center">
								<a href="#" class="btn btn-neutral btn-icon"> <span
									class="btn-inner--icon"><img
										src="resource/assets/img/icons/common/github.svg"></span> <span
									class="btn-inner--text">Github</span>
								</a> <a href="#" class="btn btn-neutral btn-icon"> <span
									class="btn-inner--icon"><img
										src="resource/assets/img/icons/common/google.svg"></span> <span
									class="btn-inner--text">Google</span>
								</a>
							</div>
						</div>
						<div class="card-body px-lg-5 py-lg-5">
							<div class="text-center text-muted mb-4">
								<small>Or sign in with credentials</small>
							</div>
							<form action="<%=request.getContextPath()%>/loginAction.jsp"
								method="post" role="form" id="loginForm">

								<%
								if (msg != null) {
								%>

								<div>
									<div class="alert alert-danger" role="alert">
										<%=msg%>
									</div>
								</div>
								<%
								}
								%>
								<div class="form-group mb-3">
									<div class="input-group input-group-alternative">
										<div class="input-group-prepend">
											<span class="input-group-text"><i
												class="ni ni-email-83"></i></span>
										</div>
										<input type="text" name="memberId" id="memberId"
											class="form-control form-control-alternative"
											placeholder="아 이 디">
									</div>
								</div>
								<div class="form-group focused">
									<div class="input-group input-group-alternative">
										<div class="input-group-prepend">
											<span class="input-group-text"><i
												class="ni ni-lock-circle-open"></i></span>
										</div>
										<input type="password" name="memberPw" id="memberPw"
											class="form-control form-control-alternative"
											placeholder="비밀번호">
									</div>
								</div>
								<div
									class="custom-control custom-control-alternative custom-checkbox">
									<input class="custom-control-input" id=" customCheckLogin"
										type="checkbox"> <label class="custom-control-label"
										for=" customCheckLogin"><span>Remember me</span></label>
								</div>
								<div class="text-center">
									<button type="button" class="btn btn-primary my-3" id="loginBt">Sign
										in</button>
								</div>
							</form>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-6">
							<a href="#" class="text-light"><small>비밀번호를 잊어버리셨나요?</small></a>
						</div>
						<div class="col-6 text-right">
							<a href="<%=request.getContextPath()%>/insertMemberForm.jsp"
								class="text-light"><small>회원가입</small></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 신규 공지 5개 페이징 -->
	<footer class="footer">
		<div class="container">
			<div class="row row-grid align-items-center mb-5">
				<!--하단 넓이로 추정 -->
				<table class="table">
					<tr class="text-center">
						<th>Notice</th>
						<th>DATE</th>
					</tr>
					<%
					for (Notice n : list) {
					%>
					<tr>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
					</tr>
					<%
					}
					%>
				</table>
			</div>
			<hr>
			<div class="row align-items-center justify-content-md-between">
				<div class="col-md-6">
					<div class="copyright">&copy; 2022 도랑</div>
				</div>
				<div class="col-md-6">
					<ul class="nav nav-footer justify-content-end">
						<li class="nav-item"><a href="" class="nav-link"
							target="_blank">Creative Tim</a></li>
						<li class="nav-item"><a href="" class="nav-link"
							target="_blank">About Us</a></li>
						<li class="nav-item"><a href="" class="nav-link"
							target="_blank">Blog</a></li>
						<li class="nav-item"><a href="" class="nav-link"
							target="_blank">License</a></li>
					</ul>
				</div>
			</div>
		</div>
		<script>
			let loginBt=document.querySelector('#loginBt');
			loginBt.addEventListener('click',function(e) {
				//디버깅	
			 	console.log('loginBt click!')
			 	
			let memberId=document.querySelector('#memberId');
			if(memberId.value==''){
				alert('아이디를 입력하세요!');
				memberId.focus();
				return;
				}
				
			let memberPw=document.querySelector('#memberPw');
			if(memberPw.value==''){
				alert('비밀번호를 입력하세요!')
				memberPw.focus();
				return;
			}
			
			let loginForm=document.querySelector('#loginForm');
			loginForm.submit();
			
			});
		</script>
	</footer>
	<!--   Core JS Files   -->
	<script src="resourc/assets/js/core/jquery.min.js"
		type="text/javascript"></script>
	<script src="resourc/assets/js/core/popper.min.js"
		type="text/javascript"></script>
	<script src="resourc/assets/js/core/bootstrap.min.js"
		type="text/javascript"></script>
	<script src="resourc/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
	<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
	<script src="resourc/assets/js/plugins/bootstrap-switch.js"></script>
	<!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
	<script src="resourc/assets/js/plugins/nouislider.min.js"
		type="text/javascript"></script>
	<script src="resourc/assets/js/plugins/moment.min.js"></script>
	<script src="resourc/assets/js/plugins/datetimepicker.js"
		type="text/javascript"></script>
	<script src="resourc/assets/js/plugins/bootstrap-datepicker.min.js"></script>
	<!-- Control Center for Argon UI Kit: parallax effects, scripts for the example pages etc -->
	<!--  Google Maps Plugin    -->
	<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
	<script src="resourc/assets/js/argon-design-system.min.js?v=1.2.2"
		type="text/javascript"></script>
	<script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>
	<script>
		window.TrackJS && TrackJS.install({
			token : "ee6fab19c5a04ac1a32a645abde4613a",
			application : "argon-design-system-pro"
		});
	</script>
</body>
</html>