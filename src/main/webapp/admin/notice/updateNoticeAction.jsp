<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.URLEncoder"%>

<%
Member loginMember=(Member)session.getAttribute("loginMember");
//방어코드
if(loginMember == null || loginMember.getMemberLevel() < 1
||request.getParameter("noticeMemo").equals("")
||request.getParameter("noticeNo")==null || request.getParameter("noticeNo").equals("")){
	String msg1=URLEncoder.encode("✔공지사항을 입력하세요!","utf-8");
	response.sendRedirect(request.getContextPath()+"/admin/notice/updateNoticeForm.jsp?msg1="+msg1);
	return;
}
request.setCharacterEncoding("utf-8");
int noticeNo=Integer.parseInt(request.getParameter("noticeNo"));
String noticeMemo=request.getParameter("noticeMemo");
//model 호출
Notice notice=new Notice();
notice.setNoticeMemo(noticeMemo);
notice.setNoticeNo(noticeNo);

NoticeDao noticeDao=new NoticeDao();
int row=noticeDao.updateNotice(notice);

if(row==1){
	System.out.println("공지사항 수정 성공");
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
}else{
	System.out.println("공지사항 수정 실패!");
	response.sendRedirect(request.getContextPath()+"/admin/notice/updateNoticeForm.jsp");
}
%>