<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>

	<main class="container mt-4">
		
            <h2 class="mb-4">회원정보</h2>
		    <div class="row">
		        <div class="col border-end">
		        	<!-- 왼쪽 영역 -->
		        	<div class="row g-0">
						<table class="table mt-3">
						    <tr>
						        <th>아이디</th>
						        <td>${com.id}</td>
						    </tr>
						    <tr>
						        <th>회사명</th>
						        <td>${com.name}</td>
						    </tr>
						    <tr>
						        <th>사업자등록번호</th>
						        <td>${com.phone}</td>
						    </tr>
						    <tr>
						        <th>대표자명</th>
						        <td>${com.name}</td>
						    </tr>
						    <tr>
						        <th>전화번호</th>
						        <td>${com.phone}</td>
						    </tr>
						    <tr>
						        <th>이메일</th>
						        <td>${com.email}</td>
						    </tr>
						    <tr>
						        <th>회사 주소</th>
						        <td></td>
						    </tr>
						    <tr>
						        <th>담당자명</th>
						        <td></td>
						    </tr>
						    <tr>
						        <th>가입일자</th>
						        <td>${com.joinedAt}</td>
						    </tr>
						    <tr>
						        <th>상태</th>
						        <td>${com.status}</td>
						    </tr>
						    <tr>
						        <th>신고횟수</th>
						        <td></td>
						    </tr>
						</table>
			    	</div>
			    	<div class="text-end mt-2">
			    		<c:choose>
			    			<c:when test="${com.status eq 'ACTIVE'}">
							    <button type="button" id="block" class="btn btn-danger" onclick="block(${com.id})">
							    차단</button>
			    			</c:when>
			    			<c:otherwise>
							    <button type="button" id="active" class="btn btn-danger">차단 해제</button>
			    			</c:otherwise>
			    		
			    		</c:choose>
					</div>
		        </div>
		        <div class="col">
		        	<!-- 오른쪽 영역 -->
		        	<ul class="nav nav-tabs" id="comContentsTab" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link ${activeTab eq 'jobPosting' ? 'active' : ''}" 
							        id="jobPosting-tab" 
							        data-bs-toggle="tab" 
							        data-bs-target="#jobPosting" 
							        type="button" role="tab">채용 공고</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link ${activeTab eq 'qna' ? 'active' : ''}" 
							        id="qna-tab" 
							        data-bs-toggle="tab" 
							        data-bs-target="#qna" 
							        type="button" role="tab">1:1 문의글</button>
						</li>
					</ul>
		        	
		        	<div class="row">
		        		<div class="tab-content mt-3" id="memberDetailTabContent">
							<!-- 채용공고(추가예정) -->
							<div class="tab-pane fade ${activeTab eq 'jobPosting' ? 'show active' : ''}" 
							     id="jobPosting" role="tabpanel" aria-labelledby="jobPosting-tab">
								<div class="table-responsive">
									<table class="table table-hover table-bordered align-middle text-center">
										<thead class="table-light">
											<tr>
												<th>No</th>
												<th>제목</th>
												<th>모집분야</th>
												<th>접수기한</th>
												<th>등록일자</th>
												<th>상태</th>
											</tr>
										</thead>
							 			<tbody>
											<c:forEach var="job" varStatus="status" items="${jobPostList}">
												<tr class="clickable-row" onclick="location.href='info?id=${job.id}'">
													<td>${status.count}</td>
													<td>${job.title}</td>
													<td>${job.field}</td>
													<td>${job.receive}</td>
													<td>${job.createdAt}</td>
													<td>${job.status}</td>
												</tr>
											</c:forEach>
										</tbody>
					
									</table>
								</div>
							</div>
							
							<!-- 1:1 문의글 -->
							<div class="tab-pane fade ${activeTab eq 'qna' ? 'show active' : ''}" 
							     id="qna" role="tabpanel" aria-labelledby="qna-tab">
								<div class="table-responsive">
									<table class="table table-hover table-bordered align-middle text-center">
										<thead class="table-light">
											<tr>
												<th>No</th>
												<th>제목</th>
												<th>작성일자</th>
												<th>상태</th>
											</tr>
										</thead>
							 			<tbody>
											<c:forEach var="qna" varStatus="status" items="${qnaList}">
												<tr class="clickable-row" onclick="location.href='info?id=${qna.id}'">
													<td>${status.count}</td>
													<td>${qna.title}</td>
													<td>${qna.createdAt}</td>
													<td>${qna.status}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							
						</div>
		        	</div>
		        </div>
		    </div>

		
	</main>
	
	<script type="text/javascript">
		function block(id) {
			if(document.getElementById("block")) {
				if(confirm("차단하시겠습니까?")) {
					document.getElementById("block").innerText = "차단 해제";
				}
			} else {
				if(confirm("차단 해제하시겠습니까?")) {
					document.getElementById("active").innerText = "차단";
				}
			}
			
			location.href="<c:url value="/admin/block" />" + "?id=" + id;
			
		}
		
		
	</script>
	
</body>
</html>