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

			<!-- 왼쪽 : 회원 정보 -->
			<div class="col-lg-5">

				<div class="card shadow-sm border-0 h-100">

					<div class="card-header bg-white border-bottom">
						<h5 class="mb-0 fw-bold">기본 정보</h5>
					</div>

					<div class="card-body px-4 py-4">

						<dl class="row mb-0">

							<dt class="col-4 text-secondary py-2">아이디</dt>
							<dd class="col-8 py-2">${com.id}</dd>

							<dt class="col-4 text-secondary py-2">회사명</dt>
							<dd class="col-8 py-2">${com.name}</dd>

							<dt class="col-4 text-secondary py-2">사업자번호</dt>
							<dd class="col-8 py-2">${com.phone}</dd>

							<dt class="col-4 text-secondary py-2">대표자명</dt>
							<dd class="col-8 py-2">${com.name}</dd>

							<dt class="col-4 text-secondary py-2">전화번호</dt>
							<dd class="col-8 py-2">${com.phone}</dd>

							<dt class="col-4 text-secondary py-2">이메일</dt>
							<dd class="col-8 py-2">${com.email}</dd>

							<dt class="col-4 text-secondary py-2">회사 주소</dt>
							<dd class="col-8 py-2">-</dd>

							<dt class="col-4 text-secondary py-2">담당자명</dt>
							<dd class="col-8 py-2">-</dd>

							<dt class="col-4 text-secondary py-2">가입일자</dt>
							<dd class="col-8 py-2">
								<fmt:parseDate var="joinDate" value="${com.joinedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" />
								<fmt:formatDate value="${joinDate}" pattern="yyyy년 MM월 dd일 HH시 mm분"/>
							</dd>

							<dt class="col-4 text-secondary py-2">상태</dt>
							<dd class="col-8 py-2">${com.status}</dd>

							<dt class="col-4 text-secondary py-2">신고횟수</dt>
							<dd class="col-8 py-2">0</dd>

						</dl>

						<div class="text-end mt-4">
							<c:choose>
								<c:when test="${com.status eq 'ACTIVE'}">
									<button type="button"
											class="btn btn-danger btn-sm"
											onclick="block(${com.id})">
										차단
									</button>
								</c:when>
								<c:otherwise>
									<button type="button"
											class="btn btn-outline-danger btn-sm"
											onclick="block(${com.id})">
										차단 해제
									</button>
								</c:otherwise>
							</c:choose>
						</div>

					</div>

				</div>

			</div>

			<!-- 오른쪽 영역 -->
			<div class="col-lg-7">

				<div class="card shadow-sm border-0">

					<div class="card-body">

						<ul class="nav nav-tabs" id="comContentsTab" role="tablist">
							<li class="nav-item" role="presentation">
								<button class="nav-link ${activeTab eq 'jobPosting' ? 'active' : ''}"
								        id="jobPosting-tab"
								        data-bs-toggle="tab"
								        data-bs-target="#jobPosting"
								        type="button" role="tab">
									채용 공고
								</button>
							</li>
							<li class="nav-item" role="presentation">
								<button class="nav-link ${activeTab eq 'qna' ? 'active' : ''}"
								        id="qna-tab"
								        data-bs-toggle="tab"
								        data-bs-target="#qna"
								        type="button" role="tab">
									1:1 문의글
								</button>
							</li>
						</ul>

						<div class="tab-content mt-4" id="memberDetailTabContent">

							<!-- 채용공고 -->
							<div class="tab-pane fade ${activeTab eq 'jobPosting' ? 'show active' : ''}"
							     id="jobPosting" role="tabpanel">

								<div class="table-responsive">
									<table class="table table-hover align-middle text-center">
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
												<tr onclick="location.href='info?id=${job.id}'"
												    style="cursor:pointer;">
													<td>${status.count}</td>
													<td>${job.title}</td>
													<td>${job.field}</td>
													<td>${job.receive}</td>
													<td>${job.createdAt}</td>
													<td>
														<span class="badge bg-secondary">
															${job.status}
														</span>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>

							</div>

							<!-- 1:1 문의글 -->
							<div class="tab-pane fade ${activeTab eq 'qna' ? 'show active' : ''}"
							     id="qna" role="tabpanel">

								<div class="table-responsive">
									<table class="table table-hover align-middle text-center">
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
												<tr onclick="location.href='info?id=${qna.id}'"
												    style="cursor:pointer;">
													<td>${status.count}</td>
													<td>${qna.title}</td>
													<td>${qna.createdAt}</td>
													<td>
														<span class="badge bg-secondary">
															${qna.status}
														</span>
													</td>
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
			<a href="<c:url value="/admin/coms" />" class="btn btn-outline-dark px-4">
				목록으로
			</a>
		</div>

	</main>

	<script>
		function block(id) {
			if(confirm("상태를 변경하시겠습니까?")) {
				location.href = "<c:url value='/admin/block' />?id=" + id;
			}
		}
	</script>

</body>
</html>