<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="<c:url value="/resources/css/jobCss/jobManagement.css" />" rel="stylesheet" type="text/css">
</head>
<body>
<div class="manage-container">
    <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 25px;">
        <h2>지원자 관리 <small style="font-size:15px; color:#888; margin-left:10px; font-weight:400;">입사지원자를 검토하고 전형 상태를 업데이트하세요.</small></h2>
        <span style="font-size: 14px; color: #666;">공고명: <strong>${postingTitle}</strong></span>
    </div>

    <c:set var="waitCount" value="0" />
	<c:set var="passCount" value="0" />
	<c:set var="interviewCount" value="0" />
	<c:set var="finalCount" value="0" />
	<c:set var="failCount" value="0" />
	
	<c:forEach var="app" items="${applicantList}">
	    <c:choose>
	        <c:when test="${app.appStep == '서류대기'}"><c:set var="waitCount" value="${waitCount + 1}" /></c:when>
	        <c:when test="${app.appStep == '서류통과'}"><c:set var="passCount" value="${passCount + 1}" /></c:when>
	        <c:when test="${app.appStep == '면접진행'}"><c:set var="interviewCount" value="${interviewCount + 1}" /></c:when>
	        <c:when test="${app.appStep == '최종합격'}"><c:set var="finalCount" value="${finalCount + 1}" /></c:when>
	        <c:when test="${app.appStep == '불합격'}"><c:set var="failCount" value="${failCount + 1}" /></c:when>
	    </c:choose>
	</c:forEach>
	
	<section class="status-tabs">
	    <div class="status-tab active" onclick="filterByStatus('all', this)">
	        <span class="label">전체</span>
	        <span class="count">${applicantList.size()}</span>
	    </div>
	    <div class="status-tab" onclick="filterByStatus('서류대기', this)"><span class="label">서류대기</span>
	    <span class="count">${waitCount}</span></div>
	    <div class="status-tab" onclick="filterByStatus('서류통과', this)"><span class="label">서류통과</span>
	    <span class="count">${passCount}</span></div>
	    <div class="status-tab" onclick="filterByStatus('면접진행', this)"><span class="label">면접진행</span>
	    <span class="count">${interviewCount}</span></div>
	    <div class="status-tab" onclick="filterByStatus('최종합격', this)"><span class="label">최종합격</span>
	    <span class="count">${finalCount}</span></div>
	    <div class="status-tab" onclick="filterByStatus('불합격', this)"><span class="label">불합격</span>
	    <span class="count">${failCount}</span></div>
	</section>

    <section class="filter-bar">
        <div class="filter-row">
		    <input type="text" id="searchInput" placeholder="지원자명/키워드 검색" style="width: 280px;">
		    <select><option>경력전체</option></select>
		    <select><option>학력전체</option></select>
		    <button class="btn-secondary" onclick="resetFilter()">
		        <i class="fa-solid fa-rotate-left"></i> 초기화
		    </button>
		</div>
        
        <div class="filter-row" style="margin-bottom: 0; border-top: 1px solid #f5f5f5; padding-top: 20px; align-items: center;">
            <span style="font-size: 14px; color: #555; margin-right: 15px;">선택한 인원을</span>
            <button class="btn-action">서류 통과</button>
            <button class="btn-action" style="background: #ff5252;">불합격</button>
            <button class="btn-secondary" onclick="processBulkStatus('면접진행')">면접요청</button>
            <button class="btn-secondary" style="margin-left: auto;"><i class="fa-solid fa-file-pdf"></i> 명단 다운로드</button>
        </div>
    </section>

    <div class="applicant-table-wrap">
        <table class="applicant-table">
            <thead>
			    <tr>
			        <th style="width: 50px; text-align: center;"><input type="checkbox"></th>
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
			                    <a href="<c:url value='/resume/detail?id=${app.resumeId}'/>" class="doc-btn">
			                        <i class="fa-solid fa-file-user"></i> 이력서
			                    </a>
			                </div>
			            </td>
			            
			            <td style="font-size: 14px;">
						    <c:choose>
						        <c:when test="${empty app.careerLevel || app.careerLevel == '신입'}">
						            <span style="color: #4CAF50; font-weight: 600;">신입</span>
						        </c:when>
						        <c:otherwise>
						            ${app.careerLevel}
						        </c:otherwise>
						    </c:choose>
						</td>
			
			            <td style="font-size: 14px;">${app.postingTitle}</td>
			            <td style="font-size: 14px; color: #666;">${app.formattedApplyDate}</td>
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
			    </tbody>
        </table>
    </div>

    <div class="pagination">
        <a href="#" class="page-link"><i class="fa-solid fa-angle-left"></i></a>
        <a href="#" class="page-link active">1</a>
        <a href="#" class="page-link">2</a>
        <a href="#" class="page-link">3</a>
        <a href="#" class="page-link"><i class="fa-solid fa-angle-right"></i></a>
    </div>
