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
			 공고 아이디 : ${jobPostDTO.job_id} | 회사 아이디 : ${jobPostDTO.comp_id }
			 <hr>
			<div class="contents">
				${jobPostDTO.field}
				${jobPostDTO.post_check }
			</div>
			
			<div>
				<input type = "button" value = "삭제" onclick = "confirm('삭제하시겠습니까?')">
			
			
			</div>
			<div class="button-group" style="text-align: center; margin-top: 20px;">
 				<button type="button" onclick="location.href='<c:url value='/admin/contents/JobPost'/>'">목록으로</button>
    			<button type="button" onclick="location.href='<c:url value='/admin/contents/JobPost'/>'" style="background-color: #ff4d4d; color: white;">삭제하기</button>
    			<!-- 삭제 리다이렉트 기능 구현 예정 -->
<%--     			<button type="button" class="btn-delete" onclick="deletePost('${jobPost.job_id}')" style="background-color: #ff4d4d; color: white;">삭제하기</button> --%>
			</div>
		</div>
	</main>

</body>
</html>