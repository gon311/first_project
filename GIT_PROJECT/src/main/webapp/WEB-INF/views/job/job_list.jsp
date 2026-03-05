<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="<c:url value="/resources/css/jobCss/jobList.css" />" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
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
		        <div class="status-tag">
			        <c:choose>
			            <c:when test="${job.postStatus == 1}">
			                <span style="background: #28a745; color: white;">모집중</span>
			            </c:when>
			            <c:when test="${job.postStatus == 2}">
			                <span style="background: #dc3545; color: white;">마감</span>
			            </c:when>
			            <c:otherwise>
			                <span style="background: #ffc107; color: black;">보류</span>
			            </c:otherwise>
			        </c:choose>
		        </div>
	        	
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
	        	<div class="scrap-icon ${job.isScrapped == 'Y' ? 'active' : ''}" 
		             onclick="toggleScrap(event, '${job.jobId}', this)">
		            ${job.isScrapped == 'Y' ? '★' : '☆'}
		        </div>
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
    
    function toggleScrap(event, jobId, element) {
    	console.log("클릭됨! 공고ID:", jobId);
        event.stopPropagation(); // 카드 클릭 이벤트 전파 방지 [cite: 44]

        const isActive = element.classList.contains('active');
        const scrapStatus = isActive ? 'N' : 'Y'; // 현재 상태의 반대값을 서버로 보냄

        $.ajax({
            url: '<c:url value="/job/toggleBookmark" />', // 요청을 보낼 주소
            type: 'POST',
            data: {
                jobId: jobId,
                status: scrapStatus
            },
            success: function(response) {
                // 서버에서 처리가 성공했을 때만 UI 변경
                if(response === "success") {
                    element.classList.toggle('active');
                    element.textContent = (scrapStatus === 'Y') ? '★' : '☆';
                    console.log("즐겨찾기 상태 변경 완료:", scrapStatus);
                } else if(response === "login_required") {
                    alert("로그인이 필요한 서비스입니다.");
                }
            },
            error: function() {
                alert("서버 통신 중 오류가 발생했습니다.");
            }
        });
    }
    
    document.addEventListener('DOMContentLoaded', renderMainCategory);
    
</script>

<script type="text/javascript">
    var msg = "${msg}";
    if (msg && msg !== "") {
        alert(msg);
    }
</script>
</body>
</html>