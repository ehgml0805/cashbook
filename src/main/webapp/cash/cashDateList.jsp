<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.* "%>
<%@ page import="java.sql.* "%>
<%@ page import="java.net.URLEncoder"%>

<%
request.setCharacterEncoding("utf-8");
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if (session.getAttribute("loginMember") == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
//System.out.println(msg1 + "메시지");
String loginMemberId = loginMember.getMemberId();
int year = Integer.parseInt(request.getParameter("year"));
//System.out.println(year + "년도");
int month = Integer.parseInt(request.getParameter("month"));
//System.out.println(month + "월");
int date = Integer.parseInt(request.getParameter("date"));
//System.out.println(date + "<-날짜");
//model 가져오기
//카테고리 목록
CategoryDao categoryDao = new CategoryDao();
ArrayList<Category> categoryList = categoryDao.selectCategoryList();
//캐시 목록
CashDao cashDao = new CashDao();
ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
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
<title>가계부 날짜 별 상세보기</title>
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

<body class="login-page">
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
							class="nav-link-inner--text">MY PAGE</span>
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
			<form id="insertCashForm"
				action="<%=request.getContextPath()%>/cash/insertCashAction.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>"
				method="post">
				<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
				<input type="hidden" name="year" value="<%=year%>">
				<input type="hidden" name="month" value="<%=month%>">
				<input type="hidden" name="date" value="<%=date%>">
					<div style="font-weight: bold;">
						사용일자
					</div>
					<div>
						<input type="text" name="cashDate"
							value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly" class="form-control form-control">
					</div>
					<div style="font-weight: bold;">
						항목
					</div>
					<div style="font-weight: bold;">
						<select name="categoryNo" class="form-control form-control">
							<%
							for (Category c : categoryList) {
							%>
							<option value="<%=c.getCategoryNo()%>">
								<%=c.getCategoryNo()%>
								<%=c.getCategoryKind()%>
								<%=c.getCategoryName()%>
							</option>
							<%
							}
							%>
						</select>
					</div>
					<div style="font-weight: bold;">
						사용금액
					</div>
					<div style="font-weight: bold;">
						<input type="text" name="cashPrice" class="form-control form-control" id="cashPrice">
					</div>
					<div style="font-weight: bold;">
						메모
					</div>
					<div>
						<textarea class="form-control  form-control-alternative" rows="3" cols="10" name="cashMemo" id="cashMemo"></textarea>
					</div>
				<div class="text-center">
					<button type="button" class="btn btn-primary mt-4" id="insetCashBt">추가</button>
				</div>
			</form>
			<script>
				let insetCashBt=document.querySelector('#insetCashBt');
				insetCashBt.addEventListener('click', function(e) {
					console.log('insetCashBt click');
					
					let cashPrice=document.querySelector('#cashPrice');
					if(cashPrice.value==''){
						alert('금액을 입력하세요');
						cashPrice.focus();
						return;
					}
					
					let cashMemo=document.querySelector('#cashMemo');
					if(cashMemo.value==''){
						alert('메모를 입력하세요');
						cashMemo.focus();
						return;
					}
					let insertCashForm=document.querySelector('#insertCashForm');
					insertCashForm.submit();
				});
			</script>
			<br>
			<br>
			<table class="table">
				<tr style="text-align: center;">
					<td>사용 날짜</td>
					<td>수입/지출</td>
					<td>항목</td>
					<td>가격</td>
					<td>메모</td>
					<td>수정 / 삭제</td>

				</tr>
				<%
				for (HashMap<String, Object> m : list) {
					String cashDate = (String) (m.get("cashDate"));
					if (Integer.parseInt(cashDate.substring(8)) == date) {
				%>
				<tr style="text-align: center;">
					<td><%=m.get("cashDate")%></td>
					<td><%=m.get("categoryKind")%></td>
					<td><%=m.get("categoryName")%></td>
					<td><%=m.get("cashPrice")%></td>
					<td><%=m.get("cashMemo")%></td>
					<td><a
						href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=m.get("cashNo")%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">수정</a>
						/ <a
						href="<%=request.getContextPath()%>/cash/deleteCashAction.jsp?cashNo=<%=m.get("cashNo")%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">삭제</a></td>
				</tr>
				<%
				}
				}
				%>
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