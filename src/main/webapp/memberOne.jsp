<%@page import="dao.MemberDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%
if(session.getAttribute("loginMember")==null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
//session에 있는 ID랑 NAME 받아오기
Member loginMember=(Member)session.getAttribute("loginMember");
String memberId=loginMember.getMemberId();
String memberName=loginMember.getMemberName();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
	<table>
		<tr>
			<td>아이디: <%=memberId %></td>
		</tr>
		<tr>
			<td>이름: <%=memberName %> </td>
		</tr>
		<tr>
			<td>비밀번호:
			<a href="<%=request.getContextPath()%>/updateMemberPWForm.jsp">비밀번호 변경</a>
			 </td>
		</tr>
	</table>
	<a href="<%=request.getContextPath()%>/updateMemberForm.jsp">개인정보 수정</a>
	<a href="<%=request.getContextPath()%>/deleteMemberForm.jsp">회원탈퇴</a>
</body>
</html>