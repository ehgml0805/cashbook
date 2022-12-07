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
String msg1=request.getParameter("msg1");
int memberLevel = loginMember.getMemberLevel();
//System.out.println(memberLevel+"<==멤버 레벨");
int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
//System.out.println(categoryNo + "<==카테고리 넘버");

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
	<%
		if(msg1!=null){
	%>		
		<div><%=msg1 %></div>
	<%		
		}
	%>
	<form
		action="<%=request.getContextPath()%>/admin/category/updateCategoryAction.jsp" method="post">
		<input type="hidden" name="categoryNo" value="<%=categoryNo%>">
		<table>
			<tr>
				<td>변경 후 수입/지출</td>
				<td>
				<%
					if(category.getCategoryKind().equals("수입")){
				%>		
					<input type="radio" name="categoryKind" value="수입" checked="checked">수입
					<input type="radio" name="categoryKind" value="지출">지출
				<%		
					}else if(category.getCategoryKind().equals("지출")){
				%>
					<input type="radio" name="categoryKind" value="수입" >수입
					<input type="radio" name="categoryKind" value="지출" checked="checked">지출
				<%
					}
				%>
				</td>
			</tr>
			<tr>
				<td>변경 전 항목</td>
				<td><input type="text" value="<%=category.getCategoryName()%>" readonly="readonly"></td>
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