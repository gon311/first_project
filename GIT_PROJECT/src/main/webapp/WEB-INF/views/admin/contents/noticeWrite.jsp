<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<title>공지사항 글 작성하기</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/common/header.jsp" />
<main class="container-fluid mt-4">
    <div class="row">
        <div class="col-lg-9">
            <div class="card shadow-sm p-4 h-100">
                <form id="noticeForm" action="<c:url value='/admin/contents/noticeSave' />" method="post">
                    <div class="mb-3">
                        <input type="text" name="title" class="form-control form-control-lg border-0 border-bottom rounded-0 px-0" 
                               placeholder="제목을 입력하세요." style="font-size: 1.5rem;">
                    </div>

               <div>
               <!-- 그 뭐냐 그 게시글 작성 시 필요한 설정 항목 추가(글자크기, 뭐 색, 이미지 등) -->
               </div>

                    <div class="mb-3">
                        <textarea name="content" class="form-control border-0 px-0" rows="15" 
                                  placeholder="본문을 입력하세요." style="resize: none;"></textarea>
                    </div>
                </form>
            </div>
        </div>

        <div class="col-lg-3">
            <div class="d-grid gap-3">
                <button type="button" class="btn btn-outline-primary py-2" data-bs-toggle="modal" data-bs-target="#publishModal">
                    게시
                </button>
                
                <button type="button" class="btn btn-outline-secondary py-2">
                    임시저장
                </button>

                <div class="card p-3 shadow-sm mt-2">
                    <label class="form-label small text-muted fw-bold">게시 유형</label>
                    <select name="userType" class="form-select">
                        <option value="all">전체</option>
                        <option value="company">기업회원</option>
                        <option value="user">구직자</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
</main>

<div class="modal fade" id="publishModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content shadow">
      <div class="modal-body text-center p-5">
        <p class="mb-4 fw-bold">게시글을 공지사항에 업로드하시겠습니까?</p>
        <div class="d-flex justify-content-center gap-2">
            <button type="button" class="btn btn-light px-4" data-bs-dismiss="modal">취소</button>
            <button type="button" class="btn btn-secondary px-4" onclick="submitForm()">확인</button>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>