</div>
<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
// 1. 개별 전형 상태 업데이트 (SELECT 박스 변경 시)
function changeStatus(appId, newStep) {
    if(!confirm("전형 상태를 '" + newStep + "'(으)로 변경하시겠습니까?")) return;

    $.ajax({
        url: '<c:url value="/job/updateAppStatus"/>',
        type: 'POST',
        data: { appId: appId, appStep: newStep },
        success: function(response) {
            if(response === "success") {
                alert("상태가 변경되었습니다.");
                location.reload(); // 상태 수치 갱신을 위해 새로고침
            } else {
                alert("상태 변경에 실패했습니다.");
            }
        }
    });
}

// 2. 관심 지원자(별표) 토글
function toggleAppFavorite(appId, element) {
    const isActive = $(element).hasClass('active');
    const nextStatus = isActive ? 'N' : 'Y';

    $.ajax({
        url: '<c:url value="/job/toggleAppFavorite"/>',
        type: 'POST',
        data: { appId: appId, isFavorite: nextStatus },
        success: function(response) {
            if(response === "success") {
//                 $(element).toggleClass('active');
                location.reload();
            }
        }
    });
}

$(function() {
    // 3. 테이블 헤더 체크박스로 전체 선택/해제
    $('.applicant-table thead input[type="checkbox"]').on('change', function() {
        const isChecked = $(this).prop('checked');
        $('input[name="selectedApp"]').prop('checked', isChecked);
    });

    // 4. 상단 '합격 통보' 버튼 클릭 (첫 번째 btn-action)
    $('.btn-action').eq(0).on('click', function() { 
        processBulkStatus("서류통과"); 
    });

    // 5. 상단 '불합격 통보' 버튼 클릭 (두 번째 btn-action)
    $('.btn-action').eq(1).on('click', function() { 
        processBulkStatus("불합격"); 
    });
});

// 6. 일괄 처리 공통 함수 (AJAX 포함)
function processBulkStatus(status) {
    const selectedIds = [];
    $('input[name="selectedApp"]:checked').each(function() {
        selectedIds.push($(this).val());
    });
    
    if(selectedIds.length === 0) {
        alert("대상을 선택해주세요.");
        return;
    }
    
    if(confirm(selectedIds.length + "명을 '" + status + "' 처리하시겠습니까?")) {
        let completedCount = 0;
        
        // 현재 Controller가 개별 업데이트만 지원하므로 반복문으로 처리하거나,
        // 필요 시 Controller에 리스트 처리 로직을 추가해야 합니다.
        selectedIds.forEach(function(appId) {
            $.ajax({
                url: '<c:url value="/job/updateAppStatus"/>',
                type: 'POST',
                data: { appId: appId, appStep: status },
                success: function(response) {
                    completedCount++;
                    if(completedCount === selectedIds.length) {
                        alert("처리가 완료되었습니다.");
                        location.reload();
                    }
                }
            });
        });
    }
}
function filterByStatus(status, element) {
    // 1. 탭 활성화 디자인 변경 (active 클래스 이동)
    $('.status-tab').removeClass('active');
    $(element).addClass('active');

    // 2. 테이블 행 필터링
    if (status === 'all') {
        $('.applicant-table tbody tr').show(); // 전체보기
    } else {
        $('.applicant-table tbody tr').each(function() {
            // 현재 행의 select 박스에서 선택된 텍스트 값을 가져옴
            const currentStatus = $(this).find('.status-select').val();
            
            if (currentStatus === status) {
                $(this).show(); // 상태가 일치하면 보임
            } else {
                $(this).hide(); // 일치하지 않으면 숨김
            }
        });
    }
    
    // (선택사항) 필터링 후 결과가 0명일 때 처리하고 싶다면 여기에 로직 추가 가능
}

function resetFilter() {
    // 1. 입력창 및 선택박스 초기화
    $('#searchInput').val('');
    $('.filter-bar select').prop('selectedIndex', 0);

    // 2. 탭 활성화 상태를 '전체'로 변경
    $('.status-tab').removeClass('active');
    $('.status-tab').first().addClass('active');

    // 3. 모든 테이블 행 보이기
    $('.applicant-table tbody tr').show();

    // 4. (중요) 상단 카운트 숫자를 JSP에서 계산된 원래 값으로 복구
    // 만약 필터링 중에 숫자를 실시간으로 바꿨다면, 
    // 페이지를 처음 로딩했을 때의 초기 변수값($ {waitCount} 등)이 표시되도록 유지해야 합니다.
    // 현재 구조에서는 location.reload()를 쓰는 것이 가장 확실하게 서버 데이터와 숫자를 맞추는 방법입니다.
    
    // 만약 새로고침 없이 숫자를 맞추고 싶다면 아래 한 줄만 추가하세요.
    location.reload(); 
}

$(function() {
    // 검색창에서 키를 입력할 때마다 실시간 필터링
    $('#searchInput').on('keyup', function() {
        var value = $(this).val().toLowerCase();
        
        $(".applicant-table tbody tr").filter(function() {
            // 이름이 포함된 칸(세 번째 td)의 텍스트를 검사
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });
});
</script>

</html>