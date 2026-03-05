<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/my/recommend.css'/>" type="text/css">
</head>

<body>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<!-- 수정 URL들 -->
<c:url var="urlRecommend" value="/my/recommend"/>              <%-- 목록(필터/정렬 GET) --%>
<c:url var="urlJobDetail" value="/job/JobDetail"/>             <%-- ?jobId= --%>
<c:url var="urlApply" value="/job/apply"/>                     <%-- ?jobId= (입사지원) --%>
<c:url var="urlHide" value="/my/recommend/hide"/>              <%-- POST: jobId --%>
<c:url var="urlBookmarkToggle" value="/my/bookmark/toggle"/>   <%-- POST: jobId --%>
<c:url var="urlRecoBookmark" value="/my/recommend/bookmark"/>  <%-- 추천에서 스크랩(확정) --%>

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
							<form action="${urlRecoBookmark}" method="post">
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
</body>
</html>




