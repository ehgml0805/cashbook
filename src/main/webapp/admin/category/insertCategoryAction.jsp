<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.*"%>

<%
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if (loginMember == null || loginMember.getMemberLevel() < 1||request.getParameter("categoryName").equals("")) {
	response.sendRedirect(request.getContextPath() +"/admin/category/insertCategoryForm.jsp");
	return;
}
request.setCharacterEncoding("utf-8");
String categoryKind = request.getParameter("categoryKind");
String categoryName = request.getParameter("categoryName");
System.out.println(categoryKind + "<--수입/지출");
System.out.println(categoryName + "<--항목");
int memberLevel = loginMember.getMemberLevel();
System.out.println(memberLevel + "<-멤버레벨");

Category category = new Category();
category.setCategoryKind(categoryKind);
category.setCategoryName(categoryName);

CategoryDao categoryDao = new CategoryDao();
int row = categoryDao.insertCategory(category);
if (row == 1) {
	System.out.println("카테고리 추가 성공");
	response.sendRedirect(request.getContextPath() + "/admin/categoryList.jsp");
} else {
	System.out.println("카테고리 추가 실패!");
	response.sendRedirect(request.getContextPath() + "/admin/category/insertCategoryForm.jsp");
}
%>