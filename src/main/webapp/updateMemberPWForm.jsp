<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>


<%
//방어코드
if(session.getAttribute("loginMember")==null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
String msg2=request.getParameter("msg2");
String msg1=request.getParameter("msg1");
//model 호출
Member loginMember=(Member)session.getAttribute("loginMember");
String loginMemberId=loginMember.getMemberId();
String loginMemberName=loginMember.getMemberName();
String loginMemberPw=loginMember.getMemberPw();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경하기</title>
</head>
<body>
<%
	if(msg1!=null){
%>
	<%=msg1 %>
<%	
	}
%>
	<form action="<%=request.getContextPath()%>/updateMemberPWAction.jsp" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="memberId" value="<%=loginMemberId%>" readonly="readonly"> </td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="memberName" value="<%=loginMemberName%>" readonly="readonly"> </td>
			</tr>
			<tr>
				<td>변경 전 비밀번호</td>
				<td><input type="password" name="bememberPw">
					<%
						if(msg2!=null){
					%>		
						<%=msg2 %>	
					<%		
						}
					%>
					
				</td>
			</tr>
			<tr>
				<td>변경 할 비밀번호</td>
				<td><input type="password" name="memberPw"> </td>
			</tr>
		</table>
	<button type="submit"> 변경하기</button>
	</form>

</body>
</html>