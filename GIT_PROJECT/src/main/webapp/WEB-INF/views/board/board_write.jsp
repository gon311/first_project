<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/board/board_write.css'/>" type="text/css">
</head>

<body>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<!-- URL주소 -->
<c:url var="urlBoardList"  value="/board"/>
<c:url var="urlBoardWrite" value="/board/write"/>

<main class="container wrap">
  <div class="cardx">
    <div class="content">

      <h2 class="page-title">글쓰기</h2>
      <div class="page-desc">게시글 유형을 선택하고, 제목/내용을 작성해 등록하세요.</div>

      <form action="${urlBoardWrite}" method="post" id="writeForm" enctype="multipart/form-data">

        <div class="section" style="border-top:0; padding-top:0;">
          <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
            <div class="label m-0">
              카테고리 <span class="hint">게시글 유형을 선택해주세요</span>
            </div>

            <div style="min-width:260px; max-width:320px;">
              <select class="select" name="category" id="category">
                <option value="JOB">취준/이직</option>
                <option value="CAREER">회사생활/커리어</option>
                <option value="FREE">자유주제</option>
              </select>
            </div>
          </div>
        </div>

        <div class="section">
          <div class="label">제목</div>
          <input class="input" type="text" name="title" id="title"
                 placeholder="질문 제목을 입력해주세요(최대 50자)" maxlength="50" required>
        </div>

        <div class="section">
          <div class="label">
            내용 <span class="hint">내용을 작성해봐요!</span>
          </div>

          <div class="editor">
            <div class="editor-toolbar">
              <button type="button" class="tool-btn" data-tool="bold">B</button>
              <button type="button" class="tool-btn" data-tool="italic">I</button>
              <button type="button" class="tool-btn" data-tool="underline">U</button>
              <span style="width:1px; height:18px; background:#e5e7eb; display:inline-block; margin:0 4px;"></span>
              <button type="button" class="tool-btn" data-tool="bullet">• 목록</button>
              <button type="button" class="tool-btn" data-tool="quote">“ 인용</button>
            </div>

            <textarea class="editor-area" name="content" id="content"
                      placeholder="등록한 글은 사용하는 닉네임으로 등록됩니다.&#10;* 타인의 권리를 침해하거나 부적절한 내용은 사전 공지 없이 삭제될 수 있어요..&#10;"
                      maxlength="5000" required></textarea>
          </div>

          <div class="counter"><span id="contentCount">0</span>/5000자</div>
        </div>

        <!-- 첨부파일 -->
        <div class="section">
          <div class="label">첨부파일 <span class="hint">여러 파일 업로드 가능</span></div>
          <input type="file" class="input" name="files" multiple>
        </div>

        <div class="section">
          <div class="label">해시태그 <span class="hint">최대 5개까지 선택가능합니다</span></div>

          <div class="tag-wrap" id="tagWrap">
            <label class="tag"><input type="checkbox" name="tags" value="신입">#신입</label>
            <label class="tag"><input type="checkbox" name="tags" value="취업">#취업</label>
            <label class="tag"><input type="checkbox" name="tags" value="이직">#이직</label>
            <label class="tag"><input type="checkbox" name="tags" value="잡담">#잡담</label>
            <label class="tag"><input type="checkbox" name="tags" value="면접">#면접</label>
            <label class="tag"><input type="checkbox" name="tags" value="자소서">#자소서</label>
            <label class="tag"><input type="checkbox" name="tags" value="커리어">#커리어</label>
            <label class="tag"><input type="checkbox" name="tags" value="퇴사">#퇴사</label>
            <label class="tag"><input type="checkbox" name="tags" value="채용">#채용</label>
            <label class="tag"><input type="checkbox" name="tags" value="경력">#경력</label>
            <label class="tag"><input type="checkbox" name="tags" value="회사생활">#회사생활</label>
          </div>
        </div>

        <div class="bottom">
          <a class="btn-ghost" href="${urlBoardList}">취소</a>
          <button type="submit" class="btn-primaryish" id="submitBtn">
            게시글 등록하기
          </button>
        </div>

      </form>

    </div>
  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const content = document.getElementById("content");
    const countEl = document.getElementById("contentCount");

    function updateCount() {
      countEl.textContent = content.value.length;
    }
    content.addEventListener("input", updateCount);
    updateCount();

    const tagWrap = document.getElementById("tagWrap");
    const tags = tagWrap.querySelectorAll(".tag");

    function selectedCount() {
      return tagWrap.querySelectorAll("input[type='checkbox']:checked").length;
    }

    tags.forEach(tag => {
      const chk = tag.querySelector("input[type='checkbox']");

      if (chk.checked) tag.classList.add("active");

      tag.addEventListener("click", function () {
        setTimeout(() => {
          const cnt = selectedCount();

          if (cnt > 5) {
            chk.checked = false;
            tag.classList.remove("active");
            alert("해시태그는 최대 5개까지 선택할 수 있어요!");
            return;
          }

          if (chk.checked) tag.classList.add("active");
          else tag.classList.remove("active");
        }, 0);
      });
    });
  });
</script>

</body>
</html>