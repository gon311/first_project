<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<%-- =========================
     URL 
   ========================= --%>
<c:url var="urlUpdateInfo" value="/my/updateInfo"/>   <%-- POST 처리 URL --%>
<c:url var="urlMyInfo" value="/my/myInfo"/>           <%-- 취소/뒤로가기 필요시 --%>

<style>
  body { background:#f6f7fb; }
  .mypage-wrap{ min-height: 100vh; }

  /* =========================================================
     ✅ [Sidebar CSS 추가]
     - inc/mySidebar.jspf의 클래스(mySidebar, myNav-link 등)와 매칭됨
     ========================================================= */
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
  .mySidebar-brand{
    padding: 6px 8px 16px;
    display:flex;
    align-items:center;
    gap:10px;
  }
  .brandText{
    font-weight:900;
    letter-spacing:-.4px;
    color:#2563eb;
    font-size:1.2rem;
  }

  .myNav{ display:flex; flex-direction:column; gap:4px; }

  .myNav-link{
    display:flex;
    align-items:center;
    gap:10px;
    padding:10px 10px;
    border-radius:10px;
    text-decoration:none;
    color:#334155;
    font-weight:600;
    position:relative;
  }
  .myNav-link i{
    font-size:1.05rem;
    color:#94a3b8;
    width:20px;
    text-align:center;
  }
  .myNav-link:hover{ background:#f3f6fb; }

  .myNav-link.active{
    background:#eaf2ff;
    color:#1d4ed8;
    font-weight:800;
  }
  .myNav-link.active i{ color:#1d4ed8; }

  .myNav-link.active::before{
    content:"";
    position:absolute;
    left:-6px;
    top:10px;
    bottom:10px;
    width:3px;
    border-radius:999px;
    background:#1d4ed8;
  }

  /* =========================================================
     오른쪽 컨텐츠 카드 
     ========================================================= */
  .myContent{ padding:22px 22px; }
  .myContent-inner{
    background:#fff;
    border:1px solid #eef2f7;
    border-radius:16px;
    box-shadow:0 10px 30px rgba(15,23,42,.04);
    padding:22px 22px;
    min-height: calc(100vh - 80px);
  }

  .page-title{ font-size:1.45rem; font-weight:900; letter-spacing:-.5px; margin:0; }
  .page-desc{ color:#6b7280; font-size:.92rem; margin-top:6px; }

  .form-grid{
    margin-top: 22px;
    display:grid;
    grid-template-columns: 1fr 1fr;
    gap: 26px;
  }
  .form-row-full{ grid-column: 1 / span 2; }

  .field-label{
    font-weight:800;
    color:#111827;
    margin-bottom: 10px;
  }

  .form-control{
    border-radius: 6px;
    border-color:#d9dde3;
    padding: 18px 16px;
    font-size: 1.05rem;
  }
  .form-control:focus{
    box-shadow:none;
    border-color:#9bbcff;
  }

  .form-actions{
    margin-top: 36px;
    display:flex;
    justify-content: space-between;
    align-items: center;
  }

  .danger-link{
    color:#9ca3af;
    font-weight:700;
    text-decoration:none;
  }
  .danger-link:hover{ text-decoration: underline; }

  .btn-save{
    background:#ffb547;
    border:1px solid #ffb547;
    color:#fff;
    font-weight:900;
    border-radius: 8px;
    padding: 14px 30px;
  }
  .btn-save:hover{
    background:#ffa726;
    border-color:#ffa726;
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

        <h2 class="page-title">내 정보 수정</h2>
        <div class="page-desc">회원 정보를 수정하고 저장할 수 있어요.</div>

        <form action="${urlUpdateInfo}" method="post">

          <div class="form-grid">

            <div>
              <div class="field-label">이메일</div>
              <input type="email" class="form-control" name="email"
                     value="${loginUser.email}" readonly />
            </div>

            <div>
              <div class="field-label">이름</div>
              <input type="text" class="form-control" name="name"
                     value="${loginUser.name}" />
            </div>

            <div class="form-row-full">
              <div class="field-label">전화번호</div>
              <input type="text" class="form-control" name="phone"
                     value="${loginUser.phone}" />
            </div>

          </div>

          <div class="form-actions">
            <a class="danger-link" href="#">계정 삭제</a>
            <button type="submit" class="btn btn-save">저장하기</button>
          </div>

        </form>

      </div>
    </section>

  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
