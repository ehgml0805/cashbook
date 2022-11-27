<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%
if(session.getAttribute("loginMember")==null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
request.setCharacterEncoding("utf-8");
String msg=request.getParameter("msg");

Member loginMember=(Member)(session.getAttribute("loginMember"));
String loginMemberId=loginMember.getMemberId();
String loginMemberName=loginMember.getMemberName();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/deleteMemberAction.jsp" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" value="<%=loginMemberId %>" name="memberId" readonly="readonly" ></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" value="<%=loginMemberName %>" name="memberName" readonly="readonly"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="memberPw"></td>
				<td>
					<%
						if(msg!=null){
					%>		
						<div> <%=msg %> </div>
					<%		
						}
					%>
				</td>
			</tr>
		</table>
		<button type="submit">탈퇴하기</button>
	</form>
	

</body>
</html>