<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- =========================================================
     [이력서 관리] myResume.jsp
   ========================================================= --%>

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
   ========================================================= --%>
<c:url var="urlMyResume" value="/my/myResume"/>
<c:url var="urlResumeCreate" value="/my/resume/create"/>   <%-- 새 이력서 작성 --%>
<c:url var="urlResumeEdit" value="/my/resume/edit"/>       <%-- 수정 --%>
<c:url var="urlResumeDelete" value="/my/resume/delete"/>   <%-- 삭제(나중에 POST) --%>
<c:url var="urlResumeDetail" value="/my/resume/detail"/>   <%-- 디테일 --%>




<main class="container-fluid px-0 mypage-wrap">
  <div class="row g-0">

    <%-- ✅ 좌측 사이드바 include --%>
    <%@ include file="/WEB-INF/views/inc/mySidebar.jspf" %>

    <%-- ✅ 우측 컨텐츠 --%>
    <section class="col-10 myContent">
      <div class="myContent-inner">
      
        <%-- 타이틀 --%>
        <h2 class="page-title">내 이력서</h2>
        <div class="page-desc">이력서를 관리하고, 필요할 때 빠르게 수정할 수 있어요.</div>
        
        <%-- 상단: 총 건수 + 상태 필터 --%>
		<c:set var="filter" value="${empty param.filter ? 'ALL' : param.filter}"/>

		<div class="topbar">
		  <div class="countText">
		    총 <strong><c:out value="${empty myResumes ? 0 : fn:length(myResumes)}"/></strong>건
		  </div>
		
		  <select class="form-select filterSelect"
		          aria-label="filter"
		          onchange="location.href='${urlMyResume}?filter=' + this.value;">
		    <option value="ALL"      ${filter eq 'ALL' ? 'selected' : ''}>전체</option>
		    <option value="DRAFT"    ${filter eq 'DRAFT' ? 'selected' : ''}>미완성</option>
		    <option value="COMPLETE" ${filter eq 'COMPLETE' ? 'selected' : ''}>완성</option>
		  </select>
		</div>

		<%-- 대표/최근 카드: topResume (완성 우선 + 최신 1개) --%>
		<c:choose>
		  <c:when test="${not empty topResume}">
		    <div class="resumeCard">
		      <div class="resumeHeader">
		        <div>
		          <div>
		            <c:choose>
		              <c:when test="${topResume.status eq 'COMPLETE'}">
		                <span class="badgeComplete">완성</span>
		              </c:when>
		              <c:otherwise>
		                <span class="badgeDraft">미완성</span>
		              </c:otherwise>
		            </c:choose>
		
		            <span class="resumeTitle"><c:out value="${topResume.title}"/></span>
		          </div>
		
		          <div class="metaRow">
		            <div class="metaItem">
		              <i class="bi bi-clock"></i>
		              <span>최종수정: <c:out value="${topResume.updatedAtStr}"/></span>
		            </div>
		
		            <c:if test="${not empty topResume.memo}">
		              <div class="metaItem">
		                <i class="bi bi-card-text"></i>
		                <span>메모: <c:out value="${topResume.memo}"/></span>
		              </div>
		            </c:if>
		          </div>
		        </div>
		
		        <div class="d-flex align-items-center gap-2">
		          <a class="btn btn-outline-primary"
		             href="${urlResumeEdit}?resumeMyId=${topResume.resumeMyId}" 
		             onclick="return confirm('이력서를 수정하시겠습니까?');">
		            이력서 수정하기
		          </a>
		
				    <form action="${urlResumeDelete}" method="post" style="display:inline;"
				          onsubmit="return confirm('정말 삭제할까요?');">
				      <input type="hidden" name="resumeMyId" value="${topResume.resumeMyId}" />
				      <button type="submit" class="btn btn-outline-danger">삭제</button>
				    </form>
		        </div>
		      </div>
		
		      <div class="memoBar">
		        <i class="bi bi-card-text"></i>
		        <c:choose>
		          <c:when test="${not empty topResume.memo}">
		            <span><c:out value="${topResume.memo}"/></span>
		          </c:when>
		          <c:otherwise>
		            <span>이력서에 관련된 중요한 내용을 메모해보세요. 예) 11월 25일까지 제출</span>
		          </c:otherwise>
		        </c:choose>
		      </div>
		    </div>
		  </c:when>
		
		  <c:otherwise>
		    <div class="resumeCard">
		      <div class="resumeHeader">
		        <div>
		          <span class="badgeDraft">미완성</span>
		          <span class="resumeTitle">이력서를 아직 만들지 않았어요</span>
		        </div>
		        <a class="btn btn-outline-primary" href="${urlResumeCreate}">
		          이력서 만들기
		        </a>
		      </div>
		      <div class="memoBar">
		        <i class="bi bi-card-text"></i>
		        <span>새 이력서를 만들고 저장하면 여기에 최근 이력서가 표시돼요.</span>
		      </div>
		    </div>
		  </c:otherwise>
		</c:choose>

		<%-- 리스트: myResumes + 필터 적용 + 대표 중복 제거 --%>
		<div class="resumeList">
		  <c:choose>
		    <c:when test="${empty myResumes}">
		      <div class="resumeCard" style="margin-top:16px;">
		        아직 등록된 이력서가 없습니다.
		      </div>
		    </c:when>
		
		    <c:otherwise>
		      <c:forEach var="r" items="${myResumes}">
		        <c:set var="isComplete" value="${r.status eq 'COMPLETE'}"/>
		        <c:set var="isTop" value="${not empty topResume && r.resumeMyId eq topResume.resumeMyId}"/>
		
		        <%-- 출력 조건: (1) 대표 중복 제외 (2) 필터 통과 --%>
		        <c:if test="${not isTop
		                      && (filter eq 'ALL'
		                          || (filter eq 'COMPLETE' && isComplete)
		                          || (filter eq 'DRAFT' && not isComplete))}">
		
		          <div class="resumeCard">
		            <div class="resumeHeader">
		              <div>
		                <div>
		                  <c:choose>
		                    <c:when test="${isComplete}">
		                      <span class="badgeComplete">완성</span>
		                    </c:when>
		                    <c:otherwise>
		                      <span class="badgeDraft">미완성</span>
		                    </c:otherwise>
		                  </c:choose>
		
		                  <span class="resumeTitle"><c:out value="${r.title}"/></span>
		                </div>
		
		                <div class="metaRow">
		                  <div class="metaItem">최종수정: <c:out value="${r.updatedAtStr}"/></div>
		                  <c:if test="${not empty r.memo}">
		                    <div class="metaItem">메모: <c:out value="${r.memo}"/></div>
		                  </c:if>
		                </div>
		              </div>
		
		              <div class="d-flex align-items-center gap-2">
		                <a class="btn btn-outline-primary"
		                   href="${urlResumeEdit}?resumeMyId=${r.resumeMyId}"  <%-- 수정링크 (나중에 수정해야함) --%>
		                   onclick="return confirm('이력서를 수정하시겠습니까?');">
		                  수정
		                </a>
		
						<form action="${urlResumeDelete}" method="post" style="display:inline;"
						      onsubmit="return confirm('정말 삭제할까요?');">
						  <input type="hidden" name="resumeMyId" value="${r.resumeMyId}" />
						  <button type="submit" class="btn btn-outline-danger">삭제</button>
						</form>
		              </div>
		            </div>
		
		            <c:if test="${not empty r.memo}">
		              <div class="memoBar">
		                <i class="bi bi-card-text"></i>
		                <span><c:out value="${r.memo}"/></span>
		              </div>
		            </c:if>
		          </div>
		
		        </c:if>
		      </c:forEach>
		    </c:otherwise>
		  </c:choose>
		</div>

      </div>
    </section>

  </div>
</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

