<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="<c:url value="/resources/css/jobCss/jobCorrection.css" />" rel="stylesheet" type="text/css">
<div class="container">
    <form action="<c:url value="/job/jobCorrection" />" method="post" enctype="multipart/form-data">
        
        <div class="form-group">
       		<input type="hidden" name="jobId" value="${job.jobId}">
        	<input type="hidden" name="compId" value="${userIdx}">
            <div class="label-box">공고제목 <span style="color:red">*</span></div>
            <div class="input-box"><input type="text" name="title" placeholder="디자이너 채용" value="${job.title}" required></div>
        </div>

        <div class="form-group">
            <div class="label-box">모집분야명 <span style="color:red">*</span></div>
            <div class="input-box">
                <div class="job-selector-wrapper">
                    <ul class="main-cat-list" id="mainCatList"></ul>
                    <ul class="sub-cat-list" id="subCatList">
                        <li style="color:#999; font-size:0.9em; width:100%; text-align:center; margin-top:80px;">대분류를 선택해주세요.</li>
                    </ul>
                </div>
                <input type="text" name="field" id="selectedJobInput" disabled placeholder="직무를 선택하면 자동 입력됩니다." value="${job.field}" style="margin-top:10px; background:#f8f9fa;" required>
            </div>
        </div>

        <div class="form-group">
            <div class="label-box">주요업무 <span style="color:red">*</span></div>
            <div class="input-box">
                <textarea name="task" rows="5" placeholder="• 사이트 웹디자인" disabled>${job.task}</textarea>
            </div>
        </div>

        <div class="form-group">
		    <div class="label-box">파일 관리</div>
		    <div class="input-box">
		        <div class="file-management-box">
		            
		            <c:if test="${not empty fileList}">
		                <span class="file-section-title">기존 첨부 파일 (삭제 시 체크)</span>
		                <div class="existing-file-list">
		                    <c:forEach var="file" items="${fileList}">
		                        <div class="existing-file-item">
		                            <span class="file-info">
		                                <i class="fas fa-file-alt"></i> ${file.originalFileName}
		                            </span>
		                            <label class="delete-label">
		                                <input type="checkbox" name="deleteFiles" value="${file.fileId}"> 삭제
		                            </label>
		                        </div>
		                    </c:forEach>
		                </div>
		                <hr class="file-divider">
		            </c:if>
		            
		            <span class="file-section-title">새 파일 추가</span>
		            <input type="file" name="files" multiple class="form-control-file">
		        </div>
		    </div>
		</div>
        
        <div class="form-group">
		    <div class="label-box">고용 형태 <span style="color:red">*</span></div>
		    <div class="input-box">
		        <select name="empType" required style="width: 200px; display:inline-block;">
		            <option value="정규직" ${job.empType == '정규직' ? 'selected' : ''}>정규직</option>
		            <option value="계약직" ${job.empType == '계약직' ? 'selected' : ''}>계약직</option>
		            <option value="인턴" ${job.empType == '인턴' ? 'selected' : ''}>인턴</option>
		        </select>
		        
		        <label style="margin-left: 15px;">
		            <input type="checkbox" name="probation" value="Y" ${job.probation == 'Y' ? 'checked' : ''}> 수습기간 있음
		        </label>
		    </div>
		</div>

        <div class="form-group">
		    <div class="label-box">경력 <span style="color:red">*</span></div>
		    <div class="input-box">
		        <label><input type="checkbox" name="expType" value="new" class="expCheck" ${job.expType == 'new' ? 'checked' : ''}> 신입</label>
				<label><input type="checkbox" name="expType" value="newCareer" class="expCheck" ${job.expType == 'newCareer' ? 'checked' : ''}> 신입·경력</label>
				<label><input type="checkbox" name="expType" value="career" class="expCheck" ${job.expType == 'career' ? 'checked' : ''}> 경력</label>
		
		        <select name="minExp" id="minExp" style="width: 140px; display:inline-block;">
				    <option value="0" ${job.minExp == '0' ? 'selected' : ''}>1년 미만</option>
				    <option value="1" ${job.minExp == '1' ? 'selected' : ''}>1년 이상</option>
				    <option value="3" ${job.minExp == '3' ? 'selected' : ''}>3년 이상</option>
				    <option value="5" ${job.minExp == '5' ? 'selected' : ''}>5년 이상</option>
				    <option value="10" ${job.minExp == '10' ? 'selected' : ''}>10년 이상</option>
				</select>
				<span style="margin: 0 5px;">~</span>
				<select name="maxExp" id="maxExp" style="width: 140px; display:inline-block;">
				    <option value="3년" ${job.maxExp == '3년' ? 'selected' : ''}>3년 이하</option>
				    <option value="5년" ${job.maxExp == '5년' ? 'selected' : ''}>5년 이하</option>
				    <option value="8년" ${job.maxExp == '8년' ? 'selected' : ''}>8년 이하</option>
				    <option value="10년" ${job.maxExp == '10년' ? 'selected' : ''}>10년 이하</option>
				    <option value="제한 없음" ${job.maxExp == '제한 없음' ? 'selected' : ''}>제한 없음</option>
				</select>
		        <label style="margin-left: 15px;">
		            <input type="checkbox" name="expNone" id="expNone"> 경력무관
		        </label>
		    </div>
		</div>

        <div class="form-group">
		    <div class="label-box">학력 <span style="color:red">*</span></div>
		    <div class="input-box">
		        <select name="edu" id="eduSelect">
		            <option ${job.edu == '학력무관' ? 'selected' : ''}>학력무관</option>
		            <option ${job.edu == '고등학교 졸업' ? 'selected' : ''}>고등학교 졸업</option>
		            <option ${job.edu == '대학교(2,3년) 졸업' ? 'selected' : ''}>대학교(2,3년) 졸업</option>
		            <option ${job.edu == '대학교(4년) 졸업' ? 'selected' : ''}>대학교(4년) 졸업</option>
		        </select>
		        <input type="checkbox" name="eduPending"> 졸업 예정자 가능
		    </div>
		</div>

        <div class="form-group">
            <div class="label-box">급여 <span style="color:red">*</span></div>
            <div class="input-box">
                <select name="salary">
				    <option ${job.salary == '면접 후 결정' ? 'selected' : ''}>면접 후 결정</option>
				    <option ${job.salary == '회사내규에 따름' ? 'selected' : ''}>회사내규에 따름</option>
				</select>
                <div class="info-box" style="margin-top:10px;">
                    ⓘ 2026년 기준 최저시급 10,320원<br>
                    당사는 최저 임금법을 준수하며, 최저임금 미만의 공고는 강제 마감될 수 있습니다.
                </div>
            </div>
        </div>

        <div class="form-group">
		    <div class="label-box">근무지 <span style="color:red">*</span></div>
		    <div class="input-box">
		        <div style="display: flex; gap: 10px; margin-bottom: 10px;">
		            <input type="text" name="postCode" id="postCode" placeholder="우편번호" style="width: 120px;" readonly required>
		            <button type="button" onclick="execDaumPostcode()" style="padding: 10px; cursor: pointer; background: #333; color: #fff; border: none; border-radius: 5px;">주소 검색</button>
		        </div>
		        <input type="text" name="address1" id="address1" placeholder="기본 주소" style="margin-bottom: 10px;" readonly required>
		        <input type="text" name="address2" id="address2" placeholder="상세 주소" required>
		        <input type="hidden" name="address" id="address">
		        
		        
		        <label style="margin-top: 10px; display: block;">
					<input type="checkbox" name="isRemote" value="Y" ${job.isRemote == 'Y' ? 'checked' : ''}> 재택근무 가능
				</label>
		    </div>
		</div>
		
		<div class="form-group">
		    <div class="label-box">담당자 정보 <span style="color:red">*</span></div>
		    <div class="input-box">
		        <div style="display: flex; gap: 10px; margin-bottom: 10px;">
		            <input type="text" name="mgrName" value="${job.mgrName}" placeholder="담당자 이름" required>
		            
		            <input type="text" name="mgrPhone" id="mgrPhone" value="${job.mgrPhone}" 
		                   placeholder="연락처" pattern="01[0-9]-[0-9]{3,4}-[0-9]{4}" required>
		        </div>
		        
		        <input type="email" name="mgrEmail" value="${job.mgrEmail}" placeholder="이메일 주소" required>
		        
		        <label style="margin-top: 10px; display: block; font-size: 0.9em; color: #666;">
		            <input type="checkbox" name="isPublic" value="Y" ${job.isPublic == 'Y' ? 'checked' : ''}> 담당자 정보 공개
		        </label>
		    </div>
		</div>

        <div class="form-group">
		    <div class="label-box">접수 기간 <span style="color:red">*</span></div>
		    <div class="input-box">
		        <input type="date" name="openDate" value="${job.openDate}" required style="width: 200px; display:inline-block;">
		        <span style="margin: 0 10px;">~</span>
		        <input type="date" name="closeDate" value="${job.closeDate}" required style="width: 200px; display:inline-block;">
		    </div>
		    <div class="label-box">공고 모집 상태 <span style="color:red">*</span></div>
		    <div class="input-box">
		        <select name="postStatus" class="status-select" style="width: 100%; height: 40px; border: 1px solid #ccc; border-radius: 4px; padding-left: 10px;">
		            <option value="1" ${job.postStatus == 1 ? 'selected' : ''}>진행중 (모집중)</option>
		            <option value="2" ${job.postStatus == 2 ? 'selected' : ''}>마감</option>
		            <option value="3" ${job.postStatus == 3 ? 'selected' : ''}>보류 (일시정지)</option>
		        </select>
		        <p style="font-size: 0.8em; color: #666; margin-top: 5px;">* '마감' 선택 시 공고 리스트에서 비활성화됩니다.</p>
		    </div>
		</div>

        <div class="button-group">
		    <button type="submit" class="btn-submit">공고 수정하기</button>
		    <button type="reset" class="btn-reset">초기화</button>
		    <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
		</div>
    </form>
