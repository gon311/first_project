<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채용 공고 상세 | 프로젝트</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    /* 1. 기본 레이아웃 및 초기화 */
    body { 
        background-color: #f8f9fa; 
        color: #333; 
/*         font-family: 'Pretendard', sans-serif;  */
        margin: 0 !important;   /* 부트스트랩 기본 마진 제거 */
        padding: 0 !important;  /* 부트스트랩 기본 패딩 제거 */
    }

    .job-detail-container { 
        max-width: 1100px; 
        margin: 0 auto; 
        padding: 40px 20px; 
    }
    
    /* 2. 상단: 회사명 및 입사지원 버튼 */
    .job-header { 
        display: flex; 
        justify-content: space-between; 
        align-items: flex-start; 
        margin-bottom: 30px; 
        border-bottom: 1px solid #eee; 
        padding-bottom: 30px; 
    }

    .company-info h1 { 
        font-size: 28px; 
        margin-bottom: 10px; 
        color: #333; 
    }

    .apply-btn { 
        background-color: #ff4b4b; 
        color: white; 
        padding: 20px 60px; 
        font-size: 20px; 
        font-weight: bold; 
        border: none; 
        border-radius: 8px; 
        cursor: pointer; 
        transition: background-color 0.2s;
    }

    .apply-btn:hover {
        background-color: #e63939;
    }

    /* 3. 중단: 주요 조건 (경력, 학력 등) */
    .info-summary-grid { 
        display: grid; 
        grid-template-columns: 1fr 1fr; 
        gap: 20px; 
        background-color: #fff; 
        border: 1px solid #eee; 
        padding: 30px; 
        border-radius: 12px; 
        margin-bottom: 40px; 
    }

    .info-item { 
        display: flex; 
        margin-bottom: 15px; 
    }

    .info-label { 
        width: 100px; 
        color: #888; 
        font-weight: 500; 
    }

    .info-value { 
        color: #333; 
        font-weight: 500; 
    }

    /* 4. 중단: 상세 내용 영역 (노란색 영역) */
    .detail-content-body { 
        background-color: #fffde7; 
        min-height: 400px; 
        padding: 40px; 
        border: 1px dashed #ccc; 
        margin-bottom: 40px; 
        text-align: center; 
        border-radius: 12px; 
    }

    /* 5. 하단: 기업 정보 및 지도 (하늘색 영역) */
    .company-footer-section { 
        background-color: #e1f5fe; 
        padding: 40px; 
        border-radius: 12px; 
    }

    .footer-flex { 
        display: flex; 
        gap: 30px; 
    }

    .map-area { 
        flex: 1; 
        background: white; 
        height: 200px; 
        border-radius: 8px; 
        display: flex; 
        align-items: center; 
        justify-content: center; 
        border: 1px solid #b3e5fc; 
    }

    .company-stats { 
        flex: 1; 
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
        <button type="button" class="apply-btn" onclick="checkResumeAndApply()">입사지원</button>
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
            <div class="info-item"><span class="info-label">근무지역</span><span class="info-value">${post.address}<a href="#">[지도]</a></span></div>
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
            <div class="map-area">
                <p><i class="fa-solid fa-location-dot"></i> 지도 API 연결 영역 (근무지 위치)</p>
            </div>
            <div class="company-stats">
                <h4>기업 정보</h4>
                <ul>
                    <li>접수기간: 남은 기간 표시</li>
                    <li>기업주소: 상세 주소 표시</li>
                    <li>홈페이지: www.company.com</li>
                </ul>
            </div>
        </div>
    </section>
</div>
<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
<script>
    // 기획안 2페이지 로직: 입사지원 클릭 시 처리
    function checkResumeAndApply() {
        // 실제 프로젝트에서는 서버와 통신하여 이력서 유무를 판단해야 합니다.
        const hasResume = confirm("이력서가 있습니까? (테스트용 확인창)"); 
        
        if(hasResume) {
            alert("작성된 이력서 선택 후 바로 지원 페이지로 이동합니다.");
            // location.href = 'apply_direct.jsp';
        } else {
            alert("작성된 이력서가 없습니다. 이력서 작성 페이지로 이동하거나 파일을 업로드해 주세요.");
            // location.href = 'resume_write.jsp';
        }
    }
</script>

</body>
</html>