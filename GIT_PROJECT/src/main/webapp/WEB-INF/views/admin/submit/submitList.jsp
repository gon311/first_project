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
		<h2 class="mb-5">제출 공고 관리</h2>
		<div class="container w-50 my-4 mx-3">
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
		
		                    <!-- 기업명 -->
		                    <div class="col-md-4">
		                        <label class="form-label fw-bold mb-2">기업명</label>
		                        <input type="text" class="form-control form-control-sm" name="keyword" placeholder="기업명을 입력하세요">
		                    </div>
		
		                    <!-- 구분 -->
		                    <div class="col-md-3">
		                        <label class="form-label fw-bold mb-2">구분</label>
		                        <select class="form-select form-select-sm" name="user_type">
		                            <option value="" selected>전체</option>
		                            <option value="1">검토전</option>
		                            <option value="2">승인</option>
		                            <option value="3">보류</option>
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
		        <option value="">전체</option>
		        <option value="new" ${param.sort == 'new' ? 'selected' : ''}>최근 일자순</option>
		        <option value="old" ${param.sort == 'old' ? 'selected' : ''}>오래된 순</option>
		        <option value="abc" ${param.sort == 'abc' ? 'selected' : ''}>가나다 순</option>
		    </select>
		</div>
	
		<!-- 탭 콘텐츠 -->
		<div class="tab-content mt-3" id="memberTabContent">
			<!-- 전체 회원 -->
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
					<c:forEach var="submit" varStatus="status" items="${submitList}">
						<tr class="clickable-row" onclick="location.href='submits/info?jobId=${submit.jobId}&userId=${submit.compId}'">
							<td>${status.count}</td>
							<td>${submit.jobId}</td>
							<td>${submit.title}</td>
							<td>${submit.regDate}</td>
							<td>${submit.compId}</td>
							<td>${submit.postCheck}</td>
						</tr>
					</c:forEach>
				</tbody>

			</table>
		</div>
	
	</main>
</body>
</html>