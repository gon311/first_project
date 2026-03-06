<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/inc/header.jspf" %>

	<main>
		<div class="mx-auto text-center" style="max-width:450px;">
			시스템 오류가 발생했습니다.<br>
			잠시 후 다시 시도해 주세요.<br>
			<input type="button" value="홈으로" onclick="location.href='<c:url value="/" />'">
		</div>

	</main>
	
	<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
	
</body>
</html>






















