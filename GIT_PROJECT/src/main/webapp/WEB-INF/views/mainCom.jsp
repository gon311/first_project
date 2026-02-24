<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/views/inc/head.jspf"%>
		
		<%-- 현재 페이지(main.jsp) 전용 CSS 영역--%>
		<link href="<c:url value="/resources/css/mainCom.css" />"
			rel="stylesheet" type="text/css">
	</head>
	<body>
		<%-- header area --%>
		<%@ include file="/WEB-INF/views/inc/headerCom.jspf"%>
		<%-- main area --%>
	
		<main class="container my-5">
			<div class="row g-4 justify-content-center">
				<section id="intro">
					<!-- 프리미엄 요금제 -->
					<div class="col-12 col-md-6 col-lg-5">
						<div class="cta-card text-center h-100" role="button"
							onclick="location.href='<c:url value="#" />'">
							<div class="cta-label">프리미엄 요금제 살펴보기</div>
						</div>
					</div>
		
					<!-- 공고 등록 바로가기 -->
					<div class="col-12 col-md-6 col-lg-5">
						<div class="cta-card text-center h-100" role="button"
							onclick="location.href='<c:url value="/job/JobPosting" />'">
							<div class="cta-label">공고 등록 바로가기</div>
						</div>
					</div>
				</section>
			</div>
		</main>
		
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf"%>
	
		<%-- 개별 페이지 자바스크립트 영역 --%>
	
	</body>
</html>

