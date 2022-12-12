<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

<%
request.setCharacterEncoding("utf-8");
//CRUD 다 해야댐 noticeDao 만들어서 해야할 듯?
//controller
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if (loginMember == null || loginMember.getMemberLevel() < 1) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
//model 호출:notice의 리스트 
int currentPage = 1;//1페이지부터 보여줄거고
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
int rowPerPage = 10;
int beginRow = (currentPage - 1) * rowPerPage;
//lastPage 구해야함 
NoticeDao noticeDao = new NoticeDao();
ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
int selectNoticeCount = noticeDao.selectNoticeCount();//전체 행의 개수 가져오기
//System.out.println(selectNoticeCount);
//last page 구하기
int lastPage = selectNoticeCount / rowPerPage;
//System.out.println(lastPage);
if (selectNoticeCount / rowPerPage != 0) {
	lastPage = lastPage + 1;
}

//view
%>

<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="apple-touch-icon" sizes="76x76"
	href="../resource/assets/img/apple-icon.png">
<link rel="icon" type="image/png"
	href="../resource/assets/img/favicon.png">
<title>공지 관리</title>
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
							<a href="<%=request.getContextPath()%>/admin/adminMain.jsp"
								class="dropdown-item">Admin Main</a> <a
								href="<%=request.getContextPath()%>/admin/noticeList.jsp"
								class="dropdown-item">Notice</a> <a
								href="<%=request.getContextPath()%>/admin/categoryList.jsp"
								class="dropdown-item">Category</a> <a
								href="<%=request.getContextPath()%>/admin/helpListAll.jsp"
								class="dropdown-item">Help List</a> <a
								href="<%=request.getContextPath()%>/admin/memberList.jsp"
								class="dropdown-item">Member</a>
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
	<!-- 페이징 작업 똑같이 하면 댐...그 머냐,,,10개씩 출력하면 되겠지,,, -->
	<section class="section section-shaped section-lg">
		<div class="shape shape-style-1 bg-gradient-default"></div>
		<!-- 배경 색 -->
		<!-- 고객센터 문의 목록 -->
		<div class="container">
			<div class="p-5 mb-7 bg-light">
				<h3>Notice List</h3>
				<!-- 공지 입력 만들기 -->
				<div>
					<a
						href="<%=request.getContextPath()%>/admin/notice/insertNoticeForm.jsp">공지
						추가</a>
				</div>
				<!-- table 배경색 -->
				<div class="row row-grid align-items-center mb-5 ">
					<table class="table text-center">
						<tr>
							<th>No.</th>
							<th>내용</th>
							<th>날짜</th>
							<th>수정 / 삭제</th>
						</tr>
						<%
						for (Notice n : list) {
						%>
						<tr>
							<td>No.<%=n.getNoticeNo()%></td>
							<td><%=n.getNoticeMemo()%></td>
							<td><%=n.getUpdatedate()%></td>
							<td><a
								href="<%=request.getContextPath()%>/admin/notice/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>&noticeMemo=<%=n.getNoticeMemo()%>">수정</a>
							/ 
							<a
								href="<%=request.getContextPath()%>/admin/notice/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a></td>
						</tr>
						<%
						}
						%>

					</table>
					<a
						href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1">처음</a>
					<%
					if (currentPage > 1) {
					%>
					<a
						href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
					<%
					}
					%>
					<span><%=currentPage%></span>
					<%
					if (currentPage < lastPage) {
					%>
					<a
						href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
					<%
					}
					%>
					<a
						href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>">마지막</a>

				</div>
			</div>
		</div>
	</section>
	<footer class="footer">
		<div class="container">
			<div class="row row-grid align-items-center mb-5">
				<!--하단 넓이로 추정 -->
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