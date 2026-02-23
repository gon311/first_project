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
		            <form action="<c:url value='/admin/submits' />" 
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
		                        <select class="form-select form-select-sm" name="user_type">
		                            <option value="" selected>전체</option>
		                            <option value="1">검토전</option>
		                            <option value="2">승인</option>
		                            <option value="3">보류</option>
		                        </select>
		                    </div>
		
		                    <!-- 상태 -->
		                    <div class="col-md-2">
		                        <label class="form-label fw-bold mb-2">상태</label>
		                        <select class="form-select form-select-sm" name="status">
		                            <option value="" selected>전체</option>
		                            <option value="active">활성</option>
		                            <option value="inactive">비활성</option>
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
	
		<!-- 정렬 Select Box -->
		<div class="d-flex justify-content-end mt-3">
			<select class="form-select w-auto" id="sort" onchange="">
				<option value="all">전체</option>
				<option value="new">최근 일자순</option>
				<option value="old">오래된 순</option>
				<option value="abc">가나다 순</option>
			</select>
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
							<td>${pay.payDate}</td>
							<td>${pay.productName}</td>
							<td>${pay.userId}</td>
							<td>${pay.userType}</td>
							<td>${pay.payPrice}원</td>
							<td>${pay.payMethod}</td>
							<td>${pay.payStatus}</td>
						</tr>
					</c:forEach>
				</tbody>
	
			</table>
		</div>
		
	</main>
</body>
</html>