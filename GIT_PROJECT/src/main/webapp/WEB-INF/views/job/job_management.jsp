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
	    <div class="status-tab active">
	        <span class="label">전체</span>
	        <span class="count">${applicantList.size()}</span>
	    </div>
	    <div class="status-tab"><span class="label">서류대기</span><span class="count">${waitCount}</span></div>
	    <div class="status-tab"><span class="label">서류통과</span><span class="count">${passCount}</span></div>
	    <div class="status-tab"><span class="label">면접진행</span><span class="count">${interviewCount}</span></div>
	    <div class="status-tab"><span class="label">최종합격</span><span class="count">${finalCount}</span></div>
	    <div class="status-tab"><span class="label">불합격</span><span class="count">${failCount}</span></div>
	</section>

    <section class="filter-bar">
        <div class="filter-row">
            <input type="text" placeholder="지원자명/키워드 검색" style="width: 280px;">
            <select><option>경력전체</option></select>
            <select><option>학력전체</option></select>
            <button class="btn-secondary"><i class="fa-solid fa-rotate-left"></i> 초기화</button>
        </div>
        <div class="filter-row" style="margin-bottom: 0; border-top: 1px solid #f5f5f5; padding-top: 20px; align-items: center;">
            <span style="font-size: 14px; color: #555; margin-right: 15px;">선택한 인원을</span>
            <button class="btn-action">합격 통보</button>
            <button class="btn-action" style="background: #ff5252;">불합격 통보</button>
            <button class="btn-secondary">면접요청</button>
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
			    
			    <c:if test="${empty applicantList}">
			        <tr>
			            <td colspan="7" style="text-align: center; padding: 50px 0; color: #999;">
			                조회된 지원자가 없습니다.
			            </td>
			        </tr>
			    </c:if>
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
// 1. 전형 상태 업데이트 (SELECT 박스 변경 시)
function changeStatus(appId, newStep) {
    if(!confirm("전형 상태를 '" + newStep + "'(으)로 변경하시겠습니까?")) return;

    $.ajax({
        url: '<c:url value="/job/updateAppStatus"/>',
        type: 'POST',
        data: { appId: appId, appStep: newStep },
        success: function(response) {
            if(response === "success") {
                alert("상태가 변경되었습니다.");
            } else {
                alert("상태 변경에 실패했습니다.");
            }
        },
        error: function() { alert("서버 통신 오류가 발생했습니다."); }
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
                $(element).toggleClass('active');
            } else {
                alert("처리에 실패했습니다.");
            }
        }
    });
}
</script>

</html>