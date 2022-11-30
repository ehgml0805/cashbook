<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
//방어코드
if(session.getAttribute("loginMember")==null||request.getParameter("memberId")==null||request.getParameter("memberId").equals("")){
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
	return;
}
//멤버 아이디 받아오기
String memberId=request.getParameter("memberId");
System.out.println(memberId+"<==강퇴할 아이디");

//model 호출
Member member=new Member();
member.setMemberId(memberId);
MemberDao memberDao=new MemberDao();
int row =memberDao.deleteMemberByAdmin(member);
if(row==1){
	System.out.println("회원 강퇴 성공");
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
}else{
	System.out.println("회원 강퇴 실패!");
	String msg=URLEncoder.encode("✔회원 강퇴 실패!", "utf-8");
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp?msg="+msg);
}

%>