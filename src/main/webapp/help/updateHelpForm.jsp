<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
//방어코드
Member loginMember=(Member)session.getAttribute("loginMember");
if(loginMember==null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
String msg1=request.getParameter("msg1");
String loginMemberId=loginMember.getMemberId();
int helpNo=Integer.parseInt(request.getParameter("helpNo"));
String helpMemo=request.getParameter("helpMemo");

Help help=new Help();
help.getHelpNo();
help.getHelpMemo();

HelpDao helpDao= new HelpDao();
Help list=helpDao.selectHelp(help);
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
	<form action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post">
		<table>
			<tr>
				<td>문의 번호</td>
				<td><input type="text" name="helpNo" value="<%=helpNo%>" readonly="readonly"> </td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="10" cols="30" name="helpMemo"><%=helpMemo%></textarea> </td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="memberId" value="<%=loginMemberId%>" readonly="readonly"> </td>
			</tr>
		</table>
	<button type="submit">수정하기</button>
	</form>
</body>
</html>