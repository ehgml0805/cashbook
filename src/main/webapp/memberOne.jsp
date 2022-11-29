<%@page import="dao.*"%>
<%@page import="vo.*"%>
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
//개인 정보 변경 후 돌아오면 이름 변경 안되어 있는데 로그아웃하고 다시 들어어면 바뀌어 있음,,,뭐로 받아와야하나


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
	<a href="<%=request.getContextPath()%>/cash/cashList.jsp">가계부</a>
	<a href="<%=request.getContextPath()%>/updateMemberForm.jsp">개인정1보 수정</a>
	<a href="<%=request.getContextPath()%>/deleteMemberForm.jsp">회원 탈퇴</a>
</body>
</html>