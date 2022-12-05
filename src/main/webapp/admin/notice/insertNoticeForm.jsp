<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="vo.*" %>
<%@page import="dao.*" %>

<%
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if(loginMember == null || loginMember.getMemberLevel() < 1){
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
String msg1=request.getParameter("msg1");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 추가하기</title>
</head>
<body>
	<%
		if(msg1!=null){
	%>		
		<div><%=msg1 %></div>
	<%		
		}
	%>
	<form action="<%=request.getContextPath()%>/admin/notice/insertNoticeAction.jsp"  method="post">
		<div>공지 내용</div>
		<div><textarea rows="10" cols="30" name="noticeMemo"></textarea></div>
		<div><button type="submit">공지 추가</button></div>
	</form>
</body>
</html>