</div>
<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

<script>
// 1. 모집분야 데이터 정의
const jobData = {
    "기획·전략": ["경영기획", "전략기획", "사업개발", "서비스기획", "데이터분석"],
    "마케팅·홍보": ["브랜드마케팅", "퍼포먼스마케팅", "광고AE", "SNS마케팅", "홍보(PR)"],
    "IT개발": ["백엔드", "프론트엔드", "앱개발", "게임개발", "AI·인공지능", "임베디드", "보안"],
    "디자인": ["UI·UX디자인", "웹디자인", "그래픽디자인", "영상편집", "제품디자인"],
    "교육": ["초중고교사", "대학교수", "전문강사", "학습지교사", "입시강사", "외국어강사", "교직원"],
    "영업·고객상담": ["IT영업", "기술영업", "영업관리", "고객상담(CS)", "인바운드"],
    "의료·보건": ["의사", "간호사", "물리치료사", "임상병리", "약사", "의료코디네이터"]
};	

document.addEventListener("DOMContentLoaded", function() {
    // === [기능 1] 모집분야 영역 수정 불가 (클릭/입력 차단) ===
    const jobSelectorWrapper = document.querySelector('.job-selector-wrapper'); 
    if (jobSelectorWrapper) {
        jobSelectorWrapper.style.pointerEvents = "none"; 
        jobSelectorWrapper.style.opacity = "0.6";        
        jobSelectorWrapper.style.userSelect = "none";    
    }

    // === [기능 2] 학력 조건 강화 금지 로직 ===
    const eduSelect = document.getElementById('eduSelect');
    if (eduSelect) {
        // 페이지 로드 시점의 기존 인덱스 저장
        const originalEduIdx = eduSelect.selectedIndex;

        eduSelect.addEventListener('change', function() {
            // 새로 선택한 인덱스가 기존보다 크면 (학력이 높아지면) 차단
            if (this.selectedIndex > originalEduIdx) {
                alert("학력 조건은 기존 공고보다 높게 수정할 수 없습니다.");
                this.selectedIndex = originalEduIdx; // 원래대로 복구
            }
        });
    }

    // === [기능 3] 기존 모집분야 카테고리 생성 로직 (건드리지 않음) ===
    const mainUl = document.getElementById('mainCatList');
    const subUl = document.getElementById('subCatList');
    const jobInput = document.getElementById('selectedJobInput');

    if (mainUl && subUl && typeof jobData !== 'undefined') {
        Object.keys(jobData).forEach(cat => {
            const li = document.createElement('li');
            li.textContent = cat;
            li.onclick = function() {
                document.querySelectorAll('.main-cat-list li').forEach(el => el.classList.remove('active'));
                this.classList.add('active');
                subUl.innerHTML = '';
                jobData[cat].forEach(sub => {
                    const subBtn = document.createElement('li');
                    subBtn.className = 'sub-job-item';
                    subBtn.textContent = sub;
                    subBtn.onclick = function() {
                        jobInput.value = sub;
                        document.querySelectorAll('.sub-job-item').forEach(el => el.classList.remove('selected'));
                        this.classList.add('selected');
                    };
                    subUl.appendChild(subBtn);
                });
            };
            mainUl.appendChild(li);
        });
    }
    
	const fullAddr = "${job.address}"; 
    
    if (fullAddr && fullAddr.includes("[")) {
        // 1. 우편번호 추출 및 삽입 (ID: postCode 대문자 확인)
        const pc = fullAddr.substring(fullAddr.indexOf("[") + 1, fullAddr.indexOf("]"));
        const postCodeInput = document.getElementById('postCode');
        if(postCodeInput) postCodeInput.value = pc;
        
        // 2. 주소 분리 및 삽입
        const remain = fullAddr.split("] ")[1];
        if (remain) {
            const addr1Input = document.getElementById('address1');
            const addr2Input = document.getElementById('address2');

            // 공백을 기준으로 앞의 두 덩어리(시, 구)를 기본주소로, 나머지를 상세주소로 분리
            const parts = remain.split(" ");
            const addr1 = parts[0] + " " + (parts[1] || "");
            const addr2 = remain.replace(addr1, "").trim();
            
            if(addr1Input) addr1Input.value = addr1;
            if(addr2Input) addr2Input.value = addr2;
        }
    }

    // === [기능 2] 경력 선택 및 셀렉트박스 제어 ===
    const minSelect = document.getElementById('minExp');
    const maxSelect = document.getElementById('maxExp');
    const noneCheck = document.getElementById('expNone');
    const expChecks = document.querySelectorAll('.expCheck');

    if (minSelect && maxSelect) {
        minSelect.addEventListener('change', function() {
            const minVal = parseInt(this.value);
            if (minVal === 0 || minVal === 1) maxSelect.value = "3년";
            else if (minVal === 3) maxSelect.value = "5년";
            else if (minVal === 5) maxSelect.value = "8년";
            else if (minVal === 10) maxSelect.value = "제한 없음";
        });
    }

    expChecks.forEach(check => {
        check.addEventListener('click', function() {
            expChecks.forEach(cb => cb.checked = false);
            this.checked = true;
            if(this.value === 'new') {
                minSelect.disabled = true;
                maxSelect.disabled = true;
            } else if(!noneCheck.checked) {
                minSelect.disabled = false;
                maxSelect.disabled = false;
            }
        });
    });

    if(noneCheck) {
        noneCheck.addEventListener('change', function() {
            minSelect.disabled = this.checked;
            maxSelect.disabled = this.checked;
        });
    }

 // === [기능 3] 접수기간 날짜 설정 (개선본) ===
    const startDateInput = document.getElementById('startDate');
    const endDateInput = document.getElementById('endDate');
    const today = new Date().toISOString().split('T')[0];

    if (startDateInput && endDateInput) {
        // 1. 시작일과 마감일 모두 오늘 이전 날짜는 선택 불가능하게 설정
        startDateInput.min = today;
        endDateInput.min = today;

        startDateInput.addEventListener('change', function() {
            if (this.value) {
                // 2. 시작일이 정해지면 마감일은 최소 시작일과 같거나 커야 함
                endDateInput.min = this.value;
                
                // 3. 만약 마감일이 이미 입력되어 있는데 시작일보다 빠르다면? 마감일을 시작일로 초기화
                if (endDateInput.value && endDateInput.value < this.value) {
                    endDateInput.value = this.value;
                }
            }
        });
    }

    // === [기능 4] 담당자 전화번호 하이픈 자동생성 ===
    const phoneInput = document.querySelector('input[name="mgrPhone"]');
    if (phoneInput) {
        phoneInput.addEventListener('input', function(e) {
            let val = e.target.value.replace(/[^0-9]/g, '');
            if (val.length > 3 && val.length <= 7) {
                val = val.substring(0, 3) + '-' + val.substring(3);
            } else if (val.length > 7) {
                val = val.substring(0, 3) + '-' + val.substring(3, 7) + '-' + val.substring(7, 11);
            }
            e.target.value = val;
        });
    }

    // === [기능 5] 폼 제출 시 데이터 최종 검증 및 주소 결합 ===
    const form = document.querySelector('form');
    if (form) {
        form.addEventListener('submit', function(e) {
            // 주소 관련 데이터 추출
            const pc = document.getElementById('postCode').value;
            const addr1 = document.getElementById('address1').value;
            const addr2 = document.getElementById('address2').value;

            // 1. 필수 선택 확인 (모집분야)
            if (!jobInput.value) {
                alert("모집분야를 선택해주세요.");
                e.preventDefault();
                return false;
            }

            // 2. 주소 결합 로직
            if (!pc || !addr1) {
                alert("근무지 주소를 검색하여 입력해주세요.");
                e.preventDefault();
                return false;
            }
            // hidden 필드(name="address")에 최종 결합된 문자열 삽입
            document.getElementById('address').value = "[" + pc + "] " + addr1 + " " + addr2;

            // 3. 전화번호 형식 검증
            const phoneRegex = /^01[0-9]-\d{3,4}-\d{4}$/;
            if (!phoneRegex.test(phoneInput.value)) {
                alert("전화번호 형식을 다시 확인해주세요.");
                e.preventDefault();
                return false;
            }
            
            // 모든 검사 통과 시 전송
        });
    }
});

// === [기능 6] 카카오 주소 API 실행 함수 ===
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            let addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
            document.getElementById('postCode').value = data.zonecode;
            document.getElementById("address1").value = addr;
            document.getElementById("address2").focus();
        }
    }).open();
}
</script>
