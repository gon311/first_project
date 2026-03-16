<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>자유게시판 관리</title>
    <%-- 기존 헤더 설정 포함 (Bootstrap 포함된 곳) --%>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
    <%-- 공통 헤더 --%>
    <%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
    <div class="container-fluid mt-4">
    <div class="card shadow-sm p-3">
        <div class="container w-100 my-4 mx-0"> <h4 class="fw-bold mb-4">자유게시판 관리</h4>

            <%-- 검색 영역: 카드의 너비를 전체의 약 60% 정도로 제한 (col-xl-7) --%>
            <div class="card shadow-sm border col-xl-7 col-lg-9 col-md-11">
                <div class="card-body p-3">
                    <h6 class="fw-bold mb-3 text-secondary"><i class="bi bi-search"></i> 검색 필터</h6>
                    
                    <div class="card bg-light border-0">
                        <div class="card-body p-2">
                            <form action="<c:url value='/admin/contents/Board' />" name="searchForm" method="get">
                                <div class="row g-2">
                                    
                                    <div class="col-md-3">
                                        <label class="form-label small fw-bold mb-1">작성일 (시작)</label>
                                        <input type="date" class="form-control form-control-sm" name="startDate" value="${param.startDate}">
                                    </div>
                                    
                                    <div class="col-md-5">
                                        <label class="form-label small fw-bold mb-1">작성자명</label>
                                        <input type="text" class="form-control form-control-sm" name="authorMemberId" 
                                               placeholder="아이디 입력" value="${param.userId}">
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <label class="form-label small fw-bold mb-1">게시 상태</label>
                                        <select class="form-select form-select-sm" name="status">
                                            <option value="ACTIVE" ${param.status == 'ACTIVE' ? 'selected' : ''}>게시</option>
                                            <option value="DELETED" ${param.status == 'DELETED' ? 'selected' : ''}>삭제</option>
                                        </select>
                                    </div>

                                    <div class="col-md-3">
                                        <label class="form-label small fw-bold mb-1">작성일 (종료)</label>
                                        <input type="date" class="form-control form-control-sm" name="endDate" value="${param.endDate}">
                                    </div>

                                    <div class="col-md-3"></div>

                                    <div class="col-md-6">
                                        <label class="form-label small fw-bold mb-1">글 제목</label>
                                        <div class="input-group input-group-sm">
                                            <input type="text" name="keyword" class="form-control" 
                                                   placeholder="검색어를 입력하세요" value="${param.keyword}">
                                            <button class="btn btn-primary px-3" type="submit">검색</button>
                                        </div>
                                    </div>
                                    
                                </div> </form>
                        </div>
                    </div>
                </div>
            </div> </div>
                            <%-- 게시글 테이블 --%>
                <div class="table-responsive">
                    <table class="table table-hover text-center align-middle">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 10%;">글 번호</th>
                                <th style="width: 40%;">글 제목</th>
                                <th style="width: 15%;">작성자명</th>
                                <th style="width: 20%;">작성일자</th>
                                <th style="width: 10%">게시상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty boardList}">
                                    <tr>
                                        <td colspan="5" class="py-5 text-muted text-center">게시글이 존재하지 않습니다.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="board" items="${boardList}">
                                        <%-- 클릭 시 상세 페이지로 이동 --%>
                                        <tr onclick="location.href='${pageContext.request.contextPath}/admin/contents/boardDetail?postId=${board.postId}'" style="cursor:pointer;">
                                            <td>${board.postId}</td>
                                            <td class="text-start ps-4 text-center">${board.title}</td>
                                            <td>${board.authorMemberId}</td>
                                            <td class="text-muted small">
												${board.createDate}
                                            </td>
                                            <td>
                                            <c:if test= '${board.status == "ACTIVE"}'>
                                            	게시
                                            </c:if>
                                            <c:if test = '${board.status == "DELETED"}'>
                                            	삭제
                                            </c:if>
                                           	</td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div> <%-- table-responsive 끝 --%>
                
          <%-- 페이지네이션 --%>      
    	 		 <c:if test="${not empty pageInfoDTO and not empty pageInfoDTO.maxPage and pageInfoDTO.maxPage > 0}">
				        <div class="d-flex flex-column align-items-center mt-5">
				            <nav aria-label="Page navigation">
				                <ul class="pagination pagination-sm m-0">
				                    <li class="page-item <c:if test="${pageInfoDTO.pageNum eq 1}">disabled</c:if>">
				                    	<a class="page-link" href="<c:url value="/admin/contents/Board?pageNum=${pageInfoDTO.pageNum - 1}" />">&lt;</a>
				                    </li>
				                    
				                    <c:forEach var="i" begin="${pageInfoDTO.startPage}" end="${pageInfoDTO.endPage}">
										<c:choose>
											<c:when test="${i eq pageInfoDTO.pageNum}">
												<a class="page-link">${i}</a>
											</c:when>
											<c:otherwise>
												<a class="page-link" href="<c:url value="/admin/contents/Board?pageNum=${i}" />">${i}</a>
											</c:otherwise>
										</c:choose>
				                    </c:forEach>
				                    
				                    <li class="page-item <c:if test="${pageInfoDTO.pageNum eq pageInfoDTO.maxPage}">disabled</c:if>">
				                    	<a class="page-link" href="<c:url value="/admin/contents/Board?pageNum=${pageInfoDTO.pageNum + 1}" />">&gt;</a>
				                    </li>
				                </ul>
				            </nav>
						</div>
					</c:if>            
    </div>
    
</div>

</body>
</html>