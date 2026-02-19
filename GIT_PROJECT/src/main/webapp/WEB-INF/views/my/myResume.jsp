<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<%-- =========================
     URL (전부 c:url)
     - 매핑은 /my 기준
   ========================= --%>
<c:url var="urlCoverNew"  value="/my/cover/new"/>
<c:url var="urlResumeNew" value="/my/resume/new"/>

<style>
  body { background:#f6f7fb; }
  .mypage-wrap{ min-height: 100vh; }

  /* =========================
     ✅ [공통] 사이드바 CSS (현재는 페이지에 박아두기)
     ========================= */
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

  /* =========================
     ✅ [오른쪽 컨텐츠 카드]
     ========================= */
  .myContent{ padding:22px; }
  .myContent-inner{
    background:#fff;
    border:1px solid #eef2f7;
    border-radius:16px;
    box-shadow:0 10px 30px rgba(15,23,42,.04);
    padding:22px;
    min-height: calc(100vh - 80px);
  }

  .page-title{
    font-size:1.55rem;
    font-weight:900;
    letter-spacing:-.6px;
    margin:0;
  }
  .page-desc{
    color:#6b7280;
    font-size:.92rem;
    margin-top:6px;
  }

  /* 섹션 구분(자기소개서 / 이력서) */
  .section{ margin-top: 22px; }
  .section + .section{
    margin-top: 34px;
    padding-top: 24px;
    border-top: 1px solid #eef2f7;
  }
  .section-title{
    font-size:1.2rem;
    font-weight:900;
    margin:0 0 14px 0;
    letter-spacing:-.4px;
  }

  /* 카드 그리드(2열) */
  .card-grid{
    display:grid;
    grid-template-columns: 1fr 1fr;
    gap: 18px;
  }

  /* 공통 카드 */
  .doc-card{
    border: 1px solid #e9edf3;
    border-radius: 14px;
    background:#fff;
    padding: 18px;
    min-height: 210px;
    position: relative;
  }
  .doc-card:hover{
    box-shadow: 0 10px 25px rgba(15,23,42,.06);
    border-color:#dbe6ff;
  }

  /* "새로 작성" 카드 */
  .create-card{
    display:flex;
    align-items:center;
    justify-content:center;
    text-align:center;
    cursor:pointer;
  }
  .create-circle{
    width: 74px;
    height: 74px;
    border-radius: 999px;
    background:#ffe2b4;
    display:flex;
    align-items:center;
    justify-content:center;
    margin: 0 auto 10px;
  }
  .create-circle i{
    font-size: 1.9rem;
    color:#ff9f1c;
  }
  .create-text{
    font-weight:900;
    color:#111827;
  }
  .create-sub{
    margin-top:4px;
    color:#6b7280;
    font-size:.9rem;
  }

  /* 문서 카드 내용 */
  .doc-top{
    display:flex;
    justify-content:space-between;
    align-items:flex-start;
    gap:10px;
    margin-bottom: 10px;
  }
  .doc-title{
    font-weight:900;
    font-size:1.05rem;
    color:#111827;
  }
  .doc-date{
    color:#9ca3af;
    font-size:.85rem;
    font-weight:700;
    white-space:nowrap;
  }

  .doc-meta{
    margin-top: 12px;
    color:#374151;
    font-size:.93rem;
    line-height: 1.6;
  }
  .doc-meta .line{
    display:flex;
    align-items:center;
    gap:8px;
    margin: 4px 0;
  }
  .doc-meta i{
    color:#9ca3af;
    width: 16px;
    text-align:center;
  }

  /* 대표 배지 */
  .badge-best{
    position:absolute;
    top:0;
    left:0;
    padding: 6px 10px;
    border-top-left-radius: 14px;
    border-bottom-right-radius: 14px;
    background:#ffb547;
    color:#fff;
    font-weight:900;
    font-size:.85rem;
  }

  /* 하단 액션 */
  .doc-actions{
    position:absolute;
    left:18px;
    right:18px;
    bottom:14px;
    display:flex;
    justify-content:space-between;
    align-items:center;
  }
  .btn-primary-mini{
    border:0;
    background:#ffb547;
    color:#fff;
    font-weight:900;
    border-radius: 999px;
    padding: 8px 14px;
    font-size:.88rem;
  }
  .btn-primary-mini:hover{ background:#ffa726; }

  .kebab{
    border:0;
    background:transparent;
    color:#9ca3af;
    font-size: 1.4rem;
    line-height: 1;
  }
  .kebab:hover{ color:#6b7280; }
</style>

<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">

    <%-- 왼쪽 사이드바(inc) --%>
    <%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

    <%-- 오른쪽 컨텐츠 --%>
    <section class="col-10 myContent">
      <div class="myContent-inner">

        <h2 class="page-title">내 문서 관리</h2>
        <div class="page-desc">자기소개서와 이력서를 작성/관리할 수 있어요.</div>

        <%-- 1) 내 자기소개서 --%>
        <div class="section">
          <h3 class="section-title">내 자기소개서</h3>

          <div class="card-grid">

            <%-- 새 자기소개서 작성 --%>
            <a class="doc-card create-card" href="${urlCoverNew}" style="text-decoration:none;">
              <div>
                <div class="create-circle">
                  <i class="bi bi-file-earmark-plus"></i>
                </div>
                <div class="create-text">새 자기소개서 작성</div>
                <div class="create-sub">새 문서를 만들고 내용을 작성해요</div>
              </div>
            </a>

            <%-- 샘플 카드 1 --%>
            <div class="doc-card">
              <div class="badge-best">★ 대표</div>

              <div class="doc-top">
                <div class="doc-title">123123</div>
                <div class="doc-date">2026-02-09</div>
              </div>

              <div class="doc-meta">
                <div class="line"><i class="bi bi-briefcase"></i> 직종: IT·전기·전자·통신</div>
                <div class="line"><i class="bi bi-building"></i> 업종: IT·전기·전자</div>
                <div class="line"><i class="bi bi-bank"></i> 기업: 공기업</div>
                <div class="line"><i class="bi bi-tag"></i> 기업명: 123</div>
              </div>

              <div class="doc-actions">
                <button type="button" class="btn-primary-mini">대표</button>
                <button type="button" class="kebab" title="더보기">⋮</button>
              </div>
            </div>

            <%-- 샘플 카드 2 --%>
            <div class="doc-card">
              <div class="doc-top">
                <div class="doc-title">123123 복사본</div>
                <div class="doc-date">2026.02.09 11:01:39</div>
              </div>

              <div class="doc-meta">
                <div class="line"><i class="bi bi-briefcase"></i> 직종: IT·전기·전자·통신</div>
                <div class="line"><i class="bi bi-building"></i> 업종: IT·전기·전자</div>
                <div class="line"><i class="bi bi-bank"></i> 기업: 공기업</div>
                <div class="line"><i class="bi bi-tag"></i> 기업명: 123</div>
              </div>

              <div class="doc-actions">
                <button type="button" class="btn-primary-mini" style="background:#eef2f7; color:#6b7280;">대표 설정</button>
                <button type="button" class="kebab" title="더보기">⋮</button>
              </div>
            </div>

          </div>
        </div>

        <%-- 2) 내 이력서 --%>
        <div class="section">
          <h3 class="section-title">내 이력서</h3>

          <div class="card-grid">

            <%-- 새 이력서 작성 --%>
            <a class="doc-card create-card" href="${urlResumeNew}" style="text-decoration:none;">
              <div>
                <div class="create-circle">
                  <i class="bi bi-file-earmark-plus"></i>
                </div>
                <div class="create-text">새 이력서 작성</div>
                <div class="create-sub">새 이력서를 만들고 내용을 작성해요</div>
              </div>
            </a>

            <%-- 샘플 이력서 카드 --%>
            <div class="doc-card">
              <div class="badge-best">★ 대표</div>

              <div class="doc-top">
                <div class="doc-title">이력서_공기업지원_01</div>
                <div class="doc-date">2026-02-10</div>
              </div>

              <div class="doc-meta">
                <div class="line"><i class="bi bi-briefcase"></i> 희망직무: 전산/개발</div>
                <div class="line"><i class="bi bi-geo-alt"></i> 희망지역: 서울/경기</div>
                <div class="line"><i class="bi bi-mortarboard"></i> 학력: 대졸</div>
                <div class="line"><i class="bi bi-clock"></i> 최종수정: 2026-02-10</div>
              </div>

              <div class="doc-actions">
                <button type="button" class="btn-primary-mini">대표</button>
                <button type="button" class="kebab" title="더보기">⋮</button>
              </div>
            </div>

          </div>
        </div>

      </div>
    </section>

  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
