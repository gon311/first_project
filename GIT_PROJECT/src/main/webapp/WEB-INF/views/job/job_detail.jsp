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
<link href="<c:url value="/resources/css/jobDetail.css" />" rel="stylesheet" type="text/css">
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