<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<div class="applicant-table-wrap">
    <table class="applicant-table">
        <thead>
            <tr>
                <th style="width: 50px; text-align: center;"><input type="checkbox" id="checkAll"></th>
                <th style="width: 80px;">번호</th>
                <th>지원자 정보</th>
                <th>지원 공고</th>
                <th>지원일</th>
                <th style="width: 150px;">전형 상태</th>
                <th style="width: 80px; text-align: center;">관심</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty applicantList}">
                    <tr>
                        <td colspan="7" style="text-align:center; padding: 50px;">지원자가 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <%-- 지원자 리스트 반복 출력 부분 --%>
					<c:forEach var="app" items="${applicantList}">
					    <tr>
					        <td style="text-align: center;"><input type="checkbox" name="appCheck" value="${app.appId}"></td>
					        <td style="color: #888;">${app.appId}</td>
					        <td>
					            <span class="name-tag">${app.userName}</span>
					            <div class="doc-links">
					                <a href="/resume/detail?resumeId=${app.resumeId}" class="doc-btn">이력서</a>
					            </div>
					        </td>
					        <td style="font-size: 14px;">${app.postingTitle}</td>
					        <td style="font-size: 14px; color: #666;">${app.formattedApplyDate}</td>
					        <td>
					            <select class="status-select" onchange="changeStatus(${app.appId}, this.value)">
					                <option value="서류대기" ${app.appStep == '서류대기' ? 'selected' : ''}>서류대기</option>
					                <option value="면접진행" ${app.appStep == '면접진행' ? 'selected' : ''}>면접진행</option>
					                <option value="최종합격" ${app.appStep == '최종합격' ? 'selected' : ''}>최종합격</option>
					            </select>
					        </td>
					        <td style="text-align: center;">
					            <i class="fa-solid fa-star star-icon ${app.isFavorite == 'Y' ? 'active' : ''}" 
					               onclick="toggleFavorite(${app.appId}, '${app.isFavorite}')"></i>
					        </td>
					    </tr>
					</c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
</body>
<script>
function updateStatus(appId, newStep) {
    if(!confirm("전형 상태를 변경하시겠습니까?")) return;
    
    $.ajax({
        url: '/job/updateAppStatus',
        type: 'POST',
        data: { appId: appId, appStep: newStep },
        success: function(res) {
            alert("상태가 변경되었습니다.");
        },
        error: function() { alert("처리에 실패했습니다."); }
    });
}
</script>
</html>