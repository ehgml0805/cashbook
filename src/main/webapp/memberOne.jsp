<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@page import="vo.*"%>
<%
if (session.getAttribute("loginMember") == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
//session에 있는 ID랑 NAME 받아오기
Member loginMember = (Member) session.getAttribute("loginMember");
String memberId = loginMember.getMemberId();
String memberName = loginMember.getMemberName();
//개인 정보 변경 후 돌아오면 이름 변경 안되어 있는데 로그아웃하고 다시 들어어면 바뀌어 있음,,,뭐로 받아와야하나-> 세션에 저장 하면 댐
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="apple-touch-icon" sizes="76x76"
	href="../assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="../assets/img/favicon.png">
<meta charset="UTF-8">
<title>마이페이지</title>
</title>
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

<body class="profile-page">
	<!-- Navbar -->
	<nav id="navbar-main"
		class="navbar navbar-main navbar-expand-lg navbar-transparent navbar-light py-2">
		<div class="container">
			<a class="navbar-brand mr-lg-5"
				href="<%=request.getContextPath()%>/memberOne.jsp"> <img
				src="resource/assets/img/brand/white.png">
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbar_global" aria-controls="navbar_global"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="navbar-collapse collapse" id="navbar_global">
				<div class="navbar-collapse-header">
					<div class="row">
						<div class="col-6 collapse-brand">
							<a href="<%=request.getContextPath()%>/memberOne.jsp"> <img
								src="resource/assets/img/brand/blue.png">
							</a>
						</div>
						<div class="col-6 collapse-close">
							<button type="button" class="navbar-toggler"
								data-toggle="collapse" data-target="#navbar_global"
								aria-controls="navbar_global" aria-expanded="false"
								aria-label="Toggle navigation">
								<span></span> <span></span>
							</button>
						</div>
					</div>
				</div>

				<ul class="navbar-nav navbar-nav-hover align-items-lg-center">
					<li class="nav-item dropdown"><a href="#" class="nav-link"
						data-toggle="dropdown" href="#" role="button"> <i
							class="ni ni-collection d-lg-none"></i> <span
							class="nav-link-inner--text">MENU</span>
					</a>
						<div class="dropdown-menu">
							<a href="<%=request.getContextPath()%>/index.jsp"
								class="dropdown-item">Index</a>
							<a
								href="<%=request.getContextPath()%>/cash/cashList.jsp"
								class="dropdown-item">Calender</a>
							<a
								href="<%=request.getContextPath()%>/help/helpList.jsp"
								class="dropdown-item">Help</a>
						</div></li>
				</ul>
				<ul class="navbar-nav align-items-lg-center ml-lg-auto">
					<li class="nav-item"><a class="nav-link nav-link-icon"
						href="https://www.facebook.com/CreativeTim/" target="_blank"
						data-toggle="tooltip" title="Like us on Facebook"> <i
							class="fa fa-facebook-square"></i> <span
							class="nav-link-inner--text d-lg-none">Facebook</span>
					</a></li>
					<li class="nav-item"><a class="nav-link nav-link-icon"
						href="https://www.instagram.com/creativetimofficial"
						target="_blank" data-toggle="tooltip"
						title="Follow us on Instagram"> <i class="fa fa-instagram"></i>
							<span class="nav-link-inner--text d-lg-none">Instagram</span>
					</a></li>
					<li class="nav-item"><a class="nav-link nav-link-icon"
						href="https://twitter.com/creativetim" target="_blank"
						data-toggle="tooltip" title="Follow us on Twitter"> <i
							class="fa fa-twitter-square"></i> <span
							class="nav-link-inner--text d-lg-none">Twitter</span>
					</a></li>
					<li class="nav-item"><a class="nav-link nav-link-icon"
						href="https://github.com/creativetimofficial/argon-design-system"
						target="_blank" data-toggle="tooltip" title="Star us on Github">
							<i class="fa fa-github"></i> <span
							class="nav-link-inner--text d-lg-none">Github</span>
					</a></li>
					<%
						if(loginMember.getMemberLevel() > 0) {
					%>
							<li class="nav-item">
							<a class="btn btn-neutral"
							href="<%=request.getContextPath()%>/admin/adminMain.jsp"> <span
								class="nav-link-inner--text">Admin Page</span>
							</a></li>
					<%	
						}
					%>
					<li class="nav-item d-none d-lg-block"><a
						href="<%=request.getContextPath()%>/logOut.jsp" target="_blank"
						class="btn btn-neutral btn-icon"> <span
							class="btn-inner--icon"> </span> <span
							class="nav-link-inner--text">LOG OUT</span>
					</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="wrapper">
		<section class="section-profile-cover section-shaped my-0">
			<!-- Circles background -->
			<img class="bg-image" src="resource/assets/img/pages/mohamed.jpg"
				style="width: 100%;">
			<!-- SVG separator -->
			<div class="separator separator-bottom separator-skew">
				<svg x="0" y="0" viewBox="0 0 2560 100" preserveAspectRatio="none"
					version="1.1" xmlns="http://www.w3.org/2000/svg">
				<polygon class="fill-secondary" points="2560 0 2560 100 0 100"></polygon>
	        </svg>
			</div>
		</section>
		<section class="section bg-secondary">
			<div class="container">
				<div class="card card-profile shadow mt--300">
					<!-- 야자수 배경 -->
					<div class="px-6">
						<!-- 흰배경 여백같은? -->
						<div class="row justify-content-center">
							<div class="col-lg-3 order-lg-2">
								<div class="card-profile-image">
									<a href="javascript:;"> <img
										src="resource/assets/img/faces/team-4.jpg"
										class="rounded-circle">
									</a>
								</div>
							</div>
							<div
								class="col-lg-4 order-lg-3 text-lg-right align-self-lg-center">
								<div class="card-profile-actions py-4 mt-lg-0">
									<a href="<%=request.getContextPath()%>/updateMemberForm.jsp"
										class="btn btn-sm btn-info mr-4">개인정보 수정</a>
									<!--숫자는 간격 -->
									<a href="<%=request.getContextPath()%>/deleteMemberForm.jsp"
										class="btn btn-sm btn-default float-right">회원 탈퇴</a>
								</div>
							</div>
							<div class="col-lg-4 order-lg-1">
								<div class="card-profile-stats d-flex justify-content-center">
									<div>
										<span class="heading">22</span> <span class="description">Friends</span>
									</div>
									<div>
										<span class="heading">10</span> <span class="description">Photos</span>
									</div>
									<div>
										<span class="heading">89</span> <span class="description">Comments</span>
									</div>
								</div>
							</div>
						</div>
						<div class="text-center mt-5">
							<h3>
								<span class="font-weight-light"><%=memberName%></span>
							</h3>
							<div class="h4 font-weight-300">
								<i class="ni location_pin mr-2"></i>ID
								<%=memberId%></div>
							<div class="h4 mt-4">
								<i class="ni business_briefcase-24 mr-2"></i>구디아카데미 공공데이터 과정 자바 58기 김도희 개인프로젝트.
								
							</div>
							<div>
								<i class="ni education_hat mr-2"></i>
									마리아 디비를 이용하고 mvc모델1으로 만들어 보았음.
							</div>
						</div>
						<div class="mt-5 py-5 border-top text-center">
							<div class="row justify-content-center">
								<div class="col-lg-9">
									<p>An artist of considerable range, Ryan — the name taken
										by Melbourne-raised, Brooklyn-based Nick Murphy — writes,
										performs and records all of his own music, giving it a warm,
										intimate feel with a solid groove structure. An artist of
										considerable range.</p>
									<a href="javascript:;">Show more</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<footer class="footer">
			<div class="container">
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
		</footer>
	</div>
	<!--   Core JS Files   -->
	<script src="resource/assets/js/core/jquery.min.js"
		type="text/javascript"></script>
	<script src="resource/assets/js/core/popper.min.js"
		type="text/javascript"></script>
	<script src="resource/assets/js/core/bootstrap.min.js"
		type="text/javascript"></script>
	<script
		src="resource/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
	<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
	<script src="resource/assets/js/plugins/bootstrap-switch.js"></script>
	<!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
	<script src="resource/assets/js/plugins/nouislider.min.js"
		type="text/javascript"></script>
	<script src="resource/assets/js/plugins/moment.min.js"></script>
	<script src="resource/assets/js/plugins/datetimepicker.js"
		type="text/javascript"></script>
	<script src="resource/assets/js/plugins/bootstrap-datepicker.min.js"></script>
	<!-- Control Center for Argon UI Kit: parallax effects, scripts for the example pages etc -->
	<!--  Google Maps Plugin    -->
	<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
	<script src="resource/assets/js/argon-design-system.min.js?v=1.2.2"
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