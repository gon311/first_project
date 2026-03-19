<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>공지사항 수정</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<main class="container-fluid mt-4">
	<div class="card shadow-sm p-5">
        <form id = "noticeForm" action="<c:url value='/admin/contents/noticeUpdateSave' />" method="post">
		    <input type="hidden" name="noticeId" value="${noticeDTO.noticeId}">
		    
		    <div class="mb-3">
		        <label>제목</label>
		        <input type="text" name="noticeTitle" class="form-control" value="${noticeDTO.noticeTitle}">
		    </div>
		
		    <div class="mb-3">
		        <label>내용</label>
		        <textarea id = "summernote" name="noticeContent" class="form-control border-0 px-0" rows="15" 
                   placeholder="본문을 입력하세요." style="resize: none;">
                    ${noticeDTO.noticeContent}
                </textarea>
		    </div>
		
		    <div class="mb-3">
		        <label>게시 유형</label>
		        <select name="userType" class="form-select">
		            <option value="all" ${noticeDTO.userType == 'all' ? 'selected' : ''}>전체</option>
		            <option value="com" ${noticeDTO.userType == 'com' ? 'selected' : ''}>기업회원</option>
		            <option value="user" ${noticeDTO.userType == 'user' ? 'selected' : ''}>구직자</option>
		        </select>
		    </div>
		    <div>
			    <select name="status" class="form-select">
				    <option value="Y" ${noticeDTO.status == 'Y' ? 'selected' : ''}>게시</option>
				    <option value="N" ${noticeDTO.status == 'N' ? 'selected' : ''}>임시저장</option>
				</select>
			</div>
			<br>
		    <button type="submit" class="btn btn-success">수정 완료</button>
		    <a href="javascript:history.back()" class="btn btn-secondary">취소</a>
		</form>
	</div>
	</main>
		<script type="text/javascript">
		function submitPost(statusValue){
			const form = document.getElementById('noticeForm');
			// 1. 상태값 담기(Y/N)
			document.getElementById('postStatus').value = statusValue;
			// 2. 제목 빈칸 확인	
			if(form.noticeTitle.value == ""){
				alert("제목을 입력하세요.");
				return;
			}
			// 3. 폼전송
			form.submit();
		}
	
		$(document).ready(function() {
		    $('#summernote').summernote({
		        placeholder: '내용을 입력해주세요.',
		        tabsize: 2,
		        height: 400, // 에디터 높이
		        lang: 'ko-KR', // 한글 설정
		        toolbar: [
		            // [그룹이름, [버튼들]]
		            ['style', ['style']],
		            ['font', ['bold', 'underline', 'clear']],
		            ['fontsize', ['fontsize']], // 글자 크기 설정
		            ['color', ['color']],       // 글자 색상 설정
		            ['para', ['ul', 'ol', 'paragraph']],
		            ['table', ['table']],
		            ['insert', ['link', 'picture', 'video']], // 이미지 및 비디오 첨부
		            ['view', ['fullscreen', 'codeview', 'help']]
		        ],
		        fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
		    });
		});
	</script>
</body>
</html>