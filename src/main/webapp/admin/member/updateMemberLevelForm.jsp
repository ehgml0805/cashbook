<%@page import="dao.MemberDao"%>
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
String loginMemberId = loginMember.getMemberId();// 로그인 한 사람 아이디
//System.out.println(loginMemberId+"로그인한 아이디");

String msg1=request.getParameter("msg1");
int memberNo=Integer.parseInt(request.getParameter("memberNo"));
//model 불러오기
MemberDao memberDao=new MemberDao();
Member member=memberDao.selectMemberOne(memberNo);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 레벨 수정(관리자)</title>
</head>
<body>
	<%
		if(msg1!=null){
	%>		
		<div><%=msg1 %></div>
	<%		
		}
	%>
	<form action="<%=request.getContextPath()%>/admin/member/updateMemberLevelAction.jsp"  method="post">
		<input type="hidden" name="memberNo" value="<%=memberNo%>">
		<table>
			<tr>
				<td>회원 아이디</td>
				<td><input type="text" name="memberId" value="<%=member.getMemberId()%>" readonly="readonly"> </td>
			</tr>
			<tr>
				<td>회원 이름</td>
				<td><input type="text" name="memberName" value="<%=member.getMemberName() %>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>회원 기존 레벨</td>
				<td>
				<%
					if(member.getMemberLevel()==0){
				%>
						<input type="radio" value="0" checked onclick="return(false);">0 일반
						<input type="radio" value="1" onclick="return(false);" >1 관리자
				<%		
					}else{
				%>	
						<input type="radio" value="0" onclick="return(false);">0 일반
						<input type="radio" value="1" checked onclick="return(false);">1 관리자
				<%		
					}
				%>
				</td>
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