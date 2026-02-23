<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
	<html>
	<head>
		 <%@ include file="/WEB-INF/views/inc/head.jspf" %>
		 
		 <%-- 현재 페이지(main.jsp) 전용 CSS 영역--%>
		 <link href="<c:url value="/resources/css/mainUser.css" />" rel="stylesheet" type="text/css">
	</head>
	<body>
		<%-- header area --%>
		<%@ include file="/WEB-INF/views/inc/header.jspf" %>
		<%-- main area --%>
		<main>
		<!-- 기업 목록 노출 영역 -->
			<div class="adMain">
				<ul class="nav nav-pills mb-3" id="jobTabs">
				    <li class="nav-item">
				        <button class="nav-link active" data-bs-toggle="pill" data-bs-target="#today">
				            오늘의 기업
				        </button>
				    </li>
				    <li class="nav-item">
				        <button class="nav-link" data-bs-toggle="pill" data-bs-target="#popular">
				            인기 기업
				        </button>
				    </li>
				    <c:if test="${!empty sessionScope.sId}">
					    <li class="nav-item">
					        <button class="nav-link" data-bs-toggle="pill" data-bs-target="#bookmark">
					            찜한 기업
					        </button>
					    </li>
				    </c:if>
				</ul>
				
				<div class="cardAds">
					이 자리에 기업 공고가 카드 형태로 들어가게 만듬 
				</div>
			</div>
			<br><br><br><br><br><br>
		<!-- AI 자소서 첨삭 시작 버튼  -->
			<div class="btAi">
				<input type="button" value="AI 자소서 첨삭 시작" onclick="location.href='<c:url value="/review/registForm" />'">
			</div>
		</main>
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
		
		<%-- 개별 페이지 자바스크립트 영역 --%>
		<script type="text/javascript">
		
		</script>
		
	</body>
</html>

