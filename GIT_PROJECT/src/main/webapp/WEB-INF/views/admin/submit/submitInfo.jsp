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

	<main class="container mt-5 pt-4 mb-5 pb-5">
		
		<div class="row">

			<!-- 왼쪽 : 기업 정보 -->
			<div class="col border-end d-flex align-items-center">

				<div class="w-100">
					<h4 class="mb-4 fw-bold">기업 정보</h4>

					<div class="card border-0 shadow-sm">
						<div class="card-body px-4 py-4">

							<dl class="row mb-0">

								<dt class="col-4 text-secondary py-2">아이디</dt>
								<dd class="col-8 py-2">${com.userId}</dd>

								<dt class="col-4 text-secondary py-2">회사명</dt>
								<dd class="col-8 py-2">${com.userName}</dd>

								<dt class="col-4 text-secondary py-2">사업자등록번호</dt>
								<dd class="col-8 py-2">-</dd>

								<dt class="col-4 text-secondary py-2">대표자명</dt>
								<dd class="col-8 py-2">${com.userName}</dd>

								<dt class="col-4 text-secondary py-2">전화번호</dt>
								<dd class="col-8 py-2">${com.phone}</dd>

								<dt class="col-4 text-secondary py-2">이메일</dt>
								<dd class="col-8 py-2">${com.email}</dd>

								<dt class="col-4 text-secondary py-2">회사 주소</dt>
								<dd class="col-8 py-2">${submit.address}</dd>

								<dt class="col-4 text-secondary py-2">담당자명</dt>
								<dd class="col-8 py-2">${submit.mgrName}</dd>

								<dt class="col-4 text-secondary py-2">보유 이용권</dt>
								<dd class="col-8 py-2">-</dd>

								<dt class="col-4 text-secondary py-2">상태</dt>
								<dd class="col-8 py-2">${com.status}</dd>

							</dl>

						</div>
					</div>
				</div>

			</div>

			<!-- 오른쪽 : 공고 상세 -->
			<div class="col">

				<div class="card shadow border-0 h-100">

					<div class="card-header bg-white border-bottom">
						<div class="d-flex justify-content-between align-items-center">
							<h5 class="mb-0 fw-bold">공고 상세 검토</h5>
							<span class="badge bg-warning text-dark px-3 py-2">
								${submit.postCheck}
							</span>
						</div>
					</div>

					<div class="card-body">

						<div class="mb-4 position-relative">
						    <h4 class="fw-bold mb-1">${submit.title}</h4>
						    <small class="text-muted position-absolute bottom-0 end-0">
								제출일 : ${submit.regDate}
						    </small>
						</div>

						<div class="p-4 bg-light rounded border">

							<dl class="row mb-0">

								<dt class="col-sm-3 text-secondary">게재기간</dt>
								<dd class="col-sm-9">
									<fmt:formatDate value="${submit.openDate}" pattern="yyyy년 MM월 dd일"/> 
									~ 
									<fmt:formatDate value="${submit.closeDate}" pattern="yyyy년 MM월 dd일"/> 
								</dd>
								
								<dt class="col-sm-3 text-secondary">모집분야</dt>
								<dd class="col-sm-9">${submit.field}</dd>
								
								<dt class="col-sm-3 text-secondary">직무</dt>
								<dd class="col-sm-9">${submit.task}</dd>

								<dt class="col-sm-3 text-secondary">고용형태</dt>
								<dd class="col-sm-9">${submit.empType}</dd>
								
								<dt class="col-sm-3 text-secondary">수습기간 여부</dt>
								<dd class="col-sm-9">${submit.probation}</dd>

								<dt class="col-sm-3 text-secondary">경력</dt>
								<dd class="col-sm-9">${submit.expType}(${submit.expYear})</dd>

								<dt class="col-sm-3 text-secondary">학력</dt>
								<dd class="col-sm-9">${submit.edu}</dd>

								<dt class="col-sm-3 text-secondary">급여</dt>
								<dd class="col-sm-9">${submit.salary}</dd>
								
								<dt class="col-sm-3 text-secondary">근무지역</dt>
								<dd class="col-sm-9">${submit.address}</dd>
								
								<dt class="col-sm-3 text-secondary">재택근무</dt>
								<dd class="col-sm-9">${submit.isRemote}</dd>

								<dt class="col-sm-3 text-secondary">담당자</dt>
								<dd class="col-sm-9">${submit.mgrName}</dd>
								
								<dt class="col-sm-3 text-secondary">담당자 연락처</dt>
								<dd class="col-sm-9">${submit.mgrPhone}</dd>
								
								<dt class="col-sm-3 text-secondary">담당자 이메일</dt>
								<dd class="col-sm-9">${submit.mgrEmail}</dd>

								<dt class="col-sm-3 text-secondary">정보 공개 여부</dt>
								<dd class="col-sm-9">${submit.isPublic}</dd>

								<dt class="col-sm-3 text-secondary">접수기간</dt>
								<dd class="col-sm-9">
									<fmt:formatDate value="${submit.openDate}" pattern="yyyy/MM/dd"/> 
									~ 
									<fmt:formatDate value="${submit.closeDate}" pattern="yyyy/MM/dd"/>
								</dd>

								<dt class="col-sm-3 text-secondary">접수방법</dt>
								<dd class="col-sm-9"></dd>
								
								<dt class="col-sm-3 text-secondary">첨부파일</dt>
								<dd class="col-sm-9"></dd>	
								
								
							</dl>

						</div>

					</div>

					<div class="card-footer bg-white border-top">

						<div class="d-flex justify-content-between align-items-center flex-wrap">

							<p class="small text-muted mb-0">
								※ 승인 시 즉시 사이트에 게시됩니다.
							</p>

							<div class="mt-2 mt-md-0">
								<button class="btn btn-primary me-2">
									승인
								</button>
								<button class="btn btn-secondary me-2">
									보류
								</button>
								<button class="btn btn-danger">
									삭제
								</button>
							</div>

						</div>

					</div>

				</div>

			</div>

		</div>

		<!-- 하단 중앙 목록 버튼 -->
		<div class="text-center mt-5">
			<a href="<c:url value="/admin/submits" />" class="btn btn-outline-dark px-4">
				목록으로
			</a>
		</div>

	</main>

</body>
</html>