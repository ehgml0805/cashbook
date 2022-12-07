<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.*" %>
<%@page import="java.util.*" %>
<%@page import="vo.*" %>
<%
//controller
Member loginMember = (Member) session.getAttribute("loginMember");
//방어코드
if (loginMember == null || loginMember.getMemberLevel() < 1) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
String loginMemberId=loginMember.getMemberId();
System.out.println(loginMemberId + "<-멤버아이디");
int memberLevel = loginMember.getMemberLevel();
System.out.println(memberLevel + "<-멤버레벨");
//model 호출

//최근 공지 5개, 신규 멤버 5명
int currentPage=1;
if(request.getParameter("currentPage")!=null){
	currentPage=Integer.parseInt(request.getParameter("currentPage"));
}
int rowPerPage=5;
int beginRow=(currentPage-1)*rowPerPage;
//lastPage 구해야함 
NoticeDao noticeDao= new NoticeDao();
ArrayList<Notice> Nolist= noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
int selectNoticeCount=noticeDao.selectNoticeCount();//전체 행의 개수 가져오기
//System.out.println(selectNoticeCount);
int lastPage=selectNoticeCount/rowPerPage;
//System.out.println(lastPage);
MemberDao memberDao = new MemberDao();
ArrayList<Member> Melist = memberDao.selectMemberListByPage(beginRow, rowPerPage);

int selectMemberAdminCount = memberDao.selectMemberAdminCount();
int MelastPage = selectMemberAdminCount / rowPerPage;
if(selectMemberAdminCount / rowPerPage!=0){
	lastPage=lastPage+1;
}
//view
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인 페이지</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지 관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">문의 관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원 관리(목록, level수정, 강제탈퇴)</a></li>
	</ul>
	<a href="<%=request.getContextPath()%>/logOut.jsp"> 로그아웃</a>
	<!-- 신규 멤버 5명 페이징 -->
	<hr> 
	신규 회원 리스트
	<table>
		<tr>
			<td>아이디</td>
			<td>이름</td>
			<td>가입일</td>
		</tr>
		<%
			for (Member m : Melist) {
		%>
		<tr>
			<td><%=m.getMemberId() %></td>
			<td><%=m.getMemberName() %></td>
			<td><%=m.getCreatedate() %></td>
		</tr>
		<%
			}
		%>
	</table>
	<hr>	
	신규 공지 리스트
		<!-- 신규 공지 5개 페이징 -->
	<table>
		<tr>
			<td>공지사항</td>
			<td>날짜</td>
		</tr>
		<%
			for(Notice n: Nolist){
		%>		
			<tr>
				<td><%=n.getNoticeMemo() %></td>
				<td><%=n.getCreatedate() %></td>
			</tr>
		<%	
			}
		%>
	</table>
</body>
</html>