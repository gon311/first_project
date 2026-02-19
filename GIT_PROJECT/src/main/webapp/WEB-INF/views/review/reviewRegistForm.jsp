<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
	<html>
	<head>
		 <%@ include file="/WEB-INF/views/inc/head.jspf" %>
		 
		 <%-- 현재 페이지(main.jsp) 전용 CSS 영역--%>
		 <link href="<c:url value="/resources/css/mainUser.css" />" rel="stylesheet" type="text/css">
		 <link href="<c:url value="/resources/css/reviewRegistForm.css" />" rel="stylesheet" type="text/css">
	</head>
	<body>
		<%-- header area --%>
		<%@ include file="/WEB-INF/views/inc/header.jspf" %>
		
		<%-- main area --%>
		<main>
		<form action="/review/registText" method="post">
			<!-- 자소서 제목 영역 -->
			<div>
			자소서 제목 <input type="text" name="title" placeholder="제목을 입력해 주세요." size=50 required>
			</div>
			<!-- 업종 선택 영역 -->
			<div>
				<h5>업종</h5>
				<label><input type="radio" name="industry" value="IT_PLATFORM"><span class="radio-btn">IT·플랫폼</span></label>
				<label><input type="radio" name="industry" value="MFG_INDUSTRY"><span class="radio-btn">제조·산업</span></label>
				<label><input type="radio" name="industry" value="FINANCE_INS"><span class="radio-btn">금융·보험</span></label>
				<label><input type="radio" name="industry" value="RETAIL_COMMERCE"><span class="radio-btn">유통·커머스</span></label>
				<label><input type="radio" name="industry" value="media_content"><span class="radio-btn">미디어·콘텐츠</span></label>
				<label><input type="radio" name="industry" value="bio_health"><span class="radio-btn">바이오·헬스</span></label>
				<label><input type="radio" name="industry" value="construction_re"><span class="radio-btn">건설·부동산</span></label>
				<label><input type="radio" name="industry" value="public_sector"><span class="radio-btn">공공·공기업</span></label>
				<label><input type="radio" name="industry" value="edu_reserch"><span class="radio-btn">교육·연구</span></label>
			</div>
			<!-- 직종 선택 영역 -->
			<div>
				<h5>직종</h5>
				<label><input type="radio" name="jobGroup" value="IT_DEV_DATA"><span class="radio-btn">IT·개발·데이터</span></label>
				<label><input type="radio" name="jobGroup" value="PLAN_MGMT_ADMIN"><span class="radio-btn">기획·경영·사무</span></label>
				<label><input type="radio" name="jobGroup" value="MKT_AD_PR"><span class="radio-btn">마케팅·광고·홍보</span></label>
				<label><input type="radio" name="jobGroup" value="DESIGN_CREATIVE"><span class="radio-btn">디자인·크리에이티브</span></label>
				<label><input type="radio" name="jobGroup" value="SALES_CS_BIZ"><span class="radio-btn">영업·고객·비즈니스</span></label>
				<label><input type="radio" name="jobGroup" value="RND_ENGINEERING"><span class="radio-btn">연구·엔지니어링</span></label>
				<label><input type="radio" name="jobGroup" value="PROD_MFG_QA"><span class="radio-btn">생산·제조·품질</span></label>
				<label><input type="radio" name="jobGroup" value="PUBLIC_EDU_SERVICE"><span class="radio-btn">공공·교육·서비스</span></label>
			</div>
			<!-- 세부 직종 선택 영역 -->
			<div>
				<c:choose>
					<c:when test="">
						<select> 
							<option id="">백엔드 개발자</option>
						</select>
					</c:when>
				
				</c:choose>
			</div>
			<!-- 기업형태 선택 영역 -->
			<div>
			
			</div>
			<!-- 지원 분야 입력 영역 -->
			<div>
				지원분야 <input type="text" required>
			</div>
			<!-- 기업명 입력 영역 -->
			<div>
				기업명 <input type="text" required>
			</div>
			<!-- 경력사항 선택 영역 -->
			<div>
				
			</div>
		</form>
		
		</main>
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
		
		<%-- 개별 페이지 자바스크립트 영역 --%>
		
	</body>
</html>

