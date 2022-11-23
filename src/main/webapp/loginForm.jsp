<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String msg=request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN Form</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/loginAction.jsp">
		<%
			if(msg!=null){
		%>		
			<div><%=msg %></div>
		<%		
			}
		%>
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="memberId"> </td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="memberPw"> </td>
			</tr>
		</table>
		<button type="submit">로그인</button>
	</form>
	<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
</body>
</html>