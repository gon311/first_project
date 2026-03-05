<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<title>공지사항 상세정보 조회</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<main class="container-fluid mt-4">
	<div class="card shadow-sm p-5">
    <div class="border-bottom pb-3 mb-4">
        <h2 class="fw-bold">${noticeDTO.noticeTitle}</h2> 
       	<div class="text-muted small">
            <span>작성일:<fmt:formatDate value="${noticeDTO.regDate}" pattern="yyyy-MM-dd"/></span> |
            <c:if test="${not empty noticeDTO.updateDate}" >
            	<span>수정일: <fmt:formatDate value="${noticeDTO.updateDate}" pattern="yyyy-MM-dd"/></span> |
            </c:if>
            <span class="ms-3"> 조회수: ${noticeDTO.readcount}</span> |
            <span class="ms-3">
            대상: <c:if test="${noticeDTO.userType == 'all' }">전체</c:if>
                  <c:if test="${noticeDTO.userType == 'user' }">구직자</c:if>
 	              <c:if test="${noticeDTO.userType == 'com' }">기업회원</c:if>
            </span>
        </div>
    </div>
    <div>
    ${noticeDTO.noticeContent } 
    </div>
    <div class="text-center mt-5">
    <a href="<c:url value='/admin/contents/notice' />" class="btn btn-secondary">목록으로</a>
    <button class="btn btn-primary" onclick="location.href='noticeUpdate?noticeId=${noticeDTO.noticeId}'">수정하기</button>
    
    <button type="button" class="btn btn-danger" onclick="confirmDelete(${noticeDTO.noticeId})">삭제하기</button>
	</div>

	<script type="text/javascript">
	function confirmDelete(noticeId) {
		console.log("삭제할 id : " + noticeId)
	    if (confirm("정말로 이 공지사항을 삭제하시겠습니까?\n삭제된 데이터는 복구할 수 없습니다.")) {
	        // 확인을 누르면 삭제 요청 페이지로 이동
	        location.href = "noticeDelete?noticeId=" + noticeId;
	    }
	}
	</script>
</div>
	</main>
</body>
</html>