<%@page import="dao.CashDao"%>
<%@page import="vo.Cash"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
request.setCharacterEncoding("utf-8");
if(session.getAttribute("loginMember") ==null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}

//updateForm에서 받아오기
Member loginMember=(Member)session.getAttribute("loginMember");
String loginMemberId=loginMember.getMemberId();
System.out.println(loginMemberId+"<-아이디");
String cashDate=request.getParameter("cashDate");
int categoryNo=Integer.parseInt(request.getParameter("categoryNo"));
Long cashPrice=Long.parseLong(request.getParameter("cashPrice"));
String cashMemo=request.getParameter("cashMemo");
int year=Integer.parseInt(request.getParameter("year"));
int month=Integer.parseInt(request.getParameter("month"));
int date=Integer.parseInt(request.getParameter("date"));

//model 호출
CashDao cashDao=new CashDao();
int row=cashDao.update(loginMemberId, cashDate, cashPrice, categoryNo, cashMemo);
if(row==1){
	System.out.println("cash 수정 성공");
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
}else{
	System.out.println("cash 추가 실패!");
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp");
}

%>