<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>

<%
int commentNo=Integer.parseInt(request.getParameter("commentNo"));
//System.out.println(commentNo+"<=commentNo");
CommentDao commentDao=new CommentDao();
int row=commentDao.deleteComment(commentNo);
if(row==1){
	System.out.println("답변 삭제 성공");
	response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
}else{
	System.out.println("답변 삭제 실패!");
	String msg1=URLEncoder.encode("✔답변 삭제 실패","utf-8");
	response.sendRedirect(request.getContextPath()+"/admin/comment/helpListAll.jsp?h&msg1="+msg1);
}
%>