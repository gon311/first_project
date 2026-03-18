<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>고객센터</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
	
	<style>
	    /* 1. 레이아웃 초기화 및 공통 스타일 */
	    body { font-family: 'Pretendard', sans-serif; color: #333; background-color: #fff; }
	    .cs-container { max-width: 1060px; margin: 0 auto; padding: 40px 20px; }
	    
	    /* 2. 검색 섹션 */
	    .search-section { background-color: #f4f6fa; border-radius: 16px; padding: 60px 20px; text-align: center; margin-bottom: 40px; }
	    .search-section h2 { font-size: 32px; font-weight: 700; margin-bottom: 24px; }
	    .search-box { position: relative; max-width: 600px; margin: 0 auto; }
	    .search-box input { width: 100%; padding: 18px 25px; border: 2px solid #4485ff; border-radius: 50px; font-size: 16px; outline: none; box-shadow: 0 4px 10px rgba(68,133,255,0.1); }
	    .search-box i { position: absolute; right: 25px; top: 50%; transform: translateY(-50%); color: #4485ff; font-size: 20px; cursor: pointer; }
	    
	    /* 3. 회원 구분 탭 */
	    .cs-tabs { display: flex; border-bottom: 1px solid #eee; margin-bottom: 40px; justify-content: center; }
	    .tab-item { padding: 15px 50px; cursor: pointer; font-size: 18px; font-weight: 600; color: #999; border-bottom: 3px solid transparent; transition: 0.3s; }
	    .tab-item.active { color: #4485ff; border-bottom-color: #4485ff; }
	
	    /* 4. 퀵 메뉴 (그리드) */
	    .quick-menu { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 60px; }
	    .menu-card { border: 1px solid #f0f0f0; border-radius: 12px; padding: 30px 15px; text-align: center; transition: all 0.2s; cursor: pointer; }
	    .menu-card:hover { border-color: #4485ff; box-shadow: 0 5px 15px rgba(0,0,0,0.05); transform: translateY(-5px); }
	    .menu-card i { font-size: 32px; color: #4485ff; margin-bottom: 15px; display: block; }
	    .menu-card span { font-size: 16px; font-weight: 500; }
	
	    /* 5. FAQ 섹션 */
	    .faq-section h3 { font-size: 22px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
	    .faq-list { border-top: 1px solid #333; }
	    .faq-item { border-bottom: 1px solid #eee; }
	    .faq-q { padding: 20px; cursor: pointer; display: flex; justify-content: space-between; font-weight: 500; }
	    .faq-q:hover { background-color: #f9f9f9; }
	    .faq-a { padding: 20px 25px; background-color: #fcfcfc; color: #666; display: none; border-top: 1px solid #f5f5f5; line-height: 1.6; }
	    
	</style>
</head>

<body>
	<c:choose>
	    <c:when test="${sessionScope.memberType == 'company'}">
	        <%@ include file="/WEB-INF/views/inc/headerCom.jspf" %>
	    </c:when>
	
	    <c:otherwise>
	        <%@ include file="/WEB-INF/views/inc/header.jspf" %>
	    </c:otherwise>
	</c:choose>
	
	<main>
		<div class="cs-container">
			<form action="<c:url value="/help/helpWord" />" method="get" >
			    <input type="hidden" name="userType" value="${userType}">    
			    <input type="hidden" name="category" value="${category}">    
			    <section class="search-section">
			        <h2>무엇을 도와드릴까요?</h2>
			        <div class="search-box">
			            <input type="text" name="keyword" placeholder="서비스 이용 중 궁금한 점을 입력해 주세요.">
				        <i class="fa-solid fa-magnifying-glass" onclick="location.href='?userType=${userType}&category=${category}&keyword=${keyword}'" /></i>
			        </div>
			    </section>
			</form>
		    <nav class="cs-tabs">
		        <div class="tab-item nav-link ${userType eq 'user' ? 'active fw-bold' : ''}" onclick="location.href='?userType=user'">개인회원</div>
		        <div class="tab-item nav-link ${userType eq 'com' ? 'active fw-bold' : ''}" onclick="location.href='?userType=com'">기업회원</div>
		    </nav>
		
		    <section class="quick-menu" id="menu-grid">
		        <div class="menu-card ${category == 'account' ? 'active' : ''}" onclick="location.href='?userType=${userType}&category=account'"><i class="fa-regular fa-user"></i><span>계정/로그인</span></div>
		        <div class="menu-card ${category == 'service' ? 'active' : ''}" onclick="location.href='?userType=${userType}&category=service'"><i class="fa-regular fa-file-lines"></i><span>이용문의</span></div>
		        <div class="menu-card ${category == 'error' ? 'active' : ''}" onclick="location.href='?userType=${userType}&category=error'"><i class="fa-regular fa-paper-plane"></i><span>오류보고</span></div>
		        <div class="menu-card ${category == 'etc' ? 'active' : ''}" onclick="location.href='<c:url value="/help/notice" />'"><i class="fa-regular fa-bell"></i><span>공지사항</span></div>
		    </section>
		
		    <section class="faq-section">
		        <h3>
		        	<c:choose>
		        		<c:when test="${category eq 'account'}">계정/로그인 질문 TOP 5</c:when>
		        		<c:when test="${category eq 'service'}">이용문의 질문 TOP 5</c:when>
		        		<c:when test="${category eq 'error'}">오류보고 질문 TOP 5</c:when>
		        		<c:otherwise>자주 묻는 질문 TOP 5 </c:otherwise>
		        	</c:choose>
		        	<small style="font-size:14px; color:#4485ff; cursor:pointer;">
		        		<a href="<c:url value="/help/faq" />">전체보기 ></a>
		        	</small>
		        </h3>
		        <div class="faq-list">
		            <div class="faq-item">
		            	<c:choose>
                        	<c:when test = "${not empty faqList }">
						    <c:forEach var="faq" items="${faqList}" varStatus="status">
						        <%-- 1. 제목 행 --%>
					            <div class="faq-q">${faq.faqTitle} <i class="fa-solid fa-chevron-down"></i></div>
					            <div class="faq-a">${faq.faqContent}</div>
						    </c:forEach>
						    </c:when>
						    <c:otherwise>
	                    		<div class="text-center py-5 text-muted">
	                    			<i class="bi bi-exclamation-circle fs-2 d-bold mb-2"></i>
	                    			검색 결과가 없습니다.
	                    		</div>
						    </c:otherwise>
					    </c:choose>
		            </div>
		        </div>
		    </section>
		</div>
	
	</main>

	<%-- footer area --%>
	<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	    // FAQ 아코디언 기능
		$('.faq-q').click(function() {
		    const $answer = $(this).next('.faq-a');
		
		    // 답변 슬라이드 제어
		    $('.faq-a').not($answer).slideUp(200);
		    $answer.slideToggle(200);
		
		    // 아이콘 제어
		    $('.faq-q').not(this).find('i').attr('class', 'fas fa-chevron-down');
		    $(this).find('i').toggleClass('fa-chevron-down fa-chevron-up');
		});
	    
	</script>

</body>
</html>