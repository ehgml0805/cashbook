<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@page import="java.net.URLEncoder"%>
<%
//방어코드
Member loginMember = (Member) session.getAttribute("loginMember");
if(loginMember == null || loginMember.getMemberLevel() < 1){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
int memberNo=Integer.parseInt(request.getParameter("memberNo"));
//방어코드
if(request.getParameter("memberNo")==null||request.getParameter("memberLevel")==null||request.getParameter("memberLevel").equals("")){
	String msg1=URLEncoder.encode("✔회원 레벨을 선택하세요", "utf-8");
	response.sendRedirect(request.getContextPath()+"/admin/member/updateMemberLevelForm.jsp?memberNo="+memberNo+"&msg1="+msg1);
	return;
}

int memberLevel=Integer.parseInt(request.getParameter("memberLevel"));
//System.out.println(memberLevel+"<==변경할 레벨");
String loginMemberId = loginMember.getMemberId();// 로그인 한 사람 아이디
//System.out.println(loginMemberId+"로그인한 아이디");

Member member=new Member();
member.setMemberNo(memberNo);
member.setMemberLevel(memberLevel);

MemberDao memberDao=new MemberDao();
int row= memberDao.updateLevel(member);

if(row==1){
	System.out.println("레벨 수정 성공");
	//session.setAttribute("loginMember", member); 이거 하니까 자꾸 수정 성공해서 멤버리스트로 돌아가면 로그인한 아이디 값이 null나옴
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
}else{
	System.out.println("레벨 수정 실패!");
	String msg1=URLEncoder.encode("✔회원 레벨 수정 실패!", "utf-8");
	response.sendRedirect(request.getContextPath()+"/admin/member/updateMemberLevelForm.jsp?memberNo="+memberNo+"&msg1="+msg1);
}
%>