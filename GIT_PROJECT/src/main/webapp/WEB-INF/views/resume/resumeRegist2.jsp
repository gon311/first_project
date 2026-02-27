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
</head>

<body class="resume-body">
	<%-- header area --%> 
		<%@ include file="/WEB-INF/views/inc/header.jspf"%>
	
	<%-- main area --%> 
<%-- 	user Id : ${sessionScope.userIdx} --%>
	<h5>
	업종 : ${param.industry}
	업종라벨 : ${param.industryLabel}<br>
	직종 : ${param.jobGroup}
	직종라벨 : ${param.jobGroupLabel}<br>
	직종세부 : ${param.jobRole}
	직종세부라벨 : ${param.jobRoleLabel}<br>
	
	기업형태 : ${param.companyType}
	기업형태라벨 : ${param.companyTypeLabel}
	기업명 : ${param.companyName}
	</h5>
	
 	<div class="container-fluid">
    <div class="row">
      
      <!-- 좌측 공백 영역 -->
      <div class="col-12 col-md-2 side-space"></div>
      
      <!-- 중앙 메인폼 -->
      <div class="col-12 col-md-8 main-form">
        <form action="<c:url value='/resume/resumeSave' />" method="post" class="resume-form">
          
          <!-- 제목 -->
          <div class="card section-card mb-4">
            <div class="card-header section-title">
              제목 <span class="text-danger">(필수)</span>
            </div>
            <div class="card-body">
              <div class="form-group mb-3">
                <label for="resumeTitle" class="resume-label">제목</label>
                <input type="text" id="title" name="title"
                       value="${param.title}" 
                       class="form-control resume-input" 
                       placeholder="제목을 입력해주세요.">
              </div>
            </div>
          </div>


    <!-- ================= 기본 인적사항 ================= -->
    <div class="card section-card mb-5">
        <div class="card-header section-title">
            기본인적사항 <span class="text-danger">(필수)</span>
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
                            <input type="text" name="name_kor" class="form-control">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">생년월일</label>
                            <input type="date" name="birth_date" class="form-control">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">이름(영문)</label>
                            <input type="text" name="name_eng" class="form-control">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">성별</label>
                            <select name="gender" class="form-select">
                                <option selected>-선택-</option>
                                <option>남</option>
                                <option>여</option>
                            </select>
                        </div>

						<div class="col-md-6">
                            <label class="form-label">이름(한문)</label>
                            <input type="text" name="name_han" class="form-control">
                        </div>	
                        <div class="col-md-6">
                            <label class="form-label">전화번호</label>
                            <input type="text" name="phone_number" class="form-control">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">이메일</label>
                            <input type="email" name="email" class="form-control">
                        </div>

                        <div class="col-md-12">
						  <label class="form-label">주소</label>
						  <div class="d-flex gap-2 mt-1">
						    <input type="text" name="address1" class="form-control address-half" placeholder="주소 입력">
						    <input type="text" name="address2" class="form-control address-half" placeholder="상세주소 입력">
						  </div>
						</div>

                    </div>
                </div>
            </div>
        </div>
    </div>

      <!-- 사회형평적 인재 우대사항 -->
     <h3 class="section-title text-center">사회형평적 인재 우대사항(필수)</h3>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">보훈대상</label>
		    <select name="veteran_status" class="form-control resume-input">
		      <option>비대상</option>
		      <option>대상(5%)</option>
		      <option>대상(10%)</option>
		    </select>
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">보훈번호</label>
		    <input type="text" name="veteran_number" class="form-control resume-input" placeholder="보훈번호 입력">
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">장애여부</label>
		    <select name="disability_status" class="form-control resume-input">
		      <option>비대상</option>
		      <option>대상</option>
		    </select>
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">장애등급</label>
		    <input type="text" name="disability_grade" class="form-control resume-input" placeholder="장애등급 입력">
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">다문화가정</label>
		    <select name="multicultural_status" class="form-control resume-input">
		      <option>비대상</option>
		      <option>대상</option>
		    </select>
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">북한이탈주민</label>
		    <select name="north_defector" class="form-control resume-input">
		      <option>비대상</option>
		      <option>대상</option>
		    </select>
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">기초생활수급자 및 차상위계층</label>
		    <select name="low_income_status" class="form-control resume-input">
		      <option>비대상</option>
		      <option>대상</option>
		    </select>
		  </div>
		</div>


      <!-- 병역사항 -->
      <h3 class="section-title text-center">병역사항(필수)</h3>

		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">군필여부</label>
		    <select name="military_service" class="form-control resume-input">
		      <option>비대상</option>
		      <option>미필</option>
		      <option>군필</option>
		      <option>면제</option>
		    </select>
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">군별</label>
		    <select name="military_branch" class="form-control resume-input">
		      <option>-군별 선택-</option>
		      <option>육군</option>
		      <option>해군</option>
		      <option>공군</option>
		      <option>전의경</option>
		      <option>카투사</option>
		      <option>공익</option>
		      <option>병특</option>
		      <option>기타</option>
		    </select>
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">계급</label>
		    <select name="military_rank" class="form-control resume-input">
		      <option>이병</option>
		      <option>일병</option>
		      <option>상병</option>
		      <option>병장</option>
		      <option>하사</option>
		      <option>중사</option>
		      <option>상사</option>
		      <option>원사</option>
		      <option>준위</option>
		      <option>소위</option>
		      <option>중위</option>
		      <option>대위</option>
		      <option>소령</option>
		      <option>중령</option>
		      <option>대령</option>
		    </select>
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">전역사유</label>
		    <select name="discharge_reason" class="form-control resume-input">
		      <option>-전역 선택-</option>
		      <option>만기 전역</option>
		      <option>조기 전역</option>
		      <option>의병 전역</option>
		      <option>의가사 전역</option>
		    </select>
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">입대일</label>
		    <input type="date" name="enlist_date" id="enlist_date" class="form-control resume-input">
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">전역일</label>
		    <input type="date" name="discharge_date" id="discharge_date" class="form-control resume-input">
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">면제사유</label>
		    <input type="text" name="exemption_reason" id="exemption_reason" class="form-control resume-input" placeholder="면제사유 입력">
		  </div>
		</div>

      <!-- 학력사항 -->
      <h3 class="section-title text-center">학력사항(필수)</h3>

		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">학력</label>
		    <select name="education_level" class="form-control resume-input">
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
		    <input type="text" name="school_name" class="form-control resume-input" placeholder="학교명 입력">
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
		      <select name="hakjum_scale" class="form-control resume-input">
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
		    <input type="date" id="eduStartday" name="edu_start_day" class="form-control resume-input">
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">졸업</label>
		    <input type="date" id="eduEndday" name="edu_end_day" class="form-control resume-input">
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



















