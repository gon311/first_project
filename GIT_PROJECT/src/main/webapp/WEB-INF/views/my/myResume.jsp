<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- =========================================================
     [이력서 관리] myResume.jsp
     - common.css 없이: 이 파일 내부 style로만 구성
     - 좌측: mySidebar.jspf include
     - 우측: 사람인 "이력서 관리" 느낌의 카드/리스트 UI
     - 나중에 DB 붙이면: resumes 리스트를 c:forEach로 자동 출력
   ========================================================= --%>

<%-- (선택) head.jspf에 부트스트랩이 없다면 아래 주석 해제
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>
--%>

<style>
  /* ====== 페이지 배경 ====== */
  body { background:#f6f7fb; }

  .mypage-wrap{ min-height:100vh; }
  
  
  /* ====== 사이드 바 ====== */
  .mySidebar{
    background:#fff;
    border-right:1px solid #e9edf3;
    min-height: 100vh;
  }
  .mySidebar-inner{
    position: sticky;
    top: 0;               /* 헤더가 fixed면 여기만 px로 조정 */
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

  /* ====== 상단 유틸(총건수 + 필터) ====== */
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
    width: 160px;
    border-radius: 10px;
    border-color:#d9dde3;
    padding: .55rem .8rem;
    font-weight:700;
  }
  .filterSelect:focus{
    box-shadow:none;
    border-color:#9bbcff;
  }

  /* ====== 사람인 느낌: "이력서 카드" ====== */
  .resumeCard{
    margin-top: 18px;
    border:1px solid #eef2f7;
    border-radius: 14px;
    padding: 18px 18px;
  }

  .resumeHeader{
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
  .resumeTitle{
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

  .linkSmall{
    color:#2563eb;
    text-decoration:none;
    font-weight:800;
  }
  .linkSmall:hover{ text-decoration: underline; }

  .btn-outline-primary{
    border-radius: 10px;
    font-weight:900;
    padding: .6rem 1.2rem;
  }

  /* ====== 메모(안내 바) ====== */
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

  /* ====== 하단: 이력서 리스트(여러 개일 때) ====== */
  .resumeList{
    margin-top: 16px;
    display:grid;
    grid-template-columns: 1fr;
    gap: 14px;
  }
  .resumeItem{
    border:1px solid #eef2f7;
    border-radius: 14px;
    padding: 16px 16px;
    display:flex;
    align-items:flex-start;
    justify-content: space-between;
    gap: 14px;
    background:#fff;
  }
  .resumeItem-title{
    font-weight:900;
    color:#111827;
    margin:0;
  }
  .resumeItem-sub{
    margin-top: 6px;
    color:#6b7280;
    font-weight:700;
    font-size:.9rem;
  }

  .resumeActions{
    display:flex;
    align-items:center;
    gap: 8px;
  }
  .btn-light, .btn-outline-secondary{
    border-radius: 10px;
    font-weight:800;
    padding: .55rem .95rem;
  }

  /* ====== 점3개 드롭다운 버튼 느낌(사람인스럽게) ====== */
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
     URL을 c:url로 통일 (ctx 변수 제거)
     - 컨트롤러 매핑은 네가 쓰는 /my/* 기준
   ========================================================= --%>
<c:url var="urlMyResume" value="/my/myResume"/>
<c:url var="urlResumeCreate" value="/my/resume/create"/>   <%-- 새 이력서 작성(나중에) --%>
<c:url var="urlResumeEdit" value="/my/resume/edit"/>       <%-- 수정(나중에 파라미터 붙이기) --%>
<c:url var="urlResumeDelete" value="/my/resume/delete"/>   <%-- 삭제(나중에 POST) --%>

<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">

    <%-- ✅ 좌측 사이드바 include
         - 이 페이지 active는 컨트롤러에서 currentMenu='resume' 내려주는 방식 추천
         - (지금은 네 mySidebar.jspf가 알아서 active 처리하도록 두면 됨)
     --%>
    <%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

    <%-- ✅ 우측 컨텐츠 --%>
    <section class="col-10 myContent">
      <div class="myContent-inner">

        <%-- 타이틀 --%>
        <h2 class="page-title">내 이력서</h2>
        <div class="page-desc">이력서를 관리하고, 필요할 때 빠르게 수정할 수 있어요.</div>

        <%-- 상단 유틸: 총건수 + 필터(전체/대표/미완성 등) --%>
        <div class="topbar">
          <div class="countText">
            <%-- resumes가 없을 수도 있으니 기본값 처리 --%>
            총 <strong><c:out value="${empty resumes ? 0 : fn:length(resumes)}"/></strong>건
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

        <%-- =========================================================
             ✅ 대표/최근 이력서 1개 카드
             - 지금은 샘플로 loginUser 기반 텍스트만 넣음
             - 나중엔 대표 이력서(resume 대표=true)를 여기 꽂으면 됨
           ========================================================= --%>
        <div class="resumeCard">
          <div class="resumeHeader">
            <div>
              <div>
                <span class="badgeDraft">미완성</span>
                <span class="resumeTitle"><c:out value="${loginUser.name}"/>의 이력서 입니다</span>
              </div>

              <div class="metaRow">
                <div class="metaItem">
                  <i class="bi bi-briefcase"></i>
                  <span>신입</span>
                </div>
                <div class="metaItem">
                  <i class="bi bi-pin-map"></i>
                  <span>희망지역: -</span>
                  <a class="linkSmall" href="#">희망근무조건 수정</a>
                </div>
                <div class="metaItem">
                  <i class="bi bi-person-workspace"></i>
                  <span>희망 직무: -</span>
                </div>
              </div>
            </div>

            <div class="d-flex align-items-center gap-2">
              <%-- 사람인 느낌의 오른쪽 버튼 --%>
              <a class="btn btn-outline-primary" href="${urlResumeCreate}">
                이력서 완성하기
              </a>

              <%-- 점3개(옵션) : 부트스트랩 dropdown 쓰고 싶으면 data-bs-toggle 사용 --%>
              <div class="dropdown">
                <button class="kebabBtn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                  <i class="bi bi-three-dots-vertical"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                  <li><a class="dropdown-item" href="${urlResumeEdit}">수정</a></li>
                  <li><a class="dropdown-item" href="#">대표 설정</a></li>
                  <li><hr class="dropdown-divider"></li>
                  <li><a class="dropdown-item text-danger" href="${urlResumeDelete}">삭제</a></li>
                </ul>
              </div>
            </div>
          </div>

          <%-- 메모 안내 바 --%>
          <div class="memoBar">
            <i class="bi bi-card-text"></i>
            <span>이력서에 관련된 중요한 내용을 메모해보세요. 예) 11월 25일까지 제출</span>
          </div>
        </div>

        <%-- =========================================================
             ✅ 리스트 영역 (나중에 DB로 자동 추가되는 곳)
             - resumes 라는 List를 model로 내려준다고 가정
             - 지금은 샘플 2개를 fallback으로 보여줌
           ========================================================= --%>

        <div class="resumeList">

          <c:choose>
            <c:when test="${not empty resumes}">
              <%-- ✅ DB 붙이면 여기만 살아남음 --%>
              <c:forEach var="r" items="${resumes}">
                <div class="resumeItem">
                  <div>
                    <p class="resumeItem-title">
                      <c:out value="${r.title}"/>
						<c:if test="${r.representative eq 'Y'}">
							<span class="badge text-bg-warning ms-2">대표</span>
						</c:if>
                    </p>
                    <div class="resumeItem-sub">
                      최종수정: <c:out value="${r.updatedAt}"/> · 상태:
                      <c:out value="${r.status}"/>
                    </div>
                  </div>

                  <div class="resumeActions">
                    <a class="btn btn-outline-secondary" href="<c:url value='/my/resume/edit'><c:param name='id' value='${r.resumeId}'/></c:url>">
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
              <%-- ✅ 아직 데이터 없을 때 보이는 샘플(뼈대) --%>
              <div class="resumeItem">
                <div>
                  <p class="resumeItem-title">샘플 이력서 #1</p>
                  <div class="resumeItem-sub">최종수정: 2026-02-19 · 상태: 미완성</div>
                </div>
                <div class="resumeActions">
                  <a class="btn btn-outline-secondary" href="#">수정</a>
                  <button class="btn btn-light" type="button">복사</button>
                  <button class="kebabBtn" type="button"><i class="bi bi-three-dots-vertical"></i></button>
                </div>
              </div>

              <div class="resumeItem">
                <div>
                  <p class="resumeItem-title">샘플 이력서 #2</p>
                  <div class="resumeItem-sub">최종수정: 2026-02-10 · 상태: 완성</div>
                </div>
                <div class="resumeActions">
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

<%-- (선택) footer.jspf에 bootstrap.bundle.js 없으면 아래 주석 해제 (dropdown용)
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
--%>

<%-- fn:length 쓰려면 JSTL functions taglib 필요.
     head에서 안 쓰면 아래 추가:
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
   지금은 fn:length를 썼으니, 에러나면 위 라인을 맨 위에 추가
--%>
