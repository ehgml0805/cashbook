<%@page import="dao.*"%>
<%@page import="vo.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>

<%
request.setCharacterEncoding("utf-8");
if(request.getParameter("memberName").equals("")
	||request.getParameter("memberPw").equals("")){
	String msg1=URLEncoder.encode("이름과 비밀번호를 확인하세요.","utf-8");
	response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg1="+msg1);
	return;
}
//개인정보 수정 폼에서 아이디 받아오기
String memberId=request.getParameter("memberId");
System.out.println(memberId+"<--아이디");
String memberName=request.getParameter("memberName");
System.out.println(memberName+"<--변경할 이름");
String memberPw=request.getParameter("memberPw");
System.out.println(memberPw+"<--비밀번호");

Member paramMember=new Member();
paramMember.setMemberId(memberId);
paramMember.setMemberPw(memberPw);
paramMember.setMemberName(memberName);

MemberDao memberDao=new MemberDao();
Member updateMember=memberDao.update(paramMember);
%>