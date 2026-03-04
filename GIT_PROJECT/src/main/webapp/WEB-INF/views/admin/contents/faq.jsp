<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>FAQ 관리자</title>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
    <%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
    	<div class="container-fluid mt-4">
		<div class="card shadow-sm p-3">
    <div class="container w-75 my-4 mx-auto">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="fw-bold m-0">FAQ 관리</h4>
            <%-- 새 글 등록 페이지로 이동하는 버튼 --%>
            <button class="btn btn-primary" onclick="location.href='<c:url value='/admin/contents/FaqWrite' />'">새 FAQ 등록</button>
        </div>
        <%-- 카테고리 탭 (기존 유지) --%>
        <ul class="nav nav-tabs border-bottom-0">
            <li class="nav-item">
            	<button class="nav-link ${userType eq 'all' or empty userType ? 'active fw-bold': '' }"
            		onclick="location.href='?userType=all'">전체</button>
           </li>
           <li class= "nav-item">
                <button class="nav-link ${userType eq 'user' ? 'active fw-bold' : ''}" 
                        onclick="location.href='?userType=user'">구직자</button>
            </li>
            <li class="nav-item">
                <button class="nav-link ${userType eq 'com' ? 'active fw-bold' : ''}" 
                        onclick="location.href='?userType=com'">기업회원</button>
            </li>
        </ul>
		
        <div class="card shadow-sm" style="border-top-left-radius: 0; border: 1px solid #dee2e6;">
            <div class="card-body p-4">
                <%-- 검색 영역 --%>
                <form action="/admin/faq" method="get" class="d-flex justify-content-end align-items-end mb-4 gap-2">
					<div class="col-md-3">
                        <label class="form-label fw-bold small text-muted">질문 카테고리</label>
                        <select name="category" class="form-select form-select-sm">
                        	<option value="">선택</option>
			                <option value="account" ${category == 'account' ? 'selected' : ''}>계정/로그인</option>
			                <option value="service" ${category == 'service' ? 'selected' : ''}>이용문의</option>
			                <option value="error" ${category == 'error' ? 'selected' : ''}>오류보고</option>
			                <option value="etc" ${category == 'etc' ? 'selected' : ''}>기타</option>
                        </select>
                    </div>
                    <div style="width: 300px;">
                    	<label class="form-label fw-bold small text-muted mb-1">제목 검색</label>
                    	<div class="input-group">
                        	<input type="text" name="keyword" class="form-control form-control-sm" placeholder="내용을 입력하세요." value="${keyword}">
                        	<button class="btn btn-outline-secondary btn-sm" type="submit">검색</button>
                    	</div>
                    </div>
                </form>
                <div class="table-responsive">
                    <table class="table table-hover text-center align-middle">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 15%;">no</th>
                                <th style="width: 70%;">글 제목</th>
                                <th style="width: 15%;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
						    <c:forEach var="faq" items="${faqList}" varStatus="status">
						        <%-- 1. 제목 행 --%>
						        <tr class="accordion-toggle" 
						            data-bs-toggle="collapse" 
						            data-bs-target="#collapse${faq.faqId}" 
						            style="cursor: pointer;">
						            <td>${status.count}</td>
						            <td class="text-start ps-4 fw-bold">
						                <i class="bi bi-chevron-down me-2 small text-muted"></i>
						                ${faq.faqTitle}
						            </td>
						            <td>
						                <%-- 관리 버튼 (이벤트 전파 방지를 위해 stopPropagation 추가) --%>
						                <button class="btn btn-sm btn-outline-primary me-1" 
						                        onclick="event.stopPropagation(); location.href='FaqUpdate?faqId=${faq.faqId}'">수정</button>
						                <button class="btn btn-sm btn-outline-danger" 
						                        onclick="event.stopPropagation();deleteFaq(${faq.faqId})">삭제</button>
						            </td>
						        </tr>
						        
						        <%-- 2. 본문 내용 행 (아코디언 영역) --%>
						        <tr>
						            <td colspan="3" class="p-0 border-0">
						                <div id="collapse${faq.faqId}" class="accordion-collapse collapse" data-bs-parent=".table">
						                    <div class="card-body bg-light text-start p-4 border-bottom">
						                        <div class="mb-2 text-muted small">
						                            <strong>내용:</strong>
						                        </div>
						                        <div style="white-space: pre-wrap;">${faq.faqContent}</div>
						                    </div>
						                </div>
						            </td>
						        </tr>
						    </c:forEach>
						</tbody>
                    </table>
                </div>
            </div>
        </div>
    </div></div></div>
    
    <script>
    function deleteFaq(faqId) {
    	console.log("삭제요청 id :" + faqId);
        if (confirm("이 FAQ를 정말 삭제하시겠습니까?")) {
            location.href = "<c:url value='/admin/contents/faqDelete'/>?faqId=" + faqId;
        }
    }
    </script>
</body>
</html>