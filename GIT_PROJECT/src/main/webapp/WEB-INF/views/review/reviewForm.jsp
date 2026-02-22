<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
	<html>
	<head>
		 <%@ include file="/WEB-INF/views/inc/head.jspf" %>
		 
		 <%-- 현재 페이지(main.jsp) 전용 CSS 영역--%>
		 <link href="<c:url value="/resources/css/reviewForm.css" />" rel="stylesheet" type="text/css">
	</head>
	<body>
		<%-- header area --%>
		<%@ include file="/WEB-INF/views/inc/header.jspf" %>
		
		<%-- main area --%>
		<main>    
			<form action="<c:url value="/review/registText" />" name ="registForm" method="post">
				<!-- 자소서 제목 영역 -->
				<div class="form-area"> 
					<div class="title">
					    <label>자소서 제목 <span class="text-danger">*</span></label>
					    <input type="text" id="title" name="title" placeholder="제목을 입력해 주세요." required>
					</div>
					<!-- 업종 선택 영역 -->
					<div class="industry">
						업종<span style="color:red">*</span> <br>
						<label><input type="radio" name="industry" value="IT_PLATFORM"><span class="radio-btn">IT·플랫폼</span></label>
						<label><input type="radio" name="industry" value="MFG_INDUSTRY"><span class="radio-btn">제조·산업</span></label>
						<label><input type="radio" name="industry" value="FINANCE_INS"><span class="radio-btn">금융·보험</span></label>
						<label><input type="radio" name="industry" value="RETAIL_COMMERCE"><span class="radio-btn">유통·커머스</span></label>
						<label><input type="radio" name="industry" value="media_content"><span class="radio-btn">미디어·콘텐츠</span></label>
						<label><input type="radio" name="industry" value="bio_health"><span class="radio-btn">바이오·헬스</span></label>
						<label><input type="radio" name="industry" value="construction_re"><span class="radio-btn">건설·부동산</span></label>
						<label><input type="radio" name="industry" value="public_sector"><span class="radio-btn">공공·공기업</span></label>
						<label><input type="radio" name="industry" value="edu_reserch"><span class="radio-btn">교육·연구</span></label>
					</div>
					<!-- 직종 선택 영역 -->
					<div class="job-group-container">
						<div class="job-group">
							직종<span style="color:red">*</span> <br>
							<label><input type="radio" name="jobGroup" value="IT_DEV_DATA"><span class="radio-btn">IT·개발·데이터</span></label>
							<label><input type="radio" name="jobGroup" value="PLAN_MGMT_ADMIN"><span class="radio-btn">기획·경영·사무</span></label>
							<label><input type="radio" name="jobGroup" value="MKT_AD_PR"><span class="radio-btn">마케팅·광고·홍보</span></label>
							<label><input type="radio" name="jobGroup" value="DESIGN_CREATIVE"><span class="radio-btn">디자인·크리에이티브</span></label>
							<label><input type="radio" name="jobGroup" value="SALES_CS_BIZ"><span class="radio-btn">영업·고객·비즈니스</span></label>
							<label><input type="radio" name="jobGroup" value="RND_ENGINEERING"><span class="radio-btn">연구·엔지니어링</span></label>
							<label><input type="radio" name="jobGroup" value="PROD_MFG_QA"><span class="radio-btn">생산·제조·품질</span></label>
							<label><input type="radio" name="jobGroup" value="PUBLIC_EDU_SERVICE"><span class="radio-btn">공공·교육·서비스</span></label>
						</div>
						<!-- 세부 직종 선택 영역 -->
						<div class="job-role">
							<select id="jobRole" name="jobRole" required>
						    	<option value="default" disabled selected>세부 직종을 선택하세요</option>
							</select>
						</div>
						<!-- hidden input으로 선택값 전달 -->
						<input type="hidden" id="selectedJobInput" name="selectedJobInput">
					</div>
					
					
					<!-- 기업형태 선택 영역 -->
					<div class="company-type">
						<br>기업 형태<span style="color:red">*</span><br>
						<label><input type="radio" name="companyType" value="MAJOR_CORP"><span class="radio-btn">대기업</span></label>
						<label><input type="radio" name="companyType" value="MID_CORP"><span class="radio-btn">중견기업</span></label>
						<label><input type="radio" name="companyType" value="SME"><span class="radio-btn">중소기업</span></label>
						<label><input type="radio" name="companyType" value="PUBLIC_CORP"><span class="radio-btn">공기업</span></label>
						<label><input type="radio" name="companyType" value="FOREIGN_CORP"><span class="radio-btn">외국계</span></label>
						<label><input type="radio" name="companyType" value="STARTUP"><span class="radio-btn">스타트업</span></label>
					</div>
					<!-- 지원 분야 입력 영역 -->
					<div class="text-group-container">
						<div class="sec">
							지원분야<span style="color:red">*</span> <input type="text" required> 
						</div>
						<!-- 기업명 입력 영역 -->
						<div class="company-name">
							기업명<span style="color:red">*</span> <input type="text" required>
						</div>
					</div>
					<!-- 경력사항 선택 영역 -->
					<div class="career-level">
						경력사항<span style="color:red">*</span><br>
						<label><input type="radio" name="careerLevel" value="ENTRY"><span class="radio-btn">신입</span></label>
						<label><input type="radio" name="careerLevel" value="EXPERIENCED"><span class="radio-btn">경력</span></label>
						<label><input type="radio" name="careerLevel" value="INTERN"><span class="radio-btn">인턴</span></label>
					</div>
					<div class="btn-submit">
					
						<input type="submit" value="저장후 다음으로">
					</div>
				</div>
			</form>
		</main>
		
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf" %>
		
		<%-- 개별 페이지 자바스크립트 영역 --%>
		<script> 
		const jobData = {
				  IT_DEV_DATA: [
				    { value: "BACKEND_DEV", label: "백엔드 개발자" },
				    { value: "FRONTEND_DEV", label: "프론트엔드 개발자" },
				    { value: "FULLSTACK_DEV", label: "풀스택 개발자" },
				    { value: "DATA_ANALYST", label: "데이터 분석가" },
				    { value: "DATA_ENGINEER", label: "데이터 엔지니어" },
				    { value: "AI_ML_ENGINEER", label: "AI/ML 엔지니어" },
				    { value: "DEVOPS_INFRA", label: "DevOps/인프라" }
				  ],
				  PLAN_MGMT_ADMIN: [
				    { value: "SERVICE_PLANNER", label: "서비스 기획자" },
				    { value: "PM_PO", label: "PM/PO" },
				    { value: "BIZ_PLANNER", label: "사업기획" },
				    { value: "STRATEGY_PLANNER", label: "전략기획" },
				    { value: "OPERATION_ADMIN", label: "운영·사무" }
				  ],
				  MKT_AD_PR: [
				    { value: "PERF_MARKETER", label: "퍼포먼스 마케터" },
				    { value: "CONTENT_MARKETER", label: "콘텐츠 마케터" },
				    { value: "BRAND_MARKETER", label: "브랜드 마케터" },
				    { value: "DIGITAL_MARKETER", label: "디지털 마케터" },
				    { value: "PR_COMM", label: "PR/커뮤니케이션" }
				  ],
				  DESIGN_CREATIVE: [
				    { value: "UX_UI_DESIGNER", label: "UX/UI 디자이너" },
				    { value: "PRODUCT_DESIGNER", label: "프로덕트 디자이너" },
				    { value: "GRAPHIC_DESIGNER", label: "그래픽 디자이너" },
				    { value: "VIDEO_MOTION_DESIGNER", label: "영상·모션 디자이너" }
				  ],
				  SALES_CS_BIZ: [
				    { value: "B2B_SALES", label: "B2B 영업" },
				    { value: "B2C_SALES", label: "B2C 영업" },
				    { value: "GLOBAL_SALES", label: "해외영업" },
				    { value: "TECH_SALES", label: "기술영업" },
				    { value: "CUSTOMER_SUCCESS", label: "고객성공(CS/CRM)" }
				  ],
				  RND_ENGINEERING: [
				    { value: "RND_RESEARCHER", label: "R&D 연구원" },
				    { value: "RESEARCH_PLANNER", label: "연구기획" },
				    { value: "PROCESS_ENGINEER", label: "공정 엔지니어" },
				    { value: "QA_ENGINEER", label: "품질 엔지니어" },
				    { value: "HW_ENGINEER", label: "HW 엔지니어" }
				  ],
				  PROD_MFG_QA: [
				    { value: "PRODUCTION_MANAGER", label: "생산관리" },
				    { value: "PROCESS_MANAGER", label: "공정관리" },
				    { value: "QUALITY_MANAGER", label: "품질관리" },
				    { value: "MAINTENANCE_ENGINEER", label: "설비·유지보수" }
				  ],
				  PUBLIC_EDU_SERVICE: [
				    { value: "PUBLIC_ADMIN", label: "공기업 사무" },
				    { value: "PUBLIC_POLICY", label: "공공행정" },
				    { value: "TEACHER_INSTRUCTOR", label: "교원·강사" },
				    { value: "SOCIAL_WORKER", label: "사회복지" },
				    { value: "SERVICE_OPERATOR", label: "서비스 운영" }
				  ],
				};

		document.addEventListener("DOMContentLoaded", function() {
			const radios = document.querySelectorAll('input[name="jobGroup"]');
			const selectBox = document.getElementById("jobRole");
			const jobInput = document.getElementById("selectedJobInput");
			
			radios.forEach(radio => {
				radio.addEventListener("change", function(){
					const selectedGroup = this.value;
					selectBox.innerHTML = '<option value="">세부 직종을 선택하세요.</option>';
					
					jobData[selectedGroup].forEach(sub => {
						const opt = document.createElement('option');
						opt.value = sub.value;
						opt.textContent = sub.label;
						selectBox.appendChild(opt);
					});
				});
			});
			
			// 드롭다운 선택 시 hidden input에 값 저장 
			selectBox.addEventListener("change", function(){
				jobInput.value = this.value;
			});
		});
		
		registForm.onsubmit = function() {
			if(registForm.industry.value == "") {
				alert("업종을 선택해주세요.");
				return false;
			} else if(registForm.jobGroup.value == "") {
				alert("직종을 선택해주세요.");
				return false;
			} else if(registForm.companyType.value == "") {
				alert("기업 형태를 선택해주세요.");
				return false;
			} else if(registForm.careerLevel.value == "") {
				alert("경력 사항을 선택해주세요.");
				return false;
			}
		}
		</script>
	</body>
</html>

