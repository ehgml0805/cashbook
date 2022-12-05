<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
request.setCharacterEncoding("utf-8");
Member loginMember=(Member)session.getAttribute("loginMember");
//방어코드
if(loginMember==null||loginMember.getMemberLevel()<1){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
String msg1=request.getParameter("msg1");
int noticeNo=Integer.parseInt(request.getParameter("noticeNo"));
System.out.println(noticeNo+"공지 번호");
String noticeMemo=request.getParameter("noticeMemo");
//model 호출
NoticeDao noticeDao=new NoticeDao();
Notice notice= noticeDao.selectNotice(noticeMemo);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if(msg1!=null){
	%>		
		<div><%=msg1 %></div>
	<%		
		}
	%>
	<form action="<%=request.getContextPath()%>/admin/notice/updateNoticeAction.jsp" method="post">
		<input type="text" name="noticeNo" value="<%=noticeNo%>">
		<div>공지내용</div>
		<div><textarea rows="10" cols="30" name="noticeMemo"><%=noticeMemo %></textarea></div>
		<button type="submit">수정하기</button>
	</form>
</body>
</html>