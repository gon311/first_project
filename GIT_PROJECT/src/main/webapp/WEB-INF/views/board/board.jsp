<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/board/board.css'/>" type="text/css">
</head>


<body>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<!-- 수정 URL 들 -->
<c:url var="urlBoardList" value="/board"/>
<c:url var="urlBoardDetail" value="/board/detail"/>
<c:url var="urlBoardWrite" value="/board/write"/>
<c:url var="urlBoardSearch" value="/board"/>
<c:url var="urlBoardDeleteBulk" value="/board/deleteBulk"/>


<main class="container board-wrap">
  <section class="boardContent">
    <div class="boardContent-inner">

      <%-- 상단 타이틀 --%>
      <div style="display:flex; justify-content:space-between; flex-wrap:wrap;">
        <div>
          <h2 class="page-title">게시글</h2>
          <div class="page-desc">자유롭게 질문하고 정보를 공유해보세요.</div>
        </div>
        <a class="btn-primaryish" href="${urlBoardWrite}">글쓰기</a>
      </div>

      <%-- 카테고리 --%>
      <div class="chipbar">
        <a class="chip ${activeCategory eq 'ALL' ? 'active' : ''}"
           href="${urlBoardList}?category=ALL&sort=${sort}&q=${param.q}">
          전체
        </a>
        <a class="chip ${activeCategory eq 'JOB' ? 'active' : ''}"
           href="${urlBoardList}?category=JOB&sort=${sort}&q=${param.q}">
          취준/이직
        </a>
        <a class="chip ${activeCategory eq 'CAREER' ? 'active' : ''}"
           href="${urlBoardList}?category=CAREER&sort=${sort}&q=${param.q}">
          회사생활/커리어
        </a>
        <a class="chip ${activeCategory eq 'FREE' ? 'active' : ''}"
           href="${urlBoardList}?category=FREE&sort=${sort}&q=${param.q}">
          자유주제
        </a>
      </div>

      <%-- 리스트 영역 --%>
      <div class="list">

        <c:choose>

          <%-- posts 없으면 샘플 표시 --%>
          <c:when test="${empty posts}">
            <div class="row-item">
              <div class="row-mid">
                <div class="meta-top">
                  <span class="badge-cat">자유주제</span>
                  <span>유저 · 방금 전</span>
                </div>
                <a class="title-link" href="${urlBoardDetail}">[샘플] 게시판 첫 화면 레이아웃 어떤가요?</a>
                <div class="subline">샘플 데이터입니다.</div>
              </div>
              <div class="row-right">
                <div class="stat">좋아요 3</div>
                <div class="stat">댓글 1</div>
                <div class="stat">조회 27</div>
              </div>
            </div>
          </c:when>

          <%-- 실제 데이터 출력 --%>
          <c:otherwise>
            <c:forEach var="p" items="${posts}">
              <div class="row-item">
                <div class="row-mid">
                  <div class="meta-top">
                    <span class="badge-cat">${p.categoryName}</span>
                    <span>${p.writerNickname} · ${p.createdAtText}</span>
                  </div>
                  <a class="title-link" href="${urlBoardDetail}?postId=${p.postId}">
                    ${p.title}
                  </a>
                  <div class="subline">${p.excerpt}</div>
                </div>
                <div class="row-right">
                  <div class="stat">좋아요 ${p.likeCount}</div>
                  <div class="stat">댓글 ${p.commentCount}</div>
                  <div class="stat">조회 ${p.viewCount}</div>
                </div>
              </div>
            </c:forEach>
          </c:otherwise>

        </c:choose>

      </div>

      <%-- 페이지네이션 --%>
      <c:if test="${page.totalPages > 1}">
        <div class="pager">
          <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
            <a class="${i == page.currentPage ? 'active' : ''}"
               href="${urlBoardList}?category=${activeCategory}&sort=${sort}&q=${param.q}&page=${i}">
              ${i}
            </a>
          </c:forEach>
        </div>
      </c:if>

    </div>
  </section>
</main>


<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
</body>
</html>