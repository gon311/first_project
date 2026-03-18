<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<meta charset="UTF-8">
<script src="https://unpkg.com/maplibre-gl/dist/maplibre-gl.js"></script>
<link href="https://unpkg.com/maplibre-gl/dist/maplibre-gl.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="<c:url value="/resources/css/jobCss/jobDetail.css" />" rel="stylesheet" type="text/css">
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<c:choose>
        <c:when test="${userType == 'P' || sessionScope.memberType == 'user'}">
			<%@ include file="/WEB-INF/views/inc/header.jspf" %>
        </c:when>
        <c:otherwise>
            <%@ include file="/WEB-INF/views/inc/headerCom.jspf" %>
        </c:otherwise>
    </c:choose>
<main>
	<div class="job-detail-container">
	    <header class="job-header">
	        <div class="company-info">
	            <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 5px;">
			        <p style="color: #666; margin: 0;">${post.companyName}</p>
			        
			        <c:choose>
			            <c:when test="${post.postStatus == 1 && post.postCheck == 2}">
			                <span style="background: #28a745; color: white; padding: 2px 8px; border-radius: 4px; font-size: 0.8em;">모집중</span>
			            </c:when>
			            <c:when test="${post.postStatus == 2}">
			                <span style="background: #dc3545; color: white; padding: 2px 8px; border-radius: 4px; font-size: 0.8em;">마감</span>
			            </c:when>
			            <c:otherwise>
			                <span style="background: #ffc107; color: black; padding: 2px 8px; border-radius: 4px; font-size: 0.8em;">보류</span>
			            </c:otherwise>
			        </c:choose>
			    </div>
			    <h1>${post.title}</h1>
	            <input type="hidden" name="userId" value="${userId}">
	        </div>
	        <c:choose>
		        <%-- 상태가 '모집중(1)'일 때만 버튼 활성화 --%>
		        <c:when test="${post.postStatus == 1 && sessionScope.userType ne 'C' && post.postCheck == 2}">
		            <button type="button" class="apply-btn" id="applyBtn" onclick="checkResumeAndApply()">입사지원</button>
		        </c:when>
		        
		        <%-- '마감(2)'일 때 --%>
		        <c:when test="${post.postStatus == 2}">
		            <button type="button" class="apply-btn" style="background: #ccc; cursor: not-allowed;" disabled>지원 마감</button>
		        </c:when>
		        
		        <%-- '보류' 또는 기타 상태일 때 --%>
		        <c:otherwise>
		            <button type="button" class="apply-btn" style="background: #ccc; cursor: not-allowed;" disabled>지원 불가</button>
		        </c:otherwise>
	   		</c:choose>
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
		        
		        <div class="file-attachments" style="margin-top:25px; padding:15px; background:#f9f9f9; border-radius:8px;">
				    <h4 style="margin-bottom:15px;"><i class="fa-solid fa-image"></i> 직무 관련 이미지/첨부</h4>
				    <c:choose>
				        <c:when test="${not empty detailFile}">
				            <div class="file-preview-container" style="display: flex; flex-wrap: wrap; gap: 15px;">
				                <c:forEach var="file" items="${detailFile}">
				                    <div class="file-item" style="width: 100%;">
				                        <%-- 파일이 이미지인 경우 (간단하게 확장자나 DB의 contentType으로 구분) --%>
				                        <c:choose>
				                            <c:when test="${file.fileExt.contains('image') || file.fileExt.contains('jpg') || file.fileExt.contains('png')}">
				                                <div style="margin-bottom: 10px;">
										            <%-- 컨트롤러 매핑인 /board/image/view 를 사용합니다 --%>
										            <img src="<c:url value='/board/image/view'/>?filePath=${file.filePath}&storedName=${file.storedName}" 
										                 alt="${file.originName}" 
										                 style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
										        </div>
				                            </c:when>
				                            <c:otherwise>
				                                <%-- 이미지가 아닌 일반 파일은 기존처럼 링크로 표시 --%>
				                                <a href="/upload/board/${file.filePath}/${file.storedName}" 
				                                   download="${file.originName}" 
				                                   style="color:#007bff; text-decoration:none; display: block; padding: 10px; border: 1px dashed #ccc;">
				                                    <i class="fa-regular fa-file-lines"></i> ${file.originName} (다운로드)
				                                </a>
				                            </c:otherwise>
				                        </c:choose>
				                    </div>
				                </c:forEach>
				            </div>
				        </c:when>
				        <c:otherwise>
				            <p style="color:#999; font-size:0.9em;">등록된 이미지가 없습니다.</p>
				        </c:otherwise>
				    </c:choose>
				</div>
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
	            <h3>입사지원</h3>
	            <button class="close-btn" onclick="closeApplyModal()">&times;</button>
	        </div>
	
	        <form action="<c:url value="/job/ApplyAction" />" method="post" onsubmit="return validateForm()">
	            <div class="modal-body">
	                <p class="job-title-mini">${post.title}</p>
	                <span><b>지원할 이력서 선택</b></span>
	                <div class="resume-card-container">
	                    <c:forEach var="resume" items="${resumeList}">
	                        <div class="resume-card" onclick="selectResume('${resume.resumeId}', this)">
	                            <p class="resume-name">${resume.title}</p>
	                        </div>
	                    </c:forEach>
	                </div>
	            </div>
	
	            <div class="modal-footer">
	                <input type="hidden" name="resumeId" id="selectedResumeId" value="">
	                <input type="hidden" name="jobId" value="${post.jobId}">
	                <button type="submit" class="final-apply-btn">입사지원하기</button>
	            </div>
	        </form>
	    </div>
	</div>
</main>
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
                location.href = "<c:url value="/resume/regist" />";
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