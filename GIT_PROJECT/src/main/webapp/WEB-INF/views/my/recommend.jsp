<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<%-- =========================
     URL (전부 c:url)
   ========================= --%>
<c:url var="urlRecommend" value="/my/recommend"/>         <%-- 목록(필터/정렬 GET) --%>
<c:url var="urlJobDetail" value="/job/JobDetail"/>          <%-- ?jobId= --%>
<c:url var="urlApply" value="/job/apply"/>               <%-- ?jobId= (입사지원) --%>
<c:url var="urlHide" value="/my/recommend/hide"/>        <%-- POST/GET 선택: ?jobId= (숨김처리) --%>

<style>
  body{ background:#f6f7fb; }
  .mypage-wrap{ min-height:100vh; }

  /* =========================
     ✅ 공통 톤(사이드바/카드) - 이전 페이지와 동일
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
     ✅ 상단 툴바(필터/정렬) - 사람인 느낌
     (화면정의서: 5/10/20개 + 입사지원 공고만 + 정렬)
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

  .btn-go{
    border:1px solid #dbe2ee;
    background:#fff;
    border-radius:10px;
    padding:10px 14px;
    font-weight:900;
  }
  .btn-go:hover{ background:#f7f9fc; }

  /* =========================
     ✅ 리스트(행) - 사람인 스타일: 얇은 구분선 + 오른쪽 버튼/메뉴
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

  /* (클릭시 채용페이지 이동) */
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

  /* 추천 라벨 */
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

  /* 입사지원 버튼(사람인 느낌: 빨간 테두리) */
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
    min-width: 96px;
    text-align:right;
    font-weight:900;
    color:#6b7280;
  }
  .deadline .today{ color:#ef4444; }

  /* 더보기(⋮) 버튼 */
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

  /* 드롭다운(부트스트랩 없이도 동작하는 심플 버전) */
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
  .more-menu a{
    display:block;
    padding: 12px 12px;
    text-decoration:none;
    color:#111827;
    font-weight:900;
    font-size:.92rem;
  }
  .more-menu a:hover{ background:#f7f9fc; }

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

    <%-- ✅ 왼쪽 사이드바(inc) --%>
    <%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

    <%-- ✅ 오른쪽 컨텐츠 --%>
    <section class="col-10 myContent">
      <div class="myContent-inner">

        <h2 class="page-title">추천 공고</h2>
        <div class="page-desc">내 이력/활동 기반으로 추천된 공고를 확인할 수 있어요.</div>

        <%-- =========================
             상단 필터/정렬
             - 화면정의서: n개씩 / 입사지원 공고만 / 선호도순 등
             - 전부 GET으로 urlRecommend에 붙여서 조회
           ========================= --%>
        <form action="${urlRecommend}" method="get" class="toolbar">

          <div class="toolbar-left">
            <%-- 5/10/20개 --%>
            <select class="select" name="size">
              <option value="5">5개씩</option>
              <option value="10" selected>10개씩</option>
              <option value="15">15개씩</option>
            </select>

            <%-- 입사지원 공고만(체크) --%>
            <label class="checkline">
              <input type="checkbox" name="onlyApplyable" value="Y">
              입사지원 공고만
            </label>
          </div>

          <div class="toolbar-right">
            <%-- 정렬(선호도/최근등록/마감임박 등) --%>
            <select class="select" name="sort">
              <option value="PREF" selected>선호도순</option>
              <option value="RECENT">최근등록순</option>
              <option value="DEADLINE">마감임박순</option>
            </select>

            <button type="submit" class="btn-go">적용</button>
          </div>

        </form>

        <%-- =========================
             ✅ 리스트 영역
             - 나중에 c:forEach로 jobList 돌리면 자동으로 행 추가됨
             - (화면정의서) 1) 제목 클릭 -> 채용페이지 이동
                            2) 입사지원 버튼
                            3) ⋮ 클릭 -> "추천에서 제외" 등 메뉴
           ========================= --%>

        <%-- ✅ 데이터 없을 때(필요하면 사용)
        <div class="empty">
          <div style="font-size:48px;">📌</div>
          <div class="big">추천 공고가 아직 없어요</div>
          <div>이력서를 등록하면 더 정확한 추천을 받을 수 있어요.</div>
        </div>
        --%>

        <div class="job-list">

          <%-- ===== 샘플 1 ===== --%>
          <div class="job-item">
            <div class="job-left">
              <div class="company">파크시스템스</div>

              <div class="job-main">
                <a class="job-title" href="${urlJobDetail}?jobId=2001">
                  2026 각 부문 신입/경력 수시채용
                </a>
                <div class="job-meta">
                  <span>신입 · 경력</span>
                  <span>대학(4년)↑</span>
                  <span>서울전체</span>
                  <span>정규직</span>
                </div>

                <%-- 추천사유/라벨(사람인 느낌) --%>
                <div class="tag">구직자들이 선호하는 공고</div>
              </div>
            </div>

            <div class="job-right">
              <a class="btn-apply" href="${urlApply}?jobId=2001">입사지원</a>

              <div class="deadline">
                ~ 07/08(수)
              </div>

              <%-- (3) 더보기 메뉴(⋮) --%>
              <div class="more-wrap">
                <button type="button" class="more-btn" onclick="toggleMoreMenu(this)">⋮</button>
                <div class="more-menu">
                  <%-- 추천에서 제외 --%>
                  <a href="${urlHide}?jobId=2001">추천에서 제외</a>
                  <%-- 필요하면 즐겨찾기/스크랩 등 추가 --%>
                  <a href="#">스크랩</a>
                </div>
              </div>

            </div>
          </div>

          <%-- ===== 샘플 2 ===== --%>
          <div class="job-item">
            <div class="job-left">
              <div class="company">동국기술단</div>
              <div class="job-main">
                <a class="job-title" href="${urlJobDetail}?jobId=2002">
                  (용인지사) 동국기술단 방재사업부 직원 채용
                </a>
                <div class="job-meta">
                  <span>경력무관</span>
                  <span>대학(4년)↑</span>
                  <span>경기 용인시</span>
                  <span>정규직</span>
                </div>
                <div class="tag">연봉을 올려줄 기업 공고</div>
              </div>
            </div>

            <div class="job-right">
              <a class="btn-apply" href="${urlApply}?jobId=2002">입사지원</a>
              <div class="deadline">~ 04/12(일)</div>

              <div class="more-wrap">
                <button type="button" class="more-btn" onclick="toggleMoreMenu(this)">⋮</button>
                <div class="more-menu">
                  <a href="${urlHide}?jobId=2002">추천에서 제외</a>
                  <a href="#">스크랩</a>
                </div>
              </div>
            </div>
          </div>

          <%-- ===== 샘플 3 (오늘마감 표시 예시) ===== --%>
          <div class="job-item">
            <div class="job-left">
              <div class="company">유정엔지니어링</div>
              <div class="job-main">
                <a class="job-title" href="${urlJobDetail}?jobId=2003">
                  수질TMS 측정기기 유지관리 담당자
                </a>
                <div class="job-meta">
                  <span>신입 · 경력</span>
                  <span>대학(2,3년)↑</span>
                  <span>경기 용인시</span>
                  <span>정규직</span>
                </div>
                <div class="tag">리프레시 휴가가 보장된</div>
              </div>
            </div>

            <div class="job-right">
              <a class="btn-apply" href="${urlApply}?jobId=2003">입사지원</a>
              <div class="deadline"><span class="today">오늘마감</span></div>

              <div class="more-wrap">
                <button type="button" class="more-btn" onclick="toggleMoreMenu(this)">⋮</button>
                <div class="more-menu">
                  <a href="${urlHide}?jobId=2003">추천에서 제외</a>
                  <a href="#">스크랩</a>
                </div>
              </div>
            </div>
          </div>

        </div>

        <div class="pager">
          <a href="#" class="active">1</a>
          <a href="#">2</a>
          <a href="#">3</a>
          <a href="#">다음</a>
        </div>

      </div>
    </section>

  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

<script>
  // =========================
  // ✅ ⋮ 더보기 메뉴 토글 (단순 버전)
  // - 다른 곳 클릭하면 닫히도록 처리
  // =========================
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
