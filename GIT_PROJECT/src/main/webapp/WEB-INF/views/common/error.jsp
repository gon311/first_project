<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%-- fragment 페이지(jspf)에서 사용할 동적인 값을 각 컨텐츠 페이지에서 미리 설정하고 jspf 파일을 포함시키기 --%>
<%-- 각 페이지마다 title 태그 내용을 다르게 표시하기 위해 pageTitle 속성값 설정 --%>
<c:set var="pageTitle" value="메인페이지" />
<!DOCTYPE html>
<html>
<head>
	<%-- inc/head.jspf 파일을 현재 위치에 포함시키기 --%>
	<%-- JSP 문법이므로 루트(/)는 webapp 경로를 가리킴(잘못 지정했을 경우 오류 발생) --%>
	<%-- include 디렉티브 사용하여 페이지를 포함시키기(= 정적 include) --%>
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
	
</body>
</html>






















