<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

<%
request.setCharacterEncoding("utf-8");
//CRUD 다 해야댐 noticeDao 만들어서 해야할 듯?
//controller
Member loginMember =(Member)session.getAttribute("loginMember");
//방어코드
if(loginMember==null||loginMember.getMemberLevel()<1){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
//model 호출:notice의 리스트 
int currentPage=1;//1페이지부터 보여줄거고
if(request.getParameter("currentPage")!=null){
	currentPage=Integer.parseInt(request.getParameter("currentPage"));
}
int rowPerPage=10;
int beginRow=(currentPage-1)*rowPerPage;
//lastPage 구해야함 
NoticeDao noticeDao= new NoticeDao();
ArrayList<Notice> list= noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
int selectNoticeCount=noticeDao.selectNoticeCount();//전체 행의 개수 가져오기
//System.out.println(selectNoticeCount);
//last page 구하기
int lastPage=selectNoticeCount/rowPerPage;
//System.out.println(lastPage);
if(selectNoticeCount/rowPerPage!=0){
	lastPage=lastPage+1;
}

//view
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 관리</title>
</head>
<body>
<!-- 페이징 작업 똑같이 하면 댐...그 머냐,,,10개씩 출력하면 되겠지,,, -->

<ul>
	<li><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">메인으로</a></li>
	<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지 관리</a> </li>
	<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a> </li>
	<li><a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">문의 관리</a></li>
	<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원 관리(목록, level수정, 강제탈퇴)</a></li>
</ul>
<!--뭐 원하는 대로 자유롭게 수정하기 -->
<!-- 공지 입력 만들기 -->
	<a href="<%=request.getContextPath()%>/admin/notice/insertNoticeForm.jsp">공지 추가</a>
	<table>
		<tr>
			<td>번호</td>
			<td>내용</td>
			<td>날짜</td>
			<td>수정</td>
			<td>삭제</td>
		</tr>
		<%
			for(Notice n: list){
		%>
			<tr>
				<td><%=n.getNoticeNo() %></td>
				<td><%=n.getNoticeMemo() %></td>
				<td><%=n.getUpdatedate() %></td>
				<td><a href="<%=request.getContextPath()%>/admin/notice/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>&noticeMemo=<%=n.getNoticeMemo()%>">수정</a></td>
				<td><a href="<%=request.getContextPath()%>/admin/notice/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a></td>
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
	<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>">마지막</a>	
	
	
</body>
</html>