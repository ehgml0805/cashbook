<%@page import="dao.*"%>
<%@page import="vo.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>

<%
request.setCharacterEncoding("utf-8");
if(session.getAttribute("loginMember")==null||request.getParameter("memberName").equals("")
	||request.getParameter("memberPw").equals("")){
	response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp");
	return;
}
//개인정보 수정 폼에서 아이디 받아오기
String memberId=request.getParameter("memberId");
//System.out.println(memberId+"<--아이디");
String memberName=request.getParameter("memberName");
//System.out.println(memberName+"<--변경할 이름");
String memberPw=request.getParameter("memberPw");
//System.out.println(memberPw+"<--비밀번호");
//model 불러오기
Member paramMember=new Member();
paramMember.setMemberPw(memberPw);
paramMember.setMemberId(memberId);
paramMember.setMemberName(memberName);
MemberDao memberDao=new MemberDao();
//Member idPwCh=memberDao.idPwCh(memberId, memberPw);
Member resultMember=memberDao.update(paramMember);
if(resultMember!=null){
	System.out.println("비밀번호 일치");
	System.out.println("개인정보 수정 성공");
	session.setAttribute("loginMember", resultMember);
	//바뀐 정보를 세션 안에 넣어주는 작업 필요 안하면 db에는 바꼈는데 페이지상에서 바뀐거 안보임
	response.sendRedirect(request.getContextPath()+"/memberOne.jsp");

}else{
	System.out.println("비밀번호가 다름!");
	System.out.println("개인정보 수정 실패!");
	String msg1=URLEncoder.encode("✔비밀번호가 다릅니다!","utf-8");
	response.sendRedirect(request.getContextPath()+"/memberOne.jsp?msg1="+msg1);
}

%>