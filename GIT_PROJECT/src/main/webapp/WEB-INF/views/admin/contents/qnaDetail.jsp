<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<title>1:1 문의글 상세 페이지</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<main class="container-fluid mt-5">
		<div class="card shadow-sm p-4">
			 <div class= "title">
			 	<h3>${qnaDTO.qnaTitle}</h3>
			 </div>
			 글 번호 : ${qnaDTO.qnaId} | 작성자 아이디 : ${qnaDTO.writerId} | 작성일자 : <fmt:formatDate value="${qnaDTO.regDate}" pattern="yyyy년 MM월 dd일 HH:mm:ss" /> 
			 | 
			 	<c:if test='${qnaDTO.reStatus eq "pending"}'> 답변전 </c:if>
			 	<c:if test= '${qnaDTO.reStatus eq "completed"}'> 답변 완료 </c:if>
			 <hr>
			<div class="contents">
				${qnaDTO.qnaContent}
			</div>
		<hr class="my-5">
		<div class="card bg-light shadow-sm mb-5">
		    <div class="card-body p-4">
		        <c:choose>
		            <%-- 1. 답변이 아직 없는 경우 (pending): 입력 폼 출력 --%>
		            <c:when test="${qnaDTO.reStatus eq 'pending'}">
		                <h5 class="fw-bold mb-3"><i class="bi bi-chat-dots me-2"></i>관리자 답변 등록</h5>
		                <form action="<c:url value='/admin/contents/qnaAnswerSave'/>" method="post">
		                    <input type="hidden" name="qnaId" value="${qnaDTO.qnaId}">
		                    <div class="mb-3">
		                        <textarea name="reContent" class="form-control" rows="5" 
		                                  placeholder="사용자에게 전달할 답변 내용을 입력하세요." required></textarea>
		                    </div>
		                    <div class="text-end">
		                        <button type="submit" class="btn btn-primary">답변 등록</button>
		                    </div>
		                </form>
		            </c:when>
		
		            <%-- 2. 답변이 이미 있는 경우 (completed): 답변 내용 및 수정/삭제 버튼 출력 --%>
		            <c:otherwise>
		            	<div id = "displayAnswer">
			                <div class="d-flex justify-content-between align-items-center mb-3">
			                    <h5 class="fw-bold m-0 text-primary"><i class="bi bi-check-circle-fill me-2"></i>등록된 답변</h5>
			                    <small class="text-muted">답변일: <fmt:formatDate value="${qnaDTO.reDate}" pattern="yyyy년 MM월 dd일 HH:mm:ss" /></small>
			                </div>
			                <div class="p-3 bg-white border rounded mb-3" style="white-space: pre-wrap;">${qnaDTO.reContent}</div>
			                <div class="text-end">
			                    <button class="btn btn-sm btn-outline-secondary me-1" onclick="showEditForm()">수정</button>
			                    <button class="btn btn-sm btn-outline-danger" onclick="deleteAnswer(${qnaDTO.qnaId})">삭제</button>
			                </div>
		           		</div>
		                <div id="editAnswerForm" style="display: none;">
					        <h5 class="fw-bold mb-3 text-primary"><i class="bi bi-pencil-square me-2"></i>답변 수정하기</h5>
					        <form action="<c:url value='/admin/contents/qnaAnswerUpdate'/>" method="post">
					            <input type="hidden" name="qnaId" value="${qnaDTO.qnaId}">
					            <div class="mb-3">
					                <textarea name="reContent" class="form-control" rows="5" required>${qnaDTO.reContent}</textarea>
					            </div>
					            <div class="text-end">
					                <button type="submit" class="btn btn-primary text-white">수정 완료</button>
					                <button type="button" class="btn btn-secondary" onclick="hideEditForm()">취소</button>
					            </div>
					        </form>
					    </div>
		            </c:otherwise>
		        </c:choose>
		    </div>
		</div>
			
			
			
			 <div class="text-center mt-5">
			    <a href="<c:url value='/admin/contents/QnA' />" class="btn btn-secondary">목록으로</a>
			    
			    <button type="button" class="btn btn-danger" onclick="confirmDelete(${qnaDTO.qnaId})">삭제하기</button>
				</div>
			
		</div>
		
		
		
		
	</main>

	<script type="text/javascript">
	function confirmDelete(qnaId) {
		console.log("삭제할 id : " + qnaId)
	    if (confirm("정말로 이 문의글을 삭제하시겠습니까?\n삭제된 데이터는 복구할 수 없습니다.")) {
	        location.href = "QnaDelete?qnaId=" + qnaId;
	    }
	}
	function deleteAnswer(qnaId) {
	    if (confirm("등록된 답변을 삭제하시겠습니까?\n삭제 시 상태가 '답변전'으로 변경됩니다.")) {
	        // 답변 내용만 비우고 상태를 pending으로 바꾸는 컨트롤러로 이동
	        location.href = "/project/admin/contents/qnaAnswerDelete?qnaId=" + qnaId;
	    }
	}
	
	function showEditForm() {
	    document.getElementById('displayAnswer').style.display = 'none';
	    document.getElementById('editAnswerForm').style.display = 'block';
	}
	function hideEditForm() {
	    document.getElementById('displayAnswer').style.display = 'block';
	    document.getElementById('editAnswerForm').style.display = 'none';
	}
	</script>
</body>
</html>