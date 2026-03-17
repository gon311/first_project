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
                
                 <%-- 데이터 전달을 위한 Hidden 필드 --%>
                 <input type="hidden" name="resumeId" value="${resume.resumeId}">
                 <input type="hidden" name="industryCode" value="${param.industryCode}" />
                 <input type="hidden" name="jobCode" value="${param.jobCode}" />
                 <input type="hidden" name="roleCode" value="${param.roleCode}" />
                 <input type="hidden" name="selectedJobInput" value="${param.selectedJobInput}" />
                 <input type="hidden" name="companyCode" value="${param.companyCode}" />
                 <input type="hidden" name="appliedField" value="${param.appliedField}" />
                 <input type="hidden" name="companyName" value="${param.companyName}" />
                 <input type="hidden" name="careerCode" value="${param.careerCode}" />
                 <input type="hidden" name="hiddenIndustry" value="${param.hiddenIndustry}" />
                 <input type="hidden" name="hiddenJob" value="${param.hiddenJob}" />
                 <input type="hidden" name="hiddenRole" value="${param.hiddenRole}" />
                 <input type="hidden" name="hiddenCompanyType" value="${param.hiddenCompanyType}" />
                       
                 <div class="card section-card mb-4">
                     <div class="card-header section-title">제목</div>
                     <div class="card-body">
                         <div class="form-group mb-3">
                             <label for="title" class="resume-label">제목</label>
                             <input type="text" id="title" name="title" value="${resume.title}" 
                                    class="form-control resume-input" placeholder="제목을 입력해주세요.">
                         </div>
                     </div>
                 </div>

                 <div class="card section-card mb-5">
                     <div class="card-header section-title">기본인적사항</div>
                     <div class="card-body">
                         <div class="row">
                             <div class="col-12 col-md-3 text-center mb-4">
                                 <div class="profile-box mx-auto mb-3"></div>
                             </div>
                             <div class="col-12 col-md-9">
                                 <div class="row g-3">
                                     <div class="col-md-6">
                                         <label class="form-label">이름(국문)</label>
                                         <input type="text" value="${resume.nameKor}" name="nameKor" class="form-control">
                                     </div>
                                     <div class="col-md-6">
                                         <label class="form-label">생년월일</label>
                                         <input type="date" value="${resume.birthDate}" name="birthDate" class="form-control">
                                     </div>
                                     <div class="col-md-6">
                                         <label class="form-label">이름(영문)</label>
                                         <input type="text" value="${resume.nameEng}" name="nameEng" class="form-control">
                                     </div>
                                     <div class="col-md-6">
                                         <label class="form-label">성별</label>
                                         <select name="gender" class="form-select">
                                             <option value="">-선택-</option>
                                             <option value="남" ${resume.gender == '남' ? 'selected' : ''}>남</option>
                                             <option value="여" ${resume.gender == '여' ? 'selected' : ''}>여</option>
                                         </select>
                                     </div>
                                     <div class="col-md-6">
                                         <label class="form-label">전화번호</label>
                                         <input type="text" value="${resume.phoneNumber}" name="phoneNumber" class="form-control">
                                     </div>
                                     <div class="col-md-6">
                                         <label class="form-label">이메일</label>
                                         <input type="email" value="${resume.email}" name="email" class="form-control">
                                     </div>
                                     <div class="col-md-12">
                                         <label class="form-label">주소</label>
                                         <div class="d-flex gap-2 mt-1">
                                             <input type="text" value="${resume.address1}" id="address1" name="address1" onclick="findAddr()" class="form-control" placeholder="주소 입력">
                                             <input type="text" value="${resume.address2}" id="address2" name="address2" class="form-control" placeholder="상세주소 입력">
                                         </div>
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
                                 <select name="veteranStatus" class="form-select resume-input">
                                     <option value="비대상" ${resume.veteranStatus eq '비대상' ? 'selected' : ''}>비대상</option>
                                     <option value="대상(5%)" ${resume.veteranStatus eq '대상(5%)' ? 'selected' : ''}>대상(5%)</option>
                                     <option value="대상(10%)" ${resume.veteranStatus eq '대상(10%)' ? 'selected' : ''}>대상(10%)</option>
                                 </select>
                             </div>
                             <div class="col-md-6">
                                 <label class="resume-label">보훈번호</label>
                                 <input type="text" value="${resume.veteranNumber}" name="veteranNumber" class="form-control resume-input">
                             </div>
                         </div>
                         <div class="row mb-3">
                             <div class="col-md-6">
                                 <label class="resume-label">장애여부</label>
                                 <select name="disabilityStatus" class="form-select resume-input">
                                     <option value="비대상" ${resume.disabilityStatus == '비대상' ? 'selected' : ''}>비대상</option>
                                     <option value="대상" ${resume.disabilityStatus == '대상' ? 'selected' : ''}>대상</option>
                                 </select>
                             </div>
                             <div class="col-md-6">
                                 <label class="resume-label">장애등급</label>
                                 <input type="text" value="${resume.disabilityGrade}" name="disabilityGrade" class="form-control resume-input">
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
                                 <select name="militaryService" class="form-select resume-input">
                                     <option value="비대상" ${resume.militaryService == '비대상' ? 'selected' : ''}>비대상</option>
                                     <option value="미필" ${resume.militaryService == '미필' ? 'selected' : ''}>미필</option>
                                     <option value="군필" ${resume.militaryService == '군필' ? 'selected' : ''}>군필</option>
                                     <option value="면제" ${resume.militaryService == '면제' ? 'selected' : ''}>면제</option>
                                 </select>
                             </div>
                             <div class="col-md-6">
                                 <label class="resume-label">군별</label>
                                 <input type="text" name="militaryBranch" value="${resume.militaryBranch}" class="form-control resume-input">
                             </div>
                         </div>
                     </div>
                 </div>

                 <div class="card section-card mb-5">
                     <div class="card-header section-title text-center">학력사항</div>
                     <div class="card-body">
                         <div class="row mb-3">
                             <div class="col-md-6">
                                 <label class="resume-label">학교명</label>
                                 <input type="text" name="educationList[0].schoolName" value="${resume.educationList[0].schoolName}" class="form-control resume-input">
                             </div>
                             <div class="col-md-6">
                                 <label class="resume-label">전공</label>
                                 <input type="text" name="educationList[0].major" value="${resume.educationList[0].major}" class="form-control resume-input">
                             </div>
                         </div>
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