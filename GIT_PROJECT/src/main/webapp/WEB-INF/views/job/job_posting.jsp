<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>
<link href="<c:url value="/resources/css/jobPosting.css" />" rel="stylesheet" type="text/css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<div class="container">
    <form action="<c:url value="/job/JobProcess" />" method="post" enctype="multipart/form-data">
        
        <div class="form-group">
        	<input type="hidden" name="compId" value="${userIdx}">
            <div class="label-box">공고제목 <span style="color:red">*</span></div>
            <div class="input-box"><input type="text" name="title" placeholder="디자이너 채용" required></div>
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
                <input type="text" name="field" id="selectedJobInput" readonly placeholder="직무를 선택하면 자동 입력됩니다." style="margin-top:10px; background:#f8f9fa;" required>
            </div>
        </div>

        <div class="form-group">
            <div class="label-box">주요업무 <span style="color:red">*</span></div>
            <div class="input-box">
                <textarea name="task" rows="5" placeholder="• 사이트 웹디자인" required></textarea>
            </div>
        </div>

        <div class="form-group">
            <div class="label-box">파일 첨부</div>
            <div class="input-box">
                <div class="file-upload-area">
                    <p>이미지 첨부파일 기능 추가</p>
                    <input type="file" name="files" multiple>
                </div>
            </div>
        </div>
        
        <div class="form-group">
		    <div class="label-box">고용 형태 <span style="color:red">*</span></div>
		    <div class="input-box">
		        <select name="empType" required style="width: 200px; display:inline-block;">
		            <option value="정규직" selected>정규직</option>
		            <option value="계약직">계약직</option>
		            <option value="인턴">인턴</option>
		        </select>
		        <label style="margin-left: 15px;">
		            <input type="checkbox" name="probation" value="Y"> 수습기간 있음
		        </label>
		    </div>
		</div>

        <div class="form-group">
		    <div class="label-box">경력 <span style="color:red">*</span></div>
		    <div class="input-box">
		        <label><input type="checkbox" name="expType" value="new" class="expCheck"> 신입</label>
		        <label><input type="checkbox" name="expType" value="newCareer" class="expCheck"> 신입·경력</label>
		        <label style="margin-right: 15px;"><input type="checkbox" name="expType" value="career" class="expCheck" checked> 경력</label>
		
		        <select name="minExp" id="minExp" style="width: 140px; display:inline-block;">
		            <option value="0" selected>1년 미만</option>
		            <option value="1">1년 이상</option>
		            <option value="3">3년 이상</option>
		            <option value="5">5년 이상</option>
		            <option value="10">10년 이상</option>
		        </select>
		        <span style="margin: 0 5px;">~</span>
		        <select name="maxExp" id="maxExp" style="width: 140px; display:inline-block;">
		            <option value="3년" selected>3년 이하</option>
		            <option value="5년">5년 이하</option>
		            <option value="8년">8년 이하</option>
		            <option value="10년">10년 이하</option>
		            <option value="제한 없음">제한 없음</option>
		        </select>
		        <label style="margin-left: 15px;">
		            <input type="checkbox" name="expNone" id="expNone"> 경력무관
		        </label>
		    </div>
		</div>

        <div class="form-group">
            <div class="label-box">학력 <span style="color:red">*</span></div>
            <div class="input-box">
                <select name="edu">
                    <option selected>학력무관</option>
                    <option>고등학교 졸업</option>
                    <option>대학교(2,3년) 졸업</option>
                    <option>대학교(4년) 졸업</option>
                </select>
                <input type="checkbox" name="eduPending"> 졸업 예정자 가능
            </div>
        </div>

        <div class="form-group">
            <div class="label-box">급여 <span style="color:red">*</span></div>
            <div class="input-box">
                <select name="salary">
                    <option selected>면접 후 결정</option>
                    <option>회사내규에 따름</option>
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
		            <input type="checkbox" name="isRemote" value="Y"> 재택근무 가능 
		        </label>
		    </div>
		</div>
		
		<div class="form-group">
		    <div class="label-box">담당자 정보 <span style="color:red">*</span></div>
		    <div class="input-box">
		        <div style="display: flex; gap: 10px; margin-bottom: 10px;">
		            <input type="text" name="mgrName" placeholder="담당자 이름" required>
		            <input type="text" name="mgrPhone" placeholder="연락처" pattern="01[0-9]-[0-9]{3,4}-[0-9]{4}" required>
		        </div>
		        <input type="email" name="mgrEmail" placeholder="이메일 주소" required>
		        <label style="margin-top: 10px; display: block; font-size: 0.9em; color: #666;">
		            <input type="checkbox" name="isPublic" value="Y" checked> 담당자 정보 공개
		        </label>
		    </div>
		</div>

        <div class="form-group">
		    <div class="label-box">접수기간 <span style="color:red">*</span></div>
		    <div class="input-box">
		        <input type="date" name="openDate" id="startDate" required style="width: 200px; display:inline-block;"> ~ 
		        <input type="date" name="closeDate" id="endDate" required style="width: 200px; display:inline-block;">
		    </div>
		</div>

        <div class="button-group">
		    <button type="submit" class="btn-submit">공고 등록하기</button>
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
    // === [기능 1] 모집분야 카테고리 선택 ===
    const mainUl = document.getElementById('mainCatList');
    const subUl = document.getElementById('subCatList');
    const jobInput = document.getElementById('selectedJobInput');

    if (mainUl && subUl) {
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
