<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%

request.setCharacterEncoding("utf-8");

String memberId=request.getParameter("memberId");//로그인 폼에서 name 써준거랑 똑같이 쓰기
System.out.println(memberId+"<--memberId");
String memberPw=request.getParameter("memberPw");
System.out.println(memberPw+"<--memberPw");

Member paramMember=new Member();
paramMember.setMemberId(memberId);
paramMember.setMemberPw(memberPw);

MemberDao memberDao= new MemberDao();
Member resultMember=memberDao.login(paramMember);


if(resultMember !=null){
	session.setAttribute("loginMember", resultMember);//loginMember에 memberId랑 memberName이 들어 있는건가?
	response.sendRedirect(request.getContextPath()+"/memberOne.jsp");
}else{
	String msg=URLEncoder.encode("✔아이디와 비밀번호를 확인하세요!","utf-8");
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
}

%>