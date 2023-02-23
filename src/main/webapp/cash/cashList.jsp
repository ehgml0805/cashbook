<%@page import="java.text.DecimalFormat"%>
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
String memberId = loginMember.getMemberId();
String memberName = loginMember.getMemberName();
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

//천 단위 콤마
DecimalFormat decFormat = new DecimalFormat("###,###");

%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="../resource2/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="../resource2/assets/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>가계부</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
    <!--     Fonts and icons     -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
    <!-- CSS Files -->
    <link href="../resource2/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../resource2/assets/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet" />
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="../resource2/assets/css/demo.css" rel="stylesheet" />
</head>

<body style="overflow: auto;">
   <div class="wrapper">
        <div class="sidebar" data-image="../resource2/assets/img/sidebar-4.jpg">
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
                    <li class="nav-item active">
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
			<div class="p-5 mb-7">
				<div style="text-align: center;">
					<h2>
						<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month - 1%>"> 
							 <i class="nc-icon nc-stre-left"></i>
						</a>
						<%=year%>년 <%=month + 1%>월
						<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month + 1%>">
							<i class="nc-icon nc-stre-right"></i>
						</a>
					</h2>
				</div>
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
					<td style="vertical-align: top;">
						<%
						int date = i - beginBlank;//시작 요일
						if (date > 0 && date <= lastDate) {
						%>
						<div>
							<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month + 1%>&date=<%=date%>">
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
							<%= decFormat.format((Long) (m.get("cashPrice")))%>원 <br>
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
<script src="../resource2/assets/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
<script src="../resource2/assets/js/core/popper.min.js" type="text/javascript"></script>
<script src="../resource2/assets/js/core/bootstrap.min.js" type="text/javascript"></script>
<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="../resource2/assets/js/plugins/bootstrap-switch.js"></script>
<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!--  Chartist Plugin  -->
<script src="../resource2/assets/js/plugins/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="../resource2/assets/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
<script src="../resource2/assets/js/light-bootstrap-dashboard.js?v=2.0.0 " type="text/javascript"></script>
<!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->
<script src="../resource2/assets/js/demo.js"></script>
</body>
</html>