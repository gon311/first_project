<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<title>공지사항 상세내용</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<main class="container-fluid mt-5">
		<div class="card shadow-sm p-4">
			 <div class= "title">
			 	<h3>${notice_title }</h3>
			 </div>
			 등록일 : ${reg_date } | 조회수 : ${readcount }
			 <hr>
			<div>
				${notice_content }
			</div>
		</div>
	</main>

</body>
</html>