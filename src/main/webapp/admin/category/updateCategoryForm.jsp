<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>

<%
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if (loginMember == null || loginMember.getMemberLevel() < 1) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
int memberLevel = loginMember.getMemberLevel();
//System.out.println(memberLevel+"<==멤버 레벨");
int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
System.out.println(categoryNo + "<==카테고리 넘버");
//model 호출
CategoryDao categoryDao = new CategoryDao();
Category category = categoryDao.selectCategoryOne(categoryNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 수정하기</title>
</head>
<body>
	<form
		action="<%=request.getContextPath()%>/admin/category/updateCategoryAction.jsp" method="post">
		<input type="hidden" name="categoryNo"
			value="<%=category.getCategoryNo()%>">
		<table>
			<tr>
				<td>변경 전 항목</td>
				<td><input type="text" value="<%=category.getCategoryName()%>"
					readonly="readonly"></td>
			</tr>
			<tr>
				<td>변경 후 항목</td>
				<td><input type="text" name="categoryName"></td>
			</tr>
		</table>
		<button type="submit">수정하기</button>
	</form>

</body>
</html>