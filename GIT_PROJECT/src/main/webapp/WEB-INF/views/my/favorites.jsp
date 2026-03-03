<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<%-- =========================
     URL
     - 컨트롤러 매핑에 맞게 value만 바꾸면 됨
   ========================= --%>
<c:url var="urlFavorites" value="/my/favorites"/>
<c:url var="urlJobDetail" value="/job/JobDetail"/>  <%-- 예: /job/detail?jobId= --%>
<c:url var="urlApply" value="/apply"/>           <%-- 예: /apply?jobId= --%>
<c:url var="urlDeleteFav" value="/my/favorites/delete"/> <%-- POST 추천 --%>




<style>
  body { background:#f6f7fb; }
  .mypage-wrap{ min-height:100vh; }

  /* ✅ 사이드바(이미 쓰던 스타일 그대로) */
  .mySidebar{ background:#fff; border-right:1px solid #e9edf3; min-height:100vh; }
  .mySidebar-inner{ position:sticky; top:0; padding:18px 14px; }
  .mySidebar-brand{ padding:6px 8px 16px; display:flex; align-items:center; gap:10px; }
  .brandText{ font-weight:900; letter-spacing:-.4px; color:#2563eb; font-size:1.2rem; }
  .myNav{ display:flex; flex-direction:column; gap:4px; }
  .myNav-link{
    display:flex; align-items:center; gap:10px;
    padding:10px 10px; border-radius:10px;
    text-decoration:none; color:#334155; font-weight:600; position:relative;
  }
  .myNav-link i{ font-size:1.05rem; color:#94a3b8; width:20px; text-align:center; }
  .myNav-link:hover{ background:#f3f6fb; }
  .myNav-link.active{ background:#eaf2ff; color:#1d4ed8; font-weight:800; }
  .myNav-link.active i{ color:#1d4ed8; }
  .myNav-link.active::before{
    content:""; position:absolute; left:-6px; top:10px; bottom:10px;
    width:3px; border-radius:999px; background:#1d4ed8;
  }

  /* ✅ 오른쪽 컨텐츠 카드 */
  .myContent{ padding:22px; }
  .myContent-inner{
    background:#fff;
    border:1px solid #eef2f7;
    border-radius:16px;
    box-shadow:0 10px 30px rgba(15,23,42,.04);
    padding:22px;
    min-height: calc(100vh - 80px);
  }

  .page-title{ font-size:1.6rem; font-weight:900; letter-spacing:-.6px; margin:0; }
  .page-desc{ color:#6b7280; font-size:.92rem; margin-top:8px; }

  /* =========================
     ✅ 상단 툴바(삭제/이동/필터/검색)
     - 사람인 느낌: 얇은 보더 + 라운드
     ========================= */
  .toolbar{
    margin-top: 18px;
    display:flex;
    align-items:center;
    justify-content:space-between;
    gap:12px;
    padding: 12px 12px;
    border:1px solid #eef2f7;
    border-radius: 12px;
    background:#fff;
  }
  .toolbar-left, .toolbar-right{
    display:flex;
    align-items:center;
    gap:10px;
  }

  .chk{
    width:18px; height:18px;
    accent-color:#2563eb;
  }

  .btn-ghost{
    border:1px solid #dbe2ee;
    background:#fff;
    padding:8px 12px;
    border-radius:10px;
    font-weight:800;
    color:#334155;
  }
  .btn-ghost:hover{ background:#f7f9fc; }

  .select{
    border:1px solid #dbe2ee;
    border-radius:10px;
    padding:8px 12px;
    font-weight:800;
    color:#334155;
    background:#fff;
  }

  .search-wrap{
    display:flex;
    align-items:center;
    gap:8px;
    border:1px solid #dbe2ee;
    border-radius:10px;
    padding: 8px 12px;
    min-width: 260px;
  }
  .search-wrap input{
    border:0;
    outline:none;
    width: 220px;
  }
  .search-ico{ color:#94a3b8; font-size:1.1rem; }

  /* =========================
     ✅ 리스트 영역
     - 한 줄(row) 구조
     - (1) 제목 클릭 → 상세 이동
     - (2) 입사지원 버튼
     - (3) 삭제 아이콘
     ========================= */
  .list{
    margin-top: 14px;
    border-top: 1px solid #eef2f7;
  }

  .row-item{
    display:flex;
    align-items:flex-start;
    gap: 14px;
    padding: 18px 6px;
    border-bottom: 1px solid #eef2f7;
  }

  .row-left{
    width: 24px;
    padding-top: 3px;
  }

  .row-mid{
    flex: 1;
    min-width: 0;
  }

  .company{
    color:#6b7280;
    font-weight:800;
    font-size:.92rem;
    margin-bottom: 6px;
  }

  /* (1) 제목 클릭 이동 */
  .title-link{
    display:inline-block;
    font-weight:900;
    font-size:1.15rem;
    color:#111827;
    text-decoration:none;
    max-width: 100%;
    white-space: nowrap;
    overflow:hidden;
    text-overflow: ellipsis;
  }
  .title-link:hover{ text-decoration:underline; }

  .subline{
    margin-top: 6px;
    color:#6b7280;
    font-size:.92rem;
  }

  .row-right{
    display:flex;
    align-items:center;
    gap: 10px;
    padding-top: 4px;
    min-width: 210px;
    justify-content:flex-end;
  }

  /* (2) 입사지원 버튼 */
  .btn-apply{
    background:#fff;
    border:1px solid #ff6b6b;
    color:#ff6b6b;
    font-weight:900;
    border-radius: 10px;
    padding: 10px 18px;
  }
  .btn-apply:hover{
    background:#fff5f5;
  }

  .btn-dead{
    background:#f3f4f6;
    border:1px solid #e5e7eb;
    color:#9ca3af;
    font-weight:900;
    border-radius: 10px;
    padding: 10px 18px;
    cursor:not-allowed;
  }

  /* (3) 삭제 아이콘 */
  .btn-trash{
    border:0;
    background:transparent;
    font-size:1.3rem;
    color:#9ca3af;
    padding: 6px 8px;
    border-radius: 10px;
  }
  .btn-trash:hover{
    background:#f3f4f6;
    color:#6b7280;
  }

  /* 날짜/마감 표시(오른쪽 작은 텍스트) */
  .deadline{
    display:flex;
    flex-direction:column;
    align-items:flex-end;
    gap: 4px;
    margin-left: 6px;
    min-width: 70px;
  }
  .deadline .d1{ color:#9ca3af; font-weight:800; font-size:.85rem; }
  .deadline .d2{ color:#9ca3af; font-size:.85rem; }

  /* 페이지네이션(뼈대) */
  .pager{
    margin-top: 18px;
    display:flex;
    justify-content:center;
    gap: 8px;
  }
  .pager a{
    display:inline-block;
    min-width: 34px;
    text-align:center;
    padding: 8px 10px;
    border:1px solid #e5e7eb;
    border-radius: 10px;
    text-decoration:none;
    color:#374151;
    font-weight:900;
    background:#fff;
  }
  .pager a.active{
    background:#2563eb;
    border-color:#2563eb;
    color:#fff;
  }
</style>

<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">
    <%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

    <section class="col-10 myContent">
      <div class="myContent-inner">

        <h2 class="page-title">관심 목록</h2>
        <div class="page-desc">스크랩한 공고를 확인하고, 지원/삭제할 수 있어요.</div>

        <!-- =========================
             ✅ 상단 툴바
             - (1) 전체선택 + 선택삭제(일괄)
             - (2) 상태/사이즈/지원제외/키워드
           ========================= -->
        <div class="toolbar">

          <!-- ✅ 일괄 삭제 폼 -->
          <form id="bulkDeleteForm" action="${urlDeleteFav}" method="post" class="toolbar-left" style="margin:0;">
            <input type="checkbox" class="chk" id="checkAll" title="전체 선택">
            <button type="submit" class="btn-ghost">삭제</button>

            <!-- ✅ 현재 상태 유지(redirect용) -->
            <input type="hidden" name="page" value="${pager.page}">
            <input type="hidden" name="size" value="${pager.size}">
            <input type="hidden" name="status" value="${status}">
            <input type="hidden" name="excludeApplied" value="${excludeApplied}">
            <input type="hidden" name="keyword" value="${empty keyword ? '' : keyword}">
          </form>

          <!-- ✅ 필터/검색 폼 (GET) -->
          <form action="${urlFavorites}" method="get" class="toolbar-right" style="margin:0;">

            <!-- 상태 -->
            <select class="select" name="status" onchange="this.form.submit()">
              <option value="ALL"    ${status=='ALL' ? 'selected' : ''}>전체</option>
              <option value="OPEN"   ${status=='OPEN' ? 'selected' : ''}>진행중</option>
              <option value="CLOSED" ${status=='CLOSED' ? 'selected' : ''}>마감</option>
            </select>

            <!-- size: 5/10/15 -->
            <select class="select" name="size" onchange="this.form.page.value=1; this.form.submit()">
              <option value="5"  ${pager.size==5  ? 'selected' : ''}>5개씩</option>
              <option value="10" ${pager.size==10 ? 'selected' : ''}>10개씩</option>
              <option value="15" ${pager.size==15 ? 'selected' : ''}>15개씩</option>
            </select>

            <!-- 지원한 공고 제외 -->
            <label style="display:flex; align-items:center; gap:6px; font-weight:900; color:#374151;">
              <input type="checkbox" class="chk" name="excludeApplied" value="true"
                     ${excludeApplied ? 'checked' : ''} onchange="this.form.page.value=1; this.form.submit()">
              지원한 공고 제외
            </label>

            <!-- 키워드 -->
            <div class="search-wrap">
              <input type="text" name="keyword" placeholder="키워드 입력" value="${empty keyword ? '' : keyword}">
            </div>

            <!-- page 유지용 -->
            <input type="hidden" name="page" value="${pager.page}">
          </form>

        </div>

        <!-- =========================
             ✅ 리스트
           ========================= -->
        <div class="list">
          <c:if test="${empty favorites}">
            <div style="padding:20px; color:#6b7280; font-weight:800;">
              관심 공고가 없습니다.
            </div>
          </c:if>

          <c:forEach var="fav" items="${favorites}">
            <div class="row-item">

              <div class="row-left">
                <!-- ✅ 체크된 것만 일괄삭제 폼으로 전송 -->
                <input type="checkbox" class="chk jobChk"
                       name="jobIds"
                       value="${fav.jobId}"
                       form="bulkDeleteForm">
              </div>

              <div class="row-mid">
                <div class="company">${fav.companyName}</div>

                <a class="title-link" href="${urlJobDetail}?jobId=${fav.jobId}">
                  ${fav.title}
                </a>

                <div class="subline">
                  ${fav.expType} · ${fav.expYear} · ${fav.edu} · ${fav.empType} · ${fav.address}
                </div>
              </div>

              <div class="row-right">

                <!-- (옵션) 입사지원 -->
                <button type="button" class="btn-ghost"
                        onclick="location.href='${urlApply}?jobId=${fav.jobId}'">
                  입사지원
                </button>

                <!-- ✅ 단일 삭제(🗑) : 같은 urlDeleteFav 사용 -->
                <form action="${urlDeleteFav}" method="post" style="margin:0;">
                  <input type="hidden" name="jobId" value="${fav.jobId}"/>

                  <!-- ✅ 현재 상태 유지(redirect용) -->
                  <input type="hidden" name="page" value="${pager.page}">
                  <input type="hidden" name="size" value="${pager.size}">
                  <input type="hidden" name="status" value="${status}">
                  <input type="hidden" name="excludeApplied" value="${excludeApplied}">
                  <input type="hidden" name="keyword" value="${empty keyword ? '' : keyword}">

                  <button type="submit" class="btn-trash" title="삭제">🗑</button>
                </form>

              </div>

            </div>
          </c:forEach>
        </div>

        <!-- =========================
             ✅ 페이지네이션
           ========================= -->
        <c:if test="${pager.total > 0}">
          <div class="pager">
            <c:if test="${pager.hasPrev}">
              <a href="${urlFavorites}?page=${pager.page-1}&size=${pager.size}&status=${status}&excludeApplied=${excludeApplied}&keyword=${empty keyword ? '' : keyword}">이전</a>
            </c:if>

            <c:forEach var="p" begin="${pager.startPage}" end="${pager.endPage}">
              <c:choose>
                <c:when test="${p == pager.page}">
                  <a class="active" href="${urlFavorites}?page=${p}&size=${pager.size}&status=${status}&excludeApplied=${excludeApplied}&keyword=${empty keyword ? '' : keyword}">
                    ${p}
                  </a>
                </c:when>
                <c:otherwise>
                  <a href="${urlFavorites}?page=${p}&size=${pager.size}&status=${status}&excludeApplied=${excludeApplied}&keyword=${empty keyword ? '' : keyword}">
                    ${p}
                  </a>
                </c:otherwise>
              </c:choose>
            </c:forEach>

            <c:if test="${pager.hasNext}">
              <a href="${urlFavorites}?page=${pager.page+1}&size=${pager.size}&status=${status}&excludeApplied=${excludeApplied}&keyword=${empty keyword ? '' : keyword}">다음</a>
            </c:if>
          </div>
        </c:if>

      </div>
    </section>
  </div>
</main>

<script>
  (function () {
    const checkAll = document.getElementById("checkAll");
    if (!checkAll) return;

    // 전체 선택
    checkAll.addEventListener("change", function () {
      const checked = this.checked;
      document.querySelectorAll(".jobChk").forEach(cb => cb.checked = checked);
    });

    // 선택 삭제 시 아무것도 선택 안 하면 막기
    const bulkForm = document.getElementById("bulkDeleteForm");
    bulkForm.addEventListener("submit", function (e) {
      const anyChecked = document.querySelectorAll(".jobChk:checked").length > 0;
      if (!anyChecked) {
        e.preventDefault();
        alert("삭제할 공고를 선택해주세요.");
      }
    });
  })();
</script>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>



