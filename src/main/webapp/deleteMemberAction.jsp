<%@page import="java.net.URLEncoder"%>
<%@page import="dao.MemberDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String memberId=request.getParameter("memberId");
String memberPw=request.getParameter("memberPw");
System.out.println(memberId);
System.out.println(memberPw);

Member paramMember=new Member();
paramMember.setMemberId(memberId);
paramMember.setMemberPw(memberPw);

MemberDao memberDao=new MemberDao();
Member deleteMember=memberDao.delete(paramMember);


String msg=URLEncoder.encode("비밀번호를 확인하세요!","utf-8");
response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg="+msg);
%>