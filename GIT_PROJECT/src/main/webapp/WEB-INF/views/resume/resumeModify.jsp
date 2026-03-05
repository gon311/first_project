<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html lang="ko">
<head>
<%-- 	<%@ include file="/WEB-INF/views/inc/head.jspf"%> --%>
    <meta charset="UTF-8">
    <title>이력서 작성</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Resume CSS -->
    <%-- 현재 페이지(main.jsp) 전용 CSS 영역--%>
		<link href="<c:url value="/resources/css/resume.css" />" 
			rel="stylesheet" type="text/css">
	<!-- resumeView.js -->	
	<script src="<c:url value="/resources/js/resumeModify.js" />"></script>		
</head>

<body class="resume-body">
	<%-- header area --%> 
		<%@ include file="/WEB-INF/views/inc/header.jspf"%>
	
	<%-- main area --%> 
<%-- 	user Id : ${sessionScope.userIdx} --%>
	<h5>
<%-- 	업종 : ${param.industryCode} --%>
<%-- 	업종라벨 : ${param.hiddenIndustry}<br> --%>
<%-- 	직종 : ${param.jobCode} --%>
<%-- 	직종라벨 : ${param.hiddenJob}<br> --%>
<%-- 	직종세부 : ${param.roleCode} --%>
<%-- 	직종세부라벨 : ${param.hiddenRole}<br> --%>
	
