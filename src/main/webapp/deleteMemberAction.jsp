<%@page import="java.net.URLEncoder"%>
<%@page import="dao.MemberDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
request.getParameter("memberPw");
System.out.println("memberPw");

Member loginMember=(Member)session.getAttribute("loginMember");
int memberNo=loginMember.getMemberNo();

Member paramMember=new Member();
paramMember.setMemberNo(memberNo);

MemberDao memberDao=new MemberDao();
Member deleteMember=memberDao.delete(paramMember);

if(deleteMember!=null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
}else{
	String msg=URLEncoder.encode("비밀번호를 확인하세요!","utf-8");
	response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg="+msg);
}
%>