<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
//방어코드
if (session.getAttribute("loginMember") == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
String msg1 = request.getParameter("msg1");
//model 호출
Member loginMember = (Member) session.getAttribute("loginMember");
String loginMemberId = loginMember.getMemberId();
String loginMemberName = loginMember.getMemberName();
String loginMemberPw = loginMember.getMemberPw();
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
<title>비밀번호 수정</title>
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
		<div class="container pt-lg-4">
			<div class="row justify-content-center">
				<div class="col-lg-5">
					<div class="card bg-secondary shadow border-0">
						<div class="card-body px-lg-5 py-lg-5">
							<div class="text-center text-muted mb-4">
								<small>비밀번호 변경하기</small>
							</div>
							<%
							if (msg1 != null) {
							%>
							<%=msg1%>
							<%
							}
							%>
							<form
								action="<%=request.getContextPath()%>/updateMemberPWAction.jsp"
								method="post" role="form">
								<div class="form-group">
									<div class="input-group input-group-alternative mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text"><i
												class="ni ni-email-83"></i></span>
										</div>
										<input type="text" value="<%=loginMemberId%>" name="memberId"
											class="form-control" readonly="readonly">
									</div>
								</div>
								<div class="form-group">
									<div class="input-group input-group-alternative mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text"><i
												class="ni ni-email-83"></i></span>
										</div>
										<input type="text" name="memberName"
											value="<%=loginMemberName%>" readonly="readonly"
											class="form-control">
									</div>
								</div>
								<div class="form-group focused">
									<div class="input-group input-group-alternative">
										<div class="input-group-prepend">
											<span class="input-group-text"><i
												class="ni ni-lock-circle-open"></i></span>
										</div>
										<input type="password" name="bememberPw" class="form-control"
											placeholder="변경 전 비밀번호">
									</div>
								</div>
								<div class="form-group focused">
									<div class="input-group input-group-alternative">
										<div class="input-group-prepend">
											<span class="input-group-text"><i
												class="ni ni-lock-circle-open"></i></span>
										</div>
										<input type="password" name="memberPw" class="form-control"
											placeholder="변경 할 비밀번호">
									</div>
								</div>
								<div class="text-center">
									<button type="submit" class="btn btn-primary mt-4">UPDATE</button>
								</div>
							</form>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-6">
							<a href="<%=request.getContextPath()%>/memberOne.jsp"
								class="text-light"><small>마이 페이지</small></a>
						</div>
						<div class="col-6 text-right">
							<a href="<%=request.getContextPath()%>/logOut.jsp"
								class="text-light"><small>LOG OUT</small></a>
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
					<div class="copyright">
						&copy; 2022 <a href="" target="_blank">Creative Tim</a>.
					</div>
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

	<!--   Core JS Files   -->
	<script src="../assets/js/core/jquery.min.js" type="text/javascript"></script>
	<script src="../assets/js/core/popper.min.js" type="text/javascript"></script>
	<script src="../assets/js/core/bootstrap.min.js" type="text/javascript"></script>
	<script src="../assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
	<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
	<script src="../assets/js/plugins/bootstrap-switch.js"></script>
	<!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
	<script src="../assets/js/plugins/nouislider.min.js"
		type="text/javascript"></script>
	<script src="../assets/js/plugins/moment.min.js"></script>
	<script src="../assets/js/plugins/datetimepicker.js"
		type="text/javascript"></script>
	<script src="../assets/js/plugins/bootstrap-datepicker.min.js"></script>
	<!-- Control Center for Argon UI Kit: parallax effects, scripts for the example pages etc -->
	<!--  Google Maps Plugin    -->
	<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
	<script src="../assets/js/argon-design-system.min.js?v=1.2.2"
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