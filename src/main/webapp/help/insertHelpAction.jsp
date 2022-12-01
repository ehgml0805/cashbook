<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>

<%
//방어코드
Member loginMember=(Member)session.getAttribute("loginMember");
if(loginMember==null|| request.getParameter("helpMemo")==null||request.getParameter("helpMemo").equals("")){
 response.sendRedirect(request.getContextPath()+"/help/insertHelpForm.jsp");
 return;
}
String helpMemo=request.getParameter("helpMemo");
String loginMemberId=loginMember.getMemberId();

%>