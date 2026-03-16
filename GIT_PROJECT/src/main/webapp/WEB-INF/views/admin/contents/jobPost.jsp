<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<title>채용공고 게시판 관리</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<main class="container-fluid mt-4">
	    <div class="card shadow-sm p-3">
			<h4 class = "fw-bold"> 채용공고 게시판 관리</h4>
		<div class="container w-50 my-4 mx-3">
		
		<!-- 검색 항목  -->
        <h5 class="card-title mb-3">검색</h5>
			<div class="card">
			    <div class="card-body">
			    	 <form action="<c:url value="/admin/contents/JobPost" />" name="searchForm" class="row g-3 align-items-center">
				        <div class="row my-3">
					        <!-- 키워드 검색 -->
					        <div class="col-md-4">
					          <label for="keyword" class="form-label">공고제목</label>
					          <input type="text" class="form-control" name="keyword" placeholder="제목을 입력하세요">
					        </div>
							<div class="col-md-4">
					    		<label for="userId" class="form-label">기업Id</label>
					    		<input type="text" class="form-control" name="userId" placeholder="아이디를 입력하세요">
					    	</div>  
					        <!-- 구분 -->
					        <div class="col-md-4">
					          <label for="postStatus" class="form-label">공고상태</label>
					          <select class="form-select" name="postStatus">
					            <option value=""  ${empty jobPostDTO.postStatus ? 'selected' : "" }>전체</option>
					            <option value="1" ${jobPostDTO.postStatus == 1 ? 'selected' : '' }>모집중</option>
					            <option value="2" ${jobPostDTO.postStatus == 2? 'selected' : '' }>마감</option>
					            <!--  0: 삭제는 데이터베이스 내에서 삭제 -->
					          </select>
					        </div>
					
					        
				        </div>

				
				        <!-- 검색 버튼 -->
				        <div class="col-12 d-flex justify-content-end mt-3">
							<button type="submit" class="btn btn-primary">검색</button>
						</div>

					</form>
				</div>
			</div> 
		</div> 
	
	
		<div class="tab-content mt-3" id="jobPostTabContent">
			<table class="table table-hover table-bordered align-middle text-center">
				<thead class="table-light">
					<tr>
						<th>No</th>
						<th>공고ID</th> 
						<th>기업 회원 ID</th>
						<th>공고 제목</th>
						<th>모집 분야</th>
						<th>접수 기한</th>
						<th>공고 상태</th>
					</tr>
				</thead>
	 			<tbody>
	 				<c:choose>
	 					<c:when test = "${not empty jobPostList }">
							<c:forEach var="jobPost" varStatus="status" items="${jobPostList}">
							<tr onclick="location.href='<c:url value='/admin/contents/JobPostDetail?jobId=${jobPost.jobId}'/>'">
								<td>${status.count }</td>
								<td>${jobPost.jobId }</td>
								<td>${jobPost.compId}</td>
								<td>${jobPost.title }</td>
								<td>${jobPost.field }</td>
								<td>
									<fmt:formatDate value="${jobPost.openDate}" pattern="yyyy-MM-dd" />
									~ <fmt:formatDate value="${jobPost.closeDate}" pattern="yyyy-MM-dd" />
								</td>
								<td><span>${jobPost.postStatus == '1' ? '모집중' : '마감' }</span></td>
							</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="7" style ="text-align: center; padding: 50px 0;">
								검색 결과가 없습니다.
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
						
				</tbody>
			</table>
			
			
			<!-- 페이지네이션 구현 -->
       	 		 <c:if test="${not empty pageInfoDTO and not empty pageInfoDTO.maxPage and pageInfoDTO.maxPage > 0}">
			        <div class="d-flex flex-column align-items-center mt-5">
			            <nav aria-label="Page navigation">
			                <ul class="pagination pagination-sm m-0">
			                    <li class="page-item <c:if test="${pageInfoDTO.pageNum eq 1}">disabled</c:if>">
			                    	<a class="page-link" href="<c:url value="/admin/contents/JobPost?pageNum=${pageInfoDTO.pageNum - 1}" />">&lt;</a>
			                    </li>
			                    
			                    <c:forEach var="i" begin="${pageInfoDTO.startPage}" end="${pageInfoDTO.endPage}">
									<c:choose>
										<c:when test="${i eq pageInfoDTO.pageNum}">
											<a class="page-link">${i}</a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="<c:url value="/admin/contents/JobPost?pageNum=${i}" />">${i}</a>
										</c:otherwise>
									</c:choose>
			                    </c:forEach>
			                    
			                    <li class="page-item <c:if test="${pageInfoDTO.pageNum eq pageInfoDTO.maxPage}">disabled</c:if>">
			                    	<a class="page-link" href="<c:url value="/admin/contents/JobPost?pageNum=${pageInfoDTO.pageNum + 1}" />">&gt;</a>
			                    </li>
			                </ul>
			            </nav>
					</div>
				</c:if>   
		</div>	
	</div>

	
	
	    
	    
	    

	</main>
</body>
</html>