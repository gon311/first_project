<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://unpkg.com/maplibre-gl/dist/maplibre-gl.js"></script>
<link href="https://unpkg.com/maplibre-gl/dist/maplibre-gl.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	/* 전체 페이지 */
	body { 
	    background-color: #f4f6fa;
	    color: #222;
	/*  font-family: 'Pretendard', sans-serif; */
	    margin: 0 !important;
	    padding: 0 !important;
	}
	
	/* 메인 컨테이너 */
	.job-detail-container { 
	    max-width: 1100px;
	    margin: 40px auto;
	    padding: 0 20px;
	}
	
	/* =========================
	   상단 채용 헤더
	========================= */
	.job-header { 
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    background: #fff;
	    border: 1px solid #e5e8ec;
	    border-radius: 10px;
	    padding: 30px;
	    margin-bottom: 25px;
	}
	
	.company-info p{
	    font-size:14px;
	    color:#888;
	}
	
	.company-info h1 { 
	    font-size: 26px;
	    font-weight: 700;
	    margin-top:5px;
	    margin-bottom:0;
	}
	
	/* 지원 버튼 (사람인 스타일) */
	.apply-btn { 
	    background-color: #4876ef;
	    color: #fff;
	    padding: 16px 55px;
	    font-size: 18px;
	    font-weight: 700;
	    border: none;
	    border-radius: 6px;
	    cursor: pointer;
	    transition: all .2s;
	}
	
	.apply-btn:hover {
	    background-color: #345fd1;
	}
	
	/* =========================
	   채용 요약 정보
	========================= */
	.info-summary-grid { 
	    display: grid;
	    grid-template-columns: 1fr 1fr;
	    gap: 20px;
	    background-color: #fff;
	    border: 1px solid #e5e8ec;
	    padding: 30px;
	    border-radius: 10px;
	    margin-bottom: 30px;
	}
	
	.info-item { 
	    display: flex;
	    align-items: center;
	    margin-bottom: 14px;
	}
	
	.info-label { 
	    width: 110px;
	    font-size: 14px;
	    color: #888;
	}
	
	.info-value { 
	    font-size: 15px;
	    font-weight: 600;
	    color: #333;
	}
	
	/* =========================
	   상세 내용
	========================= */
	.detail-content-body {
	    background-color: #fff;
	    min-height: 400px;
	    padding: 50px;
	    border: 1px solid #e5e8ec;
	    border-radius: 10px;
	    line-height: 1.9;
	    font-size: 15px;
	    color: #333;
		width:100%;
	}
	
	.detail-content-body h3{
	    font-size:20px;
	    margin-bottom:15px;
	}
	/* 채용공고 본문 스타일 */
	.detail-content-body p{
	    margin-bottom:12px;
	}
	
	.detail-content-body ul,
	.detail-content-body ol{
	    margin:15px 0;
	    padding-left:20px;
	}
	
	.detail-content-body li{
	    margin-bottom:6px;
	}
	
	.detail-content-body img{
	    max-width:100%;
	    height:auto;
	    margin:15px 0;
	    border-radius:6px;
	}
	
	.detail-content-body table{
	    width:100%;
	    border-collapse:collapse;
	    margin:20px 0;
	}
	
	.detail-content-body th,
	.detail-content-body td{
	    border:1px solid #e5e8ec;
	    padding:10px;
	}
	
	.detail-content-body th{
	    background:#f8f9fb;
	}
	
	/* =========================
	   기업 정보 영역
	========================= */
	.company-footer-section { 
	    background-color: #fff;
	    border: 1px solid #e5e8ec;
	    padding: 35px;
	    border-radius: 10px;
	}
	
	.footer-flex { 
	    display: flex;
	    gap: 30px;
	}
	
	/* 지도 */
	.map-area { 
	    flex: 1;
	    height: 320px;
	    border-radius: 8px;
	    border: 1px solid #e5e8ec;
	    overflow: hidden;
	}
	
	/* 기업 정보 */
	.company-stats { 
	    flex: 1;
	}
	
	.company-stats h4{
	    font-size:18px;
	    margin-bottom:15px;
	}
	
	.company-stats ul{
	    list-style:none;
	    padding:0;
	}
	
	.company-stats li{
	    padding:8px 0;
	    font-size:14px;
	    border-bottom:1px solid #f1f2f4;
	}
	
	/* 모달 배경 (어둡게) */
	.modal-overlay {
	    position: fixed;
	    top: 0;          /* 추가: 화면 맨 위부터 */
	    left: 0;
	    width: 100%;
	    height: 100%;    /* 추가: 화면 전체 높이만큼 */
	    background: rgba(0,0,0,0.4);
	    z-index: 9999;
	    display: none;
	}
	
	/* 모달 본체 */
	.modal-content{
	    position:fixed;
	    right:30px;
	    bottom:30px;
	
	    width:420px;
	    max-height:70vh;   /* 화면 절반 */
	
	    background:#fff;
	    padding:20px;
	    overflow-y:auto;
	
	    border-radius:10px;
	    box-shadow:0 10px 30px rgba(0,0,0,0.2);
	}
		
	@keyframes slideUp {
	    from { transform: translateY(50px); opacity: 0; }
	    to { transform: translateY(0); opacity: 1; }
	}
	
	.modal-header { padding: 20px; border-bottom: 1px solid #eee; position: relative; }
	.close-btn { position: absolute; right: 20px; top: 15px; font-size: 24px; border: none; background: none; cursor: pointer; }
	
	.modal-body { padding: 20px; }
	.job-title-mini { font-weight: bold; color: #4876ef; margin-bottom: 20px; }
	
	.final-apply-btn {
	    width: 100%;
	    padding: 15px;
	    background: #ff4b4b; /* 이미지와 유사한 강조색 */
	    color: #fff;
	    border: none;
	    font-size: 18px;
	    font-weight: bold;
	    cursor: pointer;
	}
	
	.resume-card-container {
	    max-height: 300px;
	    overflow-y: auto; /* 이력서가 많으면 스크롤 생성 */
	}
	
	.resume-card {
	    border: 1px solid #e5e8ec;
	    border-radius: 8px;
	    padding: 15px;
	    margin-bottom: 10px;
	    cursor: pointer;
	    transition: all 0.2s;
	    
	    background: #f8f9fb;
	    margin-top: 10px;
	}
	
	/* 마우스를 올렸을 때 */
	.resume-card:hover {
	    background-color: #f8f9fb;
	}
	
	/* 이력서가 선택되었을 때 디자인 변화 */
	.resume-card.selected {
	    border-color: #4876ef;
	    background-color: #f0f4ff;
	}
	
	.resume-card input[type="radio"] {
	    display: none; /* 라디오 버튼은 숨기고 카드 전체 클릭으로 대체 */
	}
	
	/* 헤더 */
	.apply-header{
	    display:flex;
	    justify-content:space-between;
	    align-items:center;
	    margin-bottom:20px;
	}
	
	.close-btn{
	    font-size:22px;
	    cursor:pointer;
	}
	
	/* 이력서 */
	.resume-section{
	    margin-bottom:20px;
	}
	
	.resume-select{
	    width:100%;
	    padding:10px;
	    border:1px solid #ddd;
	    border-radius:5px;
	}
	
	/* 파일 */
	.file-section{
	    margin-bottom:25px;
	}
	
</style>
</head>
<body>

<div class="job-detail-container">
    <header class="job-header">
        <div class="company-info">
            <p style="color: #666; margin-bottom: 5px;">${post.companyName}</p>
            <h1>${post.title}</h1>
            <input type="hidden" name="userId" value="${userId}">
        </div>
        <button type="button" class="apply-btn" id="applyBtn" onclick="checkResumeAndApply()">입사지원</button>
    </header>

    <section class="info-summary-grid">
        <div class="left-info">
<%--             <div class="info-item"><span class="info-label">경력</span><span class="info-value">${post.expType == 'career' ? '경력' : '신입·경력'} ${post.expYear != null ? post.expYear : '경력 무관'}</span></div> --%>
            <div class="info-item"><span class="info-label">경력</span><span class="info-value">${post.expYear}</span></div>
            <div class="info-item"><span class="info-label">학력</span><span class="info-value">${post.edu}</span></div>
            <div class="info-item"><span class="info-label">근무형태</span><span class="info-value">${post.empType} ${post.probation == 'Y' ? '수습기간 있음' : ''}</span></div>
        </div>
        <div class="right-info">
            <div class="info-item"><span class="info-label">급여</span><span class="info-value">${post.salary}</span></div>
            <div class="info-item"><span class="info-label">근무지역</span><span class="info-value">${post.address}
            <a href="#map" onclick="scrollToMap(event)" style="cursor:pointer; color:#007bff; margin-left:5px;">[지도]</a></span></div>
            
        </div>
    </section>

    <section class="detail-content-body">
        <div style="padding-top: 50px;">
            <h2>모직 직무 분야 : ${post.field}</h2>
            <p>${post.task}</p>
        </div>
    </section>

    <section class="company-footer-section">
        <div class="footer-flex">
            <div id="map" class="map-area">
                <p><i class="fa-solid fa-location-dot"></i> 지도 API 연결 영역 (근무지 위치)</p>
            </div>
            <div class="company-stats">
                <h4>기업 정보</h4>
                <ul>
                    <li>접수기간: 시작일 ${post.openDate} ~ 마감일 ${post.closeDate}</li>
                    <li>기업주소: ${post.address}</li>
                    
                    <c:if test="${post.isPublic eq 'Y'}">
			            <li>담당자: ${post.mgrName}</li>
			            <li>연락처: ${post.mgrPhone}</li>
			            <li>이메일: ${post.mgrEmail}</li>
			        </c:if>
                </ul>
            </div>
        </div>
    </section>
</div>

<div id="applyModal" class="modal-overlay">
    <div class="modal-content">
        <div class="modal-header">
            <h3>${post.companyName} 입사지원</h3>
            <button class="close-btn" onclick="closeApplyModal()">&times;</button>
        </div>
       <form action="<c:url value="/job/ApplyAction" />" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
	       <input type="hidden" name="resumeId" id="selectedResumeId" value="">
	       <input type="hidden" name="jobId" value="${post.jobId}">
	        <div class="modal-body">
	            <p class="job-title-mini">${post.title}</p>
	            
	            <div class="resume-section">
	                <div class="section-header" style="margin-bottom: 10px; font-weight: bold;">
	                    <span>지원할 이력서 선택</span>
	                </div>
	                <div class="resume-card-container" style="max-height: 250px; overflow-y: auto;">
	                    <c:forEach var="resume" items="${resumeList}">
	                        <div class="resume-card" onclick="selectResume('${resume.resumeId}', this)">
	                            <p class="resume-name">${resume.title}</p>
	                        </div>
	                    </c:forEach>
	                    <c:if test="${empty resumeList}">
	                        <p style="text-align: center; padding: 20px; color: #888;">보유 중인 이력서가 없습니다.</p>
	                    </c:if>
	                </div>
	            </div>
	        </div>
        <div class="modal-footer">
            <button type="submit" class="final-apply-btn">입사지원하기</button>
        </div>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
<script>
    // 1. 지도 초기화 및 마커 표시
    const map = new maplibregl.Map({
        container: 'map',
        style: 'https://tiles.openfreemap.org/styles/liberty',
        center: [126.9780, 37.5665], 
        zoom: 15
    });

    let currentAddress = "${post.address}"; 
    if (currentAddress && currentAddress.trim() !== "") {
        const searchAddress = currentAddress.split(' ').slice(0, 4).join(' ');
        const apiUrl = "https://nominatim.openstreetmap.org/search?format=json&q=" + encodeURIComponent(searchAddress);

        fetch(apiUrl)
            .then(res => res.json())
            .then(data => {
                if (data && data.length > 0) {
                    const lon = parseFloat(data[0].lon);
                    const lat = parseFloat(data[0].lat);
                    map.setCenter([lon, lat]);
                    new maplibregl.Marker({ color: '#ff4b4b' })
                        .setLngLat([lon, lat])
                        .setPopup(new maplibregl.Popup().setHTML("<b>" + currentAddress + "</b>"))
                        .addTo(map);
                }
            })
            .catch(err => console.error('주소 변환 오류:', err));
    }
    map.addControl(new maplibregl.NavigationControl());

    // 2. 입사지원 버튼 클릭 시 체크 및 모달 열기
    function checkResumeAndApply() {
        // JSTL을 통해 리스트 존재 여부를 안전하게 불리언으로 받음
        const selectedResumeId = ${not empty resumeList ? "true" : "false"}; 
        
        if (selectedResumeId) {
            document.getElementById('applyModal').style.display = 'block';
        } else {
            if (confirm("등록된 이력서가 없습니다. 이력서를 작성하시겠습니까?")) {
                location.href = "/resume/write";
            }
        }
    }

    // 3. 이력서 카드 선택 로직
    function selectResume(resumeId, element) {
        // 모든 카드의 선택 효과 제거
        document.querySelectorAll('.resume-card').forEach(card => {
            card.classList.remove('selected');
        });
        // 클릭한 카드만 선택 표시
        element.classList.add('selected');
        
        // [핵심] Hidden input에 ID 값 저장
        const hiddenInput = document.getElementById('selectedResumeId');
        if (hiddenInput) {
            hiddenInput.value = resumeId;
        }
    }
    
 	// [추가] 폼 제출 시 실행되는 검증 로직
    function validateForm() {
        const hiddenInput = document.getElementById('selectedResumeId');
        
        // 값이 없거나 비어있는지 체크
        if (!hiddenInput || !hiddenInput.value || hiddenInput.value === "") {
            alert("지원할 이력서를 선택해주세요!"); 
            return false; // 이 return false가 서버 전송을 막아줍니다.
        }
        return true;
    }

    // 4. 기타 유틸리티 함수
    function closeApplyModal() {
        document.getElementById('applyModal').style.display = 'none';
    }

    function scrollToMap(event) {
        event.preventDefault();
        const mapElement = document.getElementById('map');
        if (mapElement) {
            mapElement.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function(event) {
    const modal = document.getElementById("applyModal");
    if (event.target === modal) {
        closeApplyModal(); 
    }
};
</script>

</body>
</html>