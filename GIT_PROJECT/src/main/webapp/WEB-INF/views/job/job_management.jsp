<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="realTotal" value="${statusCounts.waitCount + statusCounts.passCount + statusCounts.interviewCount + statusCounts.finalCount + statusCounts.failCount}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="<c:url value="/resources/css/jobCss/jobManagement.css" />" rel="stylesheet" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/inc/headerCom.jspf" %>
<main>
	<div class="manage-container">
	    <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 25px;">
	        <h2>지원자 관리 <small style="font-size:15px; color:#888; margin-left:10px; font-weight:400;">입사지원자를 검토하고 전형 상태를 업데이트하세요.</small></h2>
	        <span style="font-size: 14px; color: #666;">공고명: <strong>${postingTitle}</strong></span>
	    </div>
	
	    <section class="status-tabs">
	        <div class="status-tab ${cond.status == 'all' || empty cond.status ? 'active' : ''}" onclick="changeAppStep('all')">
	            <span class="label">전체</span>
	            <span class="count">${realTotal}</span> 
	        </div>
	        <div class="status-tab ${param.appStep == '서류대기' ? 'active' : ''}" onclick="changeAppStep('서류대기')">
	            <span class="label">서류대기</span>
	            <span class="count">${statusCounts.waitCount}</span>
	        </div>
	        <div class="status-tab ${param.appStep == '서류통과' ? 'active' : ''}" onclick="changeAppStep('서류통과')">
	            <span class="label">서류통과</span>
	            <span class="count">${statusCounts.passCount}</span>
	        </div>
	        <div class="status-tab ${param.appStep == '면접진행' ? 'active' : ''}" onclick="changeAppStep('면접진행')">
	            <span class="label">면접진행</span>
	            <span class="count">${statusCounts.interviewCount}</span>
	        </div>
	        <div class="status-tab ${param.appStep == '최종합격' ? 'active' : ''}" onclick="changeAppStep('최종합격')">
	            <span class="label">최종합격</span>
	            <span class="count">${statusCounts.finalCount}</span>
	        </div>
	        <div class="status-tab ${param.appStep == '불합격' ? 'active' : ''}" onclick="changeAppStep('불합격')">
	            <span class="label">불합격</span>
	            <span class="count">${statusCounts.failCount}</span>
	        </div>
	    </section>
	
	    <div class="manage-container" style="padding:0;">
	        <form id="searchForm" action="ApplicantManage" method="get">
	            <input type="hidden" name="page" id="pageNum" value="${pager.page}">
	            <input type="hidden" name="jobId" value="${param.jobId}">
	            <input type="hidden" name="appStep" value="${param.appStep}">
	
	            <section class="filter-bar">
	                <div class="filter-row">
						<input type="text" id="searchInput" name="q" value="${cond.q}" placeholder="지원자명 검색" style="width: 280px;">
	                    <button type="submit" class="btn-secondary" style="height: 38px;">검색</button>
	                    
	                    <select id="careerFilter" name="careerType" onchange="this.form.submit()">
	                        <option value="">경력전체</option>
	                        <option value="신입" ${param.careerType == '신입' ? 'selected' : ''}>신입</option>
	                        <option value="경력" ${param.careerType == '경력' ? 'selected' : ''}>경력</option>
	                    </select>
	                    
	                    <select name="size" onchange="this.form.submit()">
	                        <option value="5"  ${pager.size == 5  ? 'selected' : ''}>5개씩 보기</option>
	                        <option value="10" ${pager.size == 10 ? 'selected' : ''}>10개씩 보기</option>
	                        <option value="15" ${pager.size == 15 ? 'selected' : ''}>15개씩 보기</option>
	                    </select>
	                    
	                    <button type="button" class="btn-secondary" onclick="location.href='ApplicantManage?jobId=${param.jobId}'">
	                        <i class="fa-solid fa-rotate-left"></i> 초기화
	                    </button>
	                </div>
	                
	                <div class="filter-row" style="margin-top: 15px;">
	                    <span style="margin-right:10px;">선택한 인원을</span>
	                    <button type="button" class="btn-action" onclick="processBulkStatus('서류통과')">서류통과</button>
	                    <button type="button" class="btn-action" style="background: #ff5252;" onclick="processBulkStatus('불합격')">불합격</button>
	                    <button type="button" class="btn-secondary" onclick="processBulkStatus('면접진행')">면접요청</button>
	                    <button type="button" class="btn-action" style="background: GREEN;" onclick="processBulkStatus('최종합격')">최종합격</button>
	                    <button type="button" class="btn-secondary" style="margin-left: auto;" onclick="downloadPDF()">
	                        <i class="fa-solid fa-file-pdf"></i> 명단 다운로드
	                    </button>         
	                </div>
	            </section>
	        </form>
	    </div>
	
	    <div id="pdfArea"> 
	        <h2 style="padding: 10px;">지원자 리스트</h2>
	        <div class="applicant-table-wrap">
	            <table class="applicant-table">
	                <thead>
	                    <tr>
	                        <th style="width: 50px; text-align: center;"><input type="checkbox" id="checkAll"></th>
	                        <th style="width: 80px;">번호</th>
	                        <th>지원자 정보</th>
	                        <th style="width: 100px;">경력</th>
	                        <th>지원 공고</th>
	                        <th>지원일</th>
	                        <th style="width: 150px;">전형 상태</th>
	                        <th style="width: 80px; text-align: center;">관심</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <c:forEach var="app" items="${applicantList}">
	                        <tr>
	                            <td style="text-align: center;">
	                                <input type="checkbox" name="selectedApp" value="${app.appId}">
	                            </td>
	                            <td style="color: #888;">${app.appId}</td>
	                            <td>
	                                <span class="name-tag">${app.userName}</span>
	                                <div class="doc-links">
	                                    <a href="<c:url value='/job/resumeView?resumeId=${app.resumeId}'/>" class="doc-btn">
	                                        <i class="fa-solid fa-file-user"></i> 이력서
	                                    </a>
	                                </div>
	                            </td>
								<td>
								    <c:choose>
								        <c:when test="${app.careerCode == 'ENTRY'}">
								            <span style="color: #4CAF50; font-weight: 600;">신입</span>
								        </c:when>
								        <c:when test="${app.careerCode == 'INTERN'}">
								            <span style="color: #2196F3; font-weight: 600;">인턴</span>
								        </c:when>
								        <c:when test="${app.careerCode == 'EXPERIENCED'}">
								            <span style="font-weight: 600;">경력</span>
								        </c:when>
								        <c:otherwise>
								            <span style="color: #888;">${app.careerCode}</span>
								        </c:otherwise>
								    </c:choose>
								</td>
	                            <td>${app.postingTitle}</td>
	                            <td>${app.formattedApplyDate}</td>
	                            <td>
	                                <select class="status-select" onchange="changeStatus(${app.appId}, this.value)">
	                                    <option value="서류대기" ${app.appStep == '서류대기' ? 'selected' : ''}>서류대기</option>
	                                    <option value="서류통과" ${app.appStep == '서류통과' ? 'selected' : ''}>서류통과</option>
	                                    <option value="면접진행" ${app.appStep == '면접진행' ? 'selected' : ''}>면접진행</option>
	                                    <option value="최종합격" ${app.appStep == '최종합격' ? 'selected' : ''}>최종합격</option>
	                                    <option value="불합격" ${app.appStep == '불합격' ? 'selected' : ''}>불합격</option>
	                                </select>
	                            </td>
	                            <td style="text-align: center;">
	                                <i class="fa-solid fa-star star-icon ${app.isFavorite == 'Y' ? 'active' : ''}" 
	                                   onclick="toggleAppFavorite(${app.appId}, this)" 
	                                   style="cursor:pointer;"></i>
	                            </td>
	                        </tr>
	                    </c:forEach>
	                    <c:if test="${empty applicantList}">
	                        <tr><td colspan="8" style="text-align:center; padding:50px;">지원자가 없습니다.</td></tr>
	                    </c:if>
	                </tbody>
	            </table>
	        </div>
	    </div>
	
	    <div class="pager">
	        <c:if test="${pager.hasPrev}">
	            <a href="javascript:void(0)" onclick="changePage(${pager.page-1})">이전</a>
	        </c:if>
	        
	        <c:forEach var="i" begin="${pager.startPage}" end="${pager.endPage}">
	            <a href="javascript:void(0)" onclick="changePage(${i})" class="${i == pager.page ? 'active' : ''}">${i}</a>
	        </c:forEach>
	        
	        <c:if test="${pager.hasNext}">
	            <a href="javascript:void(0)" onclick="changePage(${pager.page+1})">다음</a>
	        </c:if>
	    </div>
	</div>
