<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
	<html>
	<head>
		<%@ include file="/WEB-INF/views/inc/head.jspf" %>
		 
		 <%-- 현재 페이지(mainUser.jsp) 전용 CSS 영역--%>
		<link href="<c:url value="/resources/css/mainUser.css" />" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
		<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
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
				        data-bs-target="#today">
				            오늘의 기업
				        </button>
				    </li>
				    <li class="nav-item">
				        <button data-type ="popular" class="company-btn nav-link" data-bs-toggle="pill" 
				        data-bs-target="#popular">
				           🔥 인기 기업
				        </button>
				    </li>
				</ul>
			</div>
			<div class="card-slider">
				<div class="swiper companySwiper px-5">

				    <div id="companyCardArea" class="swiper-wrapper">
				        <!-- 카드 AJAX 생성 -->
				    </div>
				
				    <div class="swiper-button-next"></div>
				    <div class="swiper-button-prev"></div>
				
				</div>
			</div>
		</section>
		<section class="sec01-sub">
			<div class="ad-menu-sub">
				<ul class="nav nav-pills mb-3" id="jobTabsSub">
					<c:if test="${!empty sessionScope.sId}">
					    <li class="nav-item">
					        <button data-type ="bookmark" class="company-btn nav-link" data-bs-toggle="pill" 
					        data-bs-target="#bookmark">
					           ✨ 찜한 공고
					        </button>
					    </li>
				    </c:if>
				</ul>
			</div>
			<div class="card-slider">
				<div class="swiper companySwiper px-5">

				    <div id="companyCardAreaSub" class="swiper-wrapper">
				        <!-- 카드 AJAX 생성 -->
				    </div>

				    <div class="swiper-button-next"></div>
				    <div class="swiper-button-prev"></div>
				
				</div>
			</div>
		</section>
		
		<section class="sec02">
		    <div class="ai-banner-content">
		        <h3>"당신만의 특별한 스토리를 완성하세요"</h3>
		        <p>복잡한 자소서 작성, 이제 AI가 실시간으로 첨삭해 드립니다.</p>
		        <div class="btnAi">
		            <input type="button" id="btn04" value="AI 자소서 첨삭 시작하기" 
		                   onclick="location.href='<c:url value="/review/registForm" />'">
		        </div>
		    </div>
		</section>
			
		</main>
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
		
		<%-- 개별 페이지 자바스크립트 영역 --%>
		<script src="<c:url value="/resources/js/mainUser.js" />"></script>
		<script type="text/javascript">
			let track;
			let track2;
			let swiper;
			
			// 페이지 로드 
			document.addEventListener("DOMContentLoaded", () => {
				track = document.getElementById("companyCardArea");
				track2 = document.getElementById("companyCardAreaSub")
				
				// 이벤트 등록 
				initEvents();

				// 초기 데이터 
				loadCompanies("today", "companyCardArea");
				
				//찜한 기업 데이터 출력 
				if(${not empty sessionScope.sId}) {
					loadCompanies("bookmark", "companyCardAreaSub");
				}
				
				// 공통 클릭 핸들러 함수 → 상세 페이지 이동 
				const handleCardClick = e => {
				    const card = e.target.closest(".company-card");
				    if(!card) return;

				    const jobId = card.dataset.id;
				    location.href = "<c:url value='/job/JobDetail?jobId=' />" + jobId;
				};
				
				// 상단 슬라이더 이벤트 등록
				track.addEventListener("click", handleCardClick);
				
				// 하단 슬라이더 이벤트 등록 추가 
				if(track2) {
					track2.addEventListener("click", handleCardClick);
					
				}
				
				
			});
			
			
			// 기업 리스트 요청
			async function loadCompanies(type, targetId){
				console.log("loadCompanies 실행", type, "Target: ", targetId);
	
			    try {
			        const response = await fetch("<c:url value='/card/list'/>?type=" + type);
			        const companyList = await response.json();

			        renderCompanyCards(companyList, targetId);
			        
			    } catch(e) {
			        console.error("기업 데이터 로딩 실패", e);
			    }
			}
		
			// 카드 생성 - mainUser.js 
			
			// Swiper 초기화 
			function initSwiper(){

				// 모든 스와이퍼 요소를 순회하며 각각 초기화
			    document.querySelectorAll(".companySwiper").forEach(el => {
			        // 이미 생성된 인스턴스가 있다면 파괴 후 재생성 (갱신을 위해)
			        if (el.swiper) el.swiper.destroy(true, true);

			        new Swiper(el, {
			            slidesPerView: 3,
			            spaceBetween: 10,
			            navigation: {
			                nextEl: el.querySelector(".swiper-button-next"),
			                prevEl: el.querySelector(".swiper-button-prev")
			            }
			        });
			    });
			
			}
			
			// 메뉴 버튼 클릭
			function initEvents(){

				document.querySelectorAll(".company-btn").forEach(button => {
			        button.addEventListener("click", function() {
			            const type = this.dataset.type; // 'today', 'popular', 'bookmark' 중 하나

			            // 1. 목적지(targetId) 결정 로직 추가
			            let targetId;
			            if (type === 'bookmark') {
			                targetId = "companyCardAreaSub";
			            } else {
			                targetId = "companyCardArea";
			            }

			            // 2. 결정된 targetId를 함께 전달
			            loadCompanies(type, targetId);
			        });
			    });

			}
			
		</script>
	</body>
</html>

