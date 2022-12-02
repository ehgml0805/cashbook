<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder"%>

<%
request.setCharacterEncoding("utf-8");
//방어코드
Member loginMember=(Member)session.getAttribute("loginMember");
if(loginMember==null|| request.getParameter("helpMemo")==null||request.getParameter("helpMemo").equals("")){
	String msg1=URLEncoder.encode("메모를 입력하세요", "utf-8");
	response.sendRedirect(request.getContextPath()+"/help/insertHelpForm.jsp?msg1="+msg1);
 return;
}
//메모 받아오기
String helpMemo=request.getParameter("helpMemo");
//String memberId=request.getParameter("memberId");
String memberId=loginMember.getMemberId();
System.out.println(memberId+"memberId");

//model 불러오기
Help help=new Help();
help.setHelpMemo(helpMemo);
help.setMemberId(memberId);

HelpDao helpDao=new HelpDao();
int row =helpDao.insertHelp(help);

if(row==1){
	System.out.println("문의 추가 성공");
	response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
	return;
}else{
	System.out.println("문의 추가 실패!");
	String msg2=URLEncoder.encode("✔ 문의 추가 실패!", "utf-8");
	response.sendRedirect(request.getContextPath()+"/help/helpList.jsp?msg2="+msg2);
}
%>