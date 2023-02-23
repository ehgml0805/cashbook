<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String msg1=request.getParameter("msg1");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="resource2/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="resource2/assets/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>회원가입</title>
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
  <div class="wrapper">
        <div class="sidebar" data-image="resource2/assets/img/sidebar-5.jpg">
            <!--
        Tip 1: You can change the color of the sidebar using: data-color="purple | blue | green | orange | red"

        Tip 2: you can also add an image using data-image tag
    -->
            <div class="sidebar-wrapper">
                <div class="logo">
                    <a href="<%=request.getContextPath()%>/memberOne.jsp" class="simple-text">
                        Cashbook
                    </a>
                </div>
                <ul class="nav">
                    <li>
                        <a class="nav-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">
                            <i class="nc-icon nc-money-coins"></i>
                            <p>Calender</p>
                        </a>
                    </li>
                    <li>
						<a class="nav-link" href="<%=request.getContextPath()%>/index.jsp">
							<i class="nc-icon nc-chart-pie-36"></i>
							<p>Index</p>
						</a>
					</li>
                    <li>
                        <a class="nav-link" href="<%=request.getContextPath()%>/memberOne.jsp">
                            <i class="nc-icon nc-circle-09"></i>
                            <p>User Profile</p>
                        </a>
                    </li>
                    <li>
                        <a class="nav-link" href="<%=request.getContextPath()%>/help/helpList.jsp">
                            <i class="nc-icon nc-notes"></i>
                            <p>Customer Help</p>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
 		<div class="main-panel">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg " color-on-scroll="500">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#pablo">비회원</a>
                    <button href="" class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-bar burger-lines"></span>
                        <span class="navbar-toggler-bar burger-lines"></span>
                        <span class="navbar-toggler-bar burger-lines"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-end" id="navigation">
                        <ul class="nav navbar-nav mr-auto">
                            <li class="nav-item">
                                <a href="<%=request.getContextPath()%>/cash/cashList.jsp" class="nav-link" data-toggle="dropdown">
                                    <i class="nc-icon nc-circle-09"></i>
                                    <span class="d-lg-none">Calender</span>
                                </a>
                            </li>
                            <li class="dropdown nav-item">
                                <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                                    <i class="nc-icon nc-planet"></i>
                                    <span class="notification">5</span>
                                    <span class="d-lg-none">Notification</span>
                                </a>
                                <ul class="dropdown-menu">
                                    <a class="dropdown-item" href="#">Notification 1</a>
                                    <a class="dropdown-item" href="#">Notification 2</a>
                                    <a class="dropdown-item" href="#">Notification 3</a>
                                    <a class="dropdown-item" href="#">Notification 4</a>
                                    <a class="dropdown-item" href="#">Another notification</a>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="nc-icon nc-zoom-split"></i>
                                    <span class="d-lg-block">&nbsp;Search</span>
                                </a>
                            </li>
                        </ul>
                        <ul class="navbar-nav ml-auto">
                            <!-- <li class="nav-item">
                                <a class="nav-link" href="#pablo">
                                    <span class="no-icon">Account</span>
                                </a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="no-icon">Dropdown</span>
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                    <a class="dropdown-item" href="#">Action</a>
                                    <a class="dropdown-item" href="#">Another action</a>
                                    <a class="dropdown-item" href="#">Something</a>
                                    <a class="dropdown-item" href="#">Something else here</a>
                                    <div class="divider"></div>
                                    <a class="dropdown-item" href="#">Separated link</a>
                                </div>
                            </li> -->
                            <li class="nav-item">
                                <a class="nav-link" href="<%=request.getContextPath()%>/loginForm.jsp">
                                    <span class="no-icon">Sign In</span>
                                </a>
                            </li>
                        </ul> 
                    </div>
                </div>
            </nav>
			<!-- End Navbar -->
			<br>
			<div class="content">
				<div class="container">
					<div class="col-md-5 col-sm-6 ml-auto mr-auto">
						<form action="<%=request.getContextPath()%>/insertMemberAction.jsp"
							method="post" role="form" id="insertForm">

							<%
							if (msg1 != null) {
							%>
							<div class="alert alert-danger" role="alert">
								<%=msg1%>
							</div>
							<%
							}
							%>
							<div class="card card-login card-hidden">
								<div class="card-header ">
									<h3 class="header text-center">Sign up</h3>
								</div>
								<div class="card-body ">
									<div class="card-body">
										<div class="form-group">
											<label>Name</label> <input type="text" name="memberName"
												id="memberName" class="form-control" placeholder="이 름">
										</div>
										<div class="form-group">
											<label>Email</label> <input type="text" name="memberId"
												id="memberId" class="form-control" placeholder="아 이 디">
										</div>
										<div class="form-group">
											<label>Password</label> <input type="password"
												name="memberPw" id="memberPw" class="form-control"
												placeholder="비밀번호">
										</div>
										<!-- <div class="form-group">
											<div class="form-check" style="text-align: center;">
												<label class="form-check-label" style="vertical-align: text-top;"> 
													<input class="form-check-input" type="checkbox" value="" checked>
													<span class="form-check-sign"></span> I agree with the <a href="#">Privacy Policy
												</label>
											</div>
										</div> -->
									</div>
								</div>
								<div class="card-footer ml-auto mr-auto" style="text-align: center;">
									<button type="submit" class="btn btn-warning btn-wd" id="insertBt">Sign up</button>
								</div>
							</div>
						</form>
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
			<footer class="footer">
				<div class="container-fluid">
					<nav>
						<ul class="footer-menu">
							<li><a href="#"> Home </a></li>
							<li><a href="#"> Company </a></li>
							<li><a href="#"> Portfolio </a></li>
							<li><a href="https://github.com/ehgml0805/cashbook"
								target='_blank'> Git Hub </a></li>
						</ul>
						<p class="copyright text-center">
							©
							<script>
							document.write(new Date().getFullYear())
						</script>
							<a href="http://www.creative-tim.com">Creative Tim</a>, made
							with love for a better web
						</p>
					</nav>
				</div>
			</footer>
		</div>
	</div>
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