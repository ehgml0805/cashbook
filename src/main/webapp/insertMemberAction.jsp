<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
request.setCharacterEncoding("utf-8");
if(request.getParameter("memberName")==null
	||request.getParameter("memberId")==null
	||request.getParameter("memberPw")==null
	||request.getParameter("memberName").equals("")
	||request.getParameter("memberId").equals("")
	||request.getParameter("memberPw").equals("")){
	String msg1=URLEncoder.encode("✔아이디, 이름, 비밀번호를 입력하세요!","utf-8");
	response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg1="+msg1);
	return;
}
//회원 가입 폼에서 이름 받아오기
String memberName=request.getParameter("memberName");
String memberId=request.getParameter("memberId");
System.out.println(memberId+"<--memberId");
String memberPw=request.getParameter("memberPw");
System.out.println(memberPw+"<--memberPw");

Member paramMember=new Member();
paramMember.setMemberId(memberId);
paramMember.setMemberPw(memberPw);
paramMember.setMemberName(memberName);
//model 호출
MemberDao memberDao=new MemberDao();
if(memberDao.memberIdCh(memberId)){
	System.out.println("중복된 아이디 입니다");
	String msg=URLEncoder.encode("✔중복된 아이디입니다.","utf-8");
	response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
	return;
}
int row=memberDao.insertMember(paramMember);
System.out.println("회원가입 성공");
response.sendRedirect(request.getContextPath()+"/loginForm.jsp");


%>