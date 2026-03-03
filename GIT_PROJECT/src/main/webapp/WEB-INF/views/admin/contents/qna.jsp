<%@page import="lombok.EqualsAndHashCode.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>1:1 문의글 관리</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
	<style>
    /* 1. 활성화된 탭의 테두리를 강조하고 아래쪽 선을 지움 */
    .nav-tabs .nav-link.active {
        border-color: #dee2e6 #dee2e6 #fff !important; /* 위, 왼쪽, 오른쪽 선 유지 / 아래 선 흰색 */
        background-color: #fff !important;
        margin-bottom: -1px; /* 카드 테두리와 겹치게 아래로 1px 내림 */
        position: relative;
        z-index: 2; /* 카드 선보다 위로 올라오게 함 */
    }

    /* 2. 탭 버튼 기본 스타일 (이미지처럼 글자색 조정) */
    .nav-tabs .nav-link {
        color: #0d6efd; /* 비활성 탭은 파란색 링크 느낌 */
        border: 1px solid transparent;
    }

    /* 3. 첫 번째 탭 클릭 시 카드의 둥근 모서리와 겹치지 않게 보정 */
    .nav-tabs {
        position: relative;
        z-index: 1;
    }
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<div class="container-fluid mt-4">
		<div class="card shadow-sm p-3">
			<div class="container w-75 my-4 mx-auto">
			<h4 class = "fw-bold"> 1:1문의글 관리</h4>
			<br>
			<!-- body영역  -->

			<!-- 상태별 구분 탭  -->
				<ul class="nav nav-tabs" id="qnaTab" role="tablist">
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${reStatus eq 'pending' ? 'active fw-bold' : ''}"  
				                onclick="location.href='?reStatus=pending'">미답변</button>
				    </li>
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${reStatus eq 'completed' ? 'active fw-bold' : ''}"  
				                onclick="location.href='?reStatus=completed'">답변 완료</button>
				    </li>
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${reStatus eq 'all' or empty reStatus ? 'active fw-bold' : ''}"  
				                onclick="location.href='?reStatus=all'">전체 문의글</button>
				    </li>
				</ul>
				
				<div class="card shadow-sm" style="border-top-left-radius: 0; border: 1px solid #dee2e6;">
        			<div class="card-body p-4">

						<div class="d-flex justify-content-end mb-3">
							<select class="form-select w-auto" id="sort" onchange="selectSort()">
								<option value="all">전체</option>
								<option value="new">최근 일자순</option>
								<option value="old">오래된 순</option>
								<option value="abc">가나다 순</option>
							</select>
						</div>

						<div class="table-responsive">
                			<table class="table table-hover text-center align-middle">
						            <thead class="table-light">
						                <tr>
						                    <th style ="width:8%;">번호</th>
						                    <th style ="width:50%;">제목</th>
						                    <th>작성자</th>
						                    <th>작성일</th>
						                    <th>상태</th>
						                </tr>
						            </thead>
						            <tbody>
						                <c:choose>
						                    <c:when test="${empty qnaList}">
						                        <tr><td colspan="5" class="py-5 text-muted">문의글이 없습니다.</td></tr>
						                    </c:when>
						                    <c:otherwise>
						                        <c:forEach var="qna" items="${qnaList}">
						                            <tr>
						                                <td>${qna.qnaId}</td>
						                                <td><a href="<c:url value='/admin/contents/QnADetail?qnaId=${qna.qnaId}'/>">${qna.qnaTitle }</a></td>
						                                <td>${qna.writerId}</td>
						                                <td>${qna.regDate}</td>
						                                <td>
						                                    <c:if test="${qna.reStatus eq 'pending'}"><span class="badge bg-warning">미답변</span></c:if>
						                                    <c:if test="${qna.reStatus eq 'completed'}"><span class="badge bg-success">답변완료</span></c:if>
						                                </td>
						                            </tr>
						                        </c:forEach>
						                    </c:otherwise>
						                </c:choose>
						            </tbody>
						        </table>
					        </div>
				       </div>
						        
						        
						        
						</div>
			</div>
	
			
			
			
		<!-- 페이지네이션 구현 -->	
		<div class="d-flex flex-column align-items-center mt-3">
		           <nav aria-label="Page navigation">
		               <ul class="pagination pagination-sm m-0">
		                   <li class="page-item"><a class="page-link" href="#">&lt;</a></li>
		                   <c:forEach begin="1" end="5" var="i">
		                       <li class="page-item ${i == 12 ? 'active' : ''}"><a class="page-link" href="#">${i}</a></li>
		                   </c:forEach>
		                   <li class="page-item"><a class="page-link" href="#">&gt;</a></li>
		               </ul>
		           </nav>
			</div>
		</div>   <!-- card showdow  끝 -->
	</div>
</body>
</html>