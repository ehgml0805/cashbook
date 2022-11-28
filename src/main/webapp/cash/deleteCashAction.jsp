<%@page import="vo.Cash"%>
<%@page import="vo.Member"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CashDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Member loginMember = (Member) session.getAttribute("loginMember");
String loginMemberId = loginMember.getMemberId();
System.out.println(loginMemberId + "<-아이디");
int year = Integer.parseInt(request.getParameter("year"));
int month = Integer.parseInt(request.getParameter("month"));
int date = Integer.parseInt(request.getParameter("date"));
int cashNo = Integer.parseInt(request.getParameter("cashNo"));
System.out.println(year + "<-년도");
System.out.println(month + "<-월");
System.out.println(date + "<-일");
CashDao cashDao = new CashDao();
int row = cashDao.delete(cashNo);

if (row == 1) {
	System.out.println("cash 삭제 성공");
	response.sendRedirect(
	request.getContextPath() + "/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date);
} else {
	System.out.println("cash 삭제 실패");
	response.sendRedirect(
	request.getContextPath() + "/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date);
}
%>