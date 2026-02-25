<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="<c:url value="/resources/css/resume.css" />" rel="stylesheet" type="text/css">
	
	<!-- ✅ Bootstrap CSS 삽입 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
        rel="stylesheet" 
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
        crossorigin="anonymous">
        
</head>

<body class="resume-body">
  <div class="container resume-container">
    <h1 class="resume-title text-center">이력서</h1>

    <form action="<c:url value='/resume/resumeRegist' />" method="post" class="resume-form">
      <!-- 제목 -->
      <div class="form-group mb-3">
      	<!-- 임시. 파라미터 첵크 -->
      	업종:${param.industry}
      	직종:${param.jobGroup}
      	세부직종:${param.jobRole}
      	기업형태:${param.companyType}
      	지원분야:${param.appliedField}
      	기업명(지원한):${param.companyName}
      	경력사항:${param.careerLevel}<br>
      	
      	
        <label for="resumeTitle" class="resume-label">제목</label>
        <input type="text" id="resumeTitle" name="resumeTitle"
        		value="${param.title}" 
               class="form-control resume-input" 
               placeholder="제목을 입력해주세요.">
      </div>

      <!-- 사진 -->
		<!-- 기본 정보 -->
<div class="row mb-3">
  <!-- 사진 -->
  <div class="col-md-4 col-sm-12 text-center">
    <img src="<c:url value='/resources/images/sam_face_1.png' />" alt="photo" class="img-thumbnail resume-photo mb-2">
    <input type="button" value="사진 첨부" class="btn resume-btn btn-sm">
  </div>

  <!-- 이름 및 나머지 기본정보 -->
  <div class="col-md-8 col-sm-12">
    <div class="row mb-3">
      <!-- 이름 -->
      <div class="col-md-6 col-sm-12">
        <label class="resume-label">이름</label>
        <input type="text" name="name" class="form-control resume-input" placeholder="한글 이름 입력">
      </div>
      <!-- 생년월일 -->
      <div class="col-md-6 col-sm-12">
        <label class="resume-label">생년 월일</label>
        <input type="date" name="birth" class="form-control resume-input">
      </div>
    </div>

    <div class="row mb-3">
      <!-- 이름(영문) -->
      <div class="col-md-6 col-sm-12">
        <label class="resume-label">이름(영문)</label>
        <input type="text" name="nameEng" class="form-control resume-input" placeholder="영문 이름 입력">
      </div>
      <!-- 성별 -->
      <div class="col-md-6 col-sm-12">
        <label class="resume-label">성별</label>
        <select name="gender" class="form-control resume-input">
          <option>-선택-</option>
          <option>남성</option>
          <option>여성</option>
        </select>
      </div>
    </div>

    <div class="row mb-3">
      <!-- 이름(한문) -->
      <div class="col-md-6 col-sm-12">
        <label class="resume-label">이름(한문)</label>
        <input type="text" name="nameHanj" class="form-control resume-input" placeholder="한문 이름 입력">
      </div>
      <!-- 전화번호 -->
      <div class="col-md-6 col-sm-12">
        <label class="resume-label">전화번호</label>
        <input type="text" name="phone" class="form-control resume-input" placeholder="전화번호 입력(-제외)">
      </div>
    </div>

    <!-- 이메일은 단독으로 한 줄 -->
    <div class="row mb-3">
      <div class="col-md-12 col-sm-12">
        <label class="resume-label">이메일</label>
        <input type="text" name="email" class="form-control resume-input resume-input-wide" placeholder="이메일 입력">
      </div>
    </div>

    <!-- 주소와 상세주소 같은 행에 나란히 배치 -->
    <div class="row mb-3">
      <div class="col-md-6 col-sm-12">
        <label class="resume-label">주소</label>
        <input type="text" name="address1" class="form-control resume-input" placeholder="주소 입력">
      </div>
      <div class="col-md-6 col-sm-12 d-flex align-items-end">
        <!-- 상세주소는 라벨 없이 텍스트박스만 -->
        <input type="text" name="address2" class="form-control resume-input" placeholder="상세주소 입력">
      </div>
    </div>
  </div>
</div>

      <!-- 사회형평적 인재 우대사항 -->
     <h3 class="section-title text-center">사회형평적 인재 우대사항(필수)</h3>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">보훈대상</label>
		    <select name="veteranState" class="form-control resume-input">
		      <option>비대상</option>
		      <option>대상(5%)</option>
		      <option>대상(10%)</option>
		    </select>
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">보훈번호</label>
		    <input type="text" name="veteranNum" class="form-control resume-input" placeholder="보훈번호 입력">
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">장애여부</label>
		    <select name="disabilYn" class="form-control resume-input">
		      <option>비대상</option>
		      <option>대상</option>
		    </select>
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">장애등급</label>
		    <input type="text" name="disabilGrade" class="form-control resume-input" placeholder="장애등급 입력">
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">다문화가정</label>
		    <select name="multicult" class="form-control resume-input">
		      <option>비대상</option>
		      <option>대상</option>
		    </select>
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">북한이탈주민</label>
		    <select name="northDefector" class="form-control resume-input">
		      <option>비대상</option>
		      <option>대상</option>
		    </select>
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">기초생활수급자 및 차상위계층</label>
		    <select name="basicLive" class="form-control resume-input">
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
		    <select name="miliStatus" class="form-control resume-input">
		      <option>비대상</option>
		      <option>미필</option>
		      <option>군필</option>
		      <option>면제</option>
		    </select>
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">군별</label>
		    <select name="miliType" class="form-control resume-input">
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
		    <select name="miliRank" class="form-control resume-input">
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
		    <select name="miliEnd" class="form-control resume-input">
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
		    <input type="date" id="miliIn" class="form-control resume-input">
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">전역일</label>
		    <input type="date" id="miliOut" class="form-control resume-input">
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">면제사유</label>
		    <input type="text" id="miliExcept" class="form-control resume-input" placeholder="면제사유 입력">
		  </div>
		</div>

      <!-- 학력사항 -->
      <h3 class="section-title text-center">학력사항(필수)</h3>

		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">학력</label>
		    <select name="eduFinal" class="form-control resume-input">
		      <option>-학력 선택-</option>
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
		    <select name="eduType" class="form-control resume-input">
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
		    <input type="text" name="majorName" class="form-control resume-input" placeholder="전공명을 입력해주세요">
		  </div>
		</div>
		
		<div class="row mb-3">
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">학점</label>
		    <div class="d-flex">
		      <input type="text" name="eduScore" class="form-control resume-input me-2" placeholder="학점 입력">
		      <select class="form-control resume-input">
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
		    <input type="date" id="eduStartday" class="form-control resume-input">
		  </div>
		  <div class="col-md-6 col-sm-12">
		    <label class="resume-label">졸업</label>
		    <input type="date" id="eduEndday" class="form-control resume-input">
		  </div>
		</div>
		
		<div class="text-center mt-4">
		  <button type="button" class="btn custom-btn me-3">목록으로</button>
		  <button type="submit" class="btn custom-btn">저장</button>
		</div>


    </form>
  </div>
  
  <!-- ✅ Bootstrap JS 삽입 (body 끝 부분) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
          integrity="sha384-ENjdO4Dr2bkBIFxQpeoYz1Dh8z8I4Q+7nU5lZl+cbk+6jzrWeNseyX2VINqbodZ4" 
          crossorigin="anonymous"></script>
  
</body>

</html>



















