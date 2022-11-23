<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.* "%>
<%@ page import="java.sql.* "%>

<%
Member loginMember=(Member)session.getAttribute("loginMember");
if(session.getAttribute("loginMember")==null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}
//
int year = Integer.parseInt(request.getParameter("year"));
int month = Integer.parseInt(request.getParameter("month"));
int date = Integer.parseInt(request.getParameter("date"));
System.out.println(date+"<-날짜");

//

//
CategoryDao categoryDao=new CategoryDao();
ArrayList<Category> categoryList=categoryDao.selectCategoryList();

CashDao cashDao= new CashDao();
ArrayList<HashMap<String, Object>> list=cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>날짜별 상세보기</title>
</head>
<body>
	<div>
	<%=loginMember.getMemberName()%>님 반갑습니다.
	</div>
	<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<table>
			<tr>
				<td>사용일자</td>
				<td>
					<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>항목</td>
				<td>
					<select name="categoryNo">
					<%
						for(Category c: categoryList){
					%>		
							<option value="<%=c.getCategoryNo()%>">
							<%=c.getCategoryKind() %> <%=c.getCategoryName() %>
							</option>
					<%		
						}
					%>
					</select>
				</td>
			</tr>
			<tr>
				<td>사용금액</td>
				<td>
					<input type="text" name="cashPrice">
				</td>
			</tr>
			
			<tr>
				<td>메모</td>
				<td><textarea rows="3" cols="50" name="cashMemo"></textarea> </td>
			</tr>
		</table>
		<button type="submit">추가</button>
	</form>
	<table border="1">
		<tr>
			<td>가격</td>
			<td>수입/지출</td>
			<td>항목</td>
			<td>사용 날짜</td>
			<td>메모</td>
			<td>수정</td>
			<td>삭제</td>
		
		</tr>
	<%
		for(HashMap<String, Object> m: list){
			String cashDate=(String)(m.get("cashDate"));
			if(Integer.parseInt(cashDate.substring(8))==date){
	%>	
		<tr>	
			<td><%=m.get("cashPrice") %></td>
			<td><%=m.get("categoryKind") %></td>
			<td><%=m.get("categoryName") %></td>
			<td><%=m.get("cashDate")%></td>
			<td><%=m.get("cashMemo")%></td>
			<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=m.get("cashNo")%>">수정</a></td>
			<td><a href="<%=request.getContextPath()%>/cash/deleteCash.jsp?cashNo=<%=m.get("cashNo")%>">삭제</a></td>
		</tr>
	<%		
			}
		}
	%>
	</table>
</body>
</html>