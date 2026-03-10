<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<title>채용 공고 상세 페이지</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<main class="container-fluid mt-5">
		<div class="card shadow-sm p-4">
			 <div class= "title">
			 	<h3>${jobPostDTO.title}</h3>
			 </div>
			 공고 아이디 : ${jobPostDTO.jobId} | 회사 아이디 : ${jobPostDTO.compId }
			 <hr>
			<div class="contents">
				${jobPostDTO.field}
				${jobPostDTO.postStatus }
			</div>
			
			 <div class="text-center mt-5">
			    <a href="<c:url value='/admin/contents/JobPost' />" class="btn btn-secondary">목록으로</a>
			    
			    <button type="button" class="btn btn-danger" onclick="confirmDelete(${jobPostDTO.jobId})">삭제하기</button>
				</div>
			
		</div>
	</main>

	<script type="text/javascript">
	function confirmDelete(jobId) {
		console.log("삭제할 id : " + jobId)
	    if (confirm("정말로 이 공지사항을 삭제하시겠습니까?\n삭제된 데이터는 복구할 수 없습니다.")) {
	        // 확인을 누르면 삭제 요청 페이지로 이동
	        location.href = "JobPostDelete?jobId=" + jobId;
	    }
	}
	</script>
</body>
</html>