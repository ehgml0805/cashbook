<%@page import="dao.*"%>
<%@page import="vo.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>

<%
request.setCharacterEncoding("utf-8");
/*
if(request.getParameter("memberName")==null
	||request.getParameter("memberPw")==null
	||request.getParameter("memberName").equals("")
	||request.getParameter("memberPw").equals("")){
	
}
*/
Member loginMember=(Member)session.getAttribute("loginMember");
String memberId=loginMember.getMemberId();
System.out.println(memberId+"<--아이디");
String memberName=request.getParameter("memberName");
System.out.println(memberName+"<--변경할 이름");
String memberPw=request.getParameter("memberPw");
System.out.println(memberPw+"<--비밀번호");

Member paramMember=new Member();
paramMember.setMemberId(memberId);
paramMember.setMemberName(memberName);

MemberDao memberDao=new MemberDao();
Member updateMember=memberDao.update(paramMember);

if(updateMember!=null){//비밀번호가 맞다면 수정이 되고 마이페이지로 돌아갈거
	response.sendRedirect(request.getContextPath()+"/memberOne.jsp");
}else{
	String msg=URLEncoder.encode("비밀번호를 확인하세요.","utf-8");
	response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg);
}

%>