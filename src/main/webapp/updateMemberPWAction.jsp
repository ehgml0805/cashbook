<%@page import="dao.*"%>
<%@page import="vo.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>

<%
request.setCharacterEncoding("utf-8");
//방어코드
if(session.getAttribute("loginMember")==null||request.getParameter("bememberPw")==null||request.getParameter("bememberPw").equals("")
||request.getParameter("memberPw")==null||request.getParameter("memberPw").equals("")){
	String msg1=URLEncoder.encode("✔비밀번호를 입력하세요!","utf-8");
	response.sendRedirect(request.getContextPath()+"/updateMemberPWForm.jsp?msg1="+msg1);
	return;
}
//form에서 받아오기
String memberId=request.getParameter("memberId");
System.out.println(memberId+"<==아이디");
String memberName=request.getParameter("memberName");
String bememberPw=request.getParameter("bememberPw");
System.out.println(bememberPw+"<==변경 전 비밀번호");
String memberPw=request.getParameter("memberPw");
System.out.println(memberPw+"<==변경 할 비밀번호");

Member paramMember=new Member();
paramMember.setMemberId(memberId);
//paramMember.setMemberPw(bememberPw);//변경전 비밀번호
paramMember.setMemberPw(memberPw);//변경할 비밀번호
paramMember.setMemberName(memberName);

MemberDao memberDao=new MemberDao();
//기존 비밀번호 아이디랑 맞는지 확인
int row=memberDao.Pwch(memberId, bememberPw);
if(row==0){//일치 하지 않음
	System.out.println("비밀번호가 다름!");
	String msg2=URLEncoder.encode("✔기존 비밀번호가 다릅니다!","utf-8");
	response.sendRedirect(request.getContextPath()+"/updateMemberPWForm.jsp?msg2="+msg2);
	return;
}	
//나눠서 하니까 또 되네,,?
//비밀번호 업데이트 model 호출
Member resultMember= memberDao.updatePw(paramMember);
if(resultMember!=null){
		System.out.println("비밀번호 수정 성공");
		session.setAttribute("loginMember", resultMember);
		response.sendRedirect(request.getContextPath()+"/memberOne.jsp");
		return;
}else{
	System.out.println("비밀번호 수정 실패!");
	String msg2=URLEncoder.encode("✔기존 비밀번호가 다릅니다!","utf-8");
	response.sendRedirect(request.getContextPath()+"/updateMemberPWForm.jsp?msg2="+msg2);
	return;
}


%>