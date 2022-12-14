<%@page import="java.net.URLEncoder"%>
<%@page import="dao.*"%>
<%@page import="vo.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
//방어코드
if(session.getAttribute("loginMember")==null ||request.getParameter("memberPw").equals("")||request.getParameter("memberPw")==null){
	response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp");
	return;
}

//입력한 아이디랑 비밀 번호 받아오기
String memberId=request.getParameter("memberId");
String memberPw=request.getParameter("memberPw");
System.out.println(memberId);
System.out.println(memberPw);

Member paramMember=new Member();
paramMember.setMemberId(memberId);
paramMember.setMemberPw(memberPw);

MemberDao memberDao=new MemberDao();
Member resulMembser=memberDao.delete(paramMember);

if(resulMembser!=null){
	System.out.println("회원정보 삭제 성공");
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
String msg1=URLEncoder.encode("✔비밀번호가 다릅니다!","utf-8");
response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg1="+msg1);
return;
%>