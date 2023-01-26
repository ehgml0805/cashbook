<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="vo.*"%>
<%
//controller
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if (loginMember == null || loginMember.getMemberLevel() < 1) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
String loginMemberId = loginMember.getMemberId();
System.out.println(loginMemberId + "<-멤버아이디");
int memberLevel = loginMember.getMemberLevel();
System.out.println(memberLevel + "<-멤버레벨");
//model 호출

//최근 공지 5개, 신규 멤버 5명
int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
int rowPerPage = 5;
int beginRow = (currentPage - 1) * rowPerPage;
//lastPage 구해야함 
NoticeDao noticeDao = new NoticeDao();
ArrayList<Notice> Nolist = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
int selectNoticeCount = noticeDao.selectNoticeCount();//전체 행의 개수 가져오기
//System.out.println(selectNoticeCount);
int lastPage = selectNoticeCount / rowPerPage;
//System.out.println(lastPage);
MemberDao memberDao = new MemberDao();
ArrayList<Member> Melist = memberDao.selectMemberListByPage(beginRow, rowPerPage);

int selectMemberAdminCount = memberDao.selectMemberAdminCount();
int MelastPage = selectMemberAdminCount / rowPerPage;
if (selectMemberAdminCount / rowPerPage != 0) {
	lastPage = lastPage + 1;
}
//view
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="apple-touch-icon" sizes="76x76"
	href="../assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="../assets/img/favicon.png">
<title>관리자 메인 페이지</title>
<!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700"
	rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css"
	rel="stylesheet">
<!-- Nucleo Icons -->
<link href="../resource/assets/css/nucleo-icons.css" rel="stylesheet" />
<link href="../resource/assets/css/nucleo-svg.css" rel="stylesheet" />
<!-- Font Awesome Icons -->
<link href="../resource/assets/css/font-awesome.css" rel="stylesheet" />
<link href="../resource/assets/css/nucleo-svg.css" rel="stylesheet" />
<!-- CSS Files -->
<link href="../resource/assets/css/argon-design-system.css?v=1.2.2"
	rel="stylesheet" />
