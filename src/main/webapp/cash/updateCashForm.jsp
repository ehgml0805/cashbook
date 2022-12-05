<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@ page import="java.util.* "%>

<%
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if (loginMember == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
String loginMemberId = loginMember.getMemberId();
int year = Integer.parseInt(request.getParameter("year"));
int month = Integer.parseInt(request.getParameter("month"));
int date = Integer.parseInt(request.getParameter("date"));
int cashNo = Integer.parseInt(request.getParameter("cashNo"));
System.out.println(cashNo + "<==캐시 넘버");
//카테고리 항목
CategoryDao categoryDao = new CategoryDao();
//캐시 항목
CashDao cashDao = new CashDao();
Cash cash = cashDao.selectCashOne(cashNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캐시 수정하기</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>"> 
		<input type="hidden" name="year" value="<%=year%>"> 
		<input type="hidden" name="month" value="<%=month%>">
		<input type="hidden" name="date" value="<%=date%>"> 
		<input type="hidden" name="cashNo" value="<%=cash.getCashNo()%>">
		<table border="1">
			<tr>
				<td>사용 날짜</td>
				<td><input type="text" name="cashDate"
					value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="text" name="cashPrice" value="<%=cash.getCashPrice()%>"></td>
			</tr>
			<tr>
				<td>메모</td>
				<td><textarea cols="30" rows="10" name="cashMemo"><%=cash.getCashMemo() %></textarea></td>
			</tr>
		</table>
		<button type="submit">수정하기</button>
	</form>
</body>
</html>