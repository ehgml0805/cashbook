<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String msg=request.getParameter("msg");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/insertMemberAction.jsp">
		<table>
			<tr>
				<td>이름</td>
				<td><input type="text" name="memberName"></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="memberId"></td>
				<td>
				<%
					if(msg!=null){
				%>
					<div><%=msg %></div> <%		
				}
				%>
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
		</table>
		<button type="submit">회원가입</button>
	</form>
</body>
</html>