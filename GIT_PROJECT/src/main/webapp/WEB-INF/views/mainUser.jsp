<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
	<html>
	<head>
		<%@ include file="/WEB-INF/views/inc/head.jspf" %>
		 
		 <%-- 현재 페이지(mainUser.jsp) 전용 CSS 영역--%>
		<link href="<c:url value="/resources/css/mainUser.css" />" rel="stylesheet" type="text/css">
		<style type="text/css">
		div {
			border: 1px solid "red";
		}
		
		</style>
	</head>
	<body>
		<%-- header area --%>
		<%@ include file="/WEB-INF/views/inc/header.jspf" %>
		<%-- main area --%>
		<main>
		<!-- 기업 목록 노출 영역 -->
		<div class="ad-menu">
			<ul class="nav nav-pills mb-3" id="jobTabs">
			    <li class="nav-item">
			        <button id="today" class="nav-link active" data-bs-toggle="pill" 
			        data-bs-target="#today">
			            오늘의 기업
			        </button>
			    </li>
			    <li class="nav-item">
			        <button id ="popular" class="nav-link" data-bs-toggle="pill" 
			        data-bs-target="#popular">
			            인기 기업
			        </button>
			    </li>
			    <c:if test="${!empty sessionScope.sId}">
				    <li class="nav-item">
				        <button id ="wishlist" class="nav-link" data-bs-toggle="pill" 
				        data-bs-target="#bookmark">
				            찜한 기업
				        </button>
				    </li>
			    </c:if>
			</ul>
		</div>
		<div class="card-group">
			<div class="card">
				<img src="..." class="card-img-top" alt="공고를 게재한 기업 로고">
				<div class="card-body">
					<h4 id = "title" class="jobPostTitle card-title"></h4>
					<p id = "companyName" class="companyName"></p>
					<div class="meta">
						<span id="salary" ></span>
						<p id = "closeDate"></p>
					</div>
				</div>
			</div>
		</div>
			<br><br><br><br><br><br>
		<!-- AI 자소서 첨삭 시작 버튼  -->
			<div class="btnAi">
				<input type="button" value="AI 자소서 첨삭 시작" 
				onclick="location.href='<c:url value="/review/registForm" />'">
			</div>
		</main>
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
		
		<%-- 개별 페이지 자바스크립트 영역 --%>
		<script type="text/javascript">
			// 1) 오늘의 기업 광고 
			document.getElementById("today").addEventlistener("click", () => {
				const title = document.getElementById("today");
				const companyName = document.getElementById("companyName");
				const closeDate = document.getElementById("closeDate");
				
				async function requestTodayCompany() {
					try{
						const response = await fetch("<c:url value="/card/list" />")
						
					} catch {
						
					}
				}
			});
		</script>
		
	</body>
</html>

