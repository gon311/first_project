<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/views/inc/head.jspf"%>
		
		<%-- 현재 페이지(main.jsp) 전용 CSS 영역--%>
		<link href="<c:url value="/resources/css/resumeForm.css" />"
			rel="stylesheet" type="text/css">
	</head>
	<body>
		<%-- header area --%>
		<%@ include file="/WEB-INF/views/inc/header.jspf"%>
	
		<%-- main area --%>
		<main class="container my-4">
			<form action="<c:url value='/resume/regist2' />" name="registForm"
				id="registForm" method="post" novalidate>
				<div class="card shadow-sm">
					<div class="card-body p-4">
	
						<!-- 1. 자소서 제목 -->
						<div class="mb-4">
							<label for="title" class="form-label fw-semibold">자소서 제목 <span
								class="text-danger">*</span></label> <input type="text"
								class="form-control" id="title" name="title"
								placeholder="제목을 입력해 주세요." required>
							<div class="form-text">예) 2026 상반기 ○○기업 △△직무 자기소개서</div>
						</div>
	
						<!-- 2. 업종 -->
						<div class="mb-4">
							<div class="d-flex align-items-center mb-2">
								<label class="form-label fw-semibold mb-0 me-2">업종 <span
									class="text-danger">*</span></label>
							</div>
	
							<div class="d-flex flex-wrap chip-group">
								<input class="btn-check" type="radio" name="industry"
									id="ind_itp" value="IT_PLATFORM" required> <label
									class="btn btn-outline-secondary chip" for="ind_itp">IT·플랫폼</label>
	
								<input class="btn-check" type="radio" name="industry"
									id="ind_mfg" value="MFG_INDUSTRY" required> <label
									class="btn btn-outline-secondary chip" for="ind_mfg">제조·산업</label>
	
								<input class="btn-check" type="radio" name="industry"
									id="ind_fin" value="FINANCE_INS" required> <label
									class="btn btn-outline-secondary chip" for="ind_fin">금융·보험</label>
	
								<input class="btn-check" type="radio" name="industry"
									id="ind_retail" value="RETAIL_COMMERCE" required> <label
									class="btn btn-outline-secondary chip" for="ind_retail">유통·커머스</label>
	
								<input class="btn-check" type="radio" name="industry"
									id="ind_media" value="media_content" required> <label
									class="btn btn-outline-secondary chip" for="ind_media">미디어·콘텐츠</label>
	
								<input class="btn-check" type="radio" name="industry"
									id="ind_bio" value="bio_health" required> <label
									class="btn btn-outline-secondary chip" for="ind_bio">바이오·헬스</label>
	
								<input class="btn-check" type="radio" name="industry"
									id="ind_con" value="construction_re" required> <label
									class="btn btn-outline-secondary chip" for="ind_con">건설·부동산</label>
	
								<input class="btn-check" type="radio" name="industry"
									id="ind_public" value="public_sector" required> <label
									class="btn btn-outline-secondary chip" for="ind_public">공공·공기업</label>
	
								<input class="btn-check" type="radio" name="industry"
									id="ind_edu" value="edu_reserch" required> <label
									class="btn btn-outline-secondary chip" for="ind_edu">교육·연구</label>
							</div>
						</div>
	
						<!-- 3. 직종 + 3-1. 세부 직종 -->
						<div class="mb-4">
							<div class="d-flex align-items-center mb-2">
								<label class="form-label fw-semibold mb-0 me-2">직종 <span
									class="text-danger">*</span></label> <span class="hint">직종 선택 시
									우측의 ‘세부 직종’ 드롭다운이 활성화됩니다.</span>
							</div>
	
							<!-- 직종(칩 라디오) -->
							<div class="d-flex flex-wrap chip-group mb-3">
								<input class="btn-check" type="radio" name="jobGroup" id="jg_it"
									value="IT_DEV_DATA" required> <label
									class="btn btn-outline-primary chip" for="jg_it">IT·개발·데이터</label>
	
								<input class="btn-check" type="radio" name="jobGroup"
									id="jg_plan" value="PLAN_MGMT_ADMIN" required> <label
									class="btn btn-outline-primary chip" for="jg_plan">기획·경영·사무</label>
	
								<input class="btn-check" type="radio" name="jobGroup" id="jg_mkt"
									value="MKT_AD_PR" required> <label
									class="btn btn-outline-primary chip" for="jg_mkt">마케팅·광고·홍보</label>
	
								<input class="btn-check" type="radio" name="jobGroup"
									id="jg_design" value="DESIGN_CREATIVE" required> <label
									class="btn btn-outline-primary chip" for="jg_design">디자인·크리에이티브</label>
	
								<input class="btn-check" type="radio" name="jobGroup"
									id="jg_sales" value="SALES_CS_BIZ" required> <label
									class="btn btn-outline-primary chip" for="jg_sales">영업·고객·비즈니스</label>
	
								<input class="btn-check" type="radio" name="jobGroup" id="jg_rnd"
									value="RND_ENGINEERING" required> <label
									class="btn btn-outline-primary chip" for="jg_rnd">연구·엔지니어링</label>
	
								<input class="btn-check" type="radio" name="jobGroup"
									id="jg_prod" value="PROD_MFG_QA" required> <label
									class="btn btn-outline-primary chip" for="jg_prod">생산·제조·품질</label>
	
								<input class="btn-check" type="radio" name="jobGroup"
									id="jg_public" value="PUBLIC_EDU_SERVICE" required> <label
									class="btn btn-outline-primary chip" for="jg_public">공공·교육·서비스</label>
							</div>
	
							<!-- 세부 직종 -->
							<div class="row g-2 align-items-center">
								<div class="col-12 col-sm-6 col-md-4">
									<label for="jobRole" class="form-label mb-1">세부 직종</label> <select
										id="jobRole" name="jobRole" class="form-select" disabled
										required>
										<option value="default" disabled selected>세부 직종을 선택하세요</option>
									</select>
								</div>
							</div>
	
							<!-- hidden input -->
							<input type="hidden" id="selectedJobInput" name="selectedJobInput">
						</div>
	
						<!-- 4. 기업 형태 -->
						<div class="mb-4">
							<div class="d-flex align-items-center mb-2">
								<label class="form-label fw-semibold mb-0 me-2">기업 형태 <span
									class="text-danger">*</span></label>
							</div>
							<div class="d-flex flex-wrap chip-group">
								<input class="btn-check" type="radio" name="companyType"
									id="ct_major" value="MAJOR_CORP" required> <label
									class="btn btn-outline-secondary chip" for="ct_major">대기업</label>
	
								<input class="btn-check" type="radio" name="companyType"
									id="ct_mid" value="MID_CORP" required> <label
									class="btn btn-outline-secondary chip" for="ct_mid">중견기업</label>
	
								<input class="btn-check" type="radio" name="companyType"
									id="ct_sme" value="SME" required> <label
									class="btn btn-outline-secondary chip" for="ct_sme">중소기업</label>
	
								<input class="btn-check" type="radio" name="companyType"
									id="ct_public" value="PUBLIC_CORP" required> <label
									class="btn btn-outline-secondary chip" for="ct_public">공기업</label>
	
								<input class="btn-check" type="radio" name="companyType"
									id="ct_foreign" value="FOREIGN_CORP" required> <label
									class="btn btn-outline-secondary chip" for="ct_foreign">외국계</label>
	
								<input class="btn-check" type="radio" name="companyType"
									id="ct_start" value="STARTUP" required> <label
									class="btn btn-outline-secondary chip" for="ct_start">스타트업</label>
							</div>
						</div>
	
						<!-- 5. 지원분야 / 6. 기업명 -->
						<div class="row g-3 mb-4">
							<div class="col-12 col-md-6">
								<label class="form-label fw-semibold">지원분야 <span
									class="text-danger">*</span></label> <input type="text"
									class="form-control" id="appliedField" name="appliedField"
									required placeholder="예) 백엔드 개발자">
							</div>
							<div class="col-12 col-md-6">
								<label class="form-label fw-semibold">기업명 <span
									class="text-danger">*</span></label> <input type="text"
									class="form-control" id="companyName" name="companyName"
									required placeholder="예) ○○주식회사">
							</div>
						</div>
	
						<!-- 7. 경력 사항 -->
						<div class="mb-4">
							<div class="d-flex align-items-center mb-2">
								<label class="form-label fw-semibold mb-0 me-2">경력 사항 <span
									class="text-danger">*</span></label>
							</div>
							<div class="d-flex flex-wrap chip-group">
								<input class="btn-check" type="radio" name="careerLevel"
									id="cl_entry" value="ENTRY" required> <label
									class="btn btn-outline-secondary chip" for="cl_entry">신입</label>
	
								<input class="btn-check" type="radio" name="careerLevel"
									id="cl_exp" value="EXPERIENCED" required> <label
									class="btn btn-outline-secondary chip" for="cl_exp">경력</label> <input
									class="btn-check" type="radio" name="careerLevel" id="cl_intern"
									value="INTERN" required> <label
									class="btn btn-outline-secondary chip" for="cl_intern">인턴</label>
							</div>
						</div>


					<!-- 제출 버튼 -->
					<div class="d-flex justify-content-end gap-2 mt-4">
						<!-- 임시저장 -->
						<button type="button" id="saveDraft"
							class="btn btn-outline-secondary btn-lg">임시저장</button>

						<!-- 1단계 저장 -->
						<button type="submit" class="btn btn-primary btn-lg">저장후
							다음으로</button>
					</div>
					
					<!-- 임시저장/1단계저장 status -->
					<input type="hidden" id="status" name="status" value="0">


				</div>
				</div>
			</form>
		</main>
	
	
		<%-- footer area --%>
		<%@ include file="/WEB-INF/views/inc/footer.jspf"%>
	
		<%-- 개별 페이지 자바스크립트 영역 --%>
		<script> 
			 // ======== 세부 직종 데이터 ========
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
			document.addEventListener("DOMContentLoaded", () => {
			    const input = document.getElementById("title");
			    if (input) input.focus();
			});
			 
			document.addEventListener("DOMContentLoaded", function() {
				const radios = document.querySelectorAll('input[name="jobGroup"]');
				const selectBox = document.getElementById("jobRole");
				const jobInput = document.getElementById("selectedJobInput");
				
	
				// 초기: 비활성
				selectBox.disabled = true;
	
				
				radios.forEach(radio => {
					radio.addEventListener("change", function(){
						const selectedGroup = this.value;
						selectBox.innerHTML = '<option value="default" disabled selected>세부 직종을 선택하세요</option>';
						
						
						if (jobData[selectedGroup]) {
							jobData[selectedGroup].forEach(sub => {
								const opt = document.createElement('option');
								opt.value = sub.value;
								opt.textContent = sub.label;
								selectBox.appendChild(opt);
							});
							selectBox.disabled = false; // 활성화
							selectBox.focus();
						} else {
							selectBox.disabled = true;
						}
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
			
			document.addEventListener('DOMContentLoaded', () => {
				const form = document.getElementById('registForm');
				const statusInput = document.getElementById('status');
				const btnDraft = document.getElementById('saveDraft');
				

				btnDraft.addEventListener('click', () => {
					statusInput.value = "2";  // 임시저장 상태로 설정 (0 : 최종저장, 1: 1단계저장, 2: 임시저장)
				    form.submit();            // 서버로 전송
				});
			}   // controller에서 DB에 저장할 때, status 추가해서 저장하도록 맵핑하기 
		</script>
	</body>
</html>

