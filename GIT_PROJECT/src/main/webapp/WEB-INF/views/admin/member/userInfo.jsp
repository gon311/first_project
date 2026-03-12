<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>

	<main class="container mt-4 pt-3 mb-5 pb-5">

		<h2 class="mb-4 fw-bold">회원 정보</h2>
		
		<div class="row g-4">

			<!-- 좌측 기본 정보 영역 -->
			<div class="col-lg-5 border-end d-flex align-items-start">

				<div class="w-100">
					<div class="card shadow-sm border-0">
						<div class="card-header bg-white border-bottom">
							<h5 class="mb-0 fw-bold">기본 정보</h5>
						</div>
						<div class="card-body px-4 py-4">
							<dl class="row mb-0">
								<dt class="col-4 text-secondary py-2">아이디</dt>
								<dd class="col-8 py-2">${user.userId}</dd>

								<dt class="col-4 text-secondary py-2">이름</dt>
								<dd class="col-8 py-2">${user.userName}</dd>

								<dt class="col-4 text-secondary py-2">전화번호</dt>
								<dd class="col-8 py-2">${user.phone}</dd>

								<dt class="col-4 text-secondary py-2">이메일</dt>
								<dd class="col-8 py-2">${user.email}</dd>

								<dt class="col-4 text-secondary py-2">생년월일</dt>
								<dd class="col-8 py-2">${user.birthDate}</dd>

								<dt class="col-4 text-secondary py-2">성별</dt>
								<dd class="col-8 py-2">${user.gender}</dd>

								<dt class="col-4 text-secondary py-2">국적</dt>
								<dd class="col-8 py-2">${user.country}</dd>

								<dt class="col-4 text-secondary py-2">보유 이용권</dt>
								<dd class="col-8 py-2">${user.productName}</dd>

								<dt class="col-4 text-secondary py-2">가입일자</dt>
								<dd class="col-8 py-2">
									<fmt:parseDate var="joinDate" value="${user.joinedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" />
                           			<fmt:formatDate value="${joinDate}" pattern="yyyy년 MM월 dd일 HH:mm"/>
								</dd>
								
								<c:if test="${user.status eq '탈퇴'}">
									<dt class="col-4 text-secondary py-2">탈퇴일자</dt>
									<dd class="col-8 py-2">
                               			<fmt:parseDate var="withdrawDate" value="${user.withdrawnAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" />
                               			<fmt:formatDate value="${withdrawDate}" pattern="yyyy년 MM월 dd일 HH:mm"/>
									</dd>
								</c:if>

								<dt class="col-4 text-secondary py-2">상태</dt>
								<dd class="col-8 py-2">${user.status}</dd>

								<dt class="col-4 text-secondary py-2">신고횟수</dt>
								<dd class="col-8 py-2">${user.reportReceivedCount}</dd>
							</dl>

							<div class="text-end mt-4">
								<c:if test="${user.status eq '활성'}">
									<button type="button" id="block" class="btn btn-danger btn-sm" onclick="block(${user.userId})">
										차단
									</button>
								</c:if>
								<c:if test="${user.status eq '차단'}">
									<button type="button" id="active" class="btn btn-outline-danger btn-sm" onclick="block(${user.userId})">
										차단 해제
									</button>
								</c:if>
							
							</div>

						</div>
					</div>
				</div>

			</div>

			<!-- 우측 탭 + 목록 영역 -->
			<div class="col-lg-7">
			
				<div class="card shadow-sm border-0">

					<div class="card-body">

						<ul class="nav nav-tabs" id="userContentsTab" role="tablist">
							<li class="nav-item" role="presentation">
								<button class="nav-link ${activeTab eq 'free' ? 'active' : ''}" 
								        id="free-tab" 
								        data-bs-toggle="tab" 
								        data-bs-target="#free" 
								        type="button" role="tab">자유게시판</button>
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
											<tr class="clickable-row" onclick="location.href='<c:url value="admin/contents/boardDetail?postId=${free.postId}" />'">
												<td>${status.count}</td>
												<td>${free.title}</td>
												<td>
													<fmt:parseDate var="createdAt" value="${free.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" />
	                           						<fmt:formatDate value="${createdAt}" pattern="yyyy년 MM월 dd일"/>
												</td>
												<td>
													<c:choose>
														<c:when test="${free.status eq 'ACTIVE'}">
															게시중
														</c:when>
														<c:otherwise>
															삭제
														</c:otherwise>
													</c:choose>
												</td>
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
												<tr class="clickable-row" onclick="location.href='<c:url value="admin/contents/QnADetail?qnaId=${qna.qnaId}" />'">
													<td>${status.count}</td>
													<td>${qna.qnaTitle}</td>
													<td>
		                           						<fmt:formatDate value="${qna.regDate}" pattern="yyyy년 MM월 dd일"/>
													</td>
													<td>
														<c:choose>
															<c:when test="${qna.reStatus eq 'pending'}">
																답변전
															</c:when>
															<c:otherwise>
																답변완료
															</c:otherwise>
														</c:choose>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							
							<!-- 작성한 댓글 -->
							<div class="tab-pane fade ${activeTab eq 'comment' ? 'show active' : ''}" 
							     id="comment" role="tabpanel" aria-labelledby="qna-tab">
								<div class="table-responsive">
									<table class="table table-hover table-bordered align-middle text-center">
										<thead class="table-light">
											<tr>
												<th>No</th>
												<th>글제목</th>
												<th>댓글내용</th>
												<th>작성일자</th>
												<th>상태</th>
											</tr>
										</thead>
							 			<tbody>
											<c:forEach var="comment" varStatus="status" items="${commentList}">
												<tr class="clickable-row" onclick="location.href='<c:url value="admin/contents/boardDetail?postId=${comment.postId}" />'">
													<td>${status.count}</td>
													<td>${comment.title}</td>
													<td>${comment.content}</td>
													<td>
		                           						<fmt:formatDate value="${comment.regDate}" pattern="yyyy년 MM월 dd일"/>
													</td>
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

		</div>
		
		<!-- 하단 중앙 목록 버튼 -->
		<div class="text-center mt-5">
			<a href="<c:url value="/admin/users" />" class="btn btn-outline-dark px-4">
				목록으로
			</a>
		</div>

	</main>

	<script type="text/javascript">
		function block(userId) {
			if(document.getElementById("block")) {
				if(confirm("차단하시겠습니까?")) {
					document.getElementById("block").innerText = "차단 해제";
					location.href="<c:url value='/admin/users/block' />" + "?userId=" + userId;
				}
			} else {
				if(confirm("차단 해제하시겠습니까?")) {
					document.getElementById("active").innerText = "차단";
					location.href="<c:url value='/admin/users/unblock' />" + "?userId=" + userId;
				}
			}


		}
		
	</script>

</body>
</html>