<%@page import="vo.Cash"%>
<%@page import="vo.Member"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CashDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%
Member loginMember=(Member)session.getAttribute("loginMember");
int year = Integer.parseInt(request.getParameter("year"));
int month = Integer.parseInt(request.getParameter("month"));
int date = Integer.parseInt(request.getParameter("date"));
int cashNo=Integer.parseInt(request.getParameter("cashNo"));

CashDao cashDao=new CashDao();
Cash delete=cashDao.delete(cashNo);

response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp");

%>