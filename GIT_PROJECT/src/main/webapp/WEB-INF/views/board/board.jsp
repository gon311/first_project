<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<%-- =========================
     URL 설정
   ========================= --%>
<c:url var="urlBoardList" value="/board"/>
<c:url var="urlBoardDetail" value="/board/detail"/>
<c:url var="urlBoardWrite" value="/board/write"/>
<c:url var="urlBoardSearch" value="/board"/>
<c:url var="urlBoardDeleteBulk" value="/board/deleteBulk"/>

<style>
  body { background:#f6f7fb; }
  .board-wrap { min-height:100vh; }

  .boardContent { padding:22px; }

  .boardContent-inner{
    background:#fff;
    border:1px solid #eef2f7;
    border-radius:16px;
    box-shadow:0 10px 30px rgba(15,23,42,.04);
    padding:22px;
    min-height: calc(100vh - 80px);
  }

  .page-title{
    font-size:1.6rem;
    font-weight:900;
    letter-spacing:-.6px;
    margin:0;
  }

  .page-desc{
    color:#6b7280;
    font-size:.92rem;
    margin-top:8px;
  }

  .chipbar{
    margin-top:16px;
    display:flex;
    flex-wrap:wrap;
    gap:8px;
  }

  .chip{
    display:inline-flex;
    align-items:center;
    padding:8px 12px;
    border-radius:999px;
    border:1px solid #dbe2ee;
    background:#fff;
    text-decoration:none;
    color:#334155;
    font-weight:900;
  }

  .chip.active{
    background:#111827;
    border-color:#111827;
    color:#fff;
  }

  .toolbar{
    margin-top:14px;
    display:flex;
    justify-content:space-between;
    gap:12px;
    padding:12px;
    border:1px solid #eef2f7;
    border-radius:12px;
    background:#fff;
  }

  .toolbar-left,
  .toolbar-right{
    display:flex;
    align-items:center;
    gap:10px;
    flex-wrap:wrap;
  }

  .btn-primaryish{
    border:1px solid #111827;
    background:#111827;
    color:#fff;
    padding:8px 12px;
    border-radius:10px;
    font-weight:900;
    text-decoration:none;
    
    display:inline-flex;
    align-items: center;
    justify-content: center;
    
    
  }

  .select{
    border:1px solid #dbe2ee;
    border-radius:10px;
    padding:8px 12px;
    font-weight:900;
  }

  .search-wrap{
    display:flex;
    align-items:center;
    gap:8px;
    border:1px solid #dbe2ee;
    border-radius:10px;
    padding:8px 12px;
    background:#fff;
  }

  .search-wrap input{
    border:0;
    outline:none;
    width:220px;
  }

  .list{
    margin-top:14px;
    border-top:1px solid #eef2f7;
  }

  .row-item{
    display:flex;
    gap:14px;
    padding:18px 6px;
    border-bottom:1px solid #eef2f7;
  }

  .row-mid{ flex:1; }

  .meta-top{
    display:flex;
    gap:8px;
    align-items:center;
    margin-bottom:8px;
  }

  .badge-cat{
    padding:4px 10px;
    border-radius:999px;
    background:#eef2ff;
    font-weight:900;
    font-size:.82rem;
  }

  .title-link{
    font-weight:900;
    font-size:1.15rem;
    color:#111827;
    text-decoration:none;
  }

  .subline{
    margin-top:8px;
    color:#6b7280;
    font-size:.92rem;
  }

  .row-right{
    display:flex;
    gap:12px;
    justify-content:flex-end;
    min-width:200px;
  }

  .stat{
    text-align:right;
  }

  .pager{
    margin-top:18px;
    display:flex;
    justify-content:center;
    gap:8px;
  }

  .pager a{
    padding:8px 10px;
    border:1px solid #e5e7eb;
    border-radius:10px;
    text-decoration:none;
    font-weight:900;
  }

  .pager a.active{
    background:#2563eb;
    color:#fff;
  }
</style>

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