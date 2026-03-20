<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf"%>
    <link href="<c:url value="/resources/css/jobCss/resumeView.css" />" rel="stylesheet" type="text/css">
    <script src="<c:url value="/resources/js/resumeView.js" />"></script>     
</head>

<body class="resume-body">
    <%@ include file="/WEB-INF/views/inc/headerCom.jspf"%>
    
    <div class="container-fluid mt-4 mb-5">
        <div class="row">
            <div class="col-12 col-md-2 side-space"></div>
          
            <div class="col-12 col-md-8 main-form">
                
                 <%-- 데이터 식별을 위한 Hidden 필드 (조회 시에도 필요할 수 있음) --%>
                 <input type="hidden" name="resumeId" value="${resume.resumeId}">
                       
                 <div class="card section-card mb-4">
                     <div class="card-header section-title">제목</div>
                     <div class="card-body">
                         <div class="form-group mb-3">
                             <label class="resume-label">제목</label>
                             <div class="form-control-plaintext resume-view-data">${resume.title}</div>
                         </div>
                     </div>
                 </div>

                 <div class="card section-card mb-5">
                     <div class="card-header section-title">기본인적사항</div>
                     <div class="card-body">
                         <div class="row">
                             <div class="col-12 col-md-3 text-center mb-4">
                                 <div class="profile-box mx-auto mb-3">
								    <c:if test="${not empty photo}">
									    <img src="<c:url value='${photo.filePath}/${photo.storedName}' />"
			
									         alt="이력서 사진" 
									         style="max-width:100%; max-height:100%; object-fit:contain;"/>
									</c:if>
								</div>
                             </div>
                             <div class="col-12 col-md-9">
                                 <div class="row g-3">
                                     <div class="col-md-6">
                                         <label class="form-label">이름(국문)</label>
                                         <div class="form-control-plaintext">${resume.nameKor}</div>
                                     </div>
                                     <div class="col-md-6">
                                         <label class="form-label">생년월일</label>
                                         <div class="form-control-plaintext">${resume.birthDate}</div>
                                     </div>
                                     <div class="col-md-6">
                                         <label class="form-label">이름(영문)</label>
                                         <div class="form-control-plaintext">${resume.nameEng}</div>
                                     </div>
                                     <div class="col-md-6">
                                         <label class="form-label">성별</label>
                                         <div class="form-control-plaintext">${resume.gender}</div>
                                     </div>
                                     <div class="col-md-6">
                                         <label class="form-label">전화번호</label>
                                         <div class="form-control-plaintext">${resume.phoneNumber}</div>
                                     </div>
                                     <div class="col-md-6">
                                         <label class="form-label">이메일</label>
                                         <div class="form-control-plaintext">${resume.email}</div>
                                     </div>
                                     <div class="col-md-12">
                                         <label class="form-label">주소</label>
                                         <div class="form-control-plaintext">${resume.address1} ${resume.address2}</div>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>

                 <div class="card section-card mb-5">
                     <div class="card-header section-title text-center">사회형평적 인재 우대사항</div>
                     <div class="card-body">
                         <div class="row mb-3">
                             <div class="col-md-6">
                                 <label class="resume-label">보훈대상</label>
                                 <div class="form-control-plaintext">${resume.veteranStatus}</div>
                             </div>
                             <div class="col-md-6">
                                 <label class="resume-label">보훈번호</label>
                                 <div class="form-control-plaintext">${resume.veteranNumber}</div>
                             </div>
                         </div>
                         <div class="row mb-3">
                             <div class="col-md-6">
                                 <label class="resume-label">장애여부</label>
                                 <div class="form-control-plaintext">${resume.disabilityStatus}</div>
                             </div>
                             <div class="col-md-6">
                                 <label class="resume-label">장애등급</label>
                                 <div class="form-control-plaintext">${resume.disabilityGrade}</div>
                             </div>
                         </div>
                     </div>
                 </div>

                 <div class="card section-card mb-5">
                     <div class="card-header section-title text-center">병역사항</div>
                     <div class="card-body">
                         <div class="row mb-3">
                             <div class="col-md-6">
                                 <label class="resume-label">군필여부</label>
                                 <div class="form-control-plaintext">${resume.militaryService}</div>
                             </div>
                             <div class="col-md-6">
                                 <label class="resume-label">군별</label>
                                 <div class="form-control-plaintext">${resume.militaryBranch}</div>
                             </div>
                         </div>
                     </div>
                 </div>

                 <div class="card section-card mb-5">
                     <div class="card-header section-title text-center">학력사항</div>
                     <div class="card-body">
                         <c:forEach var="edu" items="${resume.educationList}">
                             <div class="row mb-3 border-bottom pb-2">
                                 <div class="col-md-6">
                                     <label class="resume-label">학교명</label>
                                     <div class="form-control-plaintext">${edu.schoolName}</div>
                                 </div>
                                 <div class="col-md-6">
                                     <label class="resume-label">전공</label>
                                     <div class="form-control-plaintext">${edu.major}</div>
                                 </div>
                             </div>
                         </c:forEach>
                     </div>
                 </div>
                 
				<div class="card section-card mb-5">
				    <div class="card-header section-title text-center">경력사항</div>
				    <div class="card-body">    
				        <c:forEach var="exp" items="${resume.experienceList}" varStatus="status">
				            <div class="experience-item ${status.index > 0 ? 'mt-4 pt-4 border-top' : ''}">
				                <div class="row mb-3">
				                    <div class="col-md-6">
				                        <label class="resume-label">회사명</label>
				                        <div class="form-control-plaintext resume-view-data">${exp.companyName}</div>
				                    </div>
				                    <div class="col-md-6">
				                        <label class="resume-label">부서명</label>
				                        <div class="form-control-plaintext resume-view-data">${exp.depatmentName}</div>
				                    </div>
				                </div>
				
				                <div class="row mb-3">
				                    <div class="col-md-4">
				                        <label class="resume-label">직위</label>
				                        <div class="form-control-plaintext resume-view-data">${exp.jobPosition}</div>
				                    </div>
				                    <div class="col-md-4">
				                        <label class="resume-label">시작일</label>
				                        <div class="form-control-plaintext resume-view-data">${exp.startDate}</div>
				                    </div>
				                    <div class="col-md-4">
				                        <label class="resume-label">종료일</label>
				                        <div class="form-control-plaintext resume-view-data">${exp.endDate}</div>
				                    </div>
				                </div>
				
				                <div class="row mb-3">
				                    <div class="col-md-6">
				                        <label class="resume-label">고용형태</label>
				                        <%-- DTO 필드명 employTypeName (N 대문자) 반영 --%>
				                        <div class="form-control-plaintext resume-view-data">${exp.employTypeName}</div>
				                    </div>
				                    <div class="col-md-6">
				                        <label class="resume-label">주요업무</label>
				                        <div class="form-control-plaintext resume-view-data">${exp.jobDescription}</div>
				                    </div>
				                </div>
				            </div>
				        </c:forEach>
				        
				        <c:if test="${empty resume.experienceList}">
				            <div class="text-center py-3 text-muted">등록된 경력사항이 없습니다.</div>
				        </c:if>
				    </div>
				</div>

                 <div class="text-center mt-5">
                     <button type="button" class="btn btn-outline-secondary px-5 me-3" onclick="history.back();">이전으로</button>
                 </div>

            </div>

            <div class="col-12 col-md-2 side-space"></div>
        </div>
    </div>
  
    <%@ include file="/WEB-INF/views/inc/footer.jspf"%>
    <script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>