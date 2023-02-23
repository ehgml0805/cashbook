<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="vo.*" %>
<%@page import="dao.*" %>

<%
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if(loginMember == null || loginMember.getMemberLevel() < 1){
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}

String memberId=loginMember.getMemberId();
int memberLevel = loginMember.getMemberLevel();
String memberName = loginMember.getMemberName();

int helpNo=Integer.parseInt(request.getParameter("helpNo"));
//System.out.println(helpNo+"<=문의 번호");
String msg1=request.getParameter("msg1");

HelpDao helpDao=new HelpDao();
HashMap<String, Object> map= helpDao.selectHelpComment(helpNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76" href="../../resource2/assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="../../resource2/assets/img/favicon.ico">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>답변 추가하기</title>
<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
<!--     Fonts and icons     -->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
<!-- CSS Files -->
<link href="../../resource2/assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="../../resource2/assets/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet" />
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="../../resource2/assets/css/demo.css" rel="stylesheet" />
</head>

<body style="overflow: auto;">
	<div class="wrapper">
		<div class="sidebar"
			data-image="../../resource2/assets/img/sidebar-2.jpg" data-color="orange">
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
                    <li>
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
                    <li class="nav-item active">
                        <a class="nav-link" href="<%=request.getContextPath()%>/admin/helpListAll.jsp">
                            <i class="nc-icon nc-bullet-list-67"></i>
                            <p>Admin Help List</p>
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
					<button href="" class="navbar-toggler navbar-toggler-right"
						type="button" data-toggle="collapse"
						aria-controls="navigation-index" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-bar burger-lines"></span> <span
							class="navbar-toggler-bar burger-lines"></span> <span
							class="navbar-toggler-bar burger-lines"></span>
					</button>
					<div class="collapse navbar-collapse justify-content-end"
						id="navigation">
						<ul class="nav navbar-nav mr-auto">
							<li class="nav-item"><a
								href="<%=request.getContextPath()%>/cash/cashList.jsp"
								class="nav-link" data-toggle="dropdown"> <i
									class="nc-icon nc-circle-09"></i> <span class="d-lg-none">Calender</span>
							</a></li>
							<li class="dropdown nav-item"><a href="#"
								class="dropdown-toggle nav-link" data-toggle="dropdown"> <i
									class="nc-icon nc-planet"></i> <span class="notification">5</span>
									<span class="d-lg-none">Notification</span>
							</a>
								<ul class="dropdown-menu">
									<a class="dropdown-item" href="#">Notification 1</a>
									<a class="dropdown-item" href="#">Notification 2</a>
									<a class="dropdown-item" href="#">Notification 3</a>
									<a class="dropdown-item" href="#">Notification 4</a>
									<a class="dropdown-item" href="#">Another notification</a>
								</ul></li>
							<li class="nav-item"><a href="#" class="nav-link"> <i
									class="nc-icon nc-zoom-split"></i> <span class="d-lg-block">&nbsp;Search</span>
							</a></li>
						</ul>
						<ul class="navbar-nav ml-auto">
							<!-- <li class="nav-item">
                                <a class="nav-link" href="#pablo">
                                    <span class="no-icon">Account</span>
                                </a>
                            </li> -->
							<li class="nav-item dropdown"><a
								class="nav-link dropdown-toggle" href="http://example.com"
								id="navbarDropdownMenuLink" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false"> <span
									class="no-icon">Dropdown</span>
							</a>
								<div class="dropdown-menu"
									aria-labelledby="navbarDropdownMenuLink">
									<a class="dropdown-item" href="#">Action</a> <a
										class="dropdown-item" href="#">Another action</a> <a
										class="dropdown-item" href="#">Something</a> <a
										class="dropdown-item" href="#">Something else here</a>
									<div class="divider"></div>
									<a class="dropdown-item" href="#">Separated link</a>
								</div></li>
							<li class="nav-item"><a class="nav-link"
								href="<%=request.getContextPath()%>/logOut.jsp"> <span
									class="no-icon">LOG OUT</span>
							</a></li>
						</ul>
					</div>
				</div>
			</nav>
			<!-- End Navbar -->
			<div class="content">
				<div class="container-fluid">
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-6 mr-auto ml-auto">
								<form id="insertCommentForm" action="<%=request.getContextPath()%>/admin/comment/insertCommentAction.jsp" method="post">
									<div class="card ">
										<div class="card-header ">
											<h4 class="card-title">회원문의 답변 추가</h4>
										</div>
										<%
											if(msg1!=null){
										%>		
											<div class="alert alert-danger text-center" role="alert"><%=msg1 %></div>
										<%		
											}
										%>
										<div class="card-body ">
											<div class="form-group has-label">
												<label> 문의 번호 </label> 
												<input type="text" name="helpNo" value=<%=helpNo%> readonly="readonly" class="form-control">
											</div>
											<div class="form-group has-label">
												<label> 작성자 아이디 </label> 
												<input type="text" name="memberId" value="<%=map.get("memberId")%>" readonly="readonly" class="form-control">
											</div>
											<div class="form-group has-label">
												<label> 작성 날짜 </label> 
												<input type="text" name="createdate" value="<%=map.get("createdate")%>" readonly="readonly" class="form-control">
											</div>
											<div class="form-group has-label">
												<label> 문의 내용 </label> 
												<input type="text" name="createdate" value="<%=map.get("helpMemo") %>" readonly="readonly" class="form-control">
											</div>
											<!-- 위에는 문의확인 하면서 아래는 답변하기 -->
											<div class="form-group has-label">
												<label> 답변 입력 <star class="star">*</star></label> 
												<textarea  placeholder="문의사항을 입력하세요..." id="commentMemo"
													class="form-control form-control-alternative" name="commentMemo"></textarea>
											</div>
											<div class="card-category form-category">
												<star class="star">*</star>
												Required fields
											</div>
										</div>
										<div class="card-footer text-right">
											<button type="button" class="btn btn-info btn-fill pull-right" id="insertCommentBt">답변추가</button>
											<div class="clearfix"></div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<script>
				let insertCommentBt=document.querySelector('#insertCommentBt');
				insertCommentBt.addEventListener('click', function(e) {
					console.log('insertCommentBt click');
					
					let commentMemo=document.querySelector('#commentMemo');
					if(commentMemo.value==''){
						alert('메모를 입력하세요');
						commentMemo.focus();
						return;
					}
					let insertCommentForm=document.querySelector('#insertCommentForm');
					insertCommentForm.submit();
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
							<a href="http://www.creative-tim.com">Creative Tim</a>, made with
							love for a better web
						</p>
					</nav>
				</div>
			</footer>
		</div>
	</div>
	<!--   Core JS Files   -->
<script src="../../resource2/assets/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
<script src="../../resource2/assets/js/core/popper.min.js" type="text/javascript"></script>
<script src="../../resource2/assets/js/core/bootstrap.min.js" type="text/javascript"></script>
<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="../../resource2/assets/js/plugins/bootstrap-switch.js"></script>
<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!--  Chartist Plugin  -->
<script src="../../resource2/assets/js/plugins/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="../../resource2/assets/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
<script src="../../resource2/assets/js/light-bootstrap-dashboard.js?v=2.0.0 " type="text/javascript"></script>
<!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->
<script src="../../resource2/assets/js/demo.js"></script>
</body>
</html>