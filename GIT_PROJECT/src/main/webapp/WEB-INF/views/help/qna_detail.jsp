<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
    <title>내 문의 상세 보기</title>
    <style>
        .qna-detail-card { max-width: 900px; margin: 50px auto; }
        .qna-header { background-color: #f8f9fa; border-bottom: 2px solid #333; }
        .qna-content { min-height: 200px; padding: 20px; white-space: pre-wrap; }
        .answer-box { background-color: #f0f7ff; border-left: 5px solid #007bff; }
        .status-badge { font-size: 0.9em; padding: 5px 10px; border-radius: 20px; }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/inc/header.jspf" %>

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
            <a href="<c:url value='/help/list' />" class="btn btn-outline-secondary">목록으로 돌아가기</a>
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