<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>데이터 관리</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>

</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<div class="container-fluid mt-4">
	<div class="card shadow-sm p-3">
	<div class="container w-75 my-4 mx-auto">
	<h4 class = "fw-bold"> 데이터 관리</h4>
	<br>
		<ul class="nav nav-tabs" id="qnaTab" role="tablist">
		    <li class="nav-item" role="presentation">
		        <button class="nav-link" onclick = "changeTab('user')">구직자 유형별 통계</button>
		    </li>
		    <li class="nav-item" role="presentation">
		        <button class="nav-link" onclick = "changeTab('com')">기업회원 유형별 통계</button>
		    </li>
		    <li class="nav-item" role="presentation">
		        <button class="nav-link" onclick = "changeTab('userPay')">구직자 결제 유형별 통계</button>
		    </li>
		    <li class="nav-item" role="presentation">
		        <button class="nav-link" onclick = "changeTab('comPay')">기업회원 결제 유형별 통계</button>
		    </li>
		</ul>
	
		
		<div id="stat-content-area" class="chart-wrapper">
		    <div class="stat-card">
		        <canvas id="chart-area-1"></canvas>
		    </div>
		    <div class="stat-card">
		        <canvas id="chart-area-2"></canvas>
		    </div>
		    <div class="stat-card">
		        <canvas id="chart-area-3"></canvas>
		    </div>
		</div>
				
	
	</div></div></div>
		<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> 
		<script src="${pageContext.request.contextPath}/resources/js/admin-stats.js"></script> 
		<script>
		    // 페이지 로드시 기본값 실행
		    document.addEventListener("DOMContentLoaded", function() {
		        changeTab('user');
		    });
		</script>
</body>
</html>
