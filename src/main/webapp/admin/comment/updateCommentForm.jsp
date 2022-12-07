<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if(loginMember == null || loginMember.getMemberLevel() < 1){
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
String msg1=request.getParameter("msg1");

int commentNo=Integer.parseInt(request.getParameter("commentNo"));
String commentMemo=request.getParameter("commentMemo");

CommentDao commentDao= new CommentDao();
Comment comment=commentDao.selectCommentOne(commentNo);

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
	<form action="<%=request.getContextPath()%>/admin/comment/updateCommentAction.jsp" method="post">
		<table>
			<tr>
				<td>답변 번호</td>
				<td><input type="text" name="commentNo" value="<%=commentNo%>" readonly="readonly"> </td>
			</tr>
			<tr>
				<td>답변 수정</td>
				<td><textarea rows="10" cols="30" name="commentMemo"><%=comment.getCommentMemo() %></textarea></td>
			</tr>
		</table>
		<button type="submit">답변 수정</button>
	</form>

</body>
</html>