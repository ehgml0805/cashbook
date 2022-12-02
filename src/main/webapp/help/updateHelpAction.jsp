<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder" %>

<%
request.setCharacterEncoding("utf-8");
//받아오기
String memberId=request.getParameter("memberId");
String helpMemo=request.getParameter("helpMemo");
int helpNo=Integer.parseInt(request.getParameter("helpNo"));
//방어코드
request.setCharacterEncoding("utf-8");
Member loginMember=(Member)session.getAttribute("loginMember");
if(loginMember==null||request.getParameter("helpMemo")==null||request.getParameter("helpMemo").equals("")
	||request.getParameter("helpNo")==null||request.getParameter("helpNo").equals("")
	||request.getParameter("memberId")==null||request.getParameter("memberId").equals("") ){
	String msg1=URLEncoder.encode("✔문의 사항을 입력하시오", "utf-8");
	response.sendRedirect(request.getContextPath()+"/help/updateHelpForm.jsp?msg1="+msg1+"helpNo="+helpNo);
	return;
}
//model 호출
Help help=new Help();
help.setHelpMemo(helpMemo);
help.setHelpNo(helpNo);

HelpDao helpDao=new HelpDao();
int row=helpDao.updateHelp(help);
if(row==1){
	System.out.println("문의 수정 성공");
	response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
}else{
	System.out.println("문의 수정 실패");
	String msg2=URLEncoder.encode("✔문의 사항 수정 실패", "utf-8");
	response.sendRedirect(request.getContextPath()+"/help/updateHelpForm.jsp?msg2="+msg2);
}

%>