</main>
<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

<script>
// 페이지 변경 함수
function changePage(num) {
    $('#pageNum').val(num);
    $('#searchForm').submit();
}

// 상단 상태 탭 변경 함수
function changeAppStep(step) {
    // 1. 폼 안에 있는 hidden 필드에 값 세팅
    $('input[name="appStep"]').val(step);
    // 2. 페이지는 무조건 1페이지로
    $('#pageNum').val(1);
    // 3. 폼 제출 (이게 가장 깔끔합니다)
    $('#searchForm').submit();
}

// 개별 상태 변경
function changeStatus(appId, newStep) {
    if(!confirm("상태를 '" + newStep + "'(으)로 변경하시겠습니까?")) return;
    $.post('<c:url value="/job/updateAppStatus"/>', { appId: appId, appStep: newStep }, function(res) {
        if(res === "success") location.reload();
    });
}

// 즐겨찾기 토글
function toggleAppFavorite(appId, element) {
    const nextStatus = $(element).hasClass('active') ? 'N' : 'Y';
    $.post('<c:url value="/job/toggleAppFavorite"/>', { appId: appId, isFavorite: nextStatus }, function(res) {
        if(res === "success") location.reload();
    });
}

// 전체 선택
$('#checkAll').on('change', function() {
    $('input[name="selectedApp"]').prop('checked', $(this).prop('checked'));
});

