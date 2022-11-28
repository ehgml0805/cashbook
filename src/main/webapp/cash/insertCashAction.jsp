<%@page import="vo.Cash"%>
<%@page import="dao.CashDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<%
request.setCharacterEncoding("utf-8");
//방어코드
if(session.getAttribute("loginMember") ==null||request.getParameter("cashPrice").equals("")
	||request.getParameter("cashMemo").equals("")
	||request.getParameter("categoryNo").equals("")||request.getParameter("categoryNo")==null){
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp");
	return;
}
//insertForm에서 받아오기
Member loginMember=(Member)(session.getAttribute("loginMember"));
String loginMemberId=loginMember.getMemberId();
int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
System.out.println(categoryNo+"<-카테고리");
String cashDate=request.getParameter("cashDate");
System.out.println(cashDate+"<-사용일자");
String cashMemo=request.getParameter("cashMemo");
Long cashPrice=Long.parseLong(request.getParameter("cashPrice"));
System.out.println(cashPrice+"<-금액");
int year = Integer.parseInt(request.getParameter("year"));
int month = Integer.parseInt(request.getParameter("month"));
int date = Integer.parseInt(request.getParameter("date"));

//model 호출
CashDao cashDao=new CashDao();
int row =cashDao.insert(loginMemberId, cashDate, cashPrice, categoryNo, cashMemo);
if(row==1){
	System.out.println("cash 추가 성공");
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
}else{
	System.out.println("cash 추가 실패!");
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp");
}

%>