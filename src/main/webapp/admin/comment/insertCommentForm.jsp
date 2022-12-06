<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
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
String memberId=loginMember.getMemberId();
int helpNo=Integer.parseInt(request.getParameter("helpNo"));
//System.out.println(helpNo+"<=문의 번호");
String msg1=request.getParameter("msg1");

HelpDao helpDao=new HelpDao();
HashMap<String, Object> map= helpDao.selectHelpComment(helpNo);
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
		<div><%=msg1 %></div>
	<%		
		}
	%>
	<form action="<%=request.getContextPath()%>/admin/comment/insertCommentAction.jsp" method="post">
		<table>
			<tr>
				<td>문의 번호</td>
				<td><input type="text" name="helpNo" value="<%=helpNo%>" readonly="readonly"> </td>
			</tr>
			<tr>
				<td>작성자아이디</td>
				<td><input type="text" name="memberId" value="<%=map.get("memberId")%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>작성 날짜</td>
				<td><input type="text" name="createdate" value="<%=map.get("createdate")%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>문의 내용</td>
				<td><%=map.get("helpMemo") %></td>
			</tr>
			<!-- 위에는 문의확인 하면서 아래는 답변하기 -->
			<tr>
				<td>답변 입력</td>
				<td><textarea rows="10" cols="30" name="commentMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">답변 추가</button>
	</form>

</body>
</html>