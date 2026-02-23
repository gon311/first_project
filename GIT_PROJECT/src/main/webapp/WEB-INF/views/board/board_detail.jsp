<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<%-- =========================
     URL 설정 (컨트롤러에 맞게 value만 수정)
   ========================= --%>
<c:url var="urlBoardList" value="/board"/>
<c:url var="urlBoardDetail" value="/board/detail"/>
<c:url var="urlBoardEdit" value="/board/edit"/>
<c:url var="urlBoardDelete" value="/board/delete"/>          <%-- POST 권장 --%>
<c:url var="urlBoardReport" value="/board/report"/>          <%-- POST 권장 --%>
<c:url var="urlBoardLike" value="/board/like"/>              <%-- POST/Ajax --%>
<c:url var="urlBoardScrap" value="/board/scrap"/>            <%-- POST/Ajax --%>

<c:url var="urlCommentWrite" value="/board/comment/write"/>  <%-- POST --%>
<c:url var="urlCommentMore" value="/board/comment/more"/>    <%-- (선택) 더보기 --%>

<style>
  body { background:#f6f7fb; }
  .wrap { min-height:100vh; padding:22px 0; }

  .card{
    background:#fff;
    border:1px solid #eef2f7;
    border-radius:16px;
    box-shadow:0 10px 30px rgba(15,23,42,.04);
  }

  .content{ padding:22px; }

  .title{
    font-size:1.55rem;
    font-weight:900;
    letter-spacing:-.6px;
    margin:10px 0 0;
    color:#111827;
  }

  .meta{
    margin-top:10px;
    display:flex;
    flex-wrap:wrap;
    gap:8px;
    align-items:center;
    color:#6b7280;
    font-weight:800;
    font-size:.92rem;
  }

  .badge-cat{
    display:inline-flex;
    align-items:center;
    padding:4px 10px;
    border-radius:999px;
    background:#eef2ff;
    border:1px solid rgba(55,48,163,.14);
    color:#3730a3;
    font-weight:900;
    font-size:.82rem;
  }

  .dot{ color:#cbd5e1; font-weight:900; }

  .top-actions{
    display:flex;
    justify-content:space-between;
    align-items:flex-start;
    gap:12px;
    flex-wrap:wrap;
  }

  .menu{
    display:flex;
    gap:8px;
    align-items:center;
    flex-wrap:wrap;
  }

  .btn-ghost{
    border:1px solid #dbe2ee;
    background:#fff;
    padding:8px 12px;
    border-radius:10px;
    font-weight:900;
    color:#334155;
    text-decoration:none;
    display:inline-flex;
    align-items:center;
    gap:6px;
    cursor:pointer;
  }
  .btn-ghost:hover{ background:#f7f9fc; }

  .btn-dark{
    border:1px solid #111827;
    background:#111827;
    color:#fff;
    padding:8px 12px;
    border-radius:10px;
    font-weight:900;
    text-decoration:none;
    display:inline-flex;
    align-items:center;
    gap:6px;
    cursor:pointer;
  }
  .btn-dark:hover{ opacity:.92; }

  .btn-danger-soft{
    border:1px solid #fecaca;
    background:#fff;
    color:#ef4444;
    padding:8px 12px;
    border-radius:10px;
    font-weight:900;
    cursor:pointer;
  }
  .btn-danger-soft:hover{ background:#fff5f5; }

  .body{
    margin-top:18px;
    padding-top:18px;
    border-top:1px solid #eef2f7;
    color:#111827;
    line-height:1.8;
    font-size:1rem;
    white-space:pre-wrap; /* 줄바꿈 유지 */
  }

  .bottom-actions{
    margin-top:18px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:10px;
    flex-wrap:wrap;
    padding-top:16px;
    border-top:1px solid #eef2f7;
  }

  .actions-left{
    display:flex;
    gap:10px;
    align-items:center;
    flex-wrap:wrap;
  }

  .count{
    color:#6b7280;
    font-weight:900;
    font-size:.95rem;
  }

  /* 댓글 섹션 */
  .comment-wrap{ margin-top:16px; }
  .comment-title{
    font-weight:900;
    font-size:1.05rem;
    margin:0 0 10px;
    color:#111827;
  }

  .comment-box{
    border:1px solid #eef2f7;
    border-radius:14px;
    padding:14px;
    background:#fbfcff;
  }

  .comment-head{
    display:flex;
    align-items:center;
    justify-content:space-between;
    gap:10px;
    margin-bottom:8px;
  }

  .comment-hint{
    color:#6b7280;
    font-weight:900;
    font-size:.9rem;
  }

  textarea{
    width:100%;
    border:1px solid #dbe2ee;
    border-radius:12px;
    padding:12px;
    outline:none;
    resize:vertical;
    min-height:90px;
    background:#fff;
  }

  .comment-actions{
    margin-top:10px;
    display:flex;
    justify-content:flex-end;
    gap:8px;
    align-items:center;
  }

  .btn-cancel{
    border:1px solid #e5e7eb;
    background:#fff;
    padding:8px 14px;
    border-radius:999px;
    font-weight:900;
    color:#374151;
    cursor:pointer;
  }
  .btn-submit{
    border:1px solid #2563eb;
    background:#2563eb;
    padding:8px 14px;
    border-radius:999px;
    font-weight:900;
    color:#fff;
    cursor:pointer;
  }
  .btn-submit:hover{ opacity:.92; }

  .comment-list{
    margin-top:14px;
    display:flex;
    flex-direction:column;
    gap:10px;
  }

  .comment-item{
    border:1px solid #eef2f7;
    border-radius:14px;
    padding:14px;
    background:#fff;
  }

  .comment-meta{
    display:flex;
    gap:8px;
    flex-wrap:wrap;
    align-items:center;
    color:#6b7280;
    font-weight:900;
    font-size:.88rem;
    margin-bottom:6px;
  }

  .comment-body{
    color:#111827;
    line-height:1.7;
    white-space:pre-wrap;
  }

  .comment-footer{
    margin-top:10px;
    display:flex;
    gap:10px;
    align-items:center;
    color:#6b7280;
    font-weight:900;
    font-size:.88rem;
  }

  .more-wrap{
    margin-top:12px;
    display:flex;
    justify-content:center;
  }

  .btn-more{
    border:1px solid #dbe2ee;
    background:#fff;
    padding:10px 18px;
    border-radius:12px;
    font-weight:900;
    color:#334155;
    cursor:pointer;
  }
  .btn-more:hover{ background:#f7f9fc; }

  /* 하단 네비 */
  .nav-bottom{
    margin-top:14px;
    display:flex;
    justify-content:flex-end;
    gap:8px;
  }
</style>

<main class="container wrap">

  <div class="card">
    <div class="content">

      <%-- =========================
           post 데이터 없을 때 샘플 표시
           실제 연결되면 post.title 등으로 교체
         ========================= --%>
      <c:choose>

        <c:when test="${empty post}">
          <div class="top-actions">
            <div>
              <span class="badge-cat">취준/이직</span>
              <h2 class="title">게시판 첫 화면 레이아웃 어떤가요?</h2>

              <div class="meta">
                <span>작성 51일 전</span>
                <span class="dot">·</span>
                <span>조회 15</span>
              </div>
            </div>

            <div class="menu">
              <button type="button" class="btn-ghost">신고</button>
              <button type="button" class="btn-ghost">작성자 신고</button>
            </div>
          </div>

          <div class="body">
레이아웃 어떤가요?
          </div>

          <div class="bottom-actions">
            <div class="actions-left">
              <button type="button" class="btn-ghost">좋아요</button>
              <button type="button" class="btn-ghost">스크랩</button>
              <span class="count">좋아요 0 · 스크랩 0</span>
            </div>

            <a class="btn-dark" href="${urlBoardList}">목록</a>
          </div>

          <%-- 댓글 섹션(샘플) --%>
          <div class="comment-wrap">
            <div class="comment-title">댓글 3</div>

            <div class="comment-box">
              <div class="comment-head">
                <div class="comment-hint">따뜻한 댓글을 남겨주세요 :)</div>
                <div class="comment-hint">0/5000자</div>
              </div>

              <textarea placeholder="댓글을 입력해주세요 :)"></textarea>

              <div class="comment-actions">
                <button type="button" class="btn-cancel">취소</button>
                <button type="button" class="btn-submit">등록</button>
              </div>
            </div>

            <div class="comment-list">
              <div class="comment-item">
                <div class="comment-meta">
                  <span>엄청빠른F1</span>
                  <span class="dot">·</span>
                  <span>6분 전</span>
                </div>
                <div class="comment-body">
나쁘지 않은것 같습니다.
                </div>
                <div class="comment-footer">
                  <span>좋아요 0</span>
                  <span class="dot">·</span>
                  <span>댓글 0</span>
                </div>
              </div>

              <div class="comment-item">
                <div class="comment-meta">
                  <span>현업1년차</span>
                  <span class="dot">·</span>
                  <span>1일 전</span>
                </div>
                <div class="comment-body">
많이 별로네요 수정이 필요해 보입니다..
                </div>
                <div class="comment-footer">
                  <span>좋아요 0</span>
                  <span class="dot">·</span>
                  <span>댓글 0</span>
                </div>
              </div>

              <div class="comment-item">
                <div class="comment-meta">
                  <span>익명</span>
                  <span class="dot">·</span>
                  <span>2일 전</span>
                </div>
                <div class="comment-body">
개선할 부분이 많이 보이는것 같습니다.
                </div>
                <div class="comment-footer">
                  <span>좋아요 0</span>
                  <span class="dot">·</span>
                  <span>댓글 0</span>
                </div>
              </div>
            </div>

            <div class="more-wrap">
              <button type="button" class="btn-more">댓글 더보기</button>
            </div>
          </div>

        </c:when>

        <%-- =========================
             실제 데이터 버전 (post / comments 있을 때)
           ========================= --%>
        <c:otherwise>

          <div class="top-actions">
            <div>
              <span class="badge-cat">${post.categoryName}</span>
              <h2 class="title">${post.title}</h2>

              <div class="meta">
                <span>${post.createdAtText}</span>
                <span class="dot">·</span>
                <span>조회 ${post.viewCount}</span>
              </div>
            </div>

            <div class="menu">
              <%-- 신고/작성자 신고 --%>
              <form action="${urlBoardReport}" method="post" style="margin:0;">
                <input type="hidden" name="postId" value="${post.postId}" />
                <button type="submit" class="btn-ghost">신고</button>
              </form>

              <%-- 수정/삭제는 작성자에게만 보이게 (조건은 너 프로젝트에 맞게) --%>
              <c:if test="${isOwner}">
                <a class="btn-ghost" href="${urlBoardEdit}?postId=${post.postId}">수정</a>
                <form action="${urlBoardDelete}" method="post" style="margin:0;"
                      onsubmit="return confirm('삭제할까요?');">
                  <input type="hidden" name="postId" value="${post.postId}" />
                  <button type="submit" class="btn-danger-soft">삭제</button>
                </form>
              </c:if>
            </div>
          </div>

          <div class="body">${post.content}</div>

          <div class="bottom-actions">
            <div class="actions-left">

              <form action="${urlBoardLike}" method="post" style="margin:0;">
                <input type="hidden" name="postId" value="${post.postId}" />
                <button type="submit" class="btn-ghost">좋아요</button>
              </form>

              <form action="${urlBoardScrap}" method="post" style="margin:0;">
                <input type="hidden" name="postId" value="${post.postId}" />
                <button type="submit" class="btn-ghost">스크랩</button>
              </form>

              <span class="count">좋아요 ${post.likeCount} · 스크랩 ${post.scrapCount}</span>
            </div>

            <a class="btn-dark" href="${urlBoardList}">목록</a>
          </div>

          <%-- 댓글 섹션 --%>
          <div class="comment-wrap">
            <div class="comment-title">댓글 ${commentCount}</div>

            <div class="comment-box">
              <div class="comment-head">
                <div class="comment-hint">따뜻한 댓글을 남겨주세요 :)</div>
                <div class="comment-hint">0/5000자</div>
              </div>

              <form action="${urlCommentWrite}" method="post">
                <input type="hidden" name="postId" value="${post.postId}" />
                <textarea name="content" placeholder="댓글을 입력해주세요 :)"></textarea>

                <div class="comment-actions">
                  <button type="reset" class="btn-cancel">취소</button>
                  <button type="submit" class="btn-submit">등록</button>
                </div>
              </form>
            </div>

            <div class="comment-list">
              <c:forEach var="cmt" items="${comments}">
                <div class="comment-item">
                  <div class="comment-meta">
                    <span>${cmt.writerNickname}</span>
                    <span class="dot">·</span>
                    <span>${cmt.createdAtText}</span>
                  </div>

                  <div class="comment-body">${cmt.content}</div>

                  <div class="comment-footer">
                    <span>좋아요 ${cmt.likeCount}</span>
                    <span class="dot">·</span>
                    <span>댓글 ${cmt.replyCount}</span>
                  </div>
                </div>
              </c:forEach>
            </div>

            <%-- 더보기 버튼(페이징/무한스크롤 붙일 때 사용) --%>
            <c:if test="${hasMoreComments}">
              <div class="more-wrap">
                <a class="btn-more" href="${urlCommentMore}?postId=${post.postId}&page=${nextCommentPage}">
                  댓글 더보기
                </a>
              </div>
            </c:if>

            <div class="nav-bottom">
              <a class="btn-ghost" href="javascript:window.scrollTo({top:0, behavior:'smooth'});">TOP</a>
              <a class="btn-dark" href="${urlBoardList}">목록</a>
            </div>

          </div>

        </c:otherwise>

      </c:choose>

    </div>
  </div>

</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>