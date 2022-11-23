<%@page import="vo.Cash"%>
<%@page import="dao.CashDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
request.setCharacterEncoding("utf-8");
Member loginMember=(Member)(session.getAttribute("loginMember"));
if(loginMember==null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
String cashDate=request.getParameter("cashDate");
String cashMemo=request.getParameter("cashMemo");
String cashPrice=request.getParameter("cashPrice");

int year = Integer.parseInt(request.getParameter("year"));
int month = Integer.parseInt(request.getParameter("month"));
int date = Integer.parseInt(request.getParameter("date"));

CashDao cashDao=new CashDao();

response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp");
%>