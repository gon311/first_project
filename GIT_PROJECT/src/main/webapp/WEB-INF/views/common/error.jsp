<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<c:set var="pageTitle" value="에러페이지" />
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
	
	<%-- 현재 페이지(main.jsp) 전용 CSS 영역 --%>
</head>
<body>
	<%-- 헤더 영역 --%>
	<%@ include file="/WEB-INF/views/inc/header.jspf" %>
	
	<%-- 컨텐츠 영역 --%>
	<main>
		<div class="mx-auto text-center" style="max-width:450px;">
			시스템 오류가 발생했습니다.<br>
			잠시 후 다시 시도해 주세요.<br>
			<input type="button" value="홈으로" onclick="location.href='<c:url value="/" />'"> 
		</div>
	</main>
	
	<%-- 푸터 영역 --%>
	<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
	
	<%-- 로그인 실패 시 세션에 저장된 값(에러메세지 등)을 사용한 후 세션에서 제거 --%>
	<c:remove var="errorMsg" scope="session" />
	<c:remove var="errorId" scope="session" />
</body>
</html>






















