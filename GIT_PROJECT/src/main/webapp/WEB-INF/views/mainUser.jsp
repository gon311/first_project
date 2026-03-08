<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
	<html>
	<head>
		<%@ include file="/WEB-INF/views/inc/head.jspf" %>
		 
		 <%-- 현재 페이지(mainUser.jsp) 전용 CSS 영역--%>
		<link href="<c:url value="/resources/css/mainUser.css" />" rel="stylesheet" type="text/css">
		<link href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" rel="stylesheet">
	</head>
	<body>
		<%-- header area --%>
		<%@ include file="/WEB-INF/views/inc/header.jspf" %>
		<%-- main area --%>
		<main>
		<!-- 기업 공고 목록 노출 영역 -->
		<section class="sec01">
			<div class="ad-menu">
				<ul class="nav nav-pills mb-3" id="jobTabs">
				    <li class="nav-item">
				        <button data-type ="today" class="company-btn nav-link active" data-bs-toggle="pill" 
				        data-bs-target="#today"
				        onclick="loadCompanies('today')">
				            오늘의 기업
				        </button>
				    </li>
				    <li class="nav-item">
				        <button data-type ="popular" class="company-btn nav-link" data-bs-toggle="pill" 
				        data-bs-target="#popular"
				        onclick="loadCompanies('popular')">
				           🔥 인기 기업
				        </button>
				    </li>
				    <c:if test="${!empty sessionScope.sId}">
					    <li class="nav-item">
					        <button data-type ="wishlist" class="company-btn nav-link" data-bs-toggle="pill" 
					        data-bs-target="#bookmark"
					        onclick="loadCompanies('wishlist')">
					            찜한 기업
					        </button>
					    </li>
				    </c:if>
				</ul>
			</div>
			<div class="card-group">
				<div class="swiper mySwiper">
					<%-- 카드 생성 영역 --%>
					<div class="swiper-wrapper" id="cardContainer"></div>
					
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
				</div>
			</div>
		</section>
		
		<section class="sec02">
		<!-- AI 자소서 첨삭 시작 버튼  -->
			<div class="btnAi">
				<input type="button" value="AI 자소서 첨삭 시작" 
				onclick="location.href='<c:url value="/review/registForm" />'">
			</div>
		</section>
			
		</main>
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
		
		<%-- 개별 페이지 자바스크립트 영역 --%>
		<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
		
		<script type="text/javascript">
		
		</script>
	</body>
</html>

