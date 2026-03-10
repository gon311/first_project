<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
	<title>공지사항 글 작성하기</title>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
	<main class="container-fluid mt-4">
        <form id="noticeForm" action="<c:url value='/admin/contents/noticeSave' />" method="post">
		    <div class="row">
		        <div class="col-lg-9">
	    	        <div class="card shadow-sm p-4 h-100">
	                	<input type ="hidden" id="postStatus" name="status" value="N">
	                    <div class="mb-3">
	                        <input type="text" name="noticeTitle" class="form-control form-control-lg border-0 border-bottom rounded-0 px-0" 
	                               placeholder="제목을 입력하세요." style="font-size: 1.5rem;">
	                    </div>
	
	               <div>
	               <!-- 그 뭐냐 그 게시글 작성 시 필요한 설정 항목 추가(글자크기, 뭐 색, 이미지 등) -->
	               </div>
	
	                    <div class="mb-3">
	                        <textarea id = "summernote" name="noticeContent" class="form-control border-0 px-0" rows="15" 
	                                  placeholder="본문을 입력하세요." style="resize: none;"></textarea>
	                    </div>
	            </div>
	        </div>
	
	        <div class="col-lg-3">
	            <div class="d-grid gap-3">
	                <button type="button" class="btn btn-outline-primary py-2" data-bs-toggle="modal" data-bs-target="#publishModal">
	                    게시
	                </button>
	                
	                <button type="button" class="btn btn-outline-secondary py-2" onclick="submitPost('N')">
	                    임시저장
	                </button>
	
	                <div class="card p-3 shadow-sm mt-2">
	                    <label class="form-label small text-muted fw-bold">게시 유형</label>
	                    <select name="userType" class="form-select">
	                        <option value="all">전체</option>
	                        <option value="com">기업회원</option>
	                        <option value="user">구직자</option>
	                    </select>
	                </div>
	            </div>
	        </div>
	    </div>
	    </form>
	</main>

	<div class="modal fade" id="publishModal" tabindex="-1">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content shadow">
	      <div class="modal-body text-center p-5">
	        <p class="mb-4 fw-bold">작성한 내용을 공지사항에 바로 게시하시겠습니까?</p>
	        <div class="d-flex justify-content-center gap-2">
	            <button type="button" class="btn btn-light px-4" data-bs-dismiss="modal">취소</button>
	            <button type="button" class="btn btn-secondary px-4" onclick="submitPost('Y')">확인</button>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
	
	
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