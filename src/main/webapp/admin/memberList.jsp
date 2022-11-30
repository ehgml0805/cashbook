<%@page import="java.util.ArrayList"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="vo.Member"%>

<%
//방어코드
Member loginMember =(Member)session.getAttribute("loginMember");
if(loginMember==null||loginMember.getMemberLevel()<1){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
String msg=request.getParameter("msg");
//model 호출
int currentPage=1;//시작페이지가 1
int rowPerPage=10;//10개씩 보여줄거
int beginRow=(currentPage-1)*rowPerPage;//0번부터 보여줄거
//lastpage 구하기
MemberDao memberDao =new MemberDao();
ArrayList<Member> list=memberDao.selectMemberListByPage(beginRow, rowPerPage);
int selectMemberAdminCount=memberDao.selectMemberAdminCount();
int lastPage=selectMemberAdminCount/rowPerPage;

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버 관리</title>
</head>
<body>
<!--  -->
<ul>
	<li><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">메인으로</a></li>
	<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지 관리</a> </li>
	<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a> </li>
	<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원 관리(목록, level수정, 강제탈퇴)</a></li>
</ul>
<!-- 멤버 목록 -->
<table>
	<%
		if(msg!=null){
	%>		
			<%=msg %>
	<%		
	}
	%>
	<tr>
		<td>아이디</td>
		<td>레벨</td>
		<td>이름</td>
		<td>마지막 수정일자</td>
		<td>가입일자</td>
		<td>레벨수정</td>
		<td>강제탈퇴</td>
	</tr>
	<%
		for(Member m: list){
	%>		
		<tr>
			<td><%=m.getMemberId() %> </td>
			<td><%=m.getMemberLevel() %></td>
			<td><%=m.getMemberName() %></td>
			<td><%=m.getUpdatedate() %></td>
			<td><%=m.getCreatedate() %></td>
			<td><a href="<%=request.getContextPath()%>/admin/member/updateMemberLevelForm.jsp?memberId=<%=m.getMemberId()%>&memberLevel=<%=m.getMemberLevel()%>&memberName=<%=m.getMemberName()%>">수정</a></td>
			<td><a href="<%=request.getContextPath()%>/admin/member/deleteMemberAction.jsp?memberId=<%=m.getMemberId()%>">강제탈퇴</a></td>
		</tr>
	<%		
		}
	%>
	
</table>
</body>
</html>