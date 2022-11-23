<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@ page import="java.util.* "%>

<%
Member loginMember=(Member)session.getAttribute("loginMember");
if(loginMember==null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
int cashNo=Integer.parseInt(request.getParameter("cashNo"));
String cashPrice=request.getParameter("cashPrice");
String categoryKind=request.getParameter("categoryKind");
String categoryName=request.getParameter("categoryName");
String cashDate=request.getParameter("cashDate");
int year = Integer.parseInt(request.getParameter("year"));
int month = Integer.parseInt(request.getParameter("month"));
int date = Integer.parseInt(request.getParameter("date"));

CashDao cashDao= new CashDao();
ArrayList<HashMap<String, Object>> list=cashDao.selectCashListByDate(loginMember.getMemberId() , year, month, date);



%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/updateCashAction.jsp" method="post">
		<table border="1">
		<tr>
			<td>가격</td>
			<td><input type="text" name="cashPrice" value="<%=%>"></td>
		</tr>
		<tr>
			<td>수입/지출</td>
			<td><input type="text" > </td>
		</tr>
		<tr>	
			<td>항목</td>
			<td><input type="text" name="categoryName"></td>
		</tr>
		<tr>
			<td>사용 날짜</td>
			<td><input type="text" name="cashDate" value=""></td>
		</tr>
		</table>
	<button type="submit">수정하기 </button>
	</form>

</body>
</html>