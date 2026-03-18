<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>FAQ</title>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<c:choose>
	    <c:when test="${sessionScope.memberType == 'company'}">
	        <%@ include file="/WEB-INF/views/inc/headerCom.jspf" %>
	    </c:when>
	
	    <c:otherwise>
	        <%@ include file="/WEB-INF/views/inc/header.jspf" %>
	    </c:otherwise>
	</c:choose>
    
    <main>
	   	<div class="container-fluid mt-4">
		<div class="card shadow-sm p-3">
	    <div class="container w-75 my-4 mx-auto">
	        <div class="d-flex justify-content-between align-items-center mb-4">
	            <h4 class="fw-bold m-0">FAQ</h4>
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
	                <form action='<c:url value = "/help/faq"/>' class="d-flex justify-content-end align-items-end mb-4 gap-2">
						<div class="col-md-3">
	                        <label class="form-label fw-bold small text-muted">질문 카테고리</label>
	                        <select name="category" class="form-select form-select-sm" onchange = "this.form.submit()">
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
	                                <th style="width: 15%;">대상</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                        <c:choose>
	                        	<c:when test = "${not empty faqList }">
							    <c:forEach var="faq" items="${faqList}" varStatus="status">
							        <%-- 1. 제목 행 --%>
							        <tr class="accordion-toggle" 
							            data-bs-toggle="collapse" 
							            data-bs-target="#collapse${faq.faqId}" 
							            style="cursor: pointer;">
							            <td>${status.count}</td>
							            <td class="text-start ps-4 fw-bold">
							                <i class="bi bi-chevron-down me-2 small text-muted text-center"></i>
							                ${faq.faqTitle}
							            </td>
							            <td class="text-start ps-4 fw-bold text-center">
							                ${faq.userType == 'user' ? '개인' : '기업'}
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
							    	</c:when>
								    <c:otherwise>
								    	<tr>
				                    		<td colspan="5" class="text-center py-5 text-muted">
				                    			<i class="bi bi-exclamation-circle fs-2 d-bold mb-2"></i>
				                    			검색 결과가 없습니다.
				                    		</td>
				                    	</tr>
								    </c:otherwise>
						    	</c:choose>
							</tbody>
	                    </table>
	                </div>
	            </div>
	        </div>
	    </div>
	       	 		 <c:if test="${not empty pageInfoDTO and not empty pageInfoDTO.maxPage and pageInfoDTO.maxPage > 0}">
				        <div class="d-flex flex-column align-items-center mt-5">
				            <nav aria-label="Page navigation">
				                <ul class="pagination pagination-sm m-0">
				                    <li class="page-item <c:if test="${pageInfoDTO.pageNum eq 1}">disabled</c:if>">
				                    	<a class="page-link" href="<c:url value="/admin/contents/Board?pageNum=${pageInfoDTO.pageNum - 1}" />">&lt;</a>
				                    </li>
				                    
				                    <c:forEach var="i" begin="${pageInfoDTO.startPage}" end="${pageInfoDTO.endPage}">
										<c:choose>
											<c:when test="${i eq pageInfoDTO.pageNum}">
												<a class="page-link active">${i}</a>
											</c:when>
											<c:otherwise>
												<a class="page-link" href="<c:url value="/admin/contents/FaQ?pageNum=${i}" />">${i}</a>
											</c:otherwise>
										</c:choose>
				                    </c:forEach>
				                    
				                    <li class="page-item <c:if test="${pageInfoDTO.pageNum eq pageInfoDTO.maxPage}">disabled</c:if>">
				                    	<a class="page-link" href="<c:url value="/admin/contents/FaQ?pageNum=${pageInfoDTO.pageNum + 1}" />">&gt;</a>
				                    </li>
				                </ul>
				            </nav>
						</div>
					</c:if>   
	   
	    </div></div>
    </main>
    
    <%@ include file="/WEB-INF/views/inc/footer.jspf" %>
</body>
</html>