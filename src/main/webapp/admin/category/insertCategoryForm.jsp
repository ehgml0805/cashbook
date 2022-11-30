<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
//controller
request.setCharacterEncoding("utf-8");
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if (loginMember == null || loginMember.getMemberLevel() < 1) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
int memberLevel = loginMember.getMemberLevel();
System.out.println(memberLevel + "<-멤버레벨");
//model 호출
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 추가하기</title>
</head>
<body>
	<form
		action="<%=request.getContextPath()%>/admin/category/insertCategoryAction.jsp" method="post">
		<table>
			<tr>
				<td>수입/지출</td>
				<td><input type="radio" name="categoryKind" value="수입">수입
					<input type="radio" name="categoryKind" value="지출">지출</td>
			</tr>
			<tr>
				<td>항목</td>
				<td><input type="text" name="categoryName"></td>
			</tr>
		</table>
		<button type="submit">추가하기</button>
	</form>
</body>
</html>