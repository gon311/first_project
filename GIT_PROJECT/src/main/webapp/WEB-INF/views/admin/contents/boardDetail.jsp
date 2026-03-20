<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<title>자유게시판 상세</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<div class="card shadow-sm p-5">
    <div class="pb-3 mb-4">
        <h2 class="fw-bold">${freeDTO.title}</h2> 
       	<div class="text-muted small">
       		<span>
       			작성자 : ${freeDTO.authorMemberId } |
       		</span>
            <span>
            	작성일: ${freeDTO.strCreatedAt}
           	</span> |
            <c:if test="${not empty freeDTO.updatedAt}" >
           	<span>
            	수정일:	${freeDTO.strUpdatedAt}
            </span> 
            </c:if>
            <span class="ms-3">|   조회수: ${freeDTO.readcount}</span> 
            <span class="ms-3">
             |   상태 : 
            	<c:if test='${freeDTO.status == "ACTIVE"}'>게시</c:if>
                <c:if test='${freeDTO.status == "DELETED"}'>삭제</c:if>
            </span>
        </div>
       <hr>
       <br>
    <div>
   	${freeDTO.content }
    </div>
    
    <%-- 댓글 영역 --%>
	<hr class="my-5">
	
	<div class="comment-section px-2">
	    <div class="d-flex align-items-center mb-4">
	        <h4 class="fw-bold mb-0">댓글 관리</h4>
	        <span class="badge bg-dark ms-3">총 ${commentList.size()}개</span>
	    </div>
	
	    <div class="comment-list">
	        <c:forEach var="comment" items="${commentList}">
	            <div class="comment-item p-3 mb-3 border rounded shadow-sm ${comment.status == 'DELETED' ? 'bg-light' : 'bg-white'}">
	                <div class="d-flex justify-content-between align-items-start">
	                    <div>
	                        <div class="mb-1">
	                            <span class="fw-bold text-primary">${comment.authorMemberId}</span>
	                            <small class="text-muted ms-2">
	                            	${comment.strCreatedAt}
	                            </small>
	                            <c:if test="${comment.status == 'DELETED'}">
	                                <span class="badge bg-danger ms-2">삭제됨</span>
	                            </c:if>
	                        </div>
	                        <div class="comment-content mt-2 text-dark">
	                            ${comment.content}
	                        </div>
	                    </div>
	
	                    <div class="btn-group">
   							<a href="<c:url value='/admin/users/info?userId=${comment.authorMemberId}' />" class="btn btn-sm btn-outline-warning">
 	                            신고연동
                  			 </a>
                     			 
	                        <c:if test="${comment.status == 'ACTIVE'}">
	                            <button type="button" class="btn btn-sm btn-outline-danger" onclick="confirmDelete(${comment.commentId}, ${freeDTO.postId })">
	                                삭제
	                            </button>
	                        </c:if>
	                    </div>
	                </div>
	            </div>
	        </c:forEach>
	
	        <c:if test="${empty commentList}">
	            <div class="text-center py-5 border rounded bg-light text-muted">
	                등록된 댓글이 없습니다.
	            </div>
	        </c:if>
	    </div>
	</div>
	
	<div class="text-center mt-5 pt-4 border-top">
	    <a href="<c:url value='/admin/users/info?userId=${freeDTO.authorMemberId }' />" class="btn btn-warning px-4">회원정보</a>
	    <a href="<c:url value='/admin/contents/Board' />" class="btn btn-secondary px-4">목록으로</a>
	    <button type="button" class="btn btn-danger px-4" onclick="postDelete(${freeDTO.postId })">삭제하기</button>
	</div>
	</div>
    </div>
    
	<script type="text/javascript">
	function confirmDelete(commentId, postId) {
		console.log("삭제할 id : " + commentId);
	    if (confirm("정말로 이 댓글을 삭제하시겠습니까?\n삭제된 데이터는 복구할 수 없습니다.")) {
	        // 확인을 누르면 삭제 요청 페이지로 이동
	        location.href = "commentDelete?commentId=" + commentId + "&postId=" + postId;
	    }
	}
	
	function postDelete(postId){
		if(confirm("정말로 이 게시글을 삭제하시겠습니까?")){
			location.href = "boardDelete?postId=" + postId;
		}
	}
	</script>
</body>
</html>