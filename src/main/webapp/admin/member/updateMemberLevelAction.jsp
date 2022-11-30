<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@page import="java.net.URLEncoder"%>
<%
//방어코드
Member loginMember = (Member) session.getAttribute("loginMember");
if(loginMember == null || loginMember.getMemberLevel() < 1||request.getParameter("memberLevel")==null||request.getParameter("memberLevel").equals("")){
	response.sendRedirect(request.getContextPath()+"/admin/member/updateMemberLevelForm.jsp");
	return;
}

int memberLevel=Integer.parseInt(request.getParameter("memberLevel"));
System.out.println(memberLevel+"<==변경할 레벨");
String memberId=request.getParameter("memberId");
String memberName=request.getParameter("memberName");

Member member=new Member();
member.setMemberId(memberId);
member.setMemberName(memberName);
member.setMemberLevel(memberLevel);

MemberDao memberDao=new MemberDao();
int row= memberDao.updateLevel(member);

if(row==1){
	System.out.println("레벨 수정 성공");
	session.setAttribute("loginMember", member);
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
}else{
	System.out.println("레벨 수정 실패!");
	String msg=URLEncoder.encode("✔회원 레벨 수정 실패!", "utf-8");
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp?msg="+msg);
}
%>