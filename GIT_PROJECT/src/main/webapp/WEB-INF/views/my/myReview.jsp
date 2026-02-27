<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<%-- =========================================================
     [자기소개서 관리] myReview.jsp
   ========================================================= --%>

<style>
  /* ====== 페이지 배경 ====== */
  body { background:#f6f7fb; }
  .mypage-wrap{ min-height:100vh; }

  /* ====== 사이드바 스타일 */
  .mySidebar{
    background:#fff;
    border-right:1px solid #e9edf3;
    min-height: 100vh;
  }
  .mySidebar-inner{
    position: sticky;
    top: 0;
    padding: 18px 14px;
  }
  .mySidebar-brand{ padding: 6px 8px 16px; display:flex; align-items:center; gap:10px; }
  .brandText{ font-weight:900; letter-spacing:-.4px; color:#2563eb; font-size:1.2rem; }

  .myNav{ display:flex; flex-direction:column; gap:4px; }
  .myNav-link{
    display:flex; align-items:center; gap:10px;
    padding:10px 10px; border-radius:10px;
    text-decoration:none; color:#334155; font-weight:600;
    position:relative;
  }
  .myNav-link i{ font-size:1.05rem; color:#94a3b8; width:20px; text-align:center; }
  .myNav-link:hover{ background:#f3f6fb; }
  .myNav-link.active{
    background:#eaf2ff; color:#1d4ed8; font-weight:800;
  }
  .myNav-link.active i{ color:#1d4ed8; }
  .myNav-link.active::before{
    content:""; position:absolute; left:-6px; top:10px; bottom:10px;
    width:3px; border-radius:999px; background:#1d4ed8;
  }

  /* ====== 우측 컨텐츠 카드(공통 톤) ====== */
  .myContent{ padding:22px 22px; }
  .myContent-inner{
    background:#fff;
    border:1px solid #eef2f7;
    border-radius:16px;
    box-shadow:0 10px 30px rgba(15,23,42,.04);
    padding:22px 22px;
    min-height: calc(100vh - 80px);
  }

  .page-title{
    font-size:1.45rem;
    font-weight:900;
    letter-spacing:-.5px;
    margin:0;
  }
  .page-desc{
    color:#6b7280;
    font-size:.92rem;
    margin-top:6px;
  }

  /* ====== 상단 유틸 ====== */
  .topbar{
    margin-top: 14px;
    padding-top: 8px;
    border-top: 1px solid #eef2f7;
    display:flex;
    align-items:center;
    justify-content: space-between;
    gap: 12px;
  }
  .countText{
    color:#6b7280;
    font-weight:700;
    font-size:.92rem;
  }
  .filterSelect{
    width: 180px;
    border-radius: 10px;
    border-color:#d9dde3;
    padding: .55rem .8rem;
    font-weight:700;
  }
  .filterSelect:focus{
    box-shadow:none;
    border-color:#9bbcff;
  }

  /* ====== 상단 "대표 자소서" 카드 ====== */
  .reviewCard{
    margin-top: 18px;
    border:1px solid #eef2f7;
    border-radius: 14px;
    padding: 18px 18px;
  }
  .reviewHeader{
    display:flex;
    align-items:flex-start;
    justify-content: space-between;
    gap: 14px;
  }
  
  .badgeComplete{
  display:inline-block;
  padding:2px 8px;
  border-radius:999px;
  font-weight:700;
  font-size:12px;
  color:#0f766e;           /* 초록 계열 */
  background:#ecfdf5;
  border:1px solid #99f6e4;
  }
  

  .badgeDraft{
    display:inline-block;
    font-size:.78rem;
    font-weight:900;
    color:#ef4444;
    margin-right: 8px;
  }
  .reviewTitle{
    font-size: 1.15rem;
    font-weight: 900;
    letter-spacing: -.2px;
    color:#111827;
    margin:0;
  }

  .metaRow{
    margin-top: 8px;
    display:flex;
    flex-wrap:wrap;
    gap: 14px 18px;
    color:#6b7280;
    font-size:.92rem;
    font-weight:700;
  }
  .metaItem{
    display:flex;
    align-items:center;
    gap: 6px;
  }
  .metaItem i{ color:#9ca3af; }

  .btn-outline-primary{
    border-radius: 10px;
    font-weight:900;
    padding: .6rem 1.2rem;
  }

  .memoBar{
    margin-top: 16px;
    background:#f3f6fb;
    border:1px solid #e7eefc;
    border-radius: 10px;
    padding: 12px 14px;
    color:#6b7280;
    font-size:.9rem;
    font-weight:700;
    display:flex;
    align-items:center;
    gap: 10px;
  }
  .memoBar i{ color:#94a3b8; }

  /* ====== 리스트 ====== */
  .reviewList{
    margin-top: 16px;
    display:grid;
    grid-template-columns: 1fr;
    gap: 14px;
  }
  .reviewItem{
    border:1px solid #eef2f7;
    border-radius: 14px;
    padding: 16px 16px;
    display:flex;
    align-items:flex-start;
    justify-content: space-between;
    gap: 14px;
    background:#fff;
  }
  .reviewItem-title{
    font-weight:900;
    color:#111827;
    margin:0;
  }
  .reviewItem-sub{
    margin-top: 6px;
    color:#6b7280;
    font-weight:700;
    font-size:.9rem;
  }

  .reviewActions{
    display:flex;
    align-items:center;
    gap: 8px;
  }
  .btn-light, .btn-outline-secondary{
    border-radius: 10px;
    font-weight:800;
    padding: .55rem .95rem;
  }

  .kebabBtn{
    border:1px solid #eef2f7;
    background:#fff;
    border-radius: 10px;
    width: 40px;
    height: 40px;
    display:flex;
    align-items:center;
    justify-content:center;
    color:#64748b;
  }
  .kebabBtn:hover{ background:#f8fafc; }
</style>

<%-- =========================================================
     URL 전부 c:url
   ========================================================= --%>
<c:url var="urlMyReview" value="/my/myReview"/>
<c:url var="urlReviewCreate" value="/my/review/create"/>   <%-- 새 자소서 작성 --%>
<c:url var="urlReviewEdit" value="/my/review/edit"/>       <%-- 수정 (id param 나중에) --%>
<c:url var="urlReviewDelete" value="/my/review/delete"/>   <%-- 삭제 (나중에 POST 추천) --%>

<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">
	<!-- 사이드바 -->
    <%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

    <section class="col-10 myContent">
      <div class="myContent-inner">

        <!-- 타이틀 -->
        <h2 class="page-title">내 자기소개서</h2>
        <div class="page-desc">자기소개서를 작성/관리하고, 필요할 때 빠르게 수정할 수 있어요.</div>

        <!-- 필터 기본값 -->
        <c:set var="filter" value="${empty param.filter ? 'ALL' : param.filter}"/>

        <!-- 상단: 총 건수 + 작성 버튼 + 상태 필터 -->
        <div class="topbar">
          <div class="countText">
            총 <strong><c:out value="${empty myReviews ? 0 : fn:length(myReviews)}"/></strong>건
          </div>

          <div class="d-flex align-items-center gap-2">
            <a class="btn btn-outline-primary" href="${urlReviewCreate}">
              새 자기소개서 작성
            </a>

            <select class="form-select filterSelect"
                    aria-label="filter"
                    onchange="location.href='${urlMyReview}?filter=' + this.value;">
              <option value="ALL"      ${filter eq 'ALL' ? 'selected' : ''}>전체</option>
              <option value="DRAFT"    ${filter eq 'DRAFT' ? 'selected' : ''}>미완성</option>
              <option value="COMPLETE" ${filter eq 'COMPLETE' ? 'selected' : ''}>완성</option>
            </select>
          </div>
        </div>

        <!-- 리스트 -->
        <div class="reviewList">
          <c:choose>
            <c:when test="${not empty myReviews}">
              <c:forEach var="rv" items="${myReviews}">

                <!-- 필터 조건: COMPLETE(0) / DRAFT(1,2) -->
                <c:if test="${filter eq 'ALL'
                              || (filter eq 'COMPLETE' && rv.status == 0)
                              || (filter eq 'DRAFT' && rv.status != 0)}">

                  <div class="reviewCard">
                    <div class="reviewHeader">

                      <div>
                        <div>
                          <!-- 상태 배지 -->
                          <c:choose>
                            <c:when test="${rv.status == 0}">
                              <span class="badgeComplete">완성</span>
                            </c:when>
                            <c:when test="${rv.status == 1}">
                              <span class="badgeDraft">작성중</span>
                            </c:when>
                            <c:otherwise>
                              <span class="badgeDraft">임시저장</span>
                            </c:otherwise>
                          </c:choose>

                          <!-- 제목 -->
                          <span class="reviewTitle"><c:out value="${rv.title}"/></span>
                        </div>

                        <!-- 메타 -->
                        <div class="metaRow">
                          <div class="metaItem">
                            <i class="bi bi-building"></i>
                            <span>기업: <c:out value="${rv.companyName}"/></span>
                          </div>
                          <div class="metaItem">
                            <i class="bi bi-calendar3"></i>
                            <span>작성일: <c:out value="${rv.createdAtStr}"/></span>
                          </div>
                        </div>
                      </div>

                      <!-- 액션 -->
                      <div class="d-flex align-items-center gap-2">
                        <a class="btn btn-outline-primary"
                           href="${urlReviewEdit}?coverLetterIdx=${rv.coverLetterIdx}"
                           onclick="return confirm('자기소개서를 수정하시겠습니까?');">
                          수정
                        </a>

						<!-- 삭제 -->
						<form action="${urlReviewDelete}" method="post" style="display:inline;"
						      onsubmit="return confirm('정말 삭제하시겠습니까? 삭제 후 복구가 어려울 수 있어요.');">
						  <input type="hidden" name="coverLetterIdx" value="${rv.coverLetterIdx}" />
						  <button type="submit" class="btn btn-outline-danger">삭제</button>
						</form>
						
                      </div>

                    </div>
                  </div>

                </c:if>
              </c:forEach>
            </c:when>

            <c:otherwise>
              <div class="reviewCard">
                아직 작성한 자기소개서가 없습니다.
              </div>
            </c:otherwise>

          </c:choose>
        </div>

      </div>
    </section>

  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>