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
<table>
	<tr>
		<td></td>
		<td>아이디</td>
		<td>레벨</td>
		<td>이름</td>
		<td>마지막 수정일자</td>
		<td>가입일자</td>
		<td>레벨수정</td>
		<td>강제탈퇴</td>
	</tr>
</table>
</body>
</html>