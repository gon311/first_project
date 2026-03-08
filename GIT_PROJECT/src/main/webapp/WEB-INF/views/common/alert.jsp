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
		<script type="text/javascript">
			alert("${msg}");
			
			<c:choose>
				<c:when test="${moveType eq 'redirect'}">
					location.href = "<c:url value="${url}" />";
				</c:when>
				<c:when test="${moveType eq 'back'}">
					history.back();
				</c:when>
				<c:otherwise>
					location.href = "<c:url value="/" />";
				</c:otherwise>
			</c:choose>
		</script>
	</body>
</html>