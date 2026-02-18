<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
    <title>회원가입</title>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <style>
        /* [레이아웃 초기화] */
        html, body { margin: 0; padding: 0; height: 100%; }
        
        body { 
            font-family: 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif; 
            background-color: #f4f7f6; 
            display: flex; 
            flex-direction: column; /* 세로 방향 배치 */
        }

        /* [메인 영역 스타일] */
        main {
            flex: 1; /* 남은 공간을 모두 차지하여 푸터를 밀어냄 */
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        .container { 
            background: white; 
            padding: 40px; 
            border-radius: 8px; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.1); 
            width: 100%; 
            max-width: 600px; 
        }

        h2 { text-align: center; color: #333; margin-bottom: 30px; margin-top: 0; }
        
        /* [푸터 스타일] */
        footer {
            background-color: #333;
            color: #ccc;
            padding: 30px 20px;
            text-align: center;
            font-size: 0.85em;
        }
        footer a { color: #fff; text-decoration: none; margin: 0 5px; }

        /* [기존 폼 스타일 유지] */
        .section-title { font-weight: bold; border-bottom: 2px solid #4CAF50; margin: 25px 0 15px; padding-bottom: 5px; font-size: 1.1em; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; font-size: 0.9em; color: #555; }
        
        input[type="text"], input[type="email"], input[type="password"], input[type="tel"], input[type="date"], select {
            width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; font-size: 14px;
            background-color: #fff;
        }
        input:focus, select:focus { border-color: #4CAF50; outline: none; }

        .input-with-btn { display: flex; gap: 10px; }
        .input-with-btn input { flex-grow: 1; }
        .btn-verify { 
            white-space: nowrap; padding: 0 15px; background-color: #666; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 13px;
        }
        .btn-verify:hover { background-color: #555; }
        .btn-verify.verified { background-color: #4CAF50; cursor: default; }

        .address-inputs input { margin-top: 8px; }

        .verify-area { 
            background-color: #f9f9f9; padding: 10px; margin-top: 10px; border-radius: 4px; border: 1px solid #eee; display: none; 
        }
        .verify-area.active { display: block; }
        .verify-msg { font-size: 12px; margin-top: 5px; }
        .msg-success { color: #4CAF50; }
        .msg-error { color: #e74c3c; }

        .user-type-selection { display: flex; gap: 20px; margin-bottom: 20px; justify-content: center; background: #eee; padding: 15px; border-radius: 5px; }
        .hidden { display: none; }
        .terms-box { background: #f9f9f9; padding: 15px; border: 1px solid #eee; font-size: 0.85em; }
        .btn-submit { width: 100%; padding: 15px; background-color: #4CAF50; color: white; border: none; border-radius: 4px; font-size: 16px; font-weight: bold; cursor: pointer; margin-top: 30px; }
    </style>
</head>
<body>

    <%@ include file="/WEB-INF/views/inc/header.jspf" %>

    <main>
        <div class="container">
            <h2>회원가입</h2>

            <div class="user-type-selection">
                <label><input type="radio" name="user_type" value="P" checked onclick="toggleForm('P')"> 개인회원</label>
                <label><input type="radio" name="user_type" value="C" onclick="toggleForm('C')"> 기업회원</label>
            </div>

            <form action="/signup" method="POST" onsubmit="return validateForm(event)">
                
                <div class="section-title">기본 정보</div>
                <div class="form-group">
                    <label>이메일(아이디) *</label>
                    <div class="input-with-btn">
                        <input type="email" id="email" name="email" maxlength="255" required placeholder="example@email.com">
                        <button type="button" class="btn-verify" id="btn-email-send" onclick="sendVerification('email')">인증번호 전송</button>
                    </div>
                    <div id="email-verify-area" class="verify-area">
                        <div class="input-with-btn">
                            <input type="text" id="email-code" placeholder="인증번호 4자리 (테스트: 1234)">
                            <button type="button" class="btn-verify" onclick="checkVerification('email')">확인</button>
                        </div>
                        <div id="email-msg" class="verify-msg"></div>
                    </div>
                </div>

                <div class="form-group">
                    <label>비밀번호 *</label>
                    <input type="password" name="password" maxlength="255" required>
                </div>
                <div class="form-group">
                    <label>이름 *</label>
                    <input type="text" name="user_name" maxlength="60" required>
                </div>

                <div class="form-group">
                    <label>전화번호 *</label>
                    <div class="input-with-btn">
                        <input type="tel" id="phone" name="phone" maxlength="20" required placeholder="010-0000-0000">
                        <button type="button" class="btn-verify" id="btn-phone-send" onclick="sendVerification('phone')">인증번호 전송</button>
                    </div>
                    <div id="phone-verify-area" class="verify-area">
                        <div class="input-with-btn">
                            <input type="text" id="phone-code" placeholder="인증번호 4자리 (테스트: 1234)">
                            <button type="button" class="btn-verify" onclick="checkVerification('phone')">확인</button>
                        </div>
                        <div id="phone-msg" class="verify-msg"></div>
                    </div>
                </div>

                <div id="person_fields">
                    <div class="section-title">개인 상세정보</div>
                    <div class="form-group">
                        <label>생년월일</label>
                        <input type="date" name="birth_date">
                    </div>
                    <div class="form-group">
                        <label>성별</label>
                        <select name="gender">
                            <option value="N">선택안함</option>
                            <option value="M">남성</option>
                            <option value="F">여성</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>국가</label>
                        <select name="country">
                            <option value="KR" selected>대한민국 (South Korea)</option>
                            <option value="US">미국 (United States)</option>
                            <option value="JP">일본 (Japan)</option>
                            <option value="CN">중국 (China)</option>
                            <option value="VN">베트남 (Vietnam)</option>
                            <option value="PH">필리핀 (Philippines)</option>
                            <option value="TH">태국 (Thailand)</option>
                            <option value="ID">인도네시아 (Indonesia)</option>
                            <option value="CA">캐나다 (Canada)</option>
                            <option value="AU">호주 (Australia)</option>
                            <option value="GB">영국 (United Kingdom)</option>
                            <option value="DE">독일 (Germany)</option>
                            <option value="FR">프랑스 (France)</option>
                            <option value="ETC">기타 (Others)</option>
                        </select>
                    </div>
                </div>

                <div id="company_fields" class="hidden">
                    <div class="section-title">기업 상세정보</div>
                    <div class="form-group">
                        <label>사업자등록번호 *</label>
                        <input type="text" name="biz_reg_no" maxlength="20">
                    </div>
                    <div class="form-group">
                        <label>회사명 *</label>
                        <input type="text" name="company_name" maxlength="200">
                    </div>
                    <div class="form-group">
                        <label>대표자명 *</label>
                        <input type="text" name="ceo_name" maxlength="60">
                    </div>
                    
                    <div class="form-group address-inputs">
                        <label>회사 주소 *</label>
                        <div class="input-with-btn">
                            <input type="text" id="postcode" placeholder="우편번호" readonly>
                            <button type="button" class="btn-verify" onclick="execDaumPostcode()">주소 찾기</button>
                        </div>
                        <input type="text" id="address" placeholder="주소" readonly>
                        <input type="text" id="detailAddress" placeholder="상세주소">
                        <input type="text" id="extraAddress" placeholder="참고항목" readonly>
                        <input type="hidden" name="company_address" id="real_company_address">
                    </div>
                </div>

                <div class="section-title">이용약관 동의</div>
                <div class="terms-box">
                    <div class="form-group">
                        <label><input type="checkbox" name="terms_service" value="Y" required> [필수] 서비스 이용약관 동의</label>
                    </div>
                    <div class="form-group">
                        <label><input type="checkbox" name="terms_privacy" value="Y" required> [필수] 개인정보 수집 및 이용 동의</label>
                    </div>
                    <div class="form-group">
                	<label><input type="checkbox" name="terms_marketing" value="Y"> [선택] 마케팅 정보 수신 동의</label>
            		</div>
                </div>

                <button type="submit" class="btn-submit">회원가입 완료</button>
            </form>
        </div>
    </main>

    <footer>
        <p>&copy; 2024 My Service Inc. All rights reserved.</p>
        <p>
            <a href="#">이용약관</a> | 
            <a href="#">개인정보처리방침</a> | 
            <a href="#">사업자정보확인</a>
        </p>
    </footer>

    <script>
        // 주소 API
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
                    var extraAddr = '';

                    if(data.userSelectedType === 'R'){
                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)) extraAddr += data.bname;
                        if(data.buildingName !== '' && data.apartment === 'Y') extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        if(extraAddr !== '') extraAddr = ' (' + extraAddr + ')';
                        document.getElementById("extraAddress").value = extraAddr;
                    } else {
                        document.getElementById("extraAddress").value = '';
                    }

                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById("address").value = addr;
                    document.getElementById("detailAddress").focus();
                }
            }).open();
        }

        // 인증 및 폼 검증
        const verificationStatus = { email: false, phone: false };
        let currentUserType = 'P';

        function toggleForm(type) {
            currentUserType = type;
            const personFields = document.getElementById('person_fields');
            const companyFields = document.getElementById('company_fields');
            
            if (type === 'P') {
                personFields.classList.remove('hidden');
                companyFields.classList.add('hidden');
                companyFields.querySelectorAll('input').forEach(el => {
                    if(el.type !== 'hidden') el.removeAttribute('required');
                });
            } else {
                personFields.classList.add('hidden');
                companyFields.classList.remove('hidden');
                document.querySelector('input[name="biz_reg_no"]').setAttribute('required', '');
                document.querySelector('input[name="company_name"]').setAttribute('required', '');
                document.querySelector('input[name="ceo_name"]').setAttribute('required', '');
            }
        }

        function sendVerification(type) {
            const value = document.getElementById(type).value;
            if (!value) { alert('정보를 입력해주세요.'); return; }
            document.getElementById(`${type}-verify-area`).classList.add('active');
            alert(`[전송 완료] 인증번호: 1234`);
        }

        function checkVerification(type) {
            const code = document.getElementById(`${type}-code`).value;
            if (code === '1234') {
                verificationStatus[type] = true;
                document.getElementById(`${type}-msg`).innerText = '인증 완료';
                document.getElementById(`${type}-msg`).className = 'verify-msg msg-success';
                document.getElementById(type).readOnly = true;
                document.getElementById(`${type}-code`).disabled = true;
                document.getElementById(`btn-${type}-send`).classList.add('verified');
            } else {
                document.getElementById(`${type}-msg`).innerText = '인증번호 불일치';
                document.getElementById(`${type}-msg`).className = 'verify-msg msg-error';
            }
        }

        function validateForm(event) {
            // 테스트 편의를 위해 인증 체크는 주석 처리 가능
            if (!verificationStatus.email || !verificationStatus.phone) {
            alert('이메일과 휴대폰 인증을 모두 완료해주세요.');
            return false;
            }

            if (currentUserType === 'C') {
                const postcode = document.getElementById('postcode').value;
                const address = document.getElementById('address').value;
                const detail = document.getElementById('detailAddress').value;
                const extra = document.getElementById('extraAddress').value;

                if (!postcode || !address) {
                    alert('회사 주소를 검색하여 입력해주세요.');
                    return false;
                }
                document.getElementById('real_company_address').value = `(${postcode}) ${address} ${detail} ${extra}`;
            }
            return true;
        }
    </script>

</body>
</html>