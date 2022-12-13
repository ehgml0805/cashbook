<%@page import="java.util.HashMap"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="<%=request.getContextPath()%>/memberOne.jsp">마이 페이지</a>
	<a href="<%=request.getContextPath()%>/logOut.jsp"> 로그아웃</a>
<ol>
		<li>
			<a href="<%=request.getContextPath()%>/cashListByCategory.jsp?category=수입">
				년도별 수입 목록
			</a>
		</li>
		<li>
			<a href="<%=request.getContextPath()%>/cashListByCategory.jsp?category=지출">
				년도별 지출 목록
			</a>
		</li>
		<li>
			<a href="<%=request.getContextPath()%>/cashSumByMonth.jsp?category=수입">
				월별 수입 목록
			</a>
		</li>
		<li>
			<a href="<%=request.getContextPath()%>/cashSumByMonth.jsp?category=지출">
				월별 지출 목록
			</a>
		</li>
	</ol>
</body>
</html>