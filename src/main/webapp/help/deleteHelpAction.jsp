<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder" %>

<%
//받아오기
int helpNo=Integer.parseInt(request.getParameter("helpNo"));

//model 호출
Help help=new Help();
help.setHelpNo(helpNo);

HelpDao helpDao= new HelpDao();
int row=helpDao.deleteHelp(help);

if(row==1){
	System.out.println("문의 삭제 성공");
	response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
}else{
	System.out.println("문의 삭제 성공");
	String msg1=URLEncoder.encode("✔문의 삭제 실패", "utf-8");
	response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
}
%>