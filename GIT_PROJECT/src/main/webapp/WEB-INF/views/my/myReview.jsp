<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<%-- =========================================================
     [자기소개서 관리] myReview.jsp
     - myResume.jsp 구성 그대로 가져옴(통일감)
     - 좌측: mySidebar.jspf include
     - 우측: 사람인 "자소서 관리" 느낌의 카드/리스트 UI
     - 나중에 DB 붙이면: reviews 리스트를 c:forEach로 자동 출력
   ========================================================= --%>

<style>
  /* ====== 페이지 배경 ====== */
  body { background:#f6f7fb; }
  .mypage-wrap{ min-height:100vh; }

  /* ====== (참고) 사이드바 스타일은 mySidebar.jspf에 넣어도 되지만
     지금은 myResume.jsp랑 동일하게 여기에도 둠(통일감/빠른 작업용) ====== */
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
     URL 전부 c:url로 (ctx 변수 없음)
     - 매핑은 일단 뼈대용. 나중에 컨트롤러/DTO 맞춰서 변경하면 됨.
   ========================================================= --%>
<c:url var="urlMyReview" value="/my/myReview"/>

<c:url var="urlReviewCreate" value="/my/review/create"/>   <%-- 새 자소서 작성 --%>
<c:url var="urlReviewEdit" value="/my/review/edit"/>       <%-- 수정 (id param 나중에) --%>
<c:url var="urlReviewDelete" value="/my/review/delete"/>   <%-- 삭제 (나중에 POST 추천) --%>

<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">

    <%-- ✅ 좌측 사이드바 include --%>
    <%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

    <%-- ✅ 우측 컨텐츠 --%>
    <section class="col-10 myContent">
      <div class="myContent-inner">

        <h2 class="page-title">내 자기소개서</h2>
        <div class="page-desc">자기소개서를 작성/관리하고, 필요할 때 빠르게 수정할 수 있어요.</div>

        <%-- 상단 유틸 --%>
        <div class="topbar">
          <div class="countText">
            총 <strong><c:out value="${empty reviews ? 0 : fn:length(reviews)}"/></strong>건
          </div>

          <div class="d-flex align-items-center gap-2">
            <select class="form-select filterSelect" aria-label="filter">
              <option selected>전체</option>
              <option>대표</option>
              <option>미완성</option>
              <option>완성</option>
            </select>
          </div>
        </div>

        <%-- 대표/최근 자소서 카드(샘플) --%>
        <div class="reviewCard">
          <div class="reviewHeader">
            <div>
              <div>
                <span class="badgeDraft">미완성</span>
                <span class="reviewTitle"><c:out value="${loginUser.name}"/>의 자기소개서 입니다</span>
              </div>

              <div class="metaRow">
                <div class="metaItem">
                  <i class="bi bi-file-earmark-text"></i>
                  <span>문항: -</span>
                </div>
                <div class="metaItem">
                  <i class="bi bi-calendar3"></i>
                  <span>최종수정: -</span>
                </div>
                <div class="metaItem">
                  <i class="bi bi-building"></i>
                  <span>지원기업: -</span>
                </div>
              </div>
            </div>

            <div class="d-flex align-items-center gap-2">
              <a class="btn btn-outline-primary" href="${urlReviewCreate}">
                새 자기소개서 작성
              </a>

              <div class="dropdown">
                <button class="kebabBtn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                  <i class="bi bi-three-dots-vertical"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                  <li><a class="dropdown-item" href="${urlReviewEdit}">수정</a></li>
                  <li><a class="dropdown-item" href="#">대표 설정</a></li>
                  <li><hr class="dropdown-divider"></li>
                  <li><a class="dropdown-item text-danger" href="${urlReviewDelete}">삭제</a></li>
                </ul>
              </div>
            </div>
          </div>

          <div class="memoBar">
            <i class="bi bi-card-text"></i>
            <span>자소서 관련 중요한 메모를 남겨보세요. 예) 2/28까지 제출</span>
          </div>
        </div>

        <%-- 리스트 영역 (DB 붙으면 자동 출력) --%>
        <div class="reviewList">

          <c:choose>
            <c:when test="${not empty reviews}">
              <c:forEach var="rv" items="${reviews}">
                <div class="reviewItem">
                  <div>
                    <p class="reviewItem-title">
                      <c:out value="${rv.title}"/>
                      <c:if test="${rv.representative}">
                        <span class="badge text-bg-warning ms-2">대표</span>
                      </c:if>
                    </p>

                    <div class="reviewItem-sub">
                      기업: <c:out value="${rv.companyName}"/> ·
                      최종수정: <c:out value="${rv.updatedAt}"/> ·
                      상태: <c:out value="${rv.status}"/>
                    </div>
                  </div>

                  <div class="reviewActions">
                    <%-- id 파라미터 붙이는 버전 (나중에 그대로 쓰면 됨) --%>
                    <a class="btn btn-outline-secondary"
                       href="<c:url value='/my/review/edit'><c:param name='id' value='${rv.id}'/></c:url>">
                      수정
                    </a>
                    <button class="btn btn-light" type="button">복사</button>

                    <div class="dropdown">
                      <button class="kebabBtn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-three-dots-vertical"></i>
                      </button>
                      <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#">대표 설정</a></li>
                        <li><a class="dropdown-item text-danger" href="#">삭제</a></li>
                      </ul>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </c:when>

            <c:otherwise>
              <%-- 데이터 없을 때 샘플 --%>
              <div class="reviewItem">
                <div>
                  <p class="reviewItem-title">샘플 자기소개서 #1</p>
                  <div class="reviewItem-sub">기업: - · 최종수정: 2026-02-19 · 상태: 미완성</div>
                </div>
                <div class="reviewActions">
                  <a class="btn btn-outline-secondary" href="#">수정</a>
                  <button class="btn btn-light" type="button">복사</button>
                  <button class="kebabBtn" type="button"><i class="bi bi-three-dots-vertical"></i></button>
                </div>
              </div>

              <div class="reviewItem">
                <div>
                  <p class="reviewItem-title">샘플 자기소개서 #2</p>
                  <div class="reviewItem-sub">기업: - · 최종수정: 2026-02-10 · 상태: 완성</div>
                </div>
                <div class="reviewActions">
                  <a class="btn btn-outline-secondary" href="#">수정</a>
                  <button class="btn btn-light" type="button">복사</button>
                  <button class="kebabBtn" type="button"><i class="bi bi-three-dots-vertical"></i></button>
                </div>
              </div>
            </c:otherwise>
          </c:choose>

        </div>

      </div>
    </section>

  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

<%-- dropdown 동작하려면 bootstrap.bundle.js 필요
     footer.jspf에 없으면 아래 주석 해제
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
--%>
