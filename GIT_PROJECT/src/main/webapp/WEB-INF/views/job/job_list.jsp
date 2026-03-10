<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채용공고 목록</title>
<style>
    /* 1. 전체 레이아웃 및 폰트 */
    body {
        /* font-family: 'Pretendard', sans-serif; */
/*         background-color: #f8f9fa; */
        margin: 0 !important;   /* 부트스트랩 간섭 방지 */
        padding: 0 !important;
        color: #333;
    }

    /* 2. 메인 검색 섹션 박스 */
    .search-section { background: #fff; border: 2px solid #333; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
    
    .search-tab-bar { display: flex; background: #fff; border-bottom: 1px solid #eee; }
    .tab-item { 
        padding: 18px 30px; font-weight: bold; cursor: pointer; font-size: 16px;
        display: flex; align-items: center; gap: 10px; border-right: 1px solid #eee;
    }
    .tab-item.active { color: #007bff; position: relative; }
    .tab-item.active::after { 
        content: ''; position: absolute; bottom: -1px; left: 0; right: 0; 
        height: 3px; background: #007bff; 
    }

    .search-input-area { flex: 1; display: flex; align-items: center; padding: 0 15px; }
    .search-input-area input { 
        flex: 1; border: none; outline: none; padding: 10px; font-size: 15px; 
    }
    .btn-main-search { 
        background: #333; color: #fff; border: none; padding: 12px 35px; 
        border-radius: 4px; font-weight: bold; cursor: pointer; margin-left: 10px;
    }

    /* 3. 상세 선택 에리어 (그레이 박스) */
    .selection-detail-panel { display: flex; height: 350px; background: #fff; border-top: 1px solid #eee; }
    
    /* 대분류 열 */
    .category-column { width: 220px; background: #f1f3f5; border-right: 1px solid #ddd; overflow-y: auto; }
    .category-column li { 
        padding: 15px 20px; cursor: pointer; border-bottom: 1px solid #e9ecef; font-size: 15px; 
    }
    .category-column li:hover { background: #e9ecef; }
    .category-column li.active { background: #fff; color: #007bff; font-weight: bold; }

    /* 소분류 열 (체크박스 형태) */
    .sub-item-column { flex: 1; padding: 25px; overflow-y: auto; display: grid; grid-template-columns: repeat(4, 1fr); gap: 15px; align-content: flex-start; }
    .sub-item-column label { display: flex; align-items: center; gap: 8px; font-size: 14px; cursor: pointer; }
    .sub-item-column input[type="checkbox"] { width: 16px; height: 16px; cursor: pointer; }

    /* 상세 에리어 하단 푸터 */
    .selection-footer { 
        padding: 15px 25px; background: #fff; border-top: 1px solid #eee; 
        display: flex; justify-content: space-between; align-items: center;
    }
    .selected-status { font-size: 14px; color: #666; }
    .selected-status strong { color: #007bff; }
    .btn-reset-filter { background: none; border: none; color: #999; cursor: pointer; text-decoration: underline; }

    /* 4. 공고 리스트 (하단 예시) */
    /* 공고 리스트 컨테이너 */
	.job-list-container { margin-top: 40px; width: 100%; }
	
	/* 한 줄(카드) 전체 설정 */
	.job-card { 
	    background: #fff; 
	    padding: 20px; 
	    border-radius: 8px; 
	    margin-bottom: 12px;
	    border: 1px solid #eee; 
	    display: flex;        /* 가로 배치 */
	    align-items: center;  /* 세로 중앙 정렬 */
	    justify-content: flex-start;
	    transition: all 0.2s;
	    cursor: pointer;
	}
	
	.job-card:hover { transform: translateY(-3px); box-shadow: 0 5px 15px rgba(0,0,0,0.05); border-color: #007bff; }
	
	/* 각 칸별 고정 너비 지정 (여기서 정렬이 결정됩니다) */
	.company-name { width: 120px; font-weight: bold; flex-shrink: 0; color: #333; }
	.job-title    { width: 250px; font-weight: 500; flex-shrink: 0; padding: 0 10px; color: #000; }
	.job-tags     { width: 220px; display: flex; gap: 5px; flex-shrink: 0; justify-content: center; }
	.job-location { flex: 1; color: #666; font-size: 14px; padding: 0 15px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
	.job-deadline { width: 140px; text-align: right; color: #ff4d4f; font-weight: bold; font-size: 13px; flex-shrink: 0; }
	
	/* 태그 디자인 추가 */
	.tag { 
	    background: #f1f3f5; 
	    padding: 4px 8px; 
	    border-radius: 4px; 
	    font-size: 12px; 
	    color: #666;
	    white-space: nowrap;
	}
</style>
</head>
<body>

<div class="main-wrapper">
    
    <form action="search_process.jsp" method="get">
        
        <div class="filter-dropdown-row">
            <select class="filter-select" id="expFilter" onchange="changeFilter()">
			    <option value="">경력 전체</option>
			    <option value="new" ${selectedExp == 'new' ? 'selected' : ''}>신입</option>
			    <option value="career" ${selectedExp == 'career' ? 'selected' : ''}>경력</option>
			</select>
            <select name="edu_level" class="filter-select">
                <option value="">학력 전체</option>
                <option value="high">고졸</option>
                <option value="univ2">초대졸</option>
                <option value="univ4">대졸이상</option>
            </select>
        </div>

        <div class="search-section">
            <div class="search-tab-bar">
                <div class="tab-item active" onclick="toggleTab('region')">📍 지역별</div>
                <div class="tab-item" onclick="toggleTab('job')">💼 직무별</div>
                <div class="search-input-area">
                    <input type="text" name="keyword" placeholder="기업명, 공고 제목 등 키워드를 입력하세요.">
                    <button type="submit" class="btn-main-search">검색하기</button>
                </div>
            </div>

            <div class="selection-detail-panel">
                <ul class="category-column" id="mainCategory">
                    </ul>

                <div class="sub-item-column" id="subCategory">
                    </div>
            </div>

            <div class="selection-footer">
                <div class="selected-status">
                    선택된 조건: <strong>0</strong>건
                </div>
                <button type="button" class="btn-reset-filter" onclick="resetAll()">조건 초기화 ⟳</button>
            </div>
        </div>
    </form>

    <div class="job-list-container">
	    <div class="list-header">전체 채용 공고</div>
	    
	    <c:forEach var="job" items="${jobList}">
	        <div class="job-card" onclick="location.href='/job/JobDetail?jobId=${job.jobId}'">
	            <div class="company-name">${job.comName}</div>
	            
	            <div class="job-title">${job.title}</div>
	            
	            <div class="job-tags">
	                <span class="tag">${job.field}</span>
	                <span class="tag">${job.expYear}</span>
	                <span class="tag">${job.edu}</span>
	            </div>
	            
	            <div class="job-location">${job.displayAddress}</div>
	            
	            <div class="job-deadline">
	                ~ ${job.closeDate} 까지
	            </div>
	        </div>
	    </c:forEach>
	</div>

</div>

<script>
[cite_start]// 데이터 정의 (이미지 기반 샘플) [cite: 37]
const regions = {
    "서울": ["강남구", "강동구", "강서구", "관악구", "마포구", "송파구", "영등포구"],
    "경기": ["수원시", "용인시", "성남시", "부천시", "화성시", "안산시"],
    "부산": ["강서구", "금정구", "남구", "동래구", "부산진구", "수영구", "해운대구"]
};

const jobs = {
    "IT개발": ["백엔드", "프론트엔드", "데이터엔지니어", "iOS", "안드로이드", "DevOps"],
    "디자인": ["UI/UX", "웹디자인", "영상편집", "제품디자인", "그래픽"],
    "마케팅": ["브랜드마케팅", "퍼포먼스", "SNS마케팅", "광고AE"]
};

let currentTab = 'region'; // 현재 활성화된 탭 ('region' 또는 'job')

function renderMainCategory() {
    const mainUl = document.getElementById('mainCategory');
    const data = currentTab === 'region' ? regions : jobs;
    
    mainUl.innerHTML = '';
    Object.keys(data).forEach((cat, index) => {
        const li = document.createElement('li');
        li.textContent = cat;
        if(index === 0) li.classList.add('active');
        li.onclick = () => {
            document.querySelectorAll('.category-column li').forEach(el => el.classList.remove('active'));
            li.classList.add('active');
            renderSubCategory(cat);
        };
        mainUl.appendChild(li);
    });
    
    // 첫 번째 카테고리 자동 렌더링
    renderSubCategory(Object.keys(data)[0]);
}

function renderSubCategory(catName) {
    const subDiv = document.getElementById('subCategory');
    const data = currentTab === 'region' ? regions : jobs;
    const items = data[catName];
    
    subDiv.innerHTML = '';
    items.forEach(item => {
        const label = document.createElement('label');
        label.innerHTML = `<input type="checkbox" name="selected_items" value="${item}"> ${item}`;
        subDiv.appendChild(label);
    });
}

function toggleTab(type) {
    currentTab = type;
    document.querySelectorAll('.tab-item').forEach(el => el.classList.remove('active'));
    event.target.classList.add('active');
    renderMainCategory();
}

function resetAll() {
    const checkboxes = document.querySelectorAll('input[type="checkbox"]');
    checkboxes.forEach(cb => cb.checked = false);
}

// 초기 로딩
document.addEventListener('DOMContentLoaded', renderMainCategory);

function changeFilter() {
    const expType = document.getElementById("expFilter").value;
    // 현재 주소로 파라미터를 붙여서 이동
    location.href = "JobList?expType=" + expType;
}


</script>

</body>
</html>