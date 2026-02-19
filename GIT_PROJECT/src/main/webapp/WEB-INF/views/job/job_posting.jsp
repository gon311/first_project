<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/inc/head.jspf" %>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<meta charset="UTF-8">
<title>채용공고 등록</title>
<style>
    /* (기존 스타일 유지) */
    body { font-family: 'Pretendard', sans-serif; background-color: #f8f9fa; padding: 20px; }
    .container { max-width: 900px; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); margin: auto; }
    .form-group { display: flex; align-items: flex-start; margin-bottom: 20px; }
    .label-box { width: 150px; font-weight: bold; padding-top: 10px; }
    .input-box { flex: 1; }
    input[type="text"], input[type="date"], textarea, select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; }
    .file-upload-area { background: #e9ecef; padding: 20px; border: 2px dashed #ccc; text-align: center; border-radius: 5px; margin: 10px 0; }
    .info-box { background: #f0f7ff; padding: 15px; border-radius: 5px; font-size: 0.9em; color: #0066cc; }
    .btn-submit { background: #333; color: #fff; padding: 15px 30px; border: none; border-radius: 5px; cursor: pointer; display: block; margin: 20px auto; }
    .job-selector-wrapper { display: flex; border: 1px solid #ddd; border-radius: 5px; height: 250px; margin-top: 10px; overflow: hidden; }
    .main-cat-list { width: 30%; background: #f1f3f5; border-right: 1px solid #ddd; overflow-y: auto; list-style: none; padding: 0; margin: 0; }
    .sub-cat-list { width: 70%; background: #fff; overflow-y: auto; list-style: none; padding: 10px; margin: 0; display: flex; flex-wrap: wrap; align-content: flex-start; gap: 8px; }
    .main-cat-list li { padding: 12px 15px; cursor: pointer; border-bottom: 1px solid #e9ecef; font-size: 0.95em; }
    .main-cat-list li:hover, .main-cat-list li.active { background: #333; color: #fff; }
    .sub-job-item { padding: 6px 12px; border: 1px solid #dee2e6; border-radius: 20px; cursor: pointer; font-size: 0.85em; background: #fff; transition: 0.2s; }
    .sub-job-item:hover, .sub-job-item.selected { background: #007bff; color: #fff; border-color: #007bff; }
</style>
</head>
<body>

<div class="container">
    <form action="<c:url value="/job/JobProcess" />" method="post" enctype="multipart/form-data">
        
        <div class="form-group">
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
                    <input type="file" name="attachFile" multiple>
                </div>
            </div>
        </div>
        
        <div class="form-group">
		    <div class="label-box">고용 형태 <span style="color:red">*</span></div>
		    <div class="input-box">
		        <select name="empType" required style="width: 200px; display:inline-block;">
		            <option value="정규직">정규직</option>
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
		        <label style="margin-right: 15px;"><input type="checkbox" name="expType" value="career" class="expCheck" checked> 경력</label>
		
		        <select name="minExp" id="minExp" style="width: 140px; display:inline-block;">
		            <option value="0">1년 미만</option>
		            <option value="1">1년 이상</option>
		            <option value="3">3년 이상</option>
		            <option value="5">5년 이상</option>
		            <option value="10">10년 이상</option>
		        </select>
		        <span style="margin: 0 5px;">~</span>
		        <select name="maxExp" id="maxExp" style="width: 140px; display:inline-block;">
		            <option value="3">3년 이하</option>
		            <option value="5">5년 이하</option>
		            <option value="8">8년 이하</option>
		            <option value="10">10년 이하</option>
		            <option value="99">제한 없음</option>
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
                    <option>학력무관</option>
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
                    <option>면접 후 결정</option>
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

        <button type="submit" class="btn-submit">공고 등록하기</button>
    </form>
</div>

<script>
const jobData = {
    "기획·전략": ["경영기획", "전략기획", "사업개발", "서비스기획", "데이터분석"],
    "마케팅·홍보": ["브랜드마케팅", "퍼포먼스마케팅", "광고AE", "SNS마케팅", "홍보(PR)"],
    "IT개발": ["백엔드", "프론트엔드", "앱개발", "게임개발", "AI·인공지능", "임베디드", "보안"],
    "디자인": ["UI·UX디자인", "웹디자인", "그래픽디자인", "영상편집", "제품디자인"],
    "교육": ["초중고교사", "대학교수", "전문강사", "학습지교사", "입시강사", "외국어강사", "교직원"],
    "영업·고객상담": ["IT영업", "기술영업", "영업관리", "고객상담(CS)", "인바운드"],
    "의료·보건": ["의사", "간호사", "물리치료사", "임상병리", "약사", "의료코디네이터"]
}; [cite: 37]

document.addEventListener("DOMContentLoaded", function() {
    // 1. 모집분야 선택 (정상 복구)
    const mainUl = document.getElementById('mainCatList'); [cite: 38]
    const subUl = document.getElementById('subCatList'); [cite: 38]
    const jobInput = document.getElementById('selectedJobInput'); [cite: 38]

    if (mainUl && subUl) {
        Object.keys(jobData).forEach(cat => {
            const li = document.createElement('li'); [cite: 39]
            li.textContent = cat; [cite: 39]
            li.onclick = function() {
                document.querySelectorAll('.main-cat-list li').forEach(el => el.classList.remove('active')); [cite: 39]
                this.classList.add('active'); [cite: 40]
                subUl.innerHTML = ''; [cite: 40]
                jobData[cat].forEach(sub => {
                    const subBtn = document.createElement('li'); [cite: 40]
                    subBtn.className = 'sub-job-item'; [cite: 41]
                    subBtn.textContent = sub; [cite: 41]
                    subBtn.onclick = function() {
                        jobInput.value = sub; [cite: 41]
                        document.querySelectorAll('.sub-job-item').forEach(el => el.classList.remove('selected')); [cite: 41]
                        this.classList.add('selected'); [cite: 42]
                    };
                    subUl.appendChild(subBtn); [cite: 42]
                });
            };
            mainUl.appendChild(li); [cite: 43]
        });
    }

    // 2. 경력 로직 (정상 복구)
    const minSelect = document.getElementById('minExp'); [cite: 43]
    const maxSelect = document.getElementById('maxExp'); [cite: 44]
    const noneCheck = document.getElementById('expNone'); [cite: 44]
    const expChecks = document.querySelectorAll('.expCheck'); [cite: 44]

    if (minSelect && maxSelect) {
        minSelect.addEventListener('change', function() {
            const minVal = parseInt(this.value); [cite: 45]
            if (minVal === 0 || minVal === 1) maxSelect.value = "3"; [cite: 45]
            else if (minVal === 3) maxSelect.value = "5"; [cite: 45]
            else if (minVal === 5) maxSelect.value = "8"; [cite: 45]
            else if (minVal === 10) maxSelect.value = "99"; [cite: 46]
        });
    }

    expChecks.forEach(check => {
        check.addEventListener('click', function() {
            expChecks.forEach(cb => cb.checked = false); [cite: 47]
            this.checked = true; [cite: 47]
            if(this.value === 'new') {
                minSelect.disabled = true; [cite: 47]
                maxSelect.disabled = true; [cite: 47]
            } else if(!noneCheck.checked) {
                minSelect.disabled = false; [cite: 48]
                maxSelect.disabled = false; [cite: 48]
            }
        });
    });

    if(noneCheck) {
        noneCheck.addEventListener('change', function() {
            minSelect.disabled = this.checked; [cite: 49]
            maxSelect.disabled = this.checked; [cite: 49]
        });
    }

    // 3. 날짜 제한 (정상 복구)
    const startDateInput = document.getElementById('startDate'); [cite: 50]
    const endDateInput = document.getElementById('endDate'); [cite: 50]
    const today = new Date().toISOString().split('T')[0]; [cite: 51]

    if (startDateInput && endDateInput) {
        startDateInput.max = today; [cite: 51]
        endDateInput.min = today; [cite: 52]
        startDateInput.addEventListener('change', function() {
            if (this.value) endDateInput.min = this.value; [cite: 52]
        });
    }

    // 4. 전화번호 하이픈 (정상 복구)
    const phoneInput = document.querySelector('input[name="mgrPhone"]'); [cite: 53]
    if (phoneInput) {
        phoneInput.addEventListener('input', function(e) {
            let val = e.target.value.replace(/[^0-9]/g, ''); [cite: 54]
            if (val.length > 3 && val.length <= 7) {
                val = val.substring(0, 3) + '-' + val.substring(3); [cite: 54]
            } else if (val.length > 7) {
                val = val.substring(0, 3) + '-' + val.substring(3, 7) + '-' + val.substring(7, 11); [cite: 55]
            }
            e.target.value = val; [cite: 55]
        });
    }

    // 5. 폼 검증 및 주소 결합 (통합 수정본)
    const form = document.querySelector('form'); [cite: 56]
    if (form) {
        form.addEventListener('submit', function(e) {
            const jobValue = jobInput.value; [cite: 57]
            const pc = document.getElementById('postCode').value; [cite: 57]
            const addr1 = document.getElementById('address1').value; [cite: 57]
            const addr2 = document.getElementById('address2').value; [cite: 58]
            const mgrPhone = document.querySelector('input[name="mgrPhone"]'); [cite: 57]
            const mgrEmail = document.querySelector('input[name="mgrEmail"]'); [cite: 57]

            const phoneRegex = /^01[0-9]-\d{3,4}-\d{4}$/; [cite: 58]
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; [cite: 58]

            if (!jobValue) {
                alert("직무를 선택해주세요."); [cite: 58]
                e.preventDefault();
                return false;
            }
            if (!pc || !addr1) {
                alert("주소를 입력해주세요."); [cite: 59]
                e.preventDefault();
                return false;
            }
            
            // 전송 직전 hidden 필드인 'address'에 결합된 주소 주입
            document.getElementById('address').value = "[" + pc + "] " + addr1 + " " + addr2; [cite: 65]

            if (!phoneRegex.test(mgrPhone.value)) {
                alert("전화번호를 확인해주세요."); [cite: 60]
                e.preventDefault();
                return false;
            }
            if (!emailRegex.test(mgrEmail.value)) {
                alert("이메일을 확인해주세요."); [cite: 61]
                e.preventDefault();
                return false;
            }
        });
    }
});

// 다음 주소 API (폼 밖으로 분리)
function execDaumPostcode() { [cite: 63]
    new daum.Postcode({
        oncomplete: function(data) {
            let addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress; [cite: 63]
            document.getElementById('postCode').value = data.zonecode; [cite: 63]
            document.getElementById("address1").value = addr; [cite: 63]
            document.getElementById("address2").focus(); [cite: 63]
        }
    }).open();
}
</script>
</body>
</html>