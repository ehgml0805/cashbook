<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>


<%
int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
System.out.println(categoryNo + "<==카테고리넘버");
CategoryDao categoryDao = new CategoryDao();
int row = categoryDao.deleteCategory(categoryNo);
if (row == 1) {
	System.out.println("카테고리 삭제 성공");
	response.sendRedirect(request.getContextPath() + "/admin/categoryList.jsp");
} else {
	System.out.println("카테고리 삭제 실패!");
	response.sendRedirect(request.getContextPath() + "/admin/category/categoryList.jsp");
}
%>