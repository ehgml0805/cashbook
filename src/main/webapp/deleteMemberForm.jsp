<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
if (session.getAttribute("loginMember") == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
request.setCharacterEncoding("utf-8");
String msg1 = request.getParameter("msg1");
Member loginMember = (Member) (session.getAttribute("loginMember"));
String loginMemberId = loginMember.getMemberId();
String loginMemberName = loginMember.getMemberName();
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
		<div class="container pt-lg-4">
			<div class="row justify-content-center">
				<div class="col-lg-5">
					<div class="card bg-secondary shadow border-0">
						<div class="card-body px-lg-5 py-lg-5">
							<div class="text-center text-muted mb-4">
								<small>개인 정보 수정하기</small>
							</div>
							<%
							if (msg1 != null) {
							%>
							<%=msg1%>
							<%
							}
							%>
							<form
								action="<%=request.getContextPath()%>/deleteMemberAction.jsp"
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
										<input type="password" name="memberPw" class="form-control"
											placeholder="비밀번호">
									</div>
								</div>
								<div class="text-center">
									<button type="submit" class="btn btn-primary mt-4">탈퇴하기</button>
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
</body>
</html>