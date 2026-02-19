<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
	<html>
	<head>
		 <%@ include file="/WEB-INF/views/inc/head.jspf" %>
		 
		 <%-- 현재 페이지(main.jsp) 전용 CSS 영역--%>
		 <link href="<c:url value="/resources/css/mainUser.css" />" rel="stylesheet" type="text/css">
	</head>
	<body>
		<%-- header area --%>
		<%@ include file="/WEB-INF/views/inc/header.jspf" %>
		<%-- main area --%>
		<main>
		<!-- 기업 목록 노출 영역 -->
			<div class="adMain">
				<h1>기업 목록 노출 영역</h1>
				<h1>기업 목록 노출 영역</h1>
				<h1>기업 목록 노출 영역</h1>
				<h1>기업 목록 노출 영역</h1>
			</div>
			<br><br><br><br><br><br>
		<!-- AI 자소서 첨삭 시작 버튼  -->
			<div class="btAi">
				<input type="button" value="AI 자소서 첨삭 시작" onclick="location.href='<c:url value="/review/registForm" />'">
			</div>
		</main>
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
		
		<%-- 개별 페이지 자바스크립트 영역 --%>
		
	</body>
</html>

