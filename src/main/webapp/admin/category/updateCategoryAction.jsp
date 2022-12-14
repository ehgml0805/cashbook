<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
request.setCharacterEncoding("utf-8");
Member loginMember = (Member) session.getAttribute("loginMember");
if (loginMember == null || loginMember.getMemberLevel() < 1){
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
//System.out.println(categoryNo + "<==카테고리 넘버 ");
String categoryKind=request.getParameter("categoryKind");
//방어코드
if (request.getParameter("categoryName").equals("")||request.getParameter("categoryKind")==null
	||request.getParameter("categoryKind").equals("")) {
	String msg1=URLEncoder.encode("✔항목 이름을 입력하세요!","utf-8");
	response.sendRedirect(request.getContextPath() + "/admin/category/updateCategoryForm.jsp?categoryNo=" + categoryNo+"&msg1="+msg1);
	return;
}
int memberLevel = loginMember.getMemberLevel();
//System.out.println(memberLevel+"<==멤버 레벨");
String categoryName = request.getParameter("categoryName");
//System.out.println(categoryName+"<==변경할 항목 ");


Category category = new Category();
category.setCategoryNo(categoryNo);//set으로 넘버에 맞게 이름 넣기?
category.setCategoryName(categoryName);
category.setCategoryKind(categoryKind);
//System.out.println(categoryName + "<==변경할 항목 ");

CategoryDao categoryDao = new CategoryDao();
int row = categoryDao.updateCategoryName(category);
if (row == 1) {
	System.out.println("카테고리 수정 성공");
	response.sendRedirect(request.getContextPath() + "/admin/categoryList.jsp");
} else {
	System.out.println("카테고리 수정 실패!");
	String msg1=URLEncoder.encode("✔카테고리 수정 실패!","utf-8");
	response.sendRedirect(request.getContextPath() + "/admin/category/updateCategoryForm.jsp?categoryNo=" + categoryNo+"&msg1="+msg1);
}
%>