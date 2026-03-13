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

	<main class="container-fluid px-5 mt-4">
	    <h2 class="mb-5 fw-bold">기업회원 관리</h2>
	
		<!-- 탭 메뉴 -->
	    <ul class="nav nav-tabs mt-5" id="memberTab" role="tablist">
	        <li class="nav-item">
	            <button class="nav-link ${activeTab eq 'all' ? 'active' : ''}"
	                    data-bs-toggle="tab"
	                    data-bs-target="#all"
	                    type="button">전체 회원</button>
	        </li>
	        <li class="nav-item">
	            <button class="nav-link ${activeTab eq 'withdraw' ? 'active' : ''}"
	                    data-bs-toggle="tab"
	                    data-bs-target="#withdraw"
	                    type="button">탈퇴 회원</button>
	        </li>
	    </ul>
	
		<!-- 탭 컨텐츠 -->
	    <div class="tab-content mt-3">
			
			<!-- 전체 회원 -->
	        <div class="tab-pane fade ${activeTab eq 'all' ? 'show active' : ''}"
	             id="all">
	
	            <!-- 전체 회원 검색 -->
	            <div class="container w-50 my-4 mx-3">
                    <h5 class="card-title mb-3">검색</h5>
	                <div class="card">
	                    <div class="card-body">
	
	                        <form action="<c:url value='/admin/coms' />"
	                              method="get"
	                              class="row g-3 align-items-center">
	
	                            <!-- 탭 유지용 -->
	                            <input type="hidden" name="activeTab" value="all"/>
	
	                            <div class="col-md-5">
	                                <label class="form-label fw-bold mb-2">기업명</label>
	                                <input type="search" class="form-control"
	                                       name="keyword"
	                                       placeholder="기업명을 입력하세요"
	                                       value="${param.keyword}">
	                            </div>
	
	                            <div class="col-md-3">
	                                <label class="form-label fw-bold mb-2">구분</label>
	                                <select class="form-select" name="type" >
	                                    <option value="" <c:if test="${param.type eq ''}">selected</c:if>>전체</option>
	                                    <option value="basic" <c:if test="${param.type eq 'basic'}">selected</c:if>>기본</option>
	                                    <option value="P-C1" <c:if test="${param.type eq 'P-C1'}">selected</c:if>>일반</option>
	                                    <option value="P-C2" <c:if test="${param.type eq 'P-C2'}">selected</c:if>>프리미엄</option>
	                                </select>
	                            </div>
	
	                            <div class="col-md-3">
	                                <label class="form-label fw-bold mb-2">상태</label>
	                                <select class="form-select" name="status">
	                                    <option value="" <c:if test="${param.status eq ''}">selected</c:if>>전체</option>
	                                    <option value="active" <c:if test="${param.status eq 'active'}">selected</c:if>>활성</option>
	                                    <option value="suspended" <c:if test="${param.status eq 'suspended'}">selected</c:if>>차단</option>
	                                    <option value="withdrawn" <c:if test="${param.status eq 'withdrawn'}">selected</c:if>>탈퇴</option>
	                                </select>
	                            </div>
	
	                            <div class="col-12 d-flex justify-content-end mt-2">
				                    <button type="submit" class="btn btn-primary">검색</button>
				                </div>
	                        </form>
	                    </div>
	                </div>
	            </div>
	            
	            <!-- 정렬 -->
	            <div class="d-flex justify-content-end mt-3 mb-2">
	                <form action="<c:url value='/admin/coms' />" method="get" id="comSortForm">
	                    <input type="hidden" name="activeTab" value="all"/>
	                    <input type="hidden" name="keyword" value="${param.keyword}">
	                    <input type="hidden" name="type" value="${param.type}">
	                    <input type="hidden" name="status" value="${param.status}">
	
	                    <select class="form-select w-auto" name="sort" id="comSort">
	                        <option value="">전체</option>
	                        <option value="new" ${param.sort eq 'new' ? 'selected' : ''}>최근 일자순</option>
	                        <option value="old" ${param.sort eq 'old' ? 'selected' : ''}>오래된 순</option>
	                        <option value="abc" ${param.sort eq 'abc' ? 'selected' : ''}>가나다 순</option>
	                    </select>
	                </form>
	            </div>
	
	            <!-- 전체 회원 테이블 -->
	            <div class="table-responsive">
	                <table class="table table-hover table-bordered align-middle text-center">
	                    <thead class="table-light">
	                        <tr>
	                            <th>No</th>
	                            <th>아이디</th>
	                            <th>기업명</th>
	                            <th>E-Mail</th>
	                            <th>사업자번호</th>
	                            <th>전화번호</th>
	                            <th>구분</th>
	                            <th>상태</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<c:if test="${empty comList}">
								<tr>
									<td colspan="8" class="text-center">
										게시물이 존재하지 않습니다.
									</td>
								</tr>
							</c:if>
	                        <c:forEach var="com" varStatus="status" items="${comList}">
	                            <tr class="clickable-row"
	                                onclick="location.href='coms/info?userId=${com.userId}'">
	                                <td>${status.count}</td>
	                                <td>${com.userId}</td>
	                                <td>${com.companyName}</td>
	                                <td>${com.email}</td>
	                                <td>${com.bizRegNo}</td>
	                                <td>${com.phone}</td>
	                                <td>${com.userType}</td>
	                                <td>${com.status}</td>
	                            </tr>
	                        </c:forEach>
	                    </tbody>
	                </table>
	                
	                <!-- 전체회원 페이징 -->
			        <c:if test="${not empty pageInfo and not empty pageInfo.maxPage and pageInfo.maxPage > 0}">
					    <div class="d-flex justify-content-center mt-5 mb-4">
					        <nav aria-label="Company Management Page navigation">
					            <ul class="pagination pagination-sm mb-0">
					                
					                <li class="page-item ${pageInfo.pageNum eq 1 ? 'disabled' : ''}">
					                    <a class="page-link" href="<c:url value='/admin/coms?pageNum=${pageInfo.pageNum - 1}&activeTab=${activeTab}' />" aria-label="Previous">
					                        <span aria-hidden="true">&laquo;</span>
					                    </a>
					                </li>
					
					                <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
					                    <%-- 현재 페이지인 경우 active 클래스 추가 --%>
					                    <li class="page-item ${i eq pageInfo.pageNum ? 'active' : ''}">
					                        <c:choose>
					                            <c:when test="${i eq pageInfo.pageNum}">
					                                <span class="page-link fw-bold">${i}</span>
					                            </c:when>
					                            <c:otherwise>
					                                <a class="page-link" href="<c:url value='/admin/coms?pageNum=${i}&activeTab=${activeTab}' />">${i}</a>
					                            </c:otherwise>
					                        </c:choose>
					                    </li>
					                </c:forEach>
					
					                <li class="page-item ${pageInfo.pageNum eq pageInfo.maxPage ? 'disabled' : ''}">
					                    <a class="page-link" href="<c:url value='/admin/coms?pageNum=${pageInfo.pageNum + 1}&activeTab=${activeTab}' />" aria-label="Next">
					                        <span aria-hidden="true">&raquo;</span>
					                    </a>
					                </li>
					                
					            </ul>
					        </nav>
					    </div>
					</c:if>
	                
	            </div>
	        </div>
	
	
	        <!-- 탈퇴 회원 -->
	        <div class="tab-pane fade ${activeTab eq 'withdraw' ? 'show active' : ''}"
	             id="withdraw">
	
	            <!-- 탈퇴 회원 검색 -->
	            <div class="container w-50 my-4 mx-3">
	                    <h5 class="card-title mb-3">검색</h5>
	                    <div class="card">
	                        <div class="card-body">
	                            <form action="<c:url value='/admin/coms' />" method="get" class="row g-3 align-items-center">
	                            
	                            <!-- 탭 유지용 -->
	                            <input type="hidden" name="activeTab" value="withdraw"/>
	                            
	                            <div class="row my-3">
		                            <div class="col-md-6">
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
		                                
		                                <div class="col-md-5">
		                                    <label class="form-label fw-bold mb-2">기업명</label>
		                                    <input type="text" class="form-control" name="keyword" placeholder="기업명을 입력하세요">
		                                </div>
		
		
		                                <div class="col-12 d-flex justify-content-end mt-2">
						                    <button type="submit" class="btn btn-primary">검색</button>
						                </div>
					                </div>
	                            </form>
	                        </div>
	                    </div>
	                </div>
	            
	            <!-- 정렬 -->
	            <div class="d-flex justify-content-end mt-3 mb-2">
	                <form action="<c:url value='/admin/coms' />" method="get" id="withdrawSortForm">
	                    <input type="hidden" name="activeTab" value="withdraw"/>
	                    <input type="hidden" name="keyword" value="${param.keyword}">
	                    <input type="hidden" name="startDate" value="${param.startDate}">
	                    <input type="hidden" name="endDate" value="${param.endDate}">
	
	                    <select class="form-select w-auto" name="sort" id="withdrawSort">
	                        <option value="">전체</option>
	                        <option value="new" ${param.sort eq 'new' ? 'selected' : ''}>최근 일자순</option>
	                        <option value="old" ${param.sort eq 'old' ? 'selected' : ''}>오래된 순</option>
	                        <option value="abc" ${param.sort eq 'abc' ? 'selected' : ''}>가나다 순</option>
	                    </select>
	                </form>
	            </div>
	
	            <!-- 탈퇴 회원 테이블 -->
	            <div class="table-responsive">
	                <table class="table table-bordered align-middle text-center">
	                    <thead class="table-light">
	                        <tr>
	                            <th>No</th>
	                            <th>아이디</th>
	                            <th>기업명</th>
	                            <th>E-Mail</th>
	                            <th>사업자번호</th>
	                            <th>탈퇴일자</th>
	                            <th>회원삭제</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<c:if test="${empty comWithdrawList}">
								<tr>
									<td colspan="7" class="text-center">
										게시물이 존재하지 않습니다.
									</td>
								</tr>
							</c:if>
	                        <c:forEach var="withdraw" varStatus="status" items="${comWithdrawList}">
	                        	<!-- 탈퇴 일자(일 계산) -->
                               	<fmt:parseDate var="withdrawDate" value="${withdraw.withdrawnAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" />
                               	<fmt:parseNumber var="wDate" value="${withdrawDate.time / (1000*60*60*24)}" integerOnly="true" />
                                    	
                               	<!-- 현재 날짜(일 계산) -->
                               	<fmt:parseDate var="today" value="${withdraw.today}" pattern="yyyy-MM-dd'T'HH:mm:ss" />
                               	<fmt:parseNumber var="tDay" value="${today.time / (1000*60*60*24)}" integerOnly="true" />
                               	
	                            <tr>
	                                <td>${status.count}</td>
	                                <td>${withdraw.userId}</td>
	                                <td>${withdraw.userName}</td>
	                                <td>${withdraw.email}</td>
	                                <td>${withdraw.phone}</td>
	                                <td>
                                    	${withdraw.strWithdrawnAt}
                                    </td>
                                    <td>
                                   	  <!-- 탈퇴일로부터 3년이 지난 경우 삭제 버튼 활성화 -->
                                    	<c:choose>
                                    		<c:when test="${(tDay - wDate) < 1095}">
		                                        <button class="btn btn-danger" onclick="deleteUser(${withdraw.userId})">삭제</button>
                                    		</c:when>
                                    		<c:otherwise>
		                                        <button class="btn btn-danger" disabled>삭제</button>
                                    		</c:otherwise>
                                    	</c:choose>
                                    </td>
	                            </tr>
	                        </c:forEach>
	                    </tbody>
	                </table>
	                
	                <!-- 탈퇴회원 페이징 -->
			        <c:if test="${not empty withdrawPageInfo and not empty withdrawPageInfo.maxPage and withdrawPageInfo.maxPage > 0}">
					    <div class="d-flex justify-content-center mt-5 mb-4">
					        <nav aria-label="Withdrawal Management Page navigation">
					            <ul class="pagination pagination-sm mb-0">
					                
					                <li class="page-item ${withdrawPageInfo.pageNum eq 1 ? 'disabled' : ''}">
					                    <a class="page-link" href="<c:url value='/admin/coms?pageNum=${withdrawPageInfo.pageNum - 1}&activeTab=${activeTab}' />" aria-label="Previous">
					                        <span aria-hidden="true">&laquo;</span>
					                    </a>
					                </li>
					
					                <c:forEach var="i" begin="${withdrawPageInfo.startPage}" end="${withdrawPageInfo.endPage}">
					                    <li class="page-item ${i eq withdrawPageInfo.pageNum ? 'active' : ''}">
					                        <c:choose>
					                            <c:when test="${i eq withdrawPageInfo.pageNum}">
					                                <span class="page-link fw-bold">${i}</span>
					                            </c:when>
					                            <c:otherwise>
					                                <a class="page-link" href="<c:url value='/admin/coms?pageNum=${i}&activeTab=${activeTab}' />">${i}</a>
					                            </c:otherwise>
					                        </c:choose>
					                    </li>
					                </c:forEach>
					
					                <li class="page-item ${withdrawPageInfo.pageNum eq withdrawPageInfo.maxPage ? 'disabled' : ''}">
					                    <a class="page-link" href="<c:url value='/admin/coms?pageNum=${withdrawPageInfo.pageNum + 1}&activeTab=${activeTab}' />" aria-label="Next">
					                        <span aria-hidden="true">&raquo;</span>
					                    </a>
					                </li>
					                
					            </ul>
					        </nav>
					    </div>
					</c:if>
	                
	            </div>
	
	        </div>
	    </div>
	</main>
	
	<script>
		// 전체회원 정렬
		document.getElementById("comSort").addEventListener("change", function() {
			document.getElementById("comSortForm").submit();
		})
		
		// 탈퇴회원 정렬
		document.getElementById("withdrawSort").addEventListener("change", function() {
			document.getElementById("withdrawSortForm").submit();
		})
	</script>
	
</body>
</html>