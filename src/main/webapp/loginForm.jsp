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
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>로그인</title>
<link rel="shortcut icon" href="resource/assets/images/fav.jpg">
<link rel="stylesheet" href="resource/assets/css/bootstrap.min.css">
<link rel="stylesheet" href="resource/assets/css/fontawsom-all.min.css">
<link rel="stylesheet" type="text/css"
	href="resource/assets/css/style.css" />
</head>

<body>
	<div class="container-fluid h-100">

		<div class="row no-margin h-100">

			<div class="col-sm-12 no-padding login-box h-100">
				<div class="row no-margin w-100">
					<div class="col-lg-6 col-md-6 box-de">
						<div class="small-logo">
							<i class="fab fa-asymmetrik"></i> Cashbook SignIn
						</div>
						<div class="ditk-inf sup-oi">
							<h2 class="w-100"></h2>
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
							<a href="index.html">
								<button type="button" class="btn btn-outline-light">New
									Registeration</button>
							</a>
						</div>
					</div>
					<div class="col-lg-6 col-md-6 log-det">

						<h2>Welcome</h2>
						<div class="row">
							<ul>
								<li><i class="fab fa-facebook-f"></i></li>
								<li><i class="fab fa-twitter"></i></li>
								<li><i class="fab fa-linkedin-in"></i></li>
							</ul>
						</div>
						<div class="row">
							<p class="small-info">or use your email account</p>
						</div>

						<div class="text-box-cont">
							<%
							if (msg != null) {
							%>
							<div class="alert alert-danger" role="alert">
								<%=msg%>
							</div>
							<%
							}
							%>
							<form action="<%=request.getContextPath()%>/loginAction.jsp"
								method="post" role="form" id="loginForm">
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="basic-addon1"> <i
											class="far fa-envelope"></i>
										</span>
									</div>
									<input type="text" class="form-control" placeholder="아이디"
										aria-label="Username" aria-describedby="basic-addon1"
										name="memberId" id="memberId" value="fkd0910">
								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="basic-addon1"><i
											class="fas fa-lock"></i></span>
									</div>
									<input type="password" class="form-control"
										placeholder="Password" aria-label="Username"
										aria-describedby="basic-addon1" name="memberPw" id="memberPw"
										value="1234">
								</div>
								<p>
									<label class="container"> <input type="checkbox">
										<span class="checkmark"></span>Remember me
									</label> 
								</p>

								<div class="input-group center  mb-3">

									<button type="button" id="loginBt" class="btn btn-success ">Sign
										In</button>
							</form>
							<button type="button" class="btn btn-primary"
								onclick="location.href='<%=request.getContextPath()%>/insertMemberForm.jsp' ">Sign Up</button>
						</div>
					</div>

				</div>
				<div class="foter-credit">
					<a href="https://smarteyeapps.com/">Designed by :
						Smarteyeapps.com</a>
				</div>

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
	<!-- 로그인템플릿 -->
	<script src="resource/assets/js/jquery-3.2.1.min.js"></script>
	<script src="resource/assets/js/popper.min.js"></script>
	<script src="resource/assets/js/bootstrap.min.js"></script>
	<script src="resource/assets/js/script.js"></script>
</body>
</html>