<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

<%//CRUD 다 해야댐 noticeDao 만들어서 해야할 듯?
//controller
Member loginMember =(Member)session.getAttribute("loginMember");
if(loginMember==null||loginMember.getMemberLevel()<1){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
//model 호출:notice의 리스트 
int currentPage=1;//1페이지부터 보여줄거고
int rowPerPage=10;//10개씩 보여줄거
int beginRow=(currentPage-1)*rowPerPage;//0부터 뽑을게
//lastPage
NoticeDao noticeDao=new NoticeDao();
ArrayList<Notice> list=noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
int selectNoticeCount=noticeDao.selectNoticeCount();
int lastPage= selectNoticeCount/rowPerPage;

//view
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 페이징 작업 똑같이 하면 댐...그 머냐,,,10개씩 출력하면 되겠지,,, -->

<ul>
	<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지 관리</a> </li>
	<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a> </li>
	<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원 관리(목록, level수정, 강제탈퇴)</a></li>
</ul>
<!--뭐 원하는 대로 자유롭게 수정하기 -->
	<table>
	<!-- 공지 입력 만들기 -->
		<tr>
			<td>공지내용</td>
			<td>공지날짜</td>
			<td>수정</td>
			<td>삭제</td>
		</tr>
		<%
			for(Notice n: list){
		%>
			<tr>
				<td><%=n.getNoticeMemo() %></td>
				<td><%=n.getCreatedate() %></td>
				<td><a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp">수정</a></td>
				<td><a href="<%=request.getContextPath()%>/admin/deleteNoticeAction.jsp">삭제</a></td>
			</tr>	
		<%		
			}
		%>
	</table>
	
	<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1">처음</a>
	<%
		if(currentPage>1){
	%>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1 %>">이전</a>	
	<%		
		}
	%>
		<span><%=currentPage %></span>
	<%	
		if(currentPage<lastPage){
	%>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1 %>">다음</a>	
	<%		
			
		}
	%>

	<a href="<%=request.getContextPath()%>/admin/noticeList?currentPage=<%=lastPage%>">마지막</a>	
	
	
</body>
</html>