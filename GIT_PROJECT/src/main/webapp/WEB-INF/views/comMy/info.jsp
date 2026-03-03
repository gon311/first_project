<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<style>
  body { background:#f6f7fb; }

  .mypage-wrap{ min-height: 100vh; }

  /* Sidebar */
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

  /* Content */
  .myContent{ padding:22px 22px; }
  .myContent-inner{
    background:#fff; border:1px solid #eef2f7; border-radius:16px;
    box-shadow:0 10px 30px rgba(15,23,42,.04);
    padding:18px; min-height: calc(100vh - 80px);
  }
  .page-title{ font-size:1.45rem; font-weight:900; letter-spacing:-.5px; margin:0; }
  .page-desc{ color:#6b7280; font-size:.92rem; margin-top:4px; }
  .top-actions .btn{ border-radius:12px; padding:.6rem .9rem; font-weight:700; }

  .info-grid{
    margin-top:14px;
    display:grid;
    grid-template-columns: 1fr 1fr;
    gap:14px;
  }
  .info-card{
    border:1px solid #eef2f7;
    border-radius:14px;
    padding:14px;
    background:#fff;
  }
  .info-label{ color:#6b7280; font-size:.85rem; margin-bottom:6px; font-weight:700; }
  .info-value{ font-weight:800; color:#111827; }
</style>

<%-- 수정 URL들 --%>
<c:url var="urlPassword" value="/comMy/password"/>
<c:url var="urlUpdateInfo" value="/comMy/updateInfo"/>

<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">

    <%-- ✅ 사이드바 include --%>
    <%@ include file="/WEB-INF/views/inc/comMySidebar.jspf" %>

    <section class="col-10 myContent">
      <div class="myContent-inner">

        <div class="d-flex justify-content-between align-items-start gap-3 mb-3">
          <div>
            <h2 class="page-title">내 정보</h2>
            <div class="page-desc">회원 기본 정보를 확인하고 수정할 수 있어요.</div>
          </div>

          <div class="top-actions d-flex gap-2">
            <a class="btn btn-outline-secondary" href="${urlPassword}">비밀번호 변경</a>
            <a class="btn btn-primary" href="${urlUpdateInfo}">내 정보 수정</a>
          </div>
        </div>
        
		<c:if test="${not empty msg}">
			<div class="alert alert-info mb-3" role="alert">
				${msg}
			</div>
		</c:if>

        <div class="info-grid">
          <div class="info-card">
            <div class="info-label">이름</div>
            <div class="info-value">${loginUser.userName}</div>
          </div>

          <div class="info-card">
            <div class="info-label">이메일</div>
            <div class="info-value">${loginUser.email}</div>
          </div>

          <div class="info-card">
            <div class="info-label">전화번호</div>
            <div class="info-value">${loginUser.phone}</div>
          </div>

          <div class="info-card">
            <div class="info-label">회원유형</div>
            <div class="info-value">
              <c:choose>
                <c:when test="${loginUser.userType == 'P'}">개인</c:when>
                <c:when test="${loginUser.userType == 'C'}">기업</c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>

      </div>
    </section>

  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>




