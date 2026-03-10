<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>알림</title>
</head>
<body>
	<%-- 전역 예외 처리에 따른 공통 메세지 출력 및 이동을 처리하는 뷰페이지 --%>
	<script type="text/javascript">
		// 예외 메세지 출력
		alert("${msg}");
		
		// moveType 이 "redirect" 일 경우 url 값을 사용하여 페이지 이동(location.href 실행)하고
		// 아니면, "back" 일 경우 history.back 실행하고
		// 아니면, 메인페이지로 이동
		<c:choose>
			<c:when test="${moveType eq 'redirect'}">
				location.href="<c:url value="${url}" />";
			</c:when>
			<c:when test="${moveType eq 'back'}">
				history.back();
			</c:when>
			<c:otherwise>
				location.href="<c:url value="/" />";
			</c:otherwise>
		</c:choose>
	</script>
</body>
</html>