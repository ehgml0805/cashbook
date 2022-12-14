<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
//로그인이 안된 상태면 현재 페이지에 접근 못하게
request.setCharacterEncoding("utf-8");
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if (session.getAttribute("loginMember") == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
int memberLevel = loginMember.getMemberLevel();
//System.out.println(memberLevel + "<-멤버레벨");
//request 년,월이 넘어와야함,  아무것도 안넘어오면 이번달
int year = 0;
int month = 0;

if ((request.getParameter("year") == null) || request.getParameter("month") == null) {
	Calendar today = Calendar.getInstance();//오늘날짜
	year = today.get(Calendar.YEAR);
	month = today.get(Calendar.MONTH);
} else {
	year = Integer.parseInt(request.getParameter("year"));
	month = Integer.parseInt(request.getParameter("month"));
	if (month == -1) {
		month = 11;
		year -= 1;
	}
	if (month == 12) {
		month = 0;
		year += 1;
	}
}
//출력하고자 하는 월과 월을 1일의 요일(일요일=1 공백은 0 ...~토요일=7 공백은 6)
Calendar targetDate = Calendar.getInstance();
targetDate.set(Calendar.YEAR, year);
targetDate.set(Calendar.MONTH, month);
targetDate.set(Calendar.DATE, 1);
int firstDay = targetDate.get(Calendar.DAY_OF_WEEK);//요일
//마지막 날짜
int lastDate = targetDate.getActualMaximum(Calendar.DATE);

//begin firstDay-1
int beginBlank = firstDay - 1;
int endBlank = 0;//beginBlank+lastDate+endBlank--> 7로 나누어 떨어져야함
if ((beginBlank + lastDate) % 7 != 0) {
	endBlank = 7 - ((beginBlank + lastDate) % 7);
}
//전체 td가 7로 나누어 떨어져야 함
int totalTd = beginBlank + lastDate + endBlank;

//model 호출
CashDao cashDao = new CashDao();
ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month + 1);

Cash cash = new Cash();
cash.getCashNo();

//
%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="apple-touch-icon" sizes="76x76"
	href="../resource/assets/img/apple-icon.png">
<link rel="icon" type="image/png"
	href="../resource/assets/img/favicon.png">
<title>달력 및 가계부</title>
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
							<a href="<%=request.getContextPath()%>/index.jsp"
								class="dropdown-item">Index</a> <a
								href="<%=request.getContextPath()%>/cash/cashList.jsp"
								class="dropdown-item">Calender</a> <a
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
	<!-- End Navbar -->
	<section class="section section-shaped section-lg">
		<div class="shape shape-style-1 bg-gradient-default"></div>
		<!-- 배경 색 -->
		<div class="container">
			<div>
				<h3>
					<!-- 로그인 정보(loginMember 변수 출력) 출력 -->
					&#127881;<span style="color: green; font-weight: bold;"><%=loginMember.getMemberName()%></span><span
						style="color: white;">님 반갑습니다. </span> &#127881;
				</h3>
			</div>
			<div class="p-5 mb-7 bg-light">
				<!-- table 배경색 -->
				<div style="text-align: center;">
					<h2><%=year%>년
						<%=month + 1%>월
					</h2>
				</div>
				<h5>
					<div style="text-align: center;">
						<a
							href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month - 1%>">이전달
						</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

						<a
							href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month + 1%>">다음달
						</a>
					</div>
				</h5>
				<table class="table" style="table-layout: fixed">
					<tr style="word-break: break-all;">
						<th>일</th>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th>토</th>
					</tr>
					<%
					for (int i = 1; i <= totalTd; i++) {
					%>
					<td>
						<%
						int date = i - beginBlank;//시작 요일
						if (date > 0 && date <= lastDate) {
						%>
						<div>
							<a
								href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month + 1%>&date=<%=date%>">
								<%=date%></a>
						</div>
						<div>
							<%
							for (HashMap<String, Object> m : list) {
								String cashDate = (String) (m.get("cashDate"));
								if (Integer.parseInt(cashDate.substring(8)) == date) {
							%>
							<%
							if (m.get("categoryKind").equals("수입")) {
							%>
							<span style="color: blue;"> + <%=(String) (m.get("categoryKind"))%></span>
							<%
							} else {
							%>
							<span style="color: red;"> - <%=(String) (m.get("categoryKind"))%>
							</span>
							<%
							}
							%>
							<br><%=(String) (m.get("categoryName"))%>
							<%=(Long) (m.get("cashPrice"))%>원 <br>
							<%
							}
							}
							%>
						</div> <%
 }
 %>
					</td>
					<%
					if (i % 7 == 0 && i != totalTd) {//딱 맞아 떨어질때 마지막 한 줄이 더 생길 수도 있으니까 totalTd랑 i가 같으면 안됨
					%>
					</tr>
					<tr>
						<!-- td7개 만들고 테이블 줄 바꿈 -->
						<%
						}
						}
						%>
					</tr>
				</table>
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