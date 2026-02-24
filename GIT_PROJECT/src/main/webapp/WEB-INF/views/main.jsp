<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
	<html>
	<head>
		 <%@ include file="/WEB-INF/views/inc/head.jspf" %>
		 
		 <%-- 현재 페이지(main.jsp) 전용 CSS 영역--%>
	</head>
	<body>
		<%-- header area --%>
		<%@ include file="/WEB-INF/views/inc/header.jspf" %>
		<%-- main area --%>
		<main>
			<h1> Main Area</h1>
			<h3><a href="<c:url value="/job/JobPosting" />">JobPosting</a></h3>
			<h3><a href="<c:url value="/job/JobList" />">JobLIst</a></h3>
			<h3><a href="<c:url value="/job/JobDetail" />">JobDetail</a></h3>
			<h3><a href="<c:url value="/job/JobManagement" />">JobManagement</a></h3>
			<h3><a href="<c:url value="/help/helpWord" />">Help</a></h3>
			<h3><a href="<c:url value="/board" />">커뮤니티</a></h3>
		</main>
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
		
		<%-- 개별 페이지 자바스크립트 영역 --%>
		
	</body>
</html>