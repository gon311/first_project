<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    /* 1. 전체 레이아웃 및 폰트 */
    body {
        /* font-family: 'Pretendard', sans-serif; */
        background-color: #f8f9fa;
        margin: 0 !important;   /* 부트스트랩 간섭 방지 */
        padding: 0 !important;
        color: #333;
    }

    .main-wrapper {
        max-width: 1200px;
        margin: 60px auto;
        padding: 0 20px;
    }

    /* 2. 상단 필터 (경력/학력) */
    .filter-dropdown-row {
        margin-bottom: 15px;
        display: flex;
        gap: 10px;
    }

    .filter-select {
        padding: 10px 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        background: #fff;
        font-size: 14px;
        min-width: 150px;
        cursor: pointer;
    }

    /* 3. 검색 섹션 박스 */
    .search-section {
        background: #fff;
        border: 2px solid #333;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 4px 6px rgba(0,0,0,0.05);
    }

    .search-tab-bar {
        display: flex;
        width: 100%;
        height: 60px;
        border-bottom: 1px solid #eee;
        background: #fff;
    }

    .tab-item {
        width: 150px;
        font-weight: bold;
        cursor: pointer;
        font-size: 16px;
        border-right: 1px solid #eee;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    .tab-item.active {
        color: #007bff;
        position: relative;
    }

    .tab-item.active::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        height: 3px;
        background: #007bff;
    }

    .search-input-area {
        flex: 1;
        display: flex;
        align-items: center;
        padding: 0 20px;
    }

    .search-input-area input {
        flex: 1;
        border: none;
        outline: none;
        font-size: 15px;
        height: 100%;
    }

    .btn-main-search {
        background: #333;
        color: #fff;
        border: none;
        padding: 0 30px;
        height: 40px;
        border-radius: 4px;
        font-weight: bold;
        cursor: pointer;
    }

    /* 4. 선택 패널 (지역/직무) */
    .selection-detail-panel {
        display: flex;
        height: 350px;
        border-top: 1px solid #eee;
    }

    .category-column {
        width: 220px;
        background: #f1f3f5;
        border-right: 1px solid #ddd;
        overflow-y: auto;
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .category-column li {
        padding: 15px 20px;
        cursor: pointer;
        border-bottom: 1px solid #e9ecef;
    }

    .category-column li.active {
        background: #fff;
        color: #007bff;
        font-weight: bold;
    }

    .sub-item-column {
        flex: 1;
        padding: 25px;
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 12px;
        overflow-y: auto;
        align-content: flex-start;
    }

    .sub-item-column label {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 14px;
        cursor: pointer;
    }

    /* 5. 선택 섹션 하단 푸터 및 초기화 버튼 */
    .selection-footer {
        padding: 15px 25px;
        background: #fff;
        border-top: 1px solid #eee;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .selected-status {
        font-size: 14px;
        color: #666;
    }

    .selected-status strong {
        color: #007bff;
        font-size: 16px;
        margin: 0 2px;
    }

    .btn-reset {
        display: flex;
        align-items: center;
        gap: 6px;
        background-color: transparent;
        color: #888;
        border: 1px solid #ddd;
        padding: 8px 18px;
        border-radius: 25px;
        font-size: 13px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .btn-reset:hover {
        background-color: #f8f9fa;
        color: #333;
        border-color: #bbb;
    }

    .btn-reset i {
        font-style: normal;
        font-size: 16px;
        transition: transform 0.4s ease;
    }

    .btn-reset:hover i {
        transform: rotate(-180deg);
    }

    /* 6. 요청하신 "채용정보" 타이틀 영역 */
    .list-title-area {
        margin-top: 50px;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 12px;
        border-bottom: 2px solid #333;
        padding-bottom: 15px;
    }

    .list-title-area h2 {
        margin: 0;
        font-size: 24px;
        font-weight: 800;
        color: #1a1a1a;
    }

    .total-count {
        font-size: 16px;
        color: #666;
    }

    .total-count span {
        color: #007bff;
        font-weight: 700;
    }

    /* 7. 리스트 카드 디자인 */
    .job-list-container {
        margin-top: 10px;
    }

    .job-card {
        background: #fff;
        padding: 25px 30px;
        border-radius: 12px;
        margin-bottom: 15px;
        border: 1px solid #eee;
        display: flex;
        align-items: center;
        cursor: pointer;
        transition: all 0.2s;
    }

    .job-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        border-color: #007bff;
    }

    .company-name {
        width: 120px;
        font-weight: bold;
        font-size: 15px;
    }

    .job-title {
        width: 350px;
        font-weight: 600;
        padding: 0 10px;
        font-size: 16px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .tag {
        background: #f1f3f5;
        padding: 4px 8px;
        border-radius: 4px;
        font-size: 12px;
        color: #666;
        margin-right: 5px;
    }

    .job-deadline {
        margin-left: auto;
        color: #ff4d4f;
        font-weight: bold;
        font-size: 14px;
    }
</style>
</head>
<body>

<div class="main-wrapper">
    <form id="searchForm" action="JobList" method="get">
        <div class="filter-dropdown-row">
            <select class="filter-select" id="expFilter" name="expType" onchange="changeFilter()">
                <option value="" ${empty param.expType ? 'selected' : ''}>경력 전체</option>
                <option value="new" ${param.expType == 'new' ? 'selected' : ''}>신입</option>
                <option value="career" ${param.expType == 'career' ? 'selected' : ''}>경력</option>
            </select>
            
            <select class="filter-select" id="eduFilter" name="eduType" onchange="changeFilter()">
                <option value="" ${empty param.eduType ? 'selected' : ''}>학력 전체</option>
                <option value="학력무관" ${param.eduType == '학력무관' ? 'selected' : ''}>학력무관</option>
                <option value="고등학교 졸업" ${param.eduType == '고등학교 졸업' ? 'selected' : ''}>고졸</option>
                <option value="대학교(2,3년) 졸업" ${param.eduType == '대학교(2,3년) 졸업' ? 'selected' : ''}>대학교(2,3년) 졸업</option>
                <option value="대학교(4년) 졸업" ${param.eduType == '대학교(4년) 졸업' ? 'selected' : ''}>대학교(4년) 졸업</option>
            </select>
        </div>

        <div class="search-section">
            <div class="search-tab-bar">
                <div class="tab-item active" id="tabRegion" onclick="toggleTab('region')">📍 지역별</div>
                <div class="tab-item" id="tabJob" onclick="toggleTab('job')">💼 직무별</div>
                <div class="search-input-area">
                    <input type="text" name="keyword" value="${param.keyword}" placeholder="회사명 또는 공고 제목을 검색하세요.">
                    <button type="submit" class="btn-main-search" onclick="syncHiddenFields()">검색하기</button>
                </div>
            </div>
            
            <div class="selection-detail-panel">
                <ul class="category-column" id="mainCategory"></ul>
                <div class="sub-item-column" id="subCategory"></div>
            </div>

            <div class="selection-footer">
                <div class="selected-status">선택된 조건: <strong id="selectedCount">0</strong>건</div>
                <button type="button" class="btn-reset" onclick="resetAll()">
                    <i>⟳</i> 조건 초기화
                </button>
            </div>
        </div>
        
        <div id="hiddenCheckboxes">
            <c:forEach var="val" items="${paramValues.selected_items}">
                <input type="hidden" name="selected_items" value="${val}" class="preserved-val">
            </c:forEach>
        </div>
    </form>

    <div class="list-title-area">
        <h2>채용정보</h2>
        <div class="total-count">총 <span>${jobList != null ? jobList.size() : 0}</span>건의 공고</div>
    </div>

    <div class="job-list-container">
	    <c:forEach var="job" items="${jobList}">
	        <div class="job-card" onclick="location.href='<c:url value="/job/JobDetail?jobId=${job.jobId}" />'">
			    <div class="company-name">${job.companyName}</div>
			    <div class="job-title">${job.title}</div>
			    <div class="job-tags">
			        <span class="tag">${job.field}</span>
			        <span class="tag">${job.expYear}</span>
			        <span class="tag">${job.edu}</span>
			    </div>
			    
			    <div class="job-location" style="margin-left: 20px; font-size: 14px; color: #666; min-width: 120px;">
			        ${job.displayAddress}
			    </div>
			    
			    <div class="job-deadline">~ ${job.closeDate}</div>
			</div>
	    </c:forEach>
	</div>
</div>
<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
<script>
	const regionData = {};
	
	<c:forEach var="reg" items="${existRegions}">
	    if(!regionData['${reg.city}']) {
	        regionData['${reg.city}'] = [];
	    }
	    regionData['${reg.city}'].push('${reg.district}');
	</c:forEach>
	

	const jobData = {
	    "기획·전략": ["경영기획", "전략기획", "사업개발", "서비스기획", "데이터분석"],
	    "마케팅·홍보": ["브랜드마케팅", "퍼포먼스마케팅", "광고AE", "SNS마케팅", "홍보(PR)"],
	    "IT개발": ["백엔드", "프론트엔드", "앱개발", "게임개발", "AI·인공지능", "임베디드", "보안"],
	    "디자인": ["UI·UX디자인", "웹디자인", "그래픽디자인", "영상편집", "제품디자인"],
	    "교육": ["초중고교사", "대학교수", "전문강사", "학습지교사", "입시강사", "외국어강사", "교직원"],
	    "영업·고객상담": ["IT영업", "기술영업", "영업관리", "고객상담(CS)", "인바운드"],
	    "의료·보건": ["의사", "간호사", "물리치료사", "임상병리", "약사", "의료코디네이터"]
	};
	
    let currentTab = 'region';
    let savedChecks = new Set();
    
    // 초기 로드 시 기존 파라미터 Set에 저장
    document.querySelectorAll('.preserved-val').forEach(el => savedChecks.add(el.value));

    function renderMainCategory() {
        const mainUl = document.getElementById('mainCategory');
        const data = (currentTab === 'region') ? regionData : jobData;
        mainUl.innerHTML = '';
        Object.keys(data).forEach((cat, index) => {
            const li = document.createElement('li');
            li.textContent = cat;
            if(index === 0) { li.classList.add('active'); renderSubCategory(cat); }
            li.onclick = function() {
                document.querySelectorAll('#mainCategory li').forEach(el => el.classList.remove('active'));
                this.classList.add('active');
                renderSubCategory(cat);
            };
            mainUl.appendChild(li);
        });
    }

    function renderSubCategory(catName) {
        const subDiv = document.getElementById('subCategory');
        const data = (currentTab === 'region') ? regionData : jobData;
        const items = data[catName];
        subDiv.innerHTML = '';
        if (items) {
            items.forEach(item => {
                const label = document.createElement('label');
                const checkbox = document.createElement('input');
                checkbox.type = 'checkbox';
                checkbox.value = item;
                if(savedChecks.has(item)) checkbox.checked = true;
                checkbox.onchange = function() {
                    if(this.checked) savedChecks.add(this.value);
                    else savedChecks.delete(this.value);
                    updateSelectedCount();
                };
                label.appendChild(checkbox);
                label.append(item);
                subDiv.appendChild(label);
            });
        }
        updateSelectedCount();
    }

    function updateSelectedCount() {
        document.getElementById('selectedCount').textContent = savedChecks.size;
    }

    function syncHiddenFields() {
        const container = document.getElementById('hiddenCheckboxes');
        container.innerHTML = ''; 
        savedChecks.forEach(val => {
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'selected_items';
            input.value = val;
            container.appendChild(input);
        });
    }

    function toggleTab(type) {
        currentTab = type;
        document.getElementById('tabRegion').classList.toggle('active', type === 'region');
        document.getElementById('tabJob').classList.toggle('active', type === 'job');
        renderMainCategory();
    }

    function changeFilter() {
        syncHiddenFields();
        document.getElementById("searchForm").submit();
    }

    function resetAll() {
        location.href = "JobList";
    }
    
    document.addEventListener('DOMContentLoaded', renderMainCategory);
</script>
</body>
</html>