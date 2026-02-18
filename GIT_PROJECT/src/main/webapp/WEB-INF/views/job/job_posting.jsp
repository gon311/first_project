<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<meta charset="UTF-8">
<title>채용공고 등록</title>
<style>
    body { font-family: 'Pretendard', sans-serif; background-color: #f8f9fa; padding: 20px; }
    .container { max-width: 900px; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); margin: auto; }
    .form-group { display: flex; align-items: flex-start; margin-bottom: 20px; }
    .label-box { width: 150px; font-weight: bold; padding-top: 10px; }
    .input-box { flex: 1; }
    input[type="text"], input[type="date"], textarea, select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; }
    .badge-input { display: flex; gap: 10px; align-items: center; margin-bottom: 10px; }
    .file-upload-area { background: #e9ecef; padding: 20px; border: 2px dashed #ccc; text-align: center; border-radius: 5px; margin: 10px 0; }
    .info-box { background: #f0f7ff; padding: 15px; border-radius: 5px; font-size: 0.9em; color: #0066cc; }
    .btn-submit { background: #333; color: #fff; padding: 15px 30px; border: none; border-radius: 5px; cursor: pointer; display: block; margin: 20px auto; }

    /* 직업 선택기 전용 스타일 */
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
    <form action="post_job_process.jsp" method="post" enctype="multipart/form-data">
        
        <div class="form-group">
            <div class="label-box">공고제목 <span style="color:red">*</span></div>
            <div class="input-box"><input type="text" name="title" placeholder="디자이너 채용"></div>
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
                <input type="text" name="category" id="selectedJobInput" readonly placeholder="직무를 선택하면 자동 입력됩니다." style="margin-top:10px; background:#f8f9fa;">
            </div>
        </div>

        <div class="form-group">
            <div class="label-box">주요업무 <span style="color:red">*</span></div>
            <div class="input-box">
                <textarea name="main_task" rows="5" placeholder="• 사이트 웹디자인"></textarea>
            </div>
        </div>

        <div class="form-group">
            <div class="label-box">파일 첨부</div>
            <div class="input-box">
                <div class="file-upload-area">
                    <p>이미지 첨부파일 기능(첨부하기) 추가</p>
                    <input type="file" name="attach_file" multiple>
                </div>
            </div>
        </div>

        <div class="form-group">
		    <div class="label-box">경력 <span style="color:red">*</span></div>
		    <div class="input-box">
		        <label><input type="checkbox" name="exp_type" value="new" class="exp-check"> 신입</label>
		        <label style="margin-right: 15px;"><input type="checkbox" name="exp_type" value="career" class="exp-check" checked> 경력</label>
		
		        <select name="min_exp" id="min_exp" style="width: 140px; display:inline-block;">
		            <option value="0">1년 미만</option>
		            <option value="1">1년 이상</option>
		            <option value="3">3년 이상</option>
		            <option value="5">5년 이상</option>
		            <option value="10">10년 이상</option>
		        </select>
		        <span style="margin: 0 5px;">~</span>
		        <select name="max_exp" id="max_exp" style="width: 140px; display:inline-block;">
		            <option value="3">3년 이하</option>
		            <option value="5">5년 이하</option>
		            <option value="8">8년 이하</option>
		            <option value="10">10년 이하</option>
		            <option value="99">제한 없음</option>
		        </select>
		        <label style="margin-left: 15px;">
		            <input type="checkbox" name="exp_none" id="exp_none"> 경력무관
		        </label>
		    </div>
		</div>

        <div class="form-group">
            <div class="label-box">학력 <span style="color:red">*</span></div>
            <div class="input-box">
                <select name="education">
                    <option>학력무관</option>
                    <option>고등학교 졸업</option>
                    <option>대학교(2,3년) 졸업</option>
                    <option>대학교(4년) 졸업</option>
                </select>
                <input type="checkbox"> 졸업 예정자 가능
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
		            <input type="text" name="zipcode" id="zipcode" placeholder="우편번호" style="width: 120px;" readonly>
		            <button type="button" onclick="execDaumPostcode()" style="padding: 10px; cursor: pointer; background: #333; color: #fff; border: none; border-radius: 5px;">주소 검색</button>
		        </div>
		        <input type="text" name="address" id="address" placeholder="기본 주소" style="margin-bottom: 10px;" readonly>
		        <input type="text" name="address_detail" id="address_detail" placeholder="상세 주소 (예: 101동 202호)">
		        
		        <label style="margin-top: 10px; display: block;">
		            <input type="checkbox" name="remote_work"> 재택근무 가능 
		        </label>
		    </div>
		</div>

        <div class="form-group">
		    <div class="label-box">접수기간 <span style="color:red">*</span></div>
		    <div class="input-box">
		        <input type="date" name="start_date" id="start_date" style="width: 200px; display:inline-block;"> ~ 
		        <input type="date" name="end_date" id="end_date" style="width: 200px; display:inline-block;">
		    </div>
		</div>

        <button type="submit" class="btn-submit">공고 등록하기</button>
    </form>
</div>

<script>
// 직업 데이터
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
    const mainUl = document.getElementById('mainCatList');
    const subUl = document.getElementById('subCatList');
    const jobInput = document.getElementById('selectedJobInput');

    // 대분류 렌더링
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
    
    

    // 기존 경력 관련 스크립트 로직 복구
    const minSelect = document.getElementById('min_exp');
    const maxSelect = document.getElementById('max_exp');
    const noneCheck = document.getElementById('exp_none');
    const expChecks = document.querySelectorAll('.exp-check');
	
 // 최소 경력 선택 시 최대 경력 자동 설정 로직 추가
    minSelect.addEventListener('change', function() {
	    const minVal = parseInt(this.value);
	    
	    if (minVal === 0) {
	        maxSelect.value = "3";  // 1년 미만 -> 3년 이하
	    } else if (minVal === 1) {
	        maxSelect.value = "3";  // 1년 이상 -> 5년 이하
	    } else if (minVal === 3) {
	        maxSelect.value = "5";  // 3년 이상 -> 8년 이하
	    } else if (minVal === 5) {
	        maxSelect.value = "8"; // 5년 이상 -> 10년 이하
	    } else if (minVal === 10) {
	        maxSelect.value = "99"; // 10년 이상 -> 제한 없음
	    }
	});
    
    expChecks.forEach(check => {
        check.addEventListener('click', function() {
            expChecks.forEach(cb => cb.checked = false);
            this.checked = true;
            if(this.value === 'new') {
                minSelect.disabled = true;
                maxSelect.disabled = true;
            } else {
                if(!noneCheck.checked) {
                    minSelect.disabled = false;
                    maxSelect.disabled = false;
                }
            }
        });
    });

    if(noneCheck) {
        noneCheck.addEventListener('change', function() {
            minSelect.disabled = this.checked;
            maxSelect.disabled = this.checked;
        });
    }
});

function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            let addr = ''; // 주소 변수
            let extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("address_detail").focus();
        }
    }).open();
}

