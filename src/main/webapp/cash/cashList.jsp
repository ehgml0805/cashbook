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
if (session.getAttribute("loginMember") == null ) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
int memberLevel = loginMember.getMemberLevel();
System.out.println(memberLevel + "<-멤버레벨");
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

Cash cash=new Cash();
cash.getCashNo();

cashDao.selectCashOne(cashNo);

//
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달력 및 가계부</title>
</head>
<body>
	<div>
		<!-- 로그인 정보(loginMember 변수 출력) 출력 -->
		<%=loginMember.getMemberName()%>님 반갑습니다.

	</div>
	<a href="<%=request.getContextPath()%>/memberOne.jsp">마이 페이지</a>
	<a href="<%=request.getContextPath()%>/logOut.jsp"> 로그아웃</a>
	<%
	if (loginMember.getMemberLevel() > 0) {
	%>
	<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자 페이지</a>
	<%
	}
	%>
	<div>
		<%=year%>년<%=month + 1%>월
	</div>
	<span><a
		href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month - 1%>">이전달
	</a> </span>
	<span><a
		href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month + 1%>">다음달
	</a> </span>
	<div>
		<table border="1">
			<tr>
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
					<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month + 1%>&date=<%=date%>"> <%=date%></a>
				</div>
				<div>
					<%
						for (HashMap<String, Object> m : list) {
							String cashDate = (String) (m.get("cashDate"));
							if (Integer.parseInt(cashDate.substring(8)) == date) {
					%>
							<%=(String) (m.get("categoryKind"))%>
							<%=(String) (m.get("categoryName"))%>
							<%=(Long) (m.get("cashPrice"))%>원 <br>
					<%
						}
					}
					%>
				</div> 
			<%
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
</body>
</html>