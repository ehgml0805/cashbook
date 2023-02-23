<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@page import="vo.*"%>
<%
if (session.getAttribute("loginMember") == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
String msg2 = request.getParameter("msg2");
String msg1 = request.getParameter("msg1");

//session에 있는 ID랑 NAME 받아오기
Member loginMember = (Member) session.getAttribute("loginMember");
String memberId = loginMember.getMemberId();
String memberName = loginMember.getMemberName();
//개인 정보 변경 후 돌아오면 이름 변경 안되어 있는데 로그아웃하고 다시 들어어면 바뀌어 있음,,,뭐로 받아와야하나-> 세션에 저장 하면 댐
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="resource2/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="resource2/assets/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>마이페이지</title>
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
        <div class="sidebar" data-image="resource2/assets/img/sidebar-2.jpg">
            <!--
        Tip 1: You can change the color of the sidebar using: data-color="purple | blue | green | orange | red"

        Tip 2: you can also add an image using data-image tag
    -->
            <div class="sidebar-wrapper">
                <div class="logo">
                    <a href="<%=request.getContextPath()%>/cash/cashList.jsp" class="simple-text">
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
							<p>Chart</p>
						</a>
					</li>
                    <li class="nav-item active">
                        <a class="nav-link" href="<%=request.getContextPath()%>/memberOne.jsp">
                            <i class="nc-icon nc-circle-09"></i>
                            <p>User Profile</p>
                        </a>
                    </li>
                    <li>
                        <a class="nav-link" href="<%=request.getContextPath()%>/help/helpList.jsp">
                            <i class="nc-icon nc-zoom-split"></i>
                            <p>Customer Help</p>
                        </a>
                    </li>
                    <%
						if(loginMember.getMemberLevel() > 0) {
					%>
					<hr>
                   	 <li>
                        <a class="nav-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp">
                            <i class="nc-icon nc-bell-55"></i>
                            <p>Notice</p>
                        </a>
                    </li>
                    <li>
                        <a class="nav-link" href="<%=request.getContextPath()%>/admin/categoryList.jsp">
                            <i class="nc-icon nc-preferences-circle-rotate"></i>
                            <p>Category</p>
                        </a>
                    </li>
                    <li>
                        <a class="nav-link" href="<%=request.getContextPath()%>/admin/memberList.jsp">
                            <i class="nc-icon nc-single-02"></i>
                            <p>Member</p>
                        </a>
                    </li>
                    <li>
                        <a class="nav-link" href="<%=request.getContextPath()%>/admin/helpListAll.jsp">
                            <i class="nc-icon nc-bullet-list-67"></i>
                            <p>Help List</p>
                        </a>
                   	</li>
                    <li class="nav-item active active-pro">
                        <a class="nav-link active" href="<%=request.getContextPath()%>/admin/adminMain.jsp">
                            <i class="nc-icon nc-alien-33"></i>
                            <p>Admin Page</p>
                        </a>
                    </li>
					<%	
						}
					%>
				</ul>
            </div>
        </div>
 		<div class="main-panel">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg " color-on-scroll="500">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#pablo"><%=memberName%></a>
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
                            </li> -->
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
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<%=request.getContextPath()%>/logOut.jsp">
                                    <span class="no-icon">LOG OUT</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <!-- End Navbar -->	
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Updte Profile</h4>
                                </div>
                                <%
								if (msg1 != null) {
								%>
									<div class="alert alert-danger" role="alert"><%=msg1%></div>
								<%
								}
								%>
								<div class="card-body">
                                    <form id="updateForm" action="<%=request.getContextPath()%>/updateMemberAction.jsp" method="post">
                                        <div class="form-group has-label">
												<label> ID </label> 
												<input type="text" name="memberId" id="memberId" value="<%=memberId%>" readonly="readonly"
													class="form-control form-control">
										</div>
										<div class="form-group has-label">
												<label> 변경 전 이름 </label> 
												<input type="text" name="bememberName" id="bememberName" value="<%=memberName%>" readonly="readonly"
													class="form-control form-control">
										</div>
										<div class="form-group has-label">
												<label> 변경 할 이름 </label> 
												<input type="text" name="memberName" id="memberName" class="form-control form-control" placeholder="변경할 이름을 입력해주세요">
										</div>
										<div class="form-group has-label">
												<label> 비밀번호 </label> 
												<input type="password" name="memberPw" id="memberPw" class="form-control form-control" placeholder="비밀번호를 입력해주세요">
										</div>
										
		                                <button type="button" class="btn btn-info btn-fill pull-right" id="updateBt">Update Profile</button>
		                                <div class="clearfix"></div>
									</div>
                                </form>
                                <div class="card-footer">
                                   <div class="row mt-6">
										<div class="col">
											<a href="<%=request.getContextPath()%>/updateMemberPWForm.jsp" class="text-muted"><small>비밀번호수정</small></a>
										</div>
										<div class="col">
											<a href="<%=request.getContextPath()%>/deleteMemberForm.jsp" style="color: red;" ><small>회원탈퇴</small></a>
										</div>
									</div>
								</div>
                              </div>
                           </div>
                        <div class="col-md-6">
                            <div class="card card-user">
                                <div class="card-image">
                                    <img src="https://ununsplash.imgix.net/photo-1431578500526-4d9613015464?fit=crop&fm=jpg&h=300&q=75&w=400" alt="...">
                                </div>
                                <div class="card-body">
                                    <div class="author">
                                        <a href="#">
                                            <img class="avatar border-gray" src="resource2/assets/img/faces/face-1.jpg" alt="...">
                                            <h5 class="title"><%=memberName%></h5>
                                        </a>
                                        <p class="description">
                                           <%=memberId%>
                                        </p>
                                    </div>
                                    <p class="description text-center">
                                        공공데이터과정 자바 58기 김도희 개인프로젝트
                                        <br>
                                        <br> 마리아 디비를 이용하고 mvc모델1으로 만들어 보았음
                                    </p>
                                </div>
                                <hr>
                                <div class="button-container mr-auto ml-auto">
                                	 <button type="button" onclick="window.open('https://github.com/ehgml0805/cashbook')" class="btn btn-simple btn-link btn-icon">
                                        <i class="fa fa-github"></i>
                                    </button>
                                    <button type="button" onclick="window.open('https://ko-kr.facebook.com/')" class="btn btn-simple btn-link btn-icon">
                                        <i class="fa fa-facebook-square"></i>
                                    </button>
                                    <button type="button" onclick="window.open('https://twitter.com/?lang=ko')" class="btn btn-simple btn-link btn-icon">
                                        <i class="fa fa-twitter"></i>
                                    </button>
                                    <button type="button" onclick="window.open('https://www.instagram.com/')" class="btn btn-simple btn-link btn-icon">
                                        <i class="fa fa-instagram"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>			
            <script>
				let updateBt=document.querySelector('#updateBt');
				updateBt.addEventListener('click', function(e) {
					
					let memberName=document.querySelector('#memberName');
					if(memberName.value==''){
						alert('변경 할 이름을 입력해 주세요!');
						memberName.focus();
						return;
					}
					let memberPw=document.querySelector('#memberPw');
					if(memberPw.value==''){
						alert('비밀번호를 입력하세요!');
						memberPw.focus();
						return;
					}
					
					let updateForm=document.querySelector('#updateForm');
					updateForm.submit();
					
				});
			</script>
           <footer class="footer">
                <div class="container-fluid">
                    <nav>
                        <ul class="footer-menu">
                            <li>
                                <a href="#">
                                    Home
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    Company
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    Portfolio
                                </a>
                            </li>
                            <li>
                                <a href="https://github.com/ehgml0805/cashbook" target='_blank'>
                                   Git Hub
                                </a>
                            </li>
                        </ul>
                        <p class="copyright text-center">
                            ©
                            <script>
                                document.write(new Date().getFullYear())
                            </script>
                            <a href="http://www.creative-tim.com">Creative Tim</a>, made with love for a better web
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