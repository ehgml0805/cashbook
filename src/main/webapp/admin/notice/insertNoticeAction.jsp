<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
request.setCharacterEncoding("utf-8");
String noticeMemo=request.getParameter("noticeMemo");
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if(loginMember == null||loginMember.getMemberLevel() < 1){
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
if (noticeMemo.equals("")) {
	String msg1=URLEncoder.encode("✔공지사항을 입력하세요!","utf-8");
	response.sendRedirect(request.getContextPath() + "/admin/notice/insertNoticeForm.jsp?msg1="+msg1);
	return;
}

Notice notice=new Notice();
notice.setNoticeMemo(noticeMemo);

NoticeDao noticeDao=new NoticeDao();
int row=noticeDao.insertNotice(notice);
if(row==1){
	System.out.println("공지사항 추가 성공");
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
}else{
	System.out.println("공지사항 추가 실패!");
	response.sendRedirect(request.getContextPath()+"/admin/notice/insertNoticeForm.jsp");
}

%>