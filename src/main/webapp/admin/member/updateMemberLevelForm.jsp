<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//방어코드
Member loginMember=(Member)session.getAttribute("loginMember");
if(loginMember == null || loginMember.getMemberLevel() < 1){
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
	return;
}
String memberId=request.getParameter("memberId");
System.out.println(memberId+"<== 멤버 아이디");
String memberLevel=request.getParameter("memberLevel");
System.out.println(memberLevel+"<==수정할 멤버 레벨");
String memberName=request.getParameter("memberName");
System.out.println(memberName+"<== 멤버 이름");
//model 불러오기


%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 레벨 수정(관리자)</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/admin/member/updateMemberLevelAction.jsp"  method="post">
		<table>
			<tr>
				<td>회원 아이디</td>
				<td><input type="text" name="memberId" value="<%=memberId%>" readonly="readonly"> </td>
			</tr>
			<tr>
				<td>회원 이름</td>
				<td><input type="text" name="memberName" value="<%=memberName %>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>회원 기존 레벨</td>
				<td><input type="text" name="memberBeLevel" value="<%=memberLevel%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>회원 변경 레벨</td>
				<td><input type="radio" name="memberLevel" value="0">0 일반
				<input type="radio" name="memberLevel" value="1">1 관리자</td>
			</tr>
		</table>
		<button type="submit">수정하기</button>
	</form>

</body>
</html>