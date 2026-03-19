<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
	<title>데이터 관리</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
	<style>
    /* 1. 전체를 감싸는 영역 (가로 배치 핵심) */
    .stat-container {
        display: flex !important;    /* 가로 정렬 강제 */
        flex-direction: row !important; 
        justify-content: space-between; /* 카드 사이 간격 동일하게 */
        align-items: stretch;        /* 카드 높이 통일 */
        gap: 20px;                   /* 카드 사이 여백 20px */
        width: 100% !important;      /* 부모 너비 꽉 채우기 */
        margin: 20px 0;
    }

    /* 2. 개별 카드 설정 (3등분) */
    .stat-container .my-stat-card {
        flex: 1 1 30% !important;    /* 정확히 3등분 근처로 배정 */
        min-width: 250px;            /* 너무 좁아짐 방지 */
        background: #ffffff;
        border-radius: 12px;
        border: 1px solid #e5e7eb;   /* 연한 테두리 */
        padding: 20px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        display: flex;
        flex-direction: column;
    }

    /* 3. 카드 내부 제목 스타일 */
    .card-header {
        margin-bottom: 15px;
        border-bottom: none;
        background: transparent;
        padding: 0;
    }

    .card-title {
        font-size: 1.1rem;
        font-weight: 700;
        color: #1f2937;
        margin: 0;
    }

    /* 4. 차트 박스 (높이가 핵심!) */
    .chart-box {
        position: relative;
        height: 250px !important;    /* 높이를 250px로 고정 */
        width: 100%;
        padding-top: 20px;
    }
    /* 탭 관련 css */
    /* 활성화되지 않은 일반 탭의 스타일 강제 */
    .nav-tabs .nav-link:not(.active) {
        color: #6c757d !important;      /* 회색 글씨 */
        font-weight: normal !important; /* 볼드 해제 */
        border-bottom: 1px solid #dee2e6 !important;
        background-color: #f8f9fa !important;
    }

    /* 활성화된 탭 스타일 */
    .nav-tabs .nav-link.active.fw-bold {
        color: #0d6efd !important;      /* 인디고 색상 */
        border-bottom: 3px solid #0d6efd  !important;
        background-color: #fff !important;
    }
        /* 카드 상단 테두리 보정 */
    .card {
        border: 1px solid #dee2e6;
    }
</style>

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
		        <button class="nav-link"
		        	onclick = "changeTab('user')">구직자 유형별 통계</button>
		    </li>
		    <li class="nav-item" role="presentation">
		        <button class="nav-link" 
		        	onclick = "changeTab('com')">기업회원 유형별 통계</button>
		    </li>
		    <li class="nav-item" role="presentation">
		        <button class="nav-link"
	        		onclick = "changeTab('userPay')">구직자 결제 유형별 통계</button>
		    </li>
		    <li class="nav-item" role="presentation">
		        <button class="nav-link" 
		        	onclick = "changeTab('comPay')">기업회원 결제 유형별 통계</button>
		    </li>
		</ul>
	
		<div id="stat-content-area" class="w-100">
		<%--차트 영역 --%>
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
