<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<%
//방어 코드
Member loginMember=(Member)session.getAttribute("loginMember");
if(loginMember==null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
String memberId=loginMember.getMemberId();
System.out.println(memberId+"<==로그인한 아이디");
//model호출
HelpDao helpDao=new HelpDao();
ArrayList<HashMap<String,Object>> list=helpDao.selectHelpList(memberId);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
</head>
<body>
<a href="<%=request.getContextPath()%>/memberOne.jsp">마이페이지</a>
<a href="<%=request.getContextPath()%>/logOut.jsp"> 로그아웃</a>
	<div><a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">문의 글쓰기 </a> </div>
	<table>
		<tr>
			<td>번호</td>
			<td>내용</td>
			<td>작성 날짜</td>
			<td>답변 내용</td>
			<td>답변 날짜</td>
			<td>수정</td>
			<td>삭제</td>
		</tr>
		<%
		for(HashMap<String,Object> m: list){
		%>
			<tr>
				<td><%=m.get("helpNo") %></td>
				<td><%=m.get("helpmemo") %></td>
				<td><%=m.get("helpCreatedate") %></td>
				<td>
					<%
						if(m.get("commentMemo")==null){
					%>
						답변 전		
					<%		
						}else{
					%>
							<%=m.get("commentMemo") %>
					<%		
						}
					%>
				</td>
				<td>
					<%
						if(m.get("commentCreatedate")==null){
					%>		
						답변 전	
					<%		
						}else{
					%>		
						<%=m.get("commentCreatedate") %>
					<%		
						}
					%>
				</td>
				<td>
					<%
						if(m.get("commentMemo")==null){
					%>
						<a href="">수정</a>		
					<%		
						}else{
					%>
							&nbsp;
					<%		
						}
					%>
				</td>
				<td>
					<%
						if(m.get("commentMemo")==null){
					%>
						<a href="">삭제</a>		
					<%		
						}else{
					%>
							&nbsp;
					<%		
						}
					%>
				</td>
			</tr>
		<%	
		}
		%>
		
	</table>
</body>
</html>