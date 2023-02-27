<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String msg1=request.getParameter("msg1");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>회원가입</title>
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
							<i class="fab fa-asymmetrik"></i> Cashbook SignUp
						</div>
						<div class="ditk-inf sup-oi">
							<h2 class="w-100">
								We are the Best <br>Internet Partner for You
							</h2>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
								Ut consectetur maximus justo, et malesuada dolor dictum in.
								Maecenas nec elit risus. Nunc ut nunc aliquam, blandit magna et,
								tempus quam</p>
							<ul>
								<li><i class="fas fa-check"></i> Nam facilisis nibh sed
									nunc aliquam, et volutpat ipsum</li>
								<li><i class="fas fa-check"></i> dignissim sapien.
									Vestibulum non leo fringilla, luctus turpis quis</li>
								<li><i class="fas fa-check"></i> Aliquam vitae augue nisi.
									Phasellus ut dui a neque</li>
							</ul>
							<a href="index.html">
								<button type="button" class="btn btn-outline-light">New
									Registeration</button>
							</a>
						</div>
					</div>
					<div class="col-lg-6 col-md-6 log-det">

						<h2>Welcome Back</h2>
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
							if (msg1 != null) {
							%>
								<div class="alert alert-danger" role="alert"> <%=msg1%> </div>
							<%
							}
							%>
							<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post" role="form" id="insertForm">
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="basic-addon1">
										<i class="fas fa-user"></i></span>
									</div>
									<input type="text" class="form-control" name="memberName" id="memberName" placeholder="이 름" aria-label="Username"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="basic-addon1">
										<i class="far fa-envelope"></i></span>
									</div>
									<input type="text" class="form-control" name="memberId" id="memberId" placeholder="아 이 디" aria-label="Username"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="basic-addon1">
										<i class="fas fa-lock"></i></span>
									</div>
									<input type="text" class="form-control" placeholder="Password"
										aria-label="Username" aria-describedby="basic-addon1">
								</div>
								<p>
									<label class="container"> <input type="checkbox">
										<span class="checkmark"></span>Remember me
									</label>
								</p>

								<div class="input-group center  mb-3">
									<button type="button" class="btn btn-success" id="insertBt">Sign
										Up</button>
							</form>
							<button type="button" class="btn btn-primary "
								onclick="location.href='<%=request.getContextPath()%>/loginForm.jsp' ">Sign
								In</button>
						</div>
					</div>

				</div>
				<div class="foter-credit">
					<a href="#">Designed by : Smarteyeapps.com</a>
				</div>
			</div>
		</div>
	</div>
	</div>
	<script>
		let insertBt=document.querySelector('#insertBt');
		insertBt.addEventListener('click', function(e) {
			console.log('insertBt click');
		
		let memberName=document.querySelector('#memberName');
		if(memberName.value==''){
			alert('이름을 입력하세요');
			memberName.focus();
			return;
		}
			
		let memberId=document.querySelector('#memberId');
		if(memberId.value==''){
			alert('아이디를 입력하세요!');
			memberId.focus();
			return;
		}
		
		let memberPw=document.querySelector('#memberPw');
		if(memberPw.value==''){
			alert('비밀번호를 입력하세요!');
			memberPw.focus();
			return;
		}
		
		let customCheckRegister=document.querySelectorAll('.customCheckRegister');
		console.log(customCheckRegister.length);
		if(customCheckRegister!=0){
			alert('동의하세요')
			return;
		}
		
		let insertForm=document.querySelector('#insertForm');
		insertForm.submit();
			
		});
	</script>
	<!-- 로그인템플릿 -->
	<script src="resource/assets/js/jquery-3.2.1.min.js"></script>
	<script src="resource/assets/js/popper.min.js"></script>
	<script src="resource/assets/js/bootstrap.min.js"></script>
	<script src="resource/assets/js/script.js"></script>
</body>
</html>