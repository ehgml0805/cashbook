<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
//controller
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if (loginMember == null || loginMember.getMemberLevel() < 1) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
int memberLevel = loginMember.getMemberLevel();
System.out.println(memberLevel + "<-멤버레벨");
//model 호출

//최근 공지 5개, 신규 멤버 5명

//view
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인 페이지</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지 관리</a></li>
		<li><a
			href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원 관리(목록, level수정, 강제탈퇴)</a></li>
	</ul>
	<a href="<%=request.getContextPath()%>/logOut.jsp"> 로그아웃</a>
</body>
</html>