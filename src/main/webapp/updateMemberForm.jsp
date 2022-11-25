<%@page import="dao.MemberDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%
if(session.getAttribute("loginMember")==null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}

String msg=request.getParameter("msg");
String msg1=request.getParameter("msg1");

Member loginMember=(Member)session.getAttribute("loginMember");
String memberId=loginMember.getMemberId();
String memberName=loginMember.getMemberName();
/*
Member paramMember=new Member();
paramMember.setMemberId(memberId);
paramMember.setMemberName(memberName);

MemberDao memberDao= new MemberDao();
Member resultMember=memberDao.login(paramMember);
*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보 수정</title>
</head>
<body>
<%
	if(msg1!=null){
%>		
	<div><%=msg1 %></div>
<%		
	}
%>
	<form action="<%=request.getContextPath()%>/updateMemberAction.jsp" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" value="<%=memberId %>" name="memberId" readonly="readonly" ></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="memberName"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="memberPw"></td>
				<td>
					<%
						if(msg!=null){
					%>		
						<div> <%=msg %> </div>
					<%		
						}
					%>
				</td>
			</tr>
		</table>
		<button type="submit">수정하기</button>
	</form>

</body>
</html>