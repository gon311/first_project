<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<%-- =========================
     URL (전부 c:url)
   ========================= --%>
<c:url var="urlRecommend" value="/my/recommend"/>              <%-- 목록(필터/정렬 GET) --%>
<c:url var="urlJobDetail" value="/job/JobDetail"/>             <%-- ?jobId= --%>
<c:url var="urlApply" value="/job/apply"/>                     <%-- ?jobId= (입사지원) --%>
<c:url var="urlHide" value="/my/recommend/hide"/>              <%-- POST: jobId --%>
<c:url var="urlBookmarkToggle" value="/my/bookmark/toggle"/>   <%-- POST: jobId --%>
<c:url var="urlToggleBookmark" value="/job/toggleBookmark" />  <%-- 스크랩 --%>	

<style>
  body{ background:#f6f7fb; }
  .mypage-wrap{ min-height:100vh; }

  /* =========================
     ✅ 공통 톤(사이드바/카드)
     ========================= */
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
     ✅ 상단 툴바(필터/정렬)
     ========================= */
  .toolbar{
    margin-top: 18px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:12px;
    padding:14px;
    border:1px solid #eef2f7;
    border-radius: 12px;
    background:#fff;
  }
  .toolbar-left, .toolbar-right{ display:flex; align-items:center; gap:10px; }

  .select{
    border:1px solid #dbe2ee;
    border-radius:10px;
    padding:10px 12px;
    font-weight:900;
    color:#334155;
    background:#fff;
    min-width: 140px;
  }

  .checkline{
    display:flex;
    align-items:center;
    gap:8px;
    padding: 10px 12px;
    border:1px solid #dbe2ee;
    border-radius:10px;
    background:#fff;
    font-weight:900;
    color:#334155;
  }
  .checkline input{ width:16px; height:16px; }

  /* =========================
     ✅ 리스트(행)
     ========================= */
  .job-list{ margin-top: 10px; }

  .job-item{
    display:flex;
    align-items:center;
    justify-content:space-between;
    gap: 18px;
    padding: 22px 8px;
    border-bottom: 1px solid #eef2f7;
  }

  .job-left{
    display:flex;
    align-items:flex-start;
    gap: 18px;
    min-width: 0;
    flex: 1;
  }

  .company{
    width: 140px;
    color:#6b7280;
    font-weight:900;
    flex-shrink:0;
  }

  .job-main{
    min-width: 0;
    flex: 1;
  }

  .job-title{
    display:inline-block;
    font-weight: 900;
    color:#111827;
    text-decoration:none;
    max-width: 760px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
  .job-title:hover{ text-decoration: underline; }

  .job-meta{
    margin-top: 6px;
    color:#6b7280;
    font-weight:800;
    font-size: .92rem;
    display:flex;
    gap: 10px;
    flex-wrap: wrap;
  }

  .tag{
    display:inline-block;
    margin-top: 10px;
    padding: 6px 10px;
    border-radius:999px;
    background:#f1f5f9;
    border:1px solid #e2e8f0;
    color:#334155;
    font-weight:900;
    font-size: .85rem;
  }

  .job-right{
    display:flex;
    align-items:center;
    gap: 12px;
    flex-shrink:0;
  }

  .btn-apply{
    background:#fff;
    border: 1px solid #ef4444;
    color:#ef4444;
    font-weight:900;
    border-radius: 10px;
    padding: 10px 18px;
    text-decoration:none;
    display:inline-block;
  }
  .btn-apply:hover{ background:#fff5f5; }

  .deadline{
    min-width: 110px;
    text-align:right;
    font-weight:900;
    color:#6b7280;
  }
  .deadline .today{ color:#ef4444; }

  /* 더보기(⋮) */
  .more-btn{
    width: 38px;
    height: 38px;
    border-radius: 10px;
    border:1px solid #e5e7eb;
    background:#fff;
    display:flex;
    align-items:center;
    justify-content:center;
    cursor:pointer;
  }
  .more-btn:hover{ background:#f7f9fc; }

  .more-wrap{ position:relative; }
  .more-menu{
    display:none;
    position:absolute;
    right:0;
    top: 44px;
    width: 170px;
    background:#fff;
    border:1px solid #eef2f7;
    border-radius: 12px;
    box-shadow:0 14px 30px rgba(15,23,42,.10);
    overflow:hidden;
    z-index: 10;
  }

  /* 메뉴 버튼(폼 submit) - ✅ 이거 없으면 버튼이 겹쳐 클릭이 위로 빨리는 경우가 있음 */
  .more-menu form { margin:0; }
  .more-menu .menu-btn{
    display:block;
    width:100%;
    text-align:left;
    border:0;
    background:#fff;
    padding: 12px 12px;
    color:#111827;
    font-weight:900;
    font-size:.92rem;
    cursor:pointer;
  }
  .more-menu .menu-btn:hover{ background:#f7f9fc; }
  .more-divider{ height:1px; background:#eef2f7; }

  /* 빈 화면 */
  .empty{
    margin-top: 26px;
    padding: 90px 0;
    text-align:center;
    color:#6b7280;
  }
  .empty .big{
    font-weight:900;
    font-size:1.1rem;
    color:#111827;
    margin-top: 10px;
  }

  /* 페이지네이션 */
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

    <%-- ✅ 왼쪽 사이드바(inc) --%>
    <%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

    <%-- ✅ 오른쪽 컨텐츠 --%>
    <section class="col-10 myContent">
      <div class="myContent-inner">

        <h2 class="page-title">추천 공고</h2>
        <div class="page-desc">내 활동 기반으로 추천된 공고를 확인할 수 있어요.</div>

        <%-- =========================
             상단 필터/정렬 (적용 버튼 X / 변경 즉시 반영)
           ========================= --%>
        <form action="${urlRecommend}" method="get" class="toolbar" id="filterForm">
          <div class="toolbar-left">
            <select class="select" name="size" id="sizeSelect">
              <option value="5"  <c:if test="${pager.size == 5}">selected</c:if>>5개씩</option>
              <option value="10" <c:if test="${pager.size == 10}">selected</c:if>>10개씩</option>
              <option value="15" <c:if test="${pager.size == 15}">selected</c:if>>15개씩</option>
            </select>

            <label class="checkline">
              <input type="checkbox" name="onlyApplyable" id="onlyApplyableChk"
                     <c:if test="${onlyApplyable}">checked</c:if>>
              입사지원 공고만
            </label>
          </div>

          <div class="toolbar-right">
            <select class="select" name="sort" id="sortSelect">
              <option value="PREF" <c:if test="${sort == 'PREF'}">selected</c:if>>선호도순</option>
              <option value="RECENT_DESC" <c:if test="${sort == 'RECENT_DESC'}">selected</c:if>>최근등록순</option>
              <option value="DEADLINE_ASC" <c:if test="${sort == 'DEADLINE_ASC'}">selected</c:if>>마감임박순</option>
            </select>

            <%-- 변경 시 page는 1로 리셋 --%>
            <input type="hidden" name="page" value="1"/>
          </div>
        </form>

        <%-- =========================
             리스트
           ========================= --%>
        <c:choose>
          <c:when test="${empty list}">
            <div class="empty">
              <div style="font-size:48px;">📌</div>
              <div class="big">추천 공고가 아직 없어요</div>
              <div>북마크를 추가하면 더 정확한 추천을 받을 수 있어요.</div>
            </div>
          </c:when>

          <c:otherwise>
            <div class="job-list">
              <c:forEach var="row" items="${list}">
                <div class="job-item">
                  <div class="job-left">
                    <%-- 회사명 DTO가 없으니  field 표시 (원하면 JOIN으로 company_name 추가) --%>
                    <div class="company"><c:out value="${row.field}"/></div>

                    <div class="job-main">
                      <a class="job-title" href="${urlJobDetail}?jobId=${row.jobId}">
                        <c:out value="${row.title}"/>
                      </a>

                      <div class="job-meta">
                        <span><c:out value="${row.field}"/></span>
                        <span><c:out value="${row.address}"/></span>
                        <span>점수 <fmt:formatNumber value="${row.score}" maxFractionDigits="2"/></span>
                      </div>

                      <c:choose>
                        <c:when test="${row.score >= 70}">
                          <div class="tag">당신에게 강력 추천</div>
                        </c:when>
                        <c:when test="${row.score >= 40}">
                          <div class="tag">관심 분야와 유사</div>
                        </c:when>
                        <c:otherwise>
                          <div class="tag">새로운 기회</div>
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </div>

                  <div class="job-right">
                    <a class="btn-apply" href="${urlApply}?jobId=${row.jobId}">입사지원</a>

                    <div class="deadline">
                      ~ <fmt:formatDate value="${row.closeDate}" pattern="MM/dd(E)"/>
                    </div>

                    <div class="more-wrap">
                      <button type="button" class="more-btn" onclick="toggleMoreMenu(this)">⋮</button>

                      <div class="more-menu">
                        <%-- ✅ 추천에서 제외 (POST) --%>
                        <form action="${urlHide}" method="post">
                          <input type="hidden" name="jobId" value="${row.jobId}"/>
                          <%-- 필터/페이지 유지 --%>
                          <input type="hidden" name="page" value="${pager.page}"/>
                          <input type="hidden" name="size" value="${pager.size}"/>
                          <input type="hidden" name="sort" value="${sort}"/>
                          <input type="hidden" name="onlyApplyable" value="${onlyApplyable}"/>
                          <button type="submit" class="menu-btn">추천에서 제외</button>
                        </form>

                        <div class="more-divider"></div>

                        <%-- ✅ 스크랩 토글 (POST) --%>
                        <form action="${urlBookmarkToggle}" method="post">
                          <input type="hidden" name="jobId" value="${row.jobId}"/>
                          <%-- 필터/페이지 유지 --%>
                          <input type="hidden" name="page" value="${pager.page}"/>
                          <input type="hidden" name="size" value="${pager.size}"/>
                          <input type="hidden" name="sort" value="${sort}"/>
                          <input type="hidden" name="onlyApplyable" value="${onlyApplyable}"/>
                          <button type="submit" class="menu-btn">스크랩</button>
                        </form>
                      </div>
                    </div>

                  </div>
                </div>
              </c:forEach>
            </div>

            <%-- =========================
                 페이징 (PageRes 기준)
           ========================= --%>
            <div class="pager">
              <c:if test="${pager.hasPrev}">
                <a href="${urlRecommend}?page=${pager.page - 1}&size=${pager.size}&sort=${sort}&onlyApplyable=${onlyApplyable}">이전</a>
              </c:if>

              <c:forEach var="p" begin="${pager.startPage}" end="${pager.endPage}">
                <a href="${urlRecommend}?page=${p}&size=${pager.size}&sort=${sort}&onlyApplyable=${onlyApplyable}"
                   class="<c:if test='${p == pager.page}'>active</c:if>">
                  ${p}
                </a>
              </c:forEach>

              <c:if test="${pager.hasNext}">
                <a href="${urlRecommend}?page=${pager.page + 1}&size=${pager.size}&sort=${sort}&onlyApplyable=${onlyApplyable}">다음</a>
              </c:if>
            </div>
          </c:otherwise>
        </c:choose>

      </div>
    </section>
  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

<script>
  // ✅ 툴바: 변경 즉시 submit (적용 버튼 없음)
  (function(){
    const form = document.getElementById('filterForm');
    const size = document.getElementById('sizeSelect');
    const sort = document.getElementById('sortSelect');
    const only = document.getElementById('onlyApplyableChk');

    function submitNow(){ if(form) form.submit(); }

    if(size) size.addEventListener('change', submitNow);
    if(sort) sort.addEventListener('change', submitNow);
    if(only) only.addEventListener('change', submitNow);
  })();

  // ✅ ⋮ 더보기 메뉴 토글
  function toggleMoreMenu(btn){
    const wrap = btn.closest('.more-wrap');
    const menu = wrap.querySelector('.more-menu');

    // 다른 메뉴 닫기
    document.querySelectorAll('.more-menu').forEach(m => {
      if (m !== menu) m.style.display = 'none';
    });

    // 토글
    menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
  }

  // 바깥 클릭 시 닫기
  document.addEventListener('click', function(e){
    const isMore = e.target.closest('.more-wrap');
    if(!isMore){
      document.querySelectorAll('.more-menu').forEach(m => m.style.display = 'none');
    }
  });
</script>