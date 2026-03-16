<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<link rel="stylesheet" href="<c:url value='/resources/css/my/favorites.css'/>" type="text/css">
</head>

<body>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<!-- URL 수정 -->
<c:url var="urlFavorites" value="/my/favorites"/>
<c:url var="urlJobDetail" value="/job/JobDetail"/>  <%-- 예: /job/detail?jobId= --%>
<c:url var="urlApply" value="/apply"/>           <%-- 예: /apply?jobId= --%>
<c:url var="urlDeleteFav" value="/my/favorites/delete"/> <%-- POST 추천 --%>


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
			  <div class="empty">
			    <div style="font-size:48px;">💙</div>
			    <div class="big">관심 공고가 없습니다</div>
			    <div>마음에 드는 채용공고를 스크랩하면 여기에서 모아볼 수 있어요</div>
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
                        onclick="location.href='${urlJobDetail}?jobId=${fav.jobId}'">
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

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

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

</body>
</html>

