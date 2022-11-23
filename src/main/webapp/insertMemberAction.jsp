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
response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
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

MemberDao memberDao=new MemberDao();
Member insertMember=memberDao.insert(paramMember);


if(insertMember!=null){//중복 아이디가 아니면 회원가입 되고 로그인 폼으로 넘어감
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
}else{//중복된 아이디라면 회원가입폼으로 다시 돌아가고 중복된 아이디라고 띄울거
	String msg=URLEncoder.encode("중복된 아이디입니다.","utf-8");
	response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);

}

%>