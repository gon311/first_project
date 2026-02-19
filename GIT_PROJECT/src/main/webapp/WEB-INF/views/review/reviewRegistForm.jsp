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
		<!-- 자소서 제목 영역 -->
		<div>
		자소서 제목 <input type="text" placeholder="제목을 입력해 주세요." required>
		</div>
		<!-- 업종 선택 영역 -->
		<div>
			
		</div>
		<!-- 직종 선택 영역 -->
		<div>
			
		</div>
		<!-- 기업형태 선택 영역 -->
		<div>
			
		</div>
		<!-- 지원 분야 입력 영역 -->
		<div>
			지원분야 <input type="text" required>
		</div>
		<!-- 기업명 입력 영역 -->
		<div>
			기업명 <input type="text" required>
		</div>
		<!-- 경력사항 선택 영역 -->
		<div>
			
		</div>
		
		</main>
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
		
		<%-- 개별 페이지 자바스크립트 영역 --%>
		
	</body>
</html>

