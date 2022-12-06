<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>

<%
request.setCharacterEncoding("utf-8");
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if(loginMember == null || loginMember.getMemberLevel() < 1){
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
String memberId=request.getParameter("memberId");
String commentMemo=request.getParameter("commentMemo");
int helpNo=Integer.parseInt(request.getParameter("helpNo"));

if(request.getParameter("commentMemo")==null||request.getParameter("commentMemo").equals("")
	||request.getParameter("helpNo")==null||request.getParameter("helpNo").equals("")){
	String msg1=URLEncoder.encode("✔답변을 입력하세요!","utf-8");
	response.sendRedirect(request.getContextPath() + "/admin/comment/insertCommentForm.jsp?helpNo="+helpNo+"&msg1="+msg1);
	return;
}

Comment comment=new Comment();
comment.setHelpNo(Integer.parseInt(request.getParameter("helpNo")));
comment.setCommentMemo(request.getParameter("commentMemo"));
comment.setMemberId(request.getParameter("memberId"));

CommentDao commentDao=new CommentDao();
int row= commentDao.insertComment(comment);

if(row==1){
	System.out.println("답변 추가 성공");
	response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
}else{
	System.out.println("답변 추가 실패!");
	String msg1=URLEncoder.encode("✔답변 추가 실패","utf-8");
	response.sendRedirect(request.getContextPath()+"/admin/comment/insertCommentForm.jsp?helpNo="+helpNo+"&msg1="+msg1);
}
%>