document.addEventListener("DOMContentLoaded", function() {
    const startDateInput = document.getElementById('start_date');
    const endDateInput = document.getElementById('end_date');

    // 오늘 날짜 가져오기 (YYYY-MM-DD 형식)
    const now = new Date();
    const today = now.toISOString().split('T')[0];

    // 1. 시작일 제한: 오늘 이후(미래)는 선택 불가 -> max를 오늘로 설정
    startDateInput.max = today;

    // 2. 마감일 제한: 오늘 이전(과거)은 선택 불가 -> min을 오늘로 설정
    endDateInput.min = today;

    // 3. 추가 로직: 시작일을 선택하면 마감일의 최소값이 시작일보다 뒤여야 함
    startDateInput.addEventListener('change', function() {
        if (this.value) {
            endDateInput.min = this.value;
        }
    });

    // 4. 추가 로직: 마감일을 선택하면 시작일의 최대값이 마감일보다 앞이어야 함
    endDateInput.addEventListener('change', function() {
        if (this.value) {
            // 마감일이 오늘보다 미래더라도 시작일은 '오늘'이 최대치여야 하므로 비교 로직 추가
            const selectedEndDate = this.value;
            startDateInput.max = selectedEndDate < today ? selectedEndDate : today;
        }
    });
});

</script>
</body>
</html>