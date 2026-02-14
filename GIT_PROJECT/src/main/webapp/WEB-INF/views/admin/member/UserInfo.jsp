<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>

	<main class="container mt-4">
		
		    <div class="row">
		        <div class="col border-end">
		        	<!-- 왼쪽 영역 -->
		            <h2 class="mb-4">회원정보</h2>
		        	<div class="row g-0">
						<table class="table mt-3">
						    <tr>
						        <th>아이디</th>
						        <td>${user.user_id}</td>
						    </tr>
						    <tr>
						        <th>이름</th>
						        <td>${user.user_name}</td>
						    </tr>
						    <tr>
						        <th>이메일</th>
						        <td>${user.email}</td>
						    </tr>
						    <tr>
						        <th>생년월일</th>
						        <td>생일</td>
						    </tr>
						    <tr>
						        <th>성별</th>
						        <td>성별</td>
						    </tr>
						    <tr>
						        <th>국적</th>
						        <td>국적</td>
						    </tr>
						    <tr>
						        <th>가입일자</th>
						        <td>${user.joined_at}</td>
						    </tr>
						    <tr>
						        <th>상태</th>
						        <td>${user.status}</td>
						    </tr>
						    <tr>
						        <th>신고횟수</th>
						        <td>신고횟수</td>
						    </tr>
						</table>
			    	</div>
		        </div>
		        <div class="col">
		        	<!-- 오른쪽 영역 -->
		        	<div class="row">
		        	
		        	</div>
		        </div>
		    </div>

		
	</main>
</body>
</html>