</head>
<body class="landing-page">
	<!-- Navbar -->
	<nav id="navbar-main"
		class="navbar navbar-main navbar-expand-lg navbar-transparent navbar-light py-2">
		<div class="container">
			<a class="navbar-brand mr-lg-5"
				href="<%=request.getContextPath()%>/memberOne.jsp"> <img
				src="../resource/assets/img/brand/white.png">
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
								src="../resource/assets/img/brand/blue.png">
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
							<a href="<%=request.getContextPath()%>/admin/noticeList.jsp"
								class="dropdown-item">Notice</a> <a
								href="<%=request.getContextPath()%>/admin/helpListAll.jsp"
								class="dropdown-item">Help List</a> <a
								href="<%=request.getContextPath()%>/admin/memberList.jsp"
								class="dropdown-item">Member List</a> <a
								href="<%=request.getContextPath()%>/admin/categoryList.jsp"
								class="dropdown-item">Category </a>
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
					<li class="nav-item"><a class="btn btn-neutral"
						href="<%=request.getContextPath()%>/memberOne.jsp"> <span
							class="nav-link-inner--text">My Page</span>
					</a></li>
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
		<div class="section section-hero section-shaped">
			<div class="shape shape-style-3 shape-default">
				<span class="span-150"></span> <span class="span-50"></span> <span
					class="span-50"></span> <span class="span-75"></span> <span
					class="span-100"></span> <span class="span-75"></span> <span
					class="span-50"></span> <span class="span-100"></span> <span
					class="span-50"></span> <span class="span-100"></span>
			</div>
			<div class="page-header">
				<div
					class="container shape-container d-flex align-items-center py-lg">
					<div class="col px-0">
						<div class="row align-items-center justify-content-center">
							<div class="col-lg-6 text-center">
								<h1 class="text-white display-1">관리자 메인</h1>
								<h2 class="display-4 font-weight-normal text-white"></h2>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="separator separator-bottom separator-skew zindex-100">
				<svg x="0" y="0" viewBox="0 0 2560 100" preserveAspectRatio="none"
					version="1.1" xmlns="http://www.w3.org/2000/svg">
          <polygon class="fill-white" points="2560 0 2560 100 0 100"></polygon>
        </svg>
			</div>
		</div>
		<div class="section features-4">
			<div class="container">
				<div class="row ">
					<div class="col-lg-6 ">
						<div class="info info-horizontal info-hover-primary">
							<div class="col-lg-6 col-16 mx-md-auto">
								<h3 class="title">New Member</h3>
								<!-- 신규 멤버 5명 페이징 -->
								<table class="text-center">
									<tr>
										<td>ID</td>
										<td>이름</td>
										<td>가입 날짜</td>
									</tr>
									<%
									for (Member m : Melist) {
									%>
									<tr>
										<td><%=m.getMemberId()%></td>
										<td><%=m.getMemberName()%></td>
										<td><%=m.getCreatedate()%></td>
									</tr>
									<%
									}
									%>
								</table>
								<a href="<%=request.getContextPath()%>/admin/memberList.jsp"
									class="text-info">More</a>
							</div>
						</div>
					</div>
					<div class="col-lg-6 col-16 mx-md-auto">
						<h3 class="title">Notice</h3>
						<!-- 신규 공지 5개 페이징 -->
						<table>
							<tr class="text-center">
								<td>공지사항</td>
								<td>날짜</td>
							</tr>
							<%
							for (Notice n : Nolist) {
							%>
							<tr>
								<td><%=n.getNoticeMemo()%></td>
								<td><%=n.getCreatedate()%></td>
							</tr>
							<%
							}
							%>
						</table>
						<a href="<%=request.getContextPath()%>/admin/noticeList.jsp"
							class="text-info">More</a>
					</div>
				</div>
			</div>
		</div>
		<div class="section features-1">
			<div class="container">
				<div class="row">
					<div class="col-md-4">
						<div class="info">
							<div
								class="icon icon-lg icon-shape icon-shape-primary shadow rounded-circle">
								<i class="ni ni-settings-gear-65"></i>
							</div>
							<h6 class="info-title text-uppercase text-primary">Social
								Conversations</h6>
							<p class="description opacity-8">We get insulted by others,
								lose trust for those others. We get back stabbed by friends. It
								becomes harder for us to give others a hand.</p>
							<a href="javascript:;" class="text-primary">More about us <i
								class="ni ni-bold-right text-primary"></i>
							</a>
						</div>
					</div>
					<div class="col-md-4">
						<div class="info">
							<div
								class="icon icon-lg icon-shape icon-shape-success shadow rounded-circle">
								<i class="ni ni-air-baloon"></i>
							</div>
							<h6 class="info-title text-uppercase text-success">Analyze
								Performance</h6>
							<p class="description opacity-8">Don't get your heart broken
								by people we love, even that we give them all we have. Then we
								lose family over time. As we live, our hearts turn colder.</p>
							<a href="javascript:;" class="text-primary">Learn about our
								products <i class="ni ni-bold-right text-primary"></i>
							</a>
						</div>
					</div>
					<div class="col-md-4">
						<div class="info">
							<div
								class="icon icon-lg icon-shape icon-shape-warning shadow rounded-circle">
								<i class="ni ni-world"></i>
							</div>
							<h6 class="info-title text-uppercase text-warning">Measure
								Conversions</h6>
							<p class="description opacity-8">What else could rust the
								heart more over time? Blackgold. The time is now for it to be
								okay to be great. or being a bright color. For standing out.</p>
							<a href="javascript:;" class="text-primary">Check our
								documentation <i class="ni ni-bold-right text-primary"></i>
							</a>
						</div>
					</div>

				</div>
			</div>
		</div>
		<footer class="footer">

			<div class="container">
				<div class="row row-grid align-items-center mb-5">
					<div class="col-lg-6">
						<h3 class="text-primary font-weight-light mb-2"></h3>
						<h4 class="mb-0 font-weight-light"></h4>
					</div>
					<div class="col-lg-6 text-lg-center btn-wrapper">
						<button target="_blank" href="https://twitter.com/creativetim"
							rel="nofollow"
							class="btn btn-icon-only btn-twitter rounded-circle"
							data-toggle="tooltip" data-original-title="Follow us">
							<span class="btn-inner--icon"><i class="fa fa-twitter"></i></span>
						</button>
						<button target="_blank"
							href="https://www.facebook.com/CreativeTim/" rel="nofollow"
							class="btn-icon-only rounded-circle btn btn-facebook"
							data-toggle="tooltip" data-original-title="Like us">
							<span class="btn-inner--icon"><i class="fab fa-facebook"></i></span>
						</button>
						<button target="_blank" href="https://dribbble.com/creativetim"
							rel="nofollow"
							class="btn btn-icon-only btn-dribbble rounded-circle"
							data-toggle="tooltip" data-original-title="Follow us">
							<span class="btn-inner--icon"><i class="fa fa-dribbble"></i></span>
						</button>
						<button target="_blank"
							href="https://github.com/creativetimofficial" rel="nofollow"
							class="btn btn-icon-only btn-github rounded-circle"
							data-toggle="tooltip" data-original-title="Star on Github">
							<span class="btn-inner--icon"><i class="fa fa-github"></i></span>
						</button>
					</div>
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
		</footer>
	</div>
	<!--   Core JS Files   -->
	<script src="../resource/assets/js/core/jquery.min.js"
		type="text/javascript"></script>
	<script src="../resource/assets/js/core/popper.min.js"
		type="text/javascript"></script>
	<script src="../resource/assets/js/core/bootstrap.min.js"
		type="text/javascript"></script>
	<script
		src="../resource/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
	<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
	<script src="../resource/assets/js/plugins/bootstrap-switch.js"></script>
	<!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
	<script src="../resource/assets/js/plugins/nouislider.min.js"
		type="text/javascript"></script>
	<script src="../resource/assets/js/plugins/moment.min.js"></script>
	<script src="../resource/assets/js/plugins/datetimepicker.js"
		type="text/javascript"></script>
	<script src="../resource/assets/js/plugins/bootstrap-datepicker.min.js"></script>
	<!-- Control Center for Argon UI Kit: parallax effects, scripts for the example pages etc -->
	<!--  Google Maps Plugin    -->
	<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
	<script src="../resource/assets/js/argon-design-system.min.js?v=1.2.2"
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