// 일괄 처리
function processBulkStatus(status) {
    const selectedIds = [];
    $('input[name="selectedApp"]:checked').each(function() { selectedIds.push($(this).val()); });
    
    if(selectedIds.length === 0) { alert("대상을 선택해주세요."); return; }
    
    if(confirm(selectedIds.length + "명을 '" + status + "' 처리하시겠습니까?")) {
        // 실제 운영 시에는 리스트를 한 번에 보내는 별도 API 권장
        let count = 0;
        selectedIds.forEach(id => {
            $.post('<c:url value="/job/updateAppStatus"/>', { appId: id, appStep: status }, function() {
                count++;
                if(count === selectedIds.length) {
                    alert("처리가 완료되었습니다.");
                    location.reload();
                }
            });
        });
    }
}

//PDF 다운로드 (충돌 방지를 위해 백틱 대신 따옴표 사용)
async function downloadPDF() {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF('l', 'mm', 'a4');
    const element = document.getElementById("pdfArea");
    
    try {
        const canvas = await html2canvas(element, { scale: 2, useCORS: true, backgroundColor: '#ffffff' });
        const imgData = canvas.toDataURL('image/png');
        
        // 이미지 추가
        doc.addImage(imgData, 'PNG', 10, 10, 280, (canvas.height * 280) / canvas.width);
        
        const today = new Date().toISOString().slice(0, 10);
        doc.save("지원자명단_" + today + ".pdf");
        
    } catch (error) {
        console.error("PDF 생성 중 오류 발생:", error);
        alert("PDF 생성에 실패했습니다.");
    }
}

</script>

</body>
</html>