<%@page import="dao.*"%>
<%@page import="vo.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
//controller
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if (loginMember == null || loginMember.getMemberLevel() < 1) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
int memberLevel = loginMember.getMemberLevel();
//System.out.println(memberLevel+"<-멤버레벨");
//model 호출
CategoryDao categoryDao = new CategoryDao();
ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();

//view
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>
</head>
<body>
	<!-- 페이징 놉 -->
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">메인으로</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지 관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원 관리(목록, level수정, 강제탈퇴)</a></li>
	</ul>
	<!-- 카테고리 리스트 출력하기 -->
	<h1>카테고리 리스트</h1>
	<div>
		<a href="<%=request.getContextPath()%>/admin/category/insertCategoryForm.jsp">카테고리 추가</a>
	</div>
	<table>
		<tr>
			<td>번호</td>
			<td>수입/지출</td>
			<td>항목</td>
			<td>마지막 업데이트</td>
			<td>생성날짜</td>
			<td>수정</td>
			<td>삭제</td>
		</tr>

		<%
		for (Category c : categoryList) {
		%>
		<tr>
			<td><%=c.getCategoryNo()%></td>
			<td><%=c.getCategoryKind()%></td>
			<td><%=c.getCategoryName()%></td>
			<td><%=c.getUpdatedate()%></td>
			<td><%=c.getCreatedate()%></td>
			<td><a
				href="<%=request.getContextPath()%>/admin/category/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a></td>
			<td><a
				href="<%=request.getContextPath()%>/admin/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a></td>
		</tr>
		<%
		}
		%>
	</table>
</body>
</html>