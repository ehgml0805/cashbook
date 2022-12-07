<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>

<%
request.setCharacterEncoding("utf-8");
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if(loginMember == null||loginMember.getMemberLevel() < 1){
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
int commentNo=Integer.parseInt(request.getParameter("commentNo"));
//System.out.println(commentNo+"<= 답변 번호");
String commentMemo=request.getParameter("commentMemo");

if (request.getParameter("commentNo").equals("")||request.getParameter("commentNo")==null
	||request.getParameter("commentMemo").equals("")||request.getParameter("commentMemo")==null){
	String msg1=URLEncoder.encode("✔공지사항을 입력하세요!","utf-8");
	response.sendRedirect(request.getContextPath() + "/admin/comment/updateCommentForm.jsp?commentNo="+commentNo+"&msg1="+msg1);
	return;
}
Comment comment= new Comment();
comment.setCommentMemo(commentMemo);
comment.setCommentNo(commentNo);

CommentDao commentDao= new CommentDao();
int row = commentDao.updateComment(comment);

if(row==1){
	System.out.println("답변 수정 성공");
	response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
}else{
	System.out.println("답변 수정 실패!");
	String msg1=URLEncoder.encode("✔답변 수정 실패!","utf-8");
	response.sendRedirect(request.getContextPath() + "/admin/comment/updateCommentForm.jsp?commentNo="+commentNo+"&msg1="+msg1);
	return;
}
%>