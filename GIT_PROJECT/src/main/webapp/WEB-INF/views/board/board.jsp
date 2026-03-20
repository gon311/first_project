<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
  <%@ include file="/WEB-INF/views/inc/head.jspf" %>
  <link rel="stylesheet" href="<c:url value='/resources/css/board/board.css'/>" type="text/css">
</head>

<body>
    <c:choose>
	    <c:when test="${sessionScope.memberType == 'company'}">
	        <%@ include file="/WEB-INF/views/inc/headerCom.jspf" %>
	    </c:when>
	
	    <c:otherwise>
	        <%@ include file="/WEB-INF/views/inc/header.jspf" %>
	    </c:otherwise>
	</c:choose>

  <c:url var="urlBoardList" value="/board"/>
  <c:url var="urlBoardDetail" value="/board/detail"/>
  <c:url var="urlBoardWrite" value="/board/write"/>

  <main class="container board-wrap">
    <section class="boardContent">
      <div class="boardContent-inner">

        <!-- 상단 -->
        <div class="board-top">
          <div>
            <h2 class="page-title">게시글</h2>
            <div class="page-desc">자유롭게 질문하고 정보를 공유해보세요.</div>
            <div class="page-count">총 ${totalCount}개 게시글</div>
          </div>

          <a class="btn-primaryish" href="${urlBoardWrite}">글쓰기</a>
        </div>

        <!-- 카테고리 -->
        <div class="chipbar">
          <a class="chip ${category eq 'ALL' ? 'active' : ''}"
             href="${urlBoardList}?category=ALL&sort=${sort}&searchType=${searchType}&q=${q}&size=${size}">
            전체
          </a>

          <a class="chip ${category eq 'JOB' ? 'active' : ''}"
             href="${urlBoardList}?category=JOB&sort=${sort}&searchType=${searchType}&q=${q}&size=${size}">
            취준/이직
          </a>

          <a class="chip ${category eq 'CAREER' ? 'active' : ''}"
             href="${urlBoardList}?category=CAREER&sort=${sort}&searchType=${searchType}&q=${q}&size=${size}">
            회사생활/커리어
          </a>

          <a class="chip ${category eq 'FREE' ? 'active' : ''}"
             href="${urlBoardList}?category=FREE&sort=${sort}&searchType=${searchType}&q=${q}&size=${size}">
            자유주제
          </a>
          
          <a class="chip ${category eq 'INTERVIEW_REVIEW' ? 'active' : ''}"
             href="${urlBoardList}?category=INTERVIEW_REVIEW&sort=${sort}&searchType=${searchType}&q=${q}&size=${size}">
            면접후기
          </a>
        </div>

        <!-- 정렬 + 페이지 크기 -->
        <div style="margin:15px 0; display:flex; justify-content:space-between; align-items:center; gap:10px; flex-wrap:wrap;">

          <div style="display:flex; gap:10px; flex-wrap:wrap;">
            <a class="chip ${sort eq 'latest' ? 'active' : ''}"
               href="${urlBoardList}?category=${category}&sort=latest&searchType=${searchType}&q=${q}&size=${size}">
              최신순
            </a>

            <a class="chip ${sort eq 'view' ? 'active' : ''}"
               href="${urlBoardList}?category=${category}&sort=view&searchType=${searchType}&q=${q}&size=${size}">
              조회순
            </a>

            <a class="chip ${sort eq 'comment' ? 'active' : ''}"
               href="${urlBoardList}?category=${category}&sort=comment&searchType=${searchType}&q=${q}&size=${size}">
              댓글순
            </a>
          </div>

          <form action="${urlBoardList}" method="get" class="size-form">
            <input type="hidden" name="category" value="${category}">
            <input type="hidden" name="sort" value="${sort}">
            <input type="hidden" name="searchType" value="${searchType}">
            <input type="hidden" name="q" value="${q}">
            <input type="hidden" name="page" value="1">

            <select name="size" class="size-select" onchange="this.form.submit()">
              <option value="5" ${size == 5 ? 'selected' : ''}>5개씩</option>
              <option value="10" ${size == 10 ? 'selected' : ''}>10개씩</option>
              <option value="15" ${size == 15 ? 'selected' : ''}>15개씩</option>
            </select>
          </form>

        </div>

        <!-- 검색 -->
        <form action="${urlBoardList}" method="get" class="search-form">
          <input type="hidden" name="category" value="${category}">
          <input type="hidden" name="sort" value="${sort}">
          <input type="hidden" name="size" value="${size}">

          <select name="searchType" class="search-select">
            <option value="all" ${searchType eq 'all' ? 'selected' : ''}>제목/내용</option>
            <option value="title" ${searchType eq 'title' ? 'selected' : ''}>제목</option>
            <option value="content" ${searchType eq 'content' ? 'selected' : ''}>내용</option>
          </select>

          <input type="text"
                 name="q"
                 value="${q}"
                 placeholder="검색어 입력"
                 class="search-input">

          <button type="submit" class="search-btn">검색</button>
        </form>

        <!-- 게시글 리스트 -->
        <div class="list">
          <c:choose>
            <c:when test="${empty posts}">
              <div class="row-item">
                <div class="row-mid">
                  <div class="meta-top">
                    <span class="badge-cat">자유주제</span>
                    <span>샘플 · 방금 전</span>
                  </div>

                  <a class="title-link" href="#">게시글이 없습니다</a>

                  <div class="subline">
                    첫 게시글을 작성해보세요.
                  </div>
                </div>
              </div>
            </c:when>

            <c:otherwise>
              <c:forEach var="p" items="${posts}">
                <div class="row-item">
                  <div class="row-mid">
                    <div class="meta-top">
                      <span class="badge-cat">${p.categoryName}</span>
                      <span>${p.writerNickname} · ${p.displayDateTextCreate}</span>
                    </div>

                    <a class="title-link"
                       href="${urlBoardDetail}?postId=${p.postId}">
                      ${p.title}
                    </a>

                    <div class="subline">${p.excerpt}</div>
                  </div>

                  <div class="row-right">
<%--                     <div class="stat">좋아요 ${p.likeCount}</div> --%>
                    <div class="stat">댓글 ${p.commentCount}</div>
                    <div class="stat">조회 ${p.viewCount}</div>
                  </div>
                </div>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- 페이지네이션 -->
        <c:if test="${pager.totalPages > 1}">
          <div class="pager">

            <c:if test="${pager.hasPrev}">
              <a href="${urlBoardList}?category=${category}&sort=${sort}&searchType=${searchType}&q=${q}&size=${size}&page=${pager.page - 1}">
                ‹
              </a>
            </c:if>

            <c:forEach var="i" begin="${pager.startPage}" end="${pager.endPage}">
              <a class="${i == pager.page ? 'active' : ''}"
                 href="${urlBoardList}?category=${category}&sort=${sort}&searchType=${searchType}&q=${q}&size=${size}&page=${i}">
                ${i}
              </a>
            </c:forEach>

            <c:if test="${pager.hasNext}">
              <a href="${urlBoardList}?category=${category}&sort=${sort}&searchType=${searchType}&q=${q}&size=${size}&page=${pager.page + 1}">
                ›
              </a>
            </c:if>

          </div>
        </c:if>

      </div>
    </section>
  </main>

  <%@ include file="/WEB-INF/views/inc/footer.jspf" %>
</body>
</html>