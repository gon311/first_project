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
						        <td>${user.id}</td>
						    </tr>
						    <tr>
						        <th>이름</th>
						        <td>${user.name}</td>
						    </tr>
						    <tr>
						        <th>전화번호</th>
						        <td>${user.phone}</td>
						    </tr>
						    <tr>
						        <th>이메일</th>
						        <td>${user.email}</td>
						    </tr>
						    <tr>
						        <th>생년월일</th>
						        <td></td>
						    </tr>
						    <tr>
						        <th>성별</th>
						        <td></td>
						    </tr>
						    <tr>
						        <th>국적</th>
						        <td></td>
						    </tr>
						    <tr>
						        <th>가입일자</th>
						        <td>${user.joinedAt}</td>
						    </tr>
						    <tr>
						        <th>상태</th>
						        <td>${user.status}</td>
						    </tr>
						    <tr>
						        <th>신고횟수</th>
						        <td></td>
						    </tr>
						</table>
			    	</div>
			    	<div class="text-end mt-2">
			    		<c:choose>
			    			<c:when test="${user.status eq 'ACTIVE'}">
							    <button type="button" id="block" class="btn btn-danger" onclick="block(${user.id})">
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
		        	<ul class="nav nav-tabs" id="userContentsTab" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link ${activeTab eq 'free' ? 'active' : ''}" 
							        id="free-tab" 
							        data-bs-toggle="tab" 
							        data-bs-target="#free" 
							        type="button" role="tab">자유게시판</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link ${activeTab eq 'review' ? 'active' : ''}" 
							        id="review-tab" 
							        data-bs-toggle="tab" 
							        data-bs-target="#review" 
							        type="button" role="tab">면접 후기</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link ${activeTab eq 'qna' ? 'active' : ''}" 
							        id="qna-tab" 
							        data-bs-toggle="tab" 
							        data-bs-target="#qna" 
							        type="button" role="tab">1:1 문의글</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link ${activeTab eq 'comment' ? 'active' : ''}" 
							        id="comment-tab" 
							        data-bs-toggle="tab" 
							        data-bs-target="#comment" 
							        type="button" role="tab">작성한 댓글</button>
						</li>
					</ul>
		        	
		        	<div class="row">
		        		<div class="tab-content mt-3" id="memberDetailTabContent">
							<!-- 자유게시판 -->
							<div class="tab-pane fade ${activeTab eq 'free' ? 'show active' : ''}" 
							     id="free" role="tabpanel" aria-labelledby="free-tab">
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
											<c:forEach var="free" varStatus="status" items="${freeList}">
												<tr class="clickable-row" onclick="location.href='info?id=${free.id}'">
													<td>${status.count}</td>
													<td>${free.title}</td>
													<td>${free.createdAt}</td>
													<td>${free.status}</td>
												</tr>
											</c:forEach>
										</tbody>
					
									</table>
								</div>
							</div>
					
							<!-- 면접리뷰 -->
							<div class="tab-pane fade ${activeTab eq 'review' ? 'show active' : ''}" 
							     id="review" role="tabpanel" aria-labelledby="review-tab">
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
											<c:forEach var="review" varStatus="status" items="${reviewList}">
												<tr class="clickable-row" onclick="location.href='info?id=${review.id}'">
													<td>${status.count}</td>
													<td>${review.title}</td>
													<td>${review.createdAt}</td>
													<td>${review.status}</td>
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
							
							<!-- 작성한 댓글 -->
							<div class="tab-pane fade ${activeTab eq 'comment' ? 'show active' : ''}" 
							     id="comment" role="tabpanel" aria-labelledby="comment-tab">
								<div class="table-responsive">
									<table class="table table-hover table-bordered align-middle text-center">
										<thead class="table-light">
											<tr>
												<th>No</th>
												<th>카테고리</th>
												<th>제목</th>
												<th>내용</th>
												<th>작성일자</th>
												<th>상태</th>
											</tr>
										</thead>
							 			<tbody>
											<c:forEach var="comment" varStatus="status" items="${commentList}">
												<tr class="clickable-row" onclick="location.href='info?id=${comment.id}'">
													<td>${status.count}</td>
													<td>${comment.category}</td>
													<td>${comment.title}</td>
													<td>${comment.content}</td>
													<td>${comment.createdAt}</td>
													<td>${comment.status}</td>
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