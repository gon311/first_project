<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .qna-container { max-width: 800px; margin: 50px auto; padding: 20px; background: #fff; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .qna-title { border-bottom: 2px solid #333; padding-bottom: 15px; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-weight: bold; margin-bottom: 8px; color: #444; }
        .form-group input[type="text"], .form-group select, .form-group textarea {
            width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; font-size: 14px;
        }
        .form-group textarea { height: 200px; resize: vertical; }
        .file-upload-section { background: #f9f9f9; padding: 15px; border-radius: 4px; border: 1px dashed #ccc; }
        .btn-area { text-align: center; margin-top: 30px; display: flex; gap: 10px; justify-content: center; }
        .btn { padding: 12px 30px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; transition: 0.3s; }
        .btn-submit { background: #007bff; color: white; }
        .btn-submit:hover { background: #0056b3; }
        .btn-cancel { background: #6c757d; color: white; text-decoration: none; display: inline-block; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<main class="qna-container">
    <div class="qna-title">
        <h2><i class="fa-solid fa-headset"></i> 1:1 문의하기</h2>
        <p style="color: #666; font-size: 0.9em;">궁금하신 사항을 남겨주시면 담당자가 확인 후 답변해 드립니다.</p>
    </div>

    <%-- 1. action 주소를 /help/insert로 수정 --%>
    <form action="<c:url value='/help/insert' />" method="post" enctype="multipart/form-data">
        
        <%-- 2. 문의 유형: name을 qnaCategory로 수정 --%>
        <div class="form-group">
            <label for="category">문의 유형</label>
            <select name="qnaCategory" id="category" required>
                <option value="">유형을 선택해주세요</option>
                <option value="job">입사지원 관련</option>
                <option value="account">계정/인증 관련</option>
                <option value="error">오류 신고</option>
                <option value="etc">기타 문의</option>
            </select>
        </div>

        <%-- 3. 제목: name을 qnaTitle로 수정 --%>
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="qnaTitle" placeholder="제목을 입력해주세요" required>
        </div>

        <%-- 4. 내용: name을 qnaContent로 수정 --%>
        <div class="form-group">
            <label for="content">문의 내용</label>
            <textarea id="content" name="qnaContent" placeholder="내용을 상세히 적어주시면 빠른 답변이 가능합니다." required></textarea>
        </div>

        <%-- 5. 파일 첨부: name은 컨트롤러의 @RequestParam 이름과 맞춤 --%>
        <div class="form-group">
            <label><i class="fa-solid fa-paperclip"></i> 첨부 파일</label>
            <div class="file-upload-section">
                <input type="file" name="uploadFiles" multiple>
                <p style="font-size: 0.8em; color: #888; margin-top: 5px;">* 최대 3개까지 업로드 가능합니다.</p>
            </div>
        </div>

        <div class="btn-area">
            <%-- 취소 버튼도 help 경로에 맞춰 수정하거나 메인으로 보냄 --%>
            <a href="<c:url value='/' />" class="btn btn-cancel">취소</a>
            <button type="submit" class="btn btn-submit">문의 등록하기</button>
        </div>
    </form>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
</body>
</html>