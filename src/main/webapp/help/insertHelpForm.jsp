<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="vo.*" %>
<%@page import="dao.*" %>
<%
Member loginMember=(Member)session.getAttribute("loginMember");
//방어코드
if(loginMember==null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
//아이디 받아오기
String loginMemberId=loginMember.getMemberId();
String msg1=request.getParameter("msg1");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if(msg1!=null){
%>		
		<%=msg1 %>	
<%		
	}
%>
	<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
		<table>
			<tr>
				<td>문의 내용</td>
				<td><textarea cols="30" rows="10" name="helpMemo"></textarea> </td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="memberId" value=<%=loginMemberId%> readonly="readonly"></td>
			</tr>
		</table>
	<button type="submit">문의하기</button>
	</form>
</body>
</html>