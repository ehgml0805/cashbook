<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int currentPage = 1;//1페이지부터 보여줄거
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 7;//10개씩 볼거
	int beginRow = (currentPage-1) * rowPerPage;//0번부터 뽑을거
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String,Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
	int selectHelpCount=helpDao.selectHelpCount();
	
	int lastPage=selectHelpCount/rowPerPage;
	if(selectHelpCount/rowPerPage!=0){
		lastPage=lastPage+1;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>helpListAll.jsp</title>
</head>
<body>
	<!-- header include -->
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">메인으로</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지 관리</a> </li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a> </li>
		<li><a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">문의 관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원 관리(목록, level수정, 강제탈퇴)</a></li>
	</ul>
	<!-- 고객센터 문의 목록 -->
	<table>
		<tr>
			<th>문의 번호</th>
			<th>문의 내용</th>
			<th>회원 ID</th>
			<th>문의 날짜</th>
			<th>답변 내용</th>
			<th>답변 날짜</th>
			<th>답변 추가 / 수정 / 삭제</th>
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<tr>
					<td><%=m.get("helpNo") %></td>
					<td><%=m.get("helpMemo")%></td>
					<td><%=m.get("memberId")%></td>
					<td><%=m.get("helpCreatedate")%></td>
					<td>
						<%
							if(m.get("commentMemo")==null){
						%>		
							답변 대기중
						<%		
							}else{
						%>
							<%=m.get("commentMemo")%>
						<%		
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentCreatedate")==null){
						%>		
							&nbsp;
						<%		
							}else{
						%>
							<%=m.get("commentCreatedate")%>
						<%		
							}
						%>
					</td>
					<td>
						<%
							if(m.get("commentMemo") == null) {
						%>
								<a href="<%=request.getContextPath()%>/admin/comment/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>">
									답변입력
								</a>
						<%		
							} else {
						%>
								<a href="<%=request.getContextPath()%>/admin/comment/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>">답변수정</a>
								<a href="<%=request.getContextPath()%>/admin/comment/deleteCommentAction.jsp?commentNo=<%=m.get("commentNo")%>">답변삭제</a>
						<%		
							}
						%>
					</td>
				</tr>
		<%		
			}
		%>
	</table>
	<!-- footer include -->
	<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1">처음</a>
	<%
		if(currentPage>1){
	%>
			<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1 %>">이전</a>	
	<%		
		}
	%>
		<span><%=currentPage %></span>
	<%	
		if(currentPage<lastPage){
	%>
			<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1 %>">다음</a>	
	<%		
			
		}
	%>
	<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">마지막</a>		
</body>
</html>