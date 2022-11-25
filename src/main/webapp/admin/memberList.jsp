<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="vo.Member"%>

<%
//controller
Member loginMember =(Member)session.getAttribute("loginMember");
if(loginMember==null||loginMember.getMemberLevel()<1){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
//model 호출
MemberDao memberDao =new MemberDao();

//view
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--  -->
<ul>
	<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지 관리</a> </li>
	<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a> </li>
	<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원 관리(목록, level수정, 강제탈퇴)</a></li>
</ul>
<!-- 멤버 목록 -->
</body>
</html>