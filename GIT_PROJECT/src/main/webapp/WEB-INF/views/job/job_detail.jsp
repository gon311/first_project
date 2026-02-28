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
	    display: none; /* 기본은 숨김 */
	    position: fixed;
	    top: 0; left: 0;
	    width: 100%; height: 100%;
	    background: rgba(0,0,0,0.5);
	    z-index: 1000;
	    justify-content: center;
	    align-items: center;
	}
	
	/* 모달 본체 */
	.modal-content {
	    background: #fff;
	    width: 450px;
	    border-radius: 12px;
	    overflow: hidden;
	    position: relative;
	    animation: slideUp 0.3s ease-out; /* 아래에서 위로 올라오는 효과 */
	}
	
	@keyframes slideUp {
	    from { transform: translateY(50px); opacity: 0; }
	    to { transform: translateY(0); opacity: 1; }
	}
	
	.modal-header { padding: 20px; border-bottom: 1px solid #eee; position: relative; }
	.close-btn { position: absolute; right: 20px; top: 15px; font-size: 24px; border: none; background: none; cursor: pointer; }
	
	.modal-body { padding: 20px; }
	.job-title-mini { font-weight: bold; color: #4876ef; margin-bottom: 20px; }
	
	.resume-card { 
	    border: 1px solid #e5e8ec; 
	    padding: 15px; 
	    border-radius: 8px; 
	    background: #f8f9fb;
	    margin-top: 10px;
	}
	
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
	
	/* 모달 배경 */
	.apply-modal{
	    display:none;
	    position:fixed;
	    z-index:1000;
	    left:0;
	    top:0;
	    width:100%;
	    height:100%;
	    background:rgba(0,0,0,0.4);
	}
	
	/* 모달 박스 */
	.apply-modal-content{
	    background:#fff;
	    width:450px;
	    margin:120px auto;
	    border-radius:10px;
	    padding:25px;
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
	
	/* 버튼 */
	.apply-footer{
	    text-align:right;
	}
	
	.submit-btn{
	    background:#4876ef;
	    color:#fff;
	    border:none;
	    padding:10px 20px;
	    border-radius:5px;
	    cursor:pointer;
	}
</style>
</head>
<body>

<div class="job-detail-container">
    <header class="job-header">
        <div class="company-info">
            <p style="color: #666; margin-bottom: 5px;">${post.companyName}</p>
            <h1>${post.title}</h1>
            
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
        <div style="padding-top: 150px;">
            <h3>모직 직무 분야 : ${post.field}</h3>
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
        <div class="modal-body">
            <p class="job-title-mini">${post.title}</p>
            
            <div class="resume-section">
                <div class="section-header" style="margin-bottom: 10px; font-weight: bold;">
                    <span>지원할 이력서 선택</span>
                </div>
                <div class="resume-card-container" style="max-height: 250px; overflow-y: auto;">
                    <c:forEach var="resume" items="${resumeList}">
                        <div class="resume-card" onclick="selectResume('${resume.id}', this)">
                            <p class="save-date">${resume.updateDate} 저장</p>
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
            <button class="final-apply-btn" onclick="submitApplication()">입사지원하기</button>
        </div>
    </div>
</div>

<div class="resume-card-container">
    <c:forEach var="resume" items="${resumeList}">
        <div class="resume-card" onclick="selectResume('${resume.id}')">
            <input type="radio" name="selectedResume" value="${resume.id}">
            <p class="save-date">${resume.updateDate} 저장</p>
            <p class="resume-name">${resume.title}</p>
        </div>
    </c:forEach>
</div>

<!-- 입사지원 모달 -->
<div id="applyModal" class="apply-modal">
    
    <div class="apply-modal-content">

        <!-- 상단 -->
        <div class="apply-header">
            <h3>입사지원</h3>
            <span class="close-btn" id="closeModal">&times;</span>
        </div>

        <!-- 지원 폼 -->
        <form action="/apply/submit" method="post" enctype="multipart/form-data">

            <!-- 이력서 선택 -->
            <div class="resume-section">
                <label>저장된 이력서 선택</label>

                <select name="resumeId" class="resume-select">
                    <option value="">이력서를 선택하세요</option>

                    <!-- DB에서 불러오는 부분 -->
                    <c:forEach var="resume" items="${resumeList}">
                        <option value="${resume.id}">
                            ${resume.title}
                        </option>
                    </c:forEach>

                </select>
            </div>

            <!-- 파일 첨부 -->
            <div class="file-section">
                <label>파일 첨부</label>

                <input type="file" name="files" multiple>
            </div>

            <!-- 버튼 -->
            <div class="apply-footer">
                <button type="submit" class="submit-btn">지원하기</button>
            </div>

        </form>

    </div>

</div>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
<script src="https://unpkg.com/maplibre-gl/dist/maplibre-gl.js"></script>
<script>
    // 1. 지도 초기화
    const map = new maplibregl.Map({
        container: 'map',
        style: 'https://tiles.openfreemap.org/styles/liberty',
        center: [126.9780, 37.5665], 
        zoom: 15
    });

 // 2. 주소 처리
    let currentAddress = "${post.address}"; 

    if (currentAddress && currentAddress.trim() !== "") {
        // [중요] 상세주소(예: 101동, 3층 등)가 포함되면 검색이 안 될 수 있으므로 
        // 공백으로 잘라 앞부분 3~4단어만 사용합니다.
        const searchAddress = currentAddress.split(' ').slice(0, 4).join(' ');
        
        const apiUrl = "https://nominatim.openstreetmap.org/search?format=json&q=" + encodeURIComponent(searchAddress);

        fetch(apiUrl)
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data && data.length > 0) {
                    const lon = parseFloat(data[0].lon);
                    const lat = parseFloat(data[0].lat);

                    // 1) 지도의 중심을 찾은 좌표로 이동
                    map.setCenter([lon, lat]);

                    // 2) 기존 위치에 마커 찍기
                    new maplibregl.Marker({ color: '#ff4b4b' })
                        .setLngLat([lon, lat])
                        .setPopup(new maplibregl.Popup().setHTML("<b>" + currentAddress + "</b>"))
                        .addTo(map);
                } else {
                    console.warn("주소를 찾을 수 없어 기본 위치를 유지합니다: " + searchAddress);
                }
            })
            .catch(function(error) { console.error('주소 변환 오류:', error); });
    }
    
    map.addControl(new maplibregl.NavigationControl());

	 // 기존에 두 번 선언된 checkResumeAndApply 함수를 모두 삭제하고 아래 하나로 합치세요.
    function checkResumeAndApply() {
        // 1. JSP에서 서버로부터 전달받은 이력서 리스트 존재 여부 확인
        // JSTL의 empty 연산자를 활용해 자바스크립트 변수로 변환
        const hasResumes = ${not empty resumeList};

        if (hasResumes) {
            // 2. 이력서가 있다면 모달창 표시
            const modal = document.getElementById('applyModal');
            modal.style.display = 'flex';
        } else {
            // 3. 이력서가 없다면 안내 후 작성 페이지 이동 (경로는 프로젝트에 맞게 수정)
            if (confirm("작성된 이력서가 없습니다. 이력서 작성 페이지로 이동하시겠습니까?")) {
                location.href = '/resume/write'; 
            }
        }
    }

    // 이력서 카드 선택 시 시각적 효과 부여
    function selectResume(resumeId, element) {
        // 모든 카드의 선택 효과 제거
        document.querySelectorAll('.resume-card').forEach(card => {
            card.classList.remove('selected');
        });
        // 클릭한 카드에만 선택 효과 추가
        element.classList.add('selected');
        
        // 실제 전송할 데이터(Radio 버튼 등)가 있다면 여기서 처리
        console.log("선택된 이력서 ID:", resumeId);
    }
    
    function scrollToMap(event) {
        event.preventDefault(); // 기본 링크 동작 방지
        const mapElement = document.getElementById('map');
        if (mapElement) {
            mapElement.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    }

    function closeApplyModal() {
        document.getElementById('applyModal').style.display = 'none';
    }

    // 배경 클릭 시 닫기 기능
    window.onclick = function(event) {
        const modal = document.getElementById('applyModal');
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
    

    const applyBtn = document.getElementById("applyBtn");
    const modal = document.getElementById("applyModal");
    const closeBtn = document.getElementById("closeModal");

    applyBtn.onclick = function(){
        modal.style.display = "block";
    }

    closeBtn.onclick = function(){
        modal.style.display = "none";
    }

    window.onclick = function(event){
        if(event.target == modal){
            modal.style.display = "none";
        }
    }

    
</script>

</body>
</html>