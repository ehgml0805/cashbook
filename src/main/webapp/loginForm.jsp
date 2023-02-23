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
    <link rel="apple-touch-icon" sizes="76x76" href="resource2/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="resource2/assets/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>로그인</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
    <!--     Fonts and icons     -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
    <!-- CSS Files -->
    <link href="resource2/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="resource2/assets/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet" />
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="resource2/assets/css/demo.css" rel="stylesheet" />
</head>

<body>
            <div class= data-color="black" data-image="resource2/assets/img/full-screen-image-3.jpg" ;>
            <br>
			<div class="content">
				<div class="row">
						<div class="col-md-4 col-sm-6 ml-auto mr-auto">
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
								<div class="card card-login card-hidden">
									<div class="card-header ">
										<h3 class="header text-center">Sign In</h3>
									</div>
									<div class="card-body ">
										<div class="card-body">
											<div class="form-group">
												<label>Email address</label> <input type="text"
													name="memberId" id="memberId"
													class="form-control form-control-alternative"
													placeholder="아 이 디" value="fkd0910">
											</div>
											<div class="form-group">
												<label>Password</label> <input type="password"
													name="memberPw" id="memberPw"
													class="form-control form-control-alternative"
													placeholder="비밀번호" value="1234">
											</div>
											<div class="form-group">
												<div class="form-check">
													<label class="form-check-label"> <input
														class="form-check-input" type="checkbox" value="" checked>
														<span class="form-check-sign"></span> Subscribe to
														newsletter
													</label>
												</div>
											</div>
										</div>
									</div>
									<div class="card-footer ml-auto mr-auto">
										<button type="submit" class="btn btn-warning btn-wd"
											id="loginBt">Sign In</button>
									</div>
								</div>
							</form>
							<div class="row mt-3">
								<div class="col-6">
									<a href="<%=request.getContextPath()%>/insertMemberForm.jsp"
										class="text-muted"><small>회원가입</small></a>
								</div>
							</div>
						</div>
					<div class="col-7">
						<table class="table" style="text-align: center;">
							<tr>
								<th style="text-align: center;">공지 내용</th>
								<th style="text-align: center;">날짜</th>
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
				</div>
			</div>
			</div>
	<script>
		let loginBt = document.querySelector('#loginBt');
		loginBt.addEventListener('click', function(e) {
			//디버깅	
			console.log('loginBt click!')

			let memberId = document.querySelector('#memberId');
			if (memberId.value == '') {
				alert('아이디를 입력하세요!');
				memberId.focus();
				return;
			}

			let memberPw = document.querySelector('#memberPw');
			if (memberPw.value == '') {
				alert('비밀번호를 입력하세요!')
				memberPw.focus();
				return;
			}

			let loginForm = document.querySelector('#loginForm');
			loginForm.submit();

		});
	</script>
<!--   Core JS Files   -->
<script src="resource2/assets/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
<script src="resource2/assets/js/core/popper.min.js" type="text/javascript"></script>
<script src="resource2/assets/js/core/bootstrap.min.js" type="text/javascript"></script>
<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="resource2/assets/js/plugins/bootstrap-switch.js"></script>
<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!--  Chartist Plugin  -->
<script src="resource2/assets/js/plugins/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="resource2/assets/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
<script src="resource2/assets/js/light-bootstrap-dashboard.js?v=2.0.0 " type="text/javascript"></script>
<!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->
<script src="resource2/assets/js/demo.js"></script>
</body>
</html>