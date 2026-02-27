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

	<main class="container mt-4">
		<h2 class="mb-5">결제 관리</h2>
		<div class="container w-75 my-4 mx-3">
		    <h5 class="card-title mb-3">검색</h5>
		    <div class="card">
		        <div class="card-body">
		            <form action="<c:url value='/admin/payments' />" 
		                  name="searchForm" 
		                  method="get" 
		                  class="row g-4 align-items-center">
		
		                <div class="row my-3">
		                    <!-- 기간별 검색 -->
		                    <div class="col-md-4">
		                        <label class="form-label fw-bold mb-2">기간별</label>
		                        <div class="border rounded p-2">
		                            <div class="d-flex flex-column gap-2">
		                                <!-- 시작일자 -->
		                                <div class="d-flex flex-column ms-2">
		                                    <label class="form-label small mb-1 text-secondary">시작일자</label>
		                                    <input type="date" class="form-control form-control-sm" name="startDate">
		                                </div>
		                                <!-- 종료일자 -->
		                                <div class="d-flex flex-column ms-2">
		                                    <label class="form-label small mb-1 text-secondary">종료일자</label>
		                                    <input type="date" class="form-control form-control-sm" name="endDate">
		                                </div>
		                            </div>
		                        </div>
		                    </div>
		
		                    <!-- 결제명 -->
		                    <div class="col-md-3">
		                        <label class="form-label fw-bold mb-2">결제명</label>
		                        <input type="text" class="form-control form-control-sm" name="keyword" placeholder="결제명을 입력하세요">
		                    </div>
		
		                    <!-- 구분 -->
		                    <div class="col-md-2">
		                        <label class="form-label fw-bold mb-2">구분</label>
		                        <select class="form-select form-select-sm" name="userType">
		                            <option value="" selected>전체</option>
		                            <option value="P">구직자</option>
		                            <option value="C">기업</option>
		                        </select>
		                    </div>
		                    
		                    <!-- 상태 -->
		                    <div class="col-md-2">
		                        <label class="form-label fw-bold mb-2">상태</label>
		                        <select class="form-select form-select-sm" name="payStatus">
		                            <option value="" selected>전체</option>
		                            <option value="paid">결제완료</option>
		                            <option value="ready">입금대기</option>
		                            <option value="cancelled">결제취소</option>
		                        </select>
		                    </div>
		
		                </div>
		
		                <!-- 검색 버튼 -->
		                <div class="col-12 d-flex justify-content-end mt-3">
		                    <button type="submit" class="btn btn-primary btn-sm px-3">검색</button>
		                </div>
		
		            </form>
		        </div>
		    </div>
		</div>
	
		<!-- 정렬 -->
        <div class="d-flex justify-content-end mt-3 mb-2">
            <form action="<c:url value='/admin/payments' />" method="get" id="paymentSortForm">
                <input type="hidden" name="activeTab" value="withdraw"/>
                <input type="hidden" name="keyword" value="${param.keyword}">
                <input type="hidden" name="startDate" value="${param.startDate}">
                <input type="hidden" name="endDate" value="${param.endDate}">
                <input type="hidden" name="userType" value="${param.userType}">
                <input type="hidden" name="payStatus" value="${param.payStatus}">

                <select class="form-select w-auto" name="sort" id="paymentSort">
                    <option value="">전체</option>
                    <option value="new" ${param.sort eq 'new' ? 'selected' : ''}>최근 일자순</option>
                    <option value="old" ${param.sort eq 'old' ? 'selected' : ''}>오래된 순</option>
                </select>
            </form>
        </div>
	
		<!-- 탭 콘텐츠 -->
		<div class="tab-content mt-3" id="memberTabContent">
			<!-- 전체 회원 -->
			<table class="table table-hover table-bordered align-middle text-center">
				<thead class="table-light">
					<tr>
						<th>No</th>
						<th>결제번호</th>
						<th>결제일자</th>
						<th>결제명</th>
						<th>아이디</th>
						<th>구분</th>
						<th>결제금액</th>
						<th>결제수단</th>
						<th>상태</th>
					</tr>
				</thead>
	 			<tbody>
					<c:forEach var="pay" varStatus="status" items="${payList}">
						<tr class="clickable-row" onclick="location.href='payments/info?payId=${pay.payId}'">
							<td>${status.count}</td>
							<td>${pay.payId}</td>
							<td>
								<fmt:parseDate var="payDate" value="${pay.payDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" />
								<fmt:formatDate value="${payDate}" pattern="yyyy년 MM월 dd일 HH:mm:ss" />
							</td>
							<td>${pay.productName}</td>
							<td>${pay.userId}</td>
							<td>${pay.userType}</td>
							<td>${pay.payPrice}원</td>
							<td>${pay.payMethod}</td>
							<td>
								<c:choose>
									<c:when test="${pay.payStatus eq 'paid'}">
										결제완료
									</c:when>
									<c:when test="${pay.payStatus eq 'ready'}">
										입금대기
									</c:when>
									<c:otherwise>
										결제취소
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
	
			</table>
			
			<!-- 페이징(구현예정) -->
	        <div class="d-flex flex-column align-items-center mt-5">
	            <nav aria-label="Page navigation">
	                <ul class="pagination pagination-sm m-0">
	                    <li class="page-item"><a class="page-link" href="#">&lt;</a></li>
	                    <c:forEach begin="1" end="5" var="i">
	                        <li class="page-item ${i == 12 ? 'active' : ''}"><a class="page-link" href="#">${i}</a></li>
	                    </c:forEach>
	                    <li class="page-item"><a class="page-link" href="#">&gt;</a></li>
	                </ul>
	            </nav>
			</div>
			
		</div>
		
	</main>
	
	<script>
		// 결제 내역 목록 정렬
		document.getElementById("paymentSort").addEventListener("change", function() {
			document.getElementById("paymentSortForm").submit();
		})
	
	</script>
	
</body>
</html>