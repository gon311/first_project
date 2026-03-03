<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <style>
        :root { --primary-color: #0046ff; --bg-color: #f4f7f6; }
        html, body { margin: 0; padding: 0; background-color: var(--bg-color); font-family: 'Apple SD Gothic Neo', sans-serif; }
        
        main { display: flex; justify-content: center; padding: 60px 20px; }
        .container { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); width: 100%; max-width: 550px; }
        
        h2 { text-align: center; font-size: 28px; margin-bottom: 30px; }

        /* [탭 스타일] */
        .signup-tabs { display: flex; margin-bottom: 30px; border: 1px solid #ddd; border-radius: 8px; overflow: hidden; }
        .tab { flex: 1; padding: 15px; text-align: center; cursor: pointer; background: #f9f9f9; color: #888; font-weight: bold; transition: 0.3s; }
        .tab.active { background: var(--primary-color); color: white; }

        /* [폼 스타일] */
        .section-title { font-size: 18px; font-weight: bold; margin: 35px 0 15px; padding-bottom: 8px; border-bottom: 2px solid #333; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; font-size: 14px; color: #444; }
        
        input[type="text"], input[type="email"], input[type="password"], input[type="tel"], input[type="date"], select {
            width: 100%; padding: 14px; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; font-size: 15px;
        }
        input:focus { border-color: var(--primary-color); outline: none; box-shadow: 0 0 0 3px rgba(0,70,255,0.1); }

        .input-with-btn { display: flex; gap: 8px; }
        .btn-action { white-space: nowrap; padding: 0 20px; background: white; border: 1px solid var(--primary-color); color: var(--primary-color); border-radius: 6px; cursor: pointer; font-weight: bold; }
        .btn-action:hover { background: #f0f4ff; }
        .btn-action.verified { background: #e7f0ff; border-color: #cbd8ff; color: #888; cursor: default; }

        /* 인증 영역 */
        .verify-area { background-color: #f8f9fa; padding: 15px; margin-top: 10px; border-radius: 6px; display: none; }
        .verify-msg { font-size: 12px; margin-top: 8px; }
        .msg-success { color: #2ecc71; }
        .msg-error { color: #e74c3c; }

        .gender-wrap { display: flex; gap: 15px; padding-top: 5px; }
        .hidden { display: none; }
        .mt-8 { margin-top: 8px; }

        /* 이용약관 */
        .terms-box { background: #f9f9f9; padding: 20px; border-radius: 6px; border: 1px solid #eee; }
        .terms-item { margin-bottom: 12px; font-size: 14px; display: flex; align-items: center; gap: 10px; }
        
        .btn-submit { width: 100%; padding: 20px; background-color: var(--primary-color); color: white; border: none; border-radius: 6px; font-size: 18px; font-weight: bold; cursor: pointer; margin-top: 40px; }
        .btn-submit:hover { background-color: #0036c7; }

        footer { text-align: center; padding: 40px; color: #888; font-size: 13px; }
        
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/inc/header.jspf" %>

    <main>
		<div class="container">
            <h2>회원가입</h2>

            <div class="signup-tabs">
                <div class="tab active" id="tab-P" onclick="switchTab('P')">개인회원</div>
                <div class="tab" id="tab-C" onclick="switchTab('C')">기업회원</div>
            </div>

            <form action="<c:url value="/user/regist" />" method="POST" id="signupForm" onsubmit="return validateForm(event)">
                <input type="hidden" name="userType" id="userType" value="P">

                <div class="section-title">기본 정보</div>
                <div class="form-group" >
                    <label>이메일(아이디) *</label>
                    <div class="input-with-btn">
                        <input type="email" id="email" name="email" required placeholder="example@email.com">
                        <button type="button" class="btn-action" id="btn-email-send" onclick="sendVerification('email')">인증번호 전송</button>
                    </div>
                    <div id="email-verify-area" class="verify-area">
                        <div class="input-with-btn">
                            <input type="text" id="email-code" placeholder="인증번호 6자리">
                            <button type="button" class="btn-action" onclick="checkVerification('email')">확인</button>
                        </div>
                        <div id="email-msg" class="verify-msg"></div>
                    </div>
                </div>

                <div class="form-group">
                    <label>비밀번호 *</label>
                    <input type="password" name="password" class="form-control"
	                   placeholder="8~30자, 영문+숫자+특수문자를 포함해야 합니다." required
	                   minlength="8" maxlength="30"
	                   pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,30}$"
	                   title="8~30자, 영문+숫자+특수문자를 포함해야 합니다." />
                </div>

                <div class="form-group">
                    <label>이름 *</label>
                    <input type="text" name="userName">
                </div>
                
                <div class="form-group">
                    <label>전화번호 *</label>
                    <div class="input-with-btn">
                    	<select name="mobileCarrier" id="mobileCarrier" style="width: 120px; flex: none;" required>
				            <option value="" disabled selected>통신사</option>
				            <option value="SKT">SKT</option>
				            <option value="KT">KT</option>
				            <option value="LG">LG U+</option>
				            <option value="SKT_A">SKT 알뜰폰</option>
				            <option value="KT_A">KT 알뜰폰</option>
				            <option value="LG_A">LG 알뜰폰</option>
				        </select>
				        
                        <input type="tel" id="phone" name="phone" pattern="01[0-9]-[0-9]{3,4}-[0-9]{4}" required placeholder="010-0000-0000">
                        <button type="button" class="btn-action" id="btn-phone-send" onclick="sendVerification('phone')">인증번호 전송</button>
                    </div>
				    
                    <div id="phone-verify-area" class="verify-area">
                        <div class="input-with-btn">
                            <input type="text" id="phone-code" placeholder="인증번호 6자리">
                            <button type="button" class="btn-action" onclick="checkVerification('phone')">확인</button>
                        </div>
                        <div id="phone-msg" class="verify-msg"></div>
                    </div>
                </div>

                <div id="person-fields">
                    <div class="section-title">개인 상세정보</div>
	                
	                
                    <div class="form-group">
                        <label>생년월일</label>
                        <input type="date" id="birth" name="birthDate">
                    </div>
                    <div class="form-group">
                        <label>성별</label>
                        <div class="gender-wrap">
                            <label><input type="radio" name="gender" value="M"> 남성</label>
                            <label><input type="radio" name="gender" value="F"> 여성</label>
                            <label><input type="radio" name="gender" value="N" checked> 선택안함</label>
                        </div>
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

                <div id="company-fields" class="hidden">
                    <div class="section-title">기업 정보</div>
                    <div class="form-group">
                        <label>사업자등록번호 *</label>
                        <div class="form-group">
					    	<input type="text" name="bizRegNo" id="bizRegNo" 
						           placeholder="000-00-00000" 
						           maxlength="12"
						           pattern="\d{3}-\d{2}-\d{5}"
						           title="사업자등록번호 10자리를 입력해주세요.">
						</div>
                    </div>
                    <div class="mb-3">
					    <label for="correctContent" class="form-label">조회 결과</label>
					    <div id="correctContent" class="border border-primary p-3">
					    </div>
					</div>
                    <div class="form-group">
                        <label>회사명 *</label>
                        <input type="text" name="companyName">
                    </div>
                    <div class="form-group">
                        <label>대표자명 *</label>
                        <input type="text" name="ceoName">
                    </div>
                    <div class="form-group">
                        <label>회사 주소 *</label>
                        <div class="input-with-btn">
                            <input type="text" id="postcode" placeholder="우편번호" readonly>
                            <button type="button" class="btn-action" onclick="execDaumPostcode()">주소 찾기</button>
                        </div>
                        <input type="text" id="address" class="mt-8" placeholder="기본주소" readonly>
                        <input type="text" id="detailAddress" class="mt-8" placeholder="상세주소">
                        <input type="hidden" name="companyAddress" id="real_company_address">
                    </div>
                </div>

                <div class="section-title">이용약관 동의</div>
                <div class="terms-box">
                    <div class="terms-item">
                        <input type="checkbox" name="termsCode" value="서비스 이용약관 동의" required> [필수] 서비스 이용약관 동의
                    </div>
                    <div class="terms-item">
                        <input type="checkbox" name="termsCode" value="개인정보 수집 및 이용 동의" required> [필수] 개인정보 수집 및 이용 동의
                    </div>
                    <div class="terms-item">
                        <input type="checkbox" name="termsCode" value="마케팅 정보 수신 동의"> [선택] 마케팅 정보 수신 동의
                    </div>
                </div>

                <button type="submit" class="btn-submit">가입하기</button>
            </form>
        </div>
    </main>

    <footer>
        <p>&copy; 2026 My Service Inc. All rights reserved.</p>
    </footer>

    <script>
        let currentUserType = 'P';
        const verificationStatus = { email: false, phone: false };

        // 탭 전환 함수
        function switchTab(type) {
            currentUserType = type;
            document.getElementById('userType').value = type;
            
            // 탭 UI 변경
            document.getElementById('tab-P').classList.toggle('active', type === 'P');
            document.getElementById('tab-C').classList.toggle('active', type === 'C');

            // 섹션 표시/숨김
            const personFields = document.getElementById('person-fields');
            const companyFields = document.getElementById('company-fields');

            if (type === 'P') {
                personFields.classList.remove('hidden');
                companyFields.classList.add('hidden');
                
                toggleFields(personFields, false);
                toggleFields(companyFields, true);
                
                // 필수 속성 제어
                companyFields.querySelectorAll('input').forEach(el => el.required = false);
                
            } else {
                personFields.classList.add('hidden');
                companyFields.classList.remove('hidden');
                
                toggleFields(personFields, true);
                toggleFields(companyFields, false);
                
                // 필수 속성 제어
                document.getElementsByName('bizRegNo')[0].required = true;
                document.getElementsByName('companyName')[0].required = true;
                document.getElementsByName('ceoName')[0].required = true;
            }
        }
        
        function toggleFields(container, isDisable) {
            const inputs = container.querySelectorAll('input, select');
            inputs.forEach(el => {
                el.disabled = isDisable;
            });
        }

        // 인증번호 발송 (JSP EL 충돌 방지 위해 문자열 결합 사용)
        function sendVerification(type) {
            const val = document.getElementById(type).value;
            if(!val) { alert("정보를 입력해주세요."); return; }
            
            const requestContent = {
                    type: type,   // 'email' 또는 'phone'
                    value: val    // 실제 이메일 주소나 전화번호
            };
            
			async function mailRequestCorrectContent() {
				try {
					const response = await fetch("<c:url value="/api/sendCode" />", { // 요청 주소
						method: "POST",						// 요청 메서드
						headers: {							// 요청 헤더 정보들
							"Content-type": "application/json"	// 전송 데이터 형식 : JSON 데이터
						},
						body: JSON.stringify(requestContent)
					});
					
					if(!response.ok) {
						throw new Error("오류 발생!");
					}
					const result = await response.json();
					
					alert("인증번호가 발송되었습니다.");
					console.log("type : " + result);
		            document.getElementById(type + "-verify-area").style.display = 'block';
					
		            if(type == "phone") {
					document.getElementById("phone-code").value = result.authCode;
		            }
		            
				} catch(error) {
					alert("요청 오류 발생 : " + error);
				}
			}
			
			mailRequestCorrectContent();
        }

        // 인증번호 확인
		function checkVerification(type) {
		    const code = document.getElementById(type + "-code").value;
		    const msgEl = document.getElementById(type + "-msg");
		
		    // 세션 값을 직접 비교하지 않고 서버에 요청을 보냅니다.
		    fetch("<c:url value='/api/verifyCode' />", {
		        method: "POST",
		        headers: { "Content-type": "application/json" },
		        body: JSON.stringify({ code: code })
		    })
		    .then(response => response.json())
		    .then(result => {
		        if(result.success) { // 서버 세션 값과 일치할 때
		            verificationStatus[type] = true;
		            msgEl.innerText = "인증되었습니다.";
		            msgEl.className = "verify-msg msg-success";
		            document.getElementById(type).readOnly = true;
		            document.getElementById("btn-" + type + "-send").classList.add("verified");
		        } else {
		            verificationStatus[type] = false;
		            msgEl.innerText = "인증번호가 일치하지 않습니다.";
		            msgEl.className = "verify-msg msg-error";
		        }
		    })
		    .catch(error => {
		        alert("인증 확인 중 오류가 발생했습니다.");
		    });
		}

        // 주소 API
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    let addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById("address").value = addr;
                    document.getElementById("detailAddress").focus();
                }
            }).open();
        }

        // 폼 제출 전 최종 검증
        function validateForm(e) {
        	if(!document.getElementById('mobileCarrier').value) {
                alert("통신사를 선택해주세요.");
                return false;
            }
        	
            if(!verificationStatus.email || !verificationStatus.phone) {
                alert("이메일과 휴대폰 인증을 완료해주세요.");
                return false;
            }

            if(currentUserType === 'C') {
                const pc = document.getElementById('postcode').value;
                const addr = document.getElementById('address').value;
                const det = document.getElementById('detailAddress').value;
                
                if(!pc || !addr) {
                    alert("회사 주소를 입력해주세요.");
                    return false;
                }
                // DTO의 companyAddress 필드에 합쳐서 저장
                document.getElementById('real_company_address').value = "[" + pc + "] " + addr + " " + det;
            }
            return true;
        }
        
     // 전화번호 자동 하이픈 로직 추가
        const phoneInput = document.querySelector('input[name="phone"]');
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
        
     // 사업자등록번호 자동 하이픈 로직 추가
        const bizInput = document.querySelector('input[name="bizRegNo"]');
        if (bizInput) {
            bizInput.addEventListener('input', function(e) {
                let val = e.target.value.replace(/[^0-9]/g, ''); 
                if (val.length > 3 && val.length <= 5) {
                    val = val.substring(0, 3) + '-' + val.substring(3);
                } else if (val.length > 5) {
                    val = val.substring(0, 3) + '-' + val.substring(3, 5) + '-' + val.substring(5, 10);
                }
                e.target.value = val;
            });
        }
        
        // 생년월일
        const startDateInput = document.getElementById('birth');
        const today = new Date().toISOString().split('T')[0];
        startDateInput.max = today;
        
        //페이지로드시 셀렉트되는 타입
	    window.onload = function() {
	        // 1. EL식으로 가져오는 값 (서버에서 바로 보낼 때)
	        const serverType = "${id}"; 
	        
	        // 2. URL에서 직접 가져오는 값 (redirect로 ?type=C가 붙어올 때)
	        const urlParams = new URLSearchParams(window.location.search);
	        const urlType = urlParams.get('id');

	        const finalType = serverType || urlType;

	        if (finalType === 'co') {
	            switchTab('C');
	        } else {
	            switchTab('P'); // 기본값 P
	        }
	    };
	    
	    // 사업자번호 입력시 이벤트
	    document.getElementById("bizRegNo").addEventListener("blur", function() {
	        let content = document.getElementById("bizRegNo").value.replace(/-/g, ""); // 하이픈 제거
			let requestContent = {
	        	b_no: content,
			}
	        
			async function bizRequestCorrectContent() {
				try {
					const response = await fetch("<c:url value="/api/correctionContent" />", { // 요청 주소
						method: "POST",						// 요청 메서드
						headers: {							// 요청 헤더 정보들
							"Content-type": "application/json"	// 전송 데이터 형식 : JSON 데이터
						},
						body: JSON.stringify(requestContent)
					});
					
					if(!response.ok) {
						throw new Error("오류 발생!");
					}
					
					const result = await response.json();
	 				document.getElementById("correctContent").innerHTML = result.b_stt;
	 				
				} catch(error) {
					alert("요청 오류 발생 : " + error);
				}
			}
			
			bizRequestCorrectContent();
	    });
	    
    </script>
</body>
</html>