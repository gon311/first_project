<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>

	<main class="container-fluid px-5 mt-4">
		<h2 class="mb-5 fw-bold">제출 공고 관리</h2>
		<div class="container w-50 my-4 mx-3 mt-5">
		    <h5 class="card-title mb-3">검색</h5>
		    <div class="card">
		        <div class="card-body">
		            <form action="<c:url value='/admin/submits' />" 
		                  name="searchForm" 
		                  method="get" 
		                  class="row g-4 align-items-center">
		
		                <div class="row my-3">
		                
		                    <!-- 기간별 검색 -->
		                    <div class="col-md-5">
		                        <label class="form-label fw-bold mb-2">기간별</label>
		                        <div class="border rounded p-2"> 
		                            <div class="d-flex flex-column gap-2">
		                                <!-- 시작일자 -->
		                                <div class="d-flex flex-column ms-2">
		                                    <label class="form-label small mb-1 text-secondary">시작일자</label>
		                                    <input type="date" class="form-control form-control-sm" name="startDate" value="${param.startDate}">
		                                </div>
		                                <!-- 종료일자 -->
		                                <div class="d-flex flex-column ms-2">
		                                    <label class="form-label small mb-1 text-secondary">종료일자</label>
		                                    <input type="date" class="form-control form-control-sm" name="endDate" value="${param.endDate}">
		                                </div>
		                            </div>
		                        </div>
		                    </div>
		
		                    <!-- 기업명 -->
		                    <div class="col-md-4">
		                        <label class="form-label fw-bold mb-2">기업명</label>
		                        <input type="text" class="form-control form-control-sm" name="keyword" placeholder="기업명을 입력하세요" value="${param.keyword}">
		                    </div>
		
		                    <!-- 상태 -->
		                    <div class="col-md-3">
		                        <label class="form-label fw-bold mb-2">상태</label>
		                        <select class="form-select form-select-sm" name="submitStatus">
		                            <option value="" <c:if test="${param.submitStatus eq ''}">selected</c:if>>전체</option>
		                            <option value="1" <c:if test="${param.submitStatus eq '1'}">selected</c:if>>검토전</option>
		                            <option value="2" <c:if test="${param.submitStatus eq '2'}">selected</c:if>>승인</option>
		                            <option value="3" <c:if test="${param.submitStatus eq '3'}">selected</c:if>>보류</option>
		                        </select>
		                    </div>
		                </div>
		
		                <!-- 검색 버튼 -->
		                <div class="col-12 d-flex justify-content-end mt-5">
		                    <button type="submit" class="btn btn-primary btn-sm px-3">검색</button>
		                </div>
		
		            </form>
		        </div>
		    </div>
		</div>
	
		<!-- 정렬 -->
        <div class="d-flex justify-content-end mt-3 mb-2">
            <form action="<c:url value='/admin/submits' />" method="get" id="submitSortForm">
                <input type="hidden" name="activeTab" value="withdraw"/>
                <input type="hidden" name="keyword" value="${param.keyword}">
                <input type="hidden" name="startDate" value="${param.startDate}">
                <input type="hidden" name="endDate" value="${param.endDate}">
                <input type="hidden" name="submitStatus" value="${param.submitStatus}">

                <select class="form-select w-auto" name="sort" id="submitSort">
                    <option value="">전체</option>
                    <option value="new" ${param.sort eq 'new' ? 'selected' : ''}>최근 일자순</option>
                    <option value="old" ${param.sort eq 'old' ? 'selected' : ''}>오래된 순</option>
                </select>
            </form>
        </div>
	
		<div class="tab-content mt-3" id="memberTabContent">
			<table class="table table-hover table-bordered align-middle text-center">
				<thead class="table-light">
					<tr>
						<th style="width:5%;">No</th>
		                <th style="width:10%;">공고번호</th>
		                <th style="width:35%;">제목</th> 
		                <th style="width:25%;">제출일자</th>
		                <th style="width:15%;">기업명</th>
		                <th style="width:10%;">상태</th>
					</tr>
				</thead>
	 			<tbody>
	 				<c:if test="${empty submitList}">
						<tr>
							<td colspan="6" class="text-center">
								게시물이 존재하지 않습니다.
							</td>
						</tr>
					</c:if>
					<c:forEach var="submit" varStatus="status" items="${submitList}">
						<tr class="clickable-row" onclick="location.href='submits/info?jobId=${submit.jobId}&userId=${submit.compId}'">
							<td>${status.count}</td>
							<td>${submit.jobId}</td>
							<td>${submit.title}</td>
							<td>
								${submit.strRegDate}
							</td>
							<td>${submit.companyName}</td>
							<td>
								<c:choose>
									<c:when test="${submit.postCheck == 1}">
										검토전
									</c:when>
									<c:when test="${submit.postCheck == 2}">
										승인
									</c:when>
									<c:when test="${submit.postCheck == 3}">
										보류
									</c:when>
									<c:otherwise>
										삭제됨
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>

			</table>
			
			<!-- 페이징 -->
	        <c:if test="${not empty pageInfo and not empty pageInfo.maxPage and pageInfo.maxPage > 0}">
			    <div class="d-flex justify-content-center mt-5 mb-4">
			        <nav aria-label="Page navigation">
			            <ul class="pagination pagination-sm mb-0">
			                
			                <li class="page-item ${pageInfo.pageNum eq 1 ? 'disabled' : ''}">
			                    <a class="page-link" href="<c:url value='/admin/submits?pageNum=${pageInfo.pageNum - 1}&activeTab=${activeTab}' />" aria-label="Previous">
			                        <span aria-hidden="true">&laquo;</span>
			                    </a>
			                </li>
			
			                <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
			                    <li class="page-item ${i eq pageInfo.pageNum ? 'active' : ''}">
			                        <c:choose>
			                            <c:when test="${i eq pageInfo.pageNum}">
			                                <span class="page-link">${i}</span>
			                            </c:when>
			                            <c:otherwise>
			                                <a class="page-link" href="<c:url value='/admin/submits?pageNum=${i}&activeTab=${activeTab}' />">${i}</a>
			                            </c:otherwise>
			                        </c:choose>
			                    </li>
			                </c:forEach>
			
			                <li class="page-item ${pageInfo.pageNum eq pageInfo.maxPage ? 'disabled' : ''}">
			                    <a class="page-link" href="<c:url value='/admin/submits?pageNum=${pageInfo.pageNum + 1}&activeTab=${activeTab}' />" aria-label="Next">
			                        <span aria-hidden="true">&raquo;</span>
			                    </a>
			                </li>
			                
			            </ul>
			        </nav>
			    </div>
			</c:if>
			
		</div>
	
	</main>
	
	<script>
		// 제출된 공고 목록 정렬
		document.getElementById("submitSort").addEventListener("change", function() {
			document.getElementById("submitSortForm").submit();
		})
	
	</script>
	
</body>
</html>