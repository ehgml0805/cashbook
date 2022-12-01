<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="dao.*" %>
<%@page import="java.util.*" %>
<%@page import="vo.*" %>

<%
request.setCharacterEncoding("utf-8");
String msg=request.getParameter("msg");

int currentPage=1;
if(request.getParameter("currentPage")!=null){
	currentPage=Integer.parseInt(request.getParameter("currentPage"));
}
int rowPerPage=5;
int beginRow=(currentPage-1)*rowPerPage;
//lastPage 구해야함 
NoticeDao noticeDao= new NoticeDao();
ArrayList<Notice> list= noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
int selectNoticeCount=noticeDao.selectNoticeCount();//전체 행의 개수 가져오기
//System.out.println(selectNoticeCount);
//last page 구하기
int lastPage=selectNoticeCount/rowPerPage;
//System.out.println(lastPage);
%>
<!DOCTYPE html>
<html>
<head>
  <head>
  </head>
<title>LOGIN Form</title>
</head>
<body>

	<form action="<%=request.getContextPath()%>/loginAction.jsp"  method="post">
		<%
			if(msg!=null){
		%>		
			<div><%=msg %></div>
		<%		
			}
		%>
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="memberId"> </td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="memberPw"> </td>
			</tr>
		</table>
		<button type="submit">로그인</button>
	</form>
	<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
		<!-- 신규 공지 5개 페이징 -->
	<table>
		<tr>
			<td>공지사항</td>
			<td>날짜</td>
		</tr>
		<%
			for(Notice n: list){
		%>		
			<tr>
				<td><%=n.getNoticeMemo() %></td>
				<td><%=n.getCreatedate() %></td>
			</tr>
		<%	
			}
		%>
	</table>
	
	<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">처음</a>
	<%
		if(currentPage>1){
	%>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1 %>">이전</a>	
	<%		
		}
	%>
		<span><%=currentPage %></span>
	<%	
		if(currentPage<lastPage){
	%>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1 %>">다음</a>	
	<%		
			
		}
	%>

	<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">마지막</a>	
	

</body>
</html>