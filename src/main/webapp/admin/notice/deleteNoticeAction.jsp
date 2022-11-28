<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
int noticeNo=Integer.parseInt(request.getParameter("noticeNo"));

Notice notice=new Notice();
notice.setNoticeNo(noticeNo);
NoticeDao noticeDao= new NoticeDao();
int row=noticeDao.deleteNotice(notice);
if(row==1){
	System.out.println("공지 삭제 성공");
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
}else{
	System.out.println("공지 삭제 성공");
}
%>