<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
    <link href="<c:url value="/resources/css/help/qnaDetail.css" />" rel="stylesheet" type="text/css">
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
    <main class="container qna-detail-card">
        <div class="card shadow-sm">
            <%-- 질문 헤더 --%>
            <div class="card-header qna-header p-4">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <c:choose>
				        <c:when test="${qna.qnaCategory eq 'job'}">입사지원 관련</c:when>
				        <c:when test="${qna.qnaCategory eq 'account'}">계정/인증 관련</c:when>
				        <c:when test="${qna.qnaCategory eq 'error'}">오류 신고</c:when>
				        <c:when test="${qna.qnaCategory eq 'etc'}">기타 문의</c:when>
				        <c:otherwise>${qna.qnaCategory}</c:otherwise> <%-- 혹시 모를 예외 대비 --%>
				    </c:choose>
                    <span class="text-muted small">문의 번호: ${qna.qnaId}</span>
                </div>
                <h3 class="fw-bold">${qna.qnaTitle}</h3>
                <div class="text-muted small">
                    작성일: <fmt:formatDate value="${qna.regDate}" pattern="yyyy-MM-dd HH:mm" />
                    <span class="ms-3">상태: 
                        <c:choose>
                            <c:when test='${qna.reStatus eq "pending"}'>
                                <span class="text-warning fw-bold">답변 대기중</span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-success fw-bold">답변 완료</span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>

            <%-- 질문 내용 --%>
			<div class="card-body qna-content">
			    ${qna.qnaContent}
			    
			    <c:if test="${not empty qnaFiles}">
			        <div class="file-attachments">
			            <div class="file-preview-container">
			                <c:forEach var="file" items="${qnaFiles}">
							    <c:choose>
							        <%-- 이미지인 경우 --%>
							        <c:when test="${file.fileExt.contains('image') || file.fileExt.contains('jpg') || file.fileExt.contains('png')}">
							            <div class="file-item img-item"> <img src="<c:url value='/help/image/view'/>?filePath=${file.filePath}&storedName=${file.storedName}"
							            									alt="${file.originName}">
							            									
							            </div>
							        </c:when>
							        <%-- 일반 파일인 경우 --%>
							        <c:otherwise>
									    <a href="<c:url value='/help/download'/>?filePath=${file.filePath}&storedName=${file.storedName}"
									       download="${file.originName}" 
									       class="file-download-link">
									        <i class="fa-regular fa-file-lines"></i>
									        <span>${file.originName}</span> </a>
									</c:otherwise>
							    </c:choose>
							</c:forEach>
			            </div>
			        </div>
			    </c:if>
			    
			    <c:if test="${empty qnaFiles}">
			        <%-- 이미지가 없을 때는 굳이 영역을 보여주지 않거나 아주 작게 표시 --%>
			        <p class="text-muted mt-3" style="font-size:0.8em;">첨부파일 없음</p>
			    </c:if>
			</div>

            <%-- 답변 영역 (답변이 있을 때만 출력) --%>
            <c:if test="${qna.reStatus eq 'completed'}">
                <div class="card-footer answer-box p-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold m-0 text-primary">
                            <i class="fa-solid fa-comment-dots me-2"></i>담당자 답변
                        </h5>
                        <small class="text-muted">답변일: <fmt:formatDate value="${qna.reDate}" pattern="yyyy-MM-dd HH:mm" /></small>
                    </div>
                    <div class="p-3 bg-white border rounded" style="white-space: pre-wrap;">${qna.reContent}</div>
                </div>
            </c:if>

            <c:if test="${qna.reStatus eq 'pending'}">
                <div class="card-footer text-center p-4 bg-light">
                    <p class="m-0 text-muted">문의하신 내용을 담당자가 확인하고 있습니다. 조금만 기다려주세요!</p>
                </div>
            </c:if>
        </div>

        <div class="text-center mt-4 mb-5">
            <a href="<c:url value='/my/qna' />" class="btn btn-outline-secondary">목록으로 돌아가기</a>
            <c:if test="${qna.reStatus eq 'pending'}">
                <button class="btn btn-danger ms-2" onclick="confirmDelete(${qna.qnaId})">문의 취소</button>
            </c:if>
        </div>
    </main>

    <%@ include file="/WEB-INF/views/inc/footer.jspf" %>

	<script type="text/javascript">
	function confirmDelete(qnaId) {
	    if (confirm("정말로 이 문의를 취소(삭제)하시겠습니까?")) {
	        // 컨트롤러의 /help/delete 주소로 이동
	        location.href = "<c:url value='/help/delete' />?qnaId=" + qnaId;
	    }
	}
	</script>
</body>
</html>