<%-- 	기업형태 : ${param.companyCode} --%>
<%-- 	기업형태라벨 : ${param.hiddenCompanyType} --%>
<%-- 	기업명(지원한) : ${param.companyName} --%>
	</h5>
	
 	<div class="container-fluid">
    <div class="row">
      
      <!-- 좌측 공백 영역 -->
      <div class="col-12 col-md-2 side-space"></div>
      
      <!-- 중앙 메인폼 -->
      <div class="col-12 col-md-8 main-form">
        <form action="<c:url value='/resume/resumeSave' />" method="post" class="resume-form">
	        <!-- 1.jsp에서 넘어온 값들을 hidden으로 다시 담아줌 -->
		    <input type="hidden" name="industryCode" value="${param.industryCode}" />
		    <input type="hidden" name="jobCode" value="${param.jobCode}" />
		    <input type="hidden" name="roleCode" value="${param.roleCode}" />
		    <input type="hidden" name="selectedJobInput" value="${param.selectedJobInput}" />
		    <input type="hidden" name="companyCode" value="${param.companyCode}" />
		    <input type="hidden" name="appliedField" value="${param.appliedField}" />
		    <input type="hidden" name="companyName" value="${param.companyName}" />
		    <input type="hidden" name="careerCode" value="${param.careerCode}" />
		
		    <!-- 히든 파라미터 (명칭 값들) -->
		    <input type="hidden" name="hiddenIndustry" value="${param.hiddenIndustry}" />
		    <input type="hidden" name="hiddenJob" value="${param.hiddenJob}" />
		    <input type="hidden" name="hiddenRole" value="${param.hiddenRole}" />
		    <input type="hidden" name="hiddenCompanyType" value="${param.hiddenCompanyType}" />
                  
          <!-- 제목 -->
          <div class="card section-card mb-4">
            <div class="card-header section-title">
              제목 <span class="text-danger"></span>
            </div>
            <div class="card-body">
              <div class="form-group mb-3">
                <label for="title" class="resume-label">제목</label>
                <input type="text" id="title" name="title"
                       value="${resume.title}" 
                       class="form-control resume-input" 
                       placeholder="제목을 입력해주세요.">
              </div>
            </div>
          </div>


    <!-- ================= 기본 인적사항 ================= -->
    <div class="card section-card mb-5">
        <div class="card-header section-title">
            기본인적사항 <span class="text-danger"></span>
        </div>

        <div class="card-body">
            <div class="row">
                <!-- 사진 영역 -->
                <div class="col-12 col-md-3 text-center mb-4">
                    <div class="profile-box mx-auto mb-3"></div>
                    <button class="btn btn-outline-secondary btn-sm">사진 첨부</button>
                </div>

                <!-- 입력 영역 -->
                <div class="col-12 col-md-9">
                    <div class="row g-3">

                        <div class="col-md-6">
                            <label class="form-label">이름</label>
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
                                <option selected>-선택-</option>
                                <option value="남" ${resume.gender == '남' ? 'selected' : ''}>남</option>
                                <option value="여" ${resume.gender == '여' ? 'selected' : ''}>여</option>
                            </select>
                        </div>

						<div class="col-md-6">
                            <label class="form-label">이름(한문)</label>
                            <input type="text" value="${resume.nameHan}" name="nameHan" class="form-control">
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
						    <input type="text" value="${resume.address1}" name="address1" class="form-control address-half" placeholder="주소 입력">
						    <input type="text" value="${resume.address2}" name="address2" class="form-control address-half" placeholder="상세주소 입력">
						  </div>
						</div>

                    </div>
                </div>
            </div>
        </div>
    </div>

      <!-- 사회형평적 인재 우대사항 -->
     <h3 class="section-title text-center">사회형평적 인재 우대사항</h3>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">보훈대상</label>
		    <select name="veteranStatus" class="form-control resume-input">
		      <option value="비대상" <c:if test="${resume.veteranStatus eq '비대상'}">selected</c:if>>비대상</option>
		      <option value="대상(5%)" <c:if test="${resume.veteranStatus eq '대상(5%)'}">selected</c:if>>대상(5%)</option>
		      <option value="대상(10%)" <c:if test="${resume.veteranStatus eq '대상(10%)'}">selected</c:if>>대상(10%)</option>
		    </select>
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">보훈번호</label>
		    <input type="text" value="${resume.veteranNumber}" name="veteranNumber" class="form-control resume-input" placeholder="보훈번호 입력">
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">장애여부</label>
		    <select name="disabilityStatus" class="form-control resume-input">
		      <option value="비대상" ${resume.disabilityStatus == '비대상' ? 'selected' : ''}>비대상</option>
		      <option value="대상" ${resume.disabilityStatus == '대상' ? 'selected' : ''}>대상</option>
		    </select>
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">장애등급</label>
		    <input type="text" value="${resume.disabilityGrade}" name="disabilityGrade" class="form-control resume-input" placeholder="장애등급 입력">
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">다문화가정</label>
		    <select name="multiculturalStatus" class="form-control resume-input">
		      <option value="비대상" ${resume.multiculturalStatus == '비대상' ? 'selected' : ''}>비대상</option>
		      <option value="대상" ${resume.multiculturalStatus == '대상' ? 'selected' : ''}>대상</option>
		    </select>
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">북한이탈주민</label>
		    <select name="northDefector" class="form-control resume-input">
		      <option value="비대상" ${resume.northDefector == '비대상' ? 'selected' : ''}>비대상</option>
		      <option value="대상" ${resume.northDefector == '대상' ? 'selected' : ''}>대상</option>
		    </select>
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">기초생활수급자 및 차상위계층</label>
		    <select name="lowIncomeStatus" class="form-control resume-input">
		      <option value="비대상" ${resume.lowIncomeStatus == '비대상' ? 'selected' : ''}>비대상</option>
		      <option value="대상" ${resume.lowIncomeStatus == '대상' ? 'selected' : ''}>대상</option>
		    </select>
		  </div>
		</div>


      <!-- 병역사항 -->
      <h3 class="section-title text-center">병역사항</h3>

		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">군필여부</label>
		    <select name="militaryService" class="form-control resume-input">
		      <option value="비대상" ${resume.militaryService == '비대상' ? 'selected' : ''}>비대상</option>
		      <option value="미필" ${resume.militaryService == '미필' ? 'selected' : ''}>미필</option>
		      <option value="군필" ${resume.militaryService == '군필' ? 'selected' : ''}>군필</option>
		      <option value="면제" ${resume.militaryService == '면제' ? 'selected' : ''}>면제</option>
		    </select>
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">군별</label>
		    <select name="militaryBranch" class="form-control resume-input">
		      <option value="-군별 선택-" ${resume.militaryBranch == '-군별 선택-' ? 'selected' : ''}>-군별 선택-</option>
		      <option value="육군" ${resume.militaryBranch == '육군' ? 'selected' : ''}>육군</option>
		      <option value="해군" ${resume.militaryBranch == '해군' ? 'selected' : ''}>해군</option>
		      <option value="공군" ${resume.militaryBranch == '공군' ? 'selected' : ''}>공군</option>
		      <option value="전의경" ${resume.militaryBranch == '전의경' ? 'selected' : ''}>전의경</option>
		      <option value="카투사" ${resume.militaryBranch == '카투사' ? 'selected' : ''}>카투사</option>
		      <option value="공익" ${resume.militaryBranch == '공익' ? 'selected' : ''}>공익</option>
		      <option value="병특" ${resume.militaryBranch == '병특' ? 'selected' : ''}>병특</option>
		      <option value="기타" ${resume.militaryBranch == '기타' ? 'selected' : ''}>기타</option>
		    </select>
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">계급</label>
		    <select name="militaryRank" class="form-control resume-input">
		      <option value="-계급 선택-" ${resume.militaryRank == '-계급 선택-' ? 'selected' : ''}>-계급 선택-</option>
		      <option value="이병" ${resume.militaryRank == '이병' ? 'selected' : ''}>이병</option>
		      <option value="일병" ${resume.militaryRank == '일병' ? 'selected' : ''}>일병</option>
		      <option value="상병" ${resume.militaryRank == '상병' ? 'selected' : ''}>상병</option>
		      <option value="병장" ${resume.militaryRank == '병장' ? 'selected' : ''}>병장</option>
		      <option value="하사" ${resume.militaryRank == '하사' ? 'selected' : ''}>하사</option>
		      <option value="중사" ${resume.militaryRank == '중사' ? 'selected' : ''}>중사</option>
		      <option value="상사" ${resume.militaryRank == '상사' ? 'selected' : ''}>상사</option>
		      <option value="원사" ${resume.militaryRank == '원사' ? 'selected' : ''}>원사</option>
		      <option value="준위" ${resume.militaryRank == '준위' ? 'selected' : ''}>준위</option>
		      <option value="소위" ${resume.militaryRank == '소위' ? 'selected' : ''}>소위</option>
		      <option value="중위" ${resume.militaryRank == '중위' ? 'selected' : ''}>중위</option>
		      <option value="대위" ${resume.militaryRank == '대위' ? 'selected' : ''}>대위</option>
		      <option value="소령" ${resume.militaryRank == '소령' ? 'selected' : ''}>소령</option>
		      <option value="중령" ${resume.militaryRank == '중령' ? 'selected' : ''}>중령</option>
		      <option value="대령" ${resume.militaryRank == '대령' ? 'selected' : ''}>대령</option>
		    </select>
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">전역사유</label>
		    <select name="dischargeReason" class="form-control resume-input">
		      <option value="-전역 선택-" ${resume.dischargeReason == '-전역 선택-' ? 'selected' : ''}>-전역 선택-</option>
		      <option value="만기 전역" ${resume.dischargeReason == '만기 전역' ? 'selected' : ''}>만기 전역</option>
		      <option value="조기 전역" ${resume.dischargeReason == '조기 전역' ? 'selected' : ''}>조기 전역</option>
		      <option value="의병 전역" ${resume.dischargeReason == '의병 전역' ? 'selected' : ''}>의병 전역</option>
		      <option value="의가사 전역" ${resume.dischargeReason == '의가사 전역' ? 'selected' : ''}>의가사 전역</option>
		    </select>
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">입대일</label>
		    <input type="date" value="${resume.enlistDate}" name="enlistDate" id="dischargeDate" class="form-control resume-input">
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">전역일</label>
		    <input type="date" value="${resume.dischargeDate}" name="dischargeDate" id="dischargeDate" class="form-control resume-input">
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">면제사유</label>
		    <input type="text" value="${resume.exemptionReason}" name="exemptionReason" id="exemptionReason" class="form-control resume-input" placeholder="면제사유 입력">
		  </div>
		</div>

      <!-- 학력사항 -->
      <h3 class="section-title text-center">학력사항</h3>

		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">학력</label>
		    <select name="educationLevel" class="form-control resume-input">
		      <option>-학력 선택-</option>
		      <option>고등학교</option>
		      <option>대학교(2-3년제)</option>
		      <option>대학교(4년제)</option>
		      <option>대학원(석사)</option>
		      <option>대학원(박사)</option>
		    </select>
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">학교명</label>
		    <input type="text" name="schoolName" class="form-control resume-input" placeholder="학교명 입력">
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">계열</label>
		    <select name="department" class="form-control resume-input">
		      <option>-계열 선택-</option>
		      <option>인문계열</option>
		      <option>사회계열</option>
		      <option>교육계열</option>
		      <option>공학계열</option>
		      <option>자연계열</option>
		      <option>의학계열</option>
		      <option>상경계열</option>
		      <option>법학계열</option>
		      <option>예체능계열</option>
		    </select>
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">전공</label>
		    <input type="text" name="major" class="form-control resume-input" placeholder="전공명을 입력해주세요">
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">학점</label>
		    <div class="d-flex">
		      <input type="text" name="hakjum" class="form-control resume-input me-2" placeholder="학점 입력">
		      <select name="hakjumScale" class="form-control resume-input">
		        <option>기준 학점</option>
		        <option>4.0</option>
		        <option>4.3</option>
		        <option>4.5</option>
		        <option>5.0</option>
		        <option>7.0</option>
		        <option>100</option>
		      </select>
		    </div>
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">부/복수전공</label>
		    <div class="d-flex">
		      <select class="form-control resume-input me-2">
		        <option>전공 추가</option>
		        <option>부전공</option>
		        <option>복수전공</option>
		        <option>이중전공</option>
		      </select>
		      <input type="text" id="majorSub" class="form-control resume-input" placeholder="추가 전공 입력">
		    </div>
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">입학</label>
		    <input type="date" id="eduStartDay" name="eduStartDay" class="form-control resume-input">
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">졸업</label>
		    <input type="date" id="eduEndDay" name="eduEndDay" class="form-control resume-input">
		  </div>
		</div>
		
		<div class="text-center mt-4">
		  <button type="button" class="btn custom-btn me-3">목록으로</button>
		  <button type="submit" class="btn custom-btn">저장</button>
		</div>

    </form>
  </div>

	<!-- 우측 공백 영역 -->
      <div class="col-12 col-md-2 side-space"></div>
    </div>
  </div>
  
    <!-- ✅ Bootstrap JS 삽입 (body 끝 부분) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  
  
  <%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf"%>
  
</body>
    


</html>



















