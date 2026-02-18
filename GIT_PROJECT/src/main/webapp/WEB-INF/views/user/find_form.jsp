<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
    <title>아이디/비밀번호 찾기 - 최종 완성</title>
    <style>
        /* [기본 스타일] */
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Malgun Gothic', 'Noto Sans KR', sans-serif; }
        body { background-color: #f5f6f7; color: #333; font-size: 14px; }
        input, select, button { outline: none; vertical-align: middle; }
        
        /* [레이아웃] */
        .container { width: 1500px; margin: 50px auto; background: #fff; padding: 40px; border: 1px solid #ddd; }
        
        /* [탭 메뉴] */
        .tab-nav { display: flex; margin-bottom: 30px; border-bottom: 2px solid #0055ff; }
        .tab-btn { flex: 1; padding: 15px 0; text-align: center; background: #f8f9fa; border: 1px solid #ddd; border-bottom: none; cursor: pointer; font-size: 16px; color: #666; font-weight: bold; }
        .tab-btn.active { background: #0055ff; color: #fff; border-color: #0055ff; }

        /* [타이틀] */
        .section-title { font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333; }
        .section-desc { font-size: 13px; color: #888; margin-bottom: 30px; }

        /* [분할 레이아웃] */
        .split-box { display: flex; gap: 20px; }
        .member-col { flex: 1; border: 1px solid #e1e1e1; display: flex; flex-direction: column; }
        .col-header { background: #f9f9f9; padding: 15px; font-weight: bold; border-bottom: 1px solid #e1e1e1; font-size: 15px; color: #444; }
        .col-body { padding: 25px 20px; flex: 1; position: relative; }

        /* [핵심: 비활성화 스타일] */
        .field-area { transition: all 0.2s; }
        .field-area.disabled { opacity: 0.4; pointer-events: none; user-select: none; filter: grayscale(100%); }
        .field-area.disabled input, .field-area.disabled select { background-color: #eee; }

        /* [폼 요소] */
        .radio-row { margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid #eee; }
        .radio-label { margin-right: 15px; cursor: pointer; display: inline-flex; align-items: center; gap: 6px; font-weight: 500; }
        
        .form-row { margin-bottom: 12px; display: flex; align-items: center; }
        .form-label { width: 100px; font-weight: bold; color: #555; font-size: 13px; flex-shrink: 0; }
        .form-input-group { flex: 1; display: flex; align-items: center; gap: 6px; position: relative; }
        
        input[type="text"] { height: 32px; padding: 0 10px; border: 1px solid #ccc; width: 100%; font-size: 13px; }
        select { height: 32px; padding: 0 5px; border: 1px solid #ccc; font-size: 13px; }
        
        /* 버튼 */
        .btn-auth { height: 32px; background: #555; color: #fff; border: none; padding: 0 10px; cursor: pointer; font-size: 12px; min-width: 80px; white-space: nowrap; }
        .btn-submit { display: block; width: 220px; margin: 40px auto 0; background: #2c3e50; color: #fff; padding: 15px; font-size: 18px; font-weight: bold; border: none; cursor: pointer; }

        /* [툴팁] */
        .tooltip-trigger { display: inline-block; width: 16px; height: 16px; background: #0055ff; color: #fff; text-align: center; font-size: 11px; margin-left: 5px; cursor: pointer; line-height: 16px; border-radius: 2px; }
        .tooltip-box { position: absolute; top: 40px; left: 80px; width: 250px; background: #fff; border: 1px solid #333; padding: 15px; z-index: 100; display: none; box-shadow: 2px 2px 5px rgba(0,0,0,0.2); }
        .tooltip-close { position: absolute; top: 5px; right: 8px; font-size: 16px; cursor: pointer; font-weight: bold; }

        /* 유틸 */
        .d-none { display: none !important; }
        .timer-text { color: #e74c3c; font-weight: bold; font-size: 12px; margin-left: 5px; min-width: 40px; }
    </style>
</head>
<body>
	
    <%@ include file="/WEB-INF/views/inc/header.jspf" %>

    <div class="container">
        <nav class="tab-nav">
            <button class="tab-btn active" onclick="switchTab('id')" id="tab-btn-id">아이디 찾기</button>
            <button class="tab-btn" onclick="switchTab('pw')" id="tab-btn-pw">비밀번호 찾기</button>
        </nav>

        <div id="view-id">
            <h2 class="section-title">회원정보 입력</h2>
            <p class="section-desc">· 가입 시 입력한 본인정보를 입력해 주세요.</p>

            <div class="split-box">
                <div class="member-col">
                    <div class="col-header">개인회원</div>
                    <div class="col-body">
                        <div class="radio-row">
                            <label class="radio-label">
                                <input type="radio" name="auth_group_id" value="email" onclick="updateFormState('id')"> 이메일 인증
                            </label>
                            <label class="radio-label">
                                <input type="radio" name="auth_group_id" value="phone" checked onclick="updateFormState('id')"> 휴대폰 인증
                            </label>
                        </div>

                        <div id="area-id-personal" class="field-area">
                            <div class="form-row">
                                <label class="form-label">이름</label>
                                <div class="form-input-group">
                                    <input type="text" id="id-name" placeholder="성명 입력">
                                </div>
                            </div>

                            <div id="row-id-email" class="form-row d-none">
                                <label class="form-label">이메일 주소</label>
                                <div class="form-input-group">
                                    <input type="text" style="width: 25%;" id="id-email-1"> @ 
                                    <input type="text" style="width: 25%;" id="id-email-2">
                                    <select style="width: 30%;" onchange="document.getElementById('id-email-2').value=this.value">
                                        <option value="">선택하세요</option>
                                        <option value="naver.com">naver.com</option>
                                        <option value="hanmail.net">hanmail.net</option>
                                        <option value="daum.net">daum.net</option>
                                        <option value="nate.com">nate.com</option>
                                        <option value="gmail.com">gmail.com</option>
                                        <option value="direct">직접입력</option>
                                    </select>
                                    <button class="btn-auth" onclick="sendAuthCode('id', 'email')">인증번호 전송</button>
                                </div>
                            </div>

                            <div id="row-id-phone" class="form-row">
                                <label class="form-label">휴대폰 번호</label>
                                <div class="form-input-group">
                                    <select style="width: 25%;" id="id-phone-1"><option>010</option></select> - 
                                    <input type="text" style="width: 25%;" id="id-phone-2" maxlength="4"> - 
                                    <input type="text" style="width: 25%;" id="id-phone-3" maxlength="4">
                                    <button class="btn-auth" onclick="sendAuthCode('id', 'phone')">인증번호 전송</button>
                                </div>
                            </div>

                            <div id="row-id-authcode" class="form-row d-none">
                                <label class="form-label">인증번호</label>
                                <div class="form-input-group">
                                    <input type="text" placeholder="인증번호 6자리" maxlength="6">
                                    <span class="timer-text" id="timer-id"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="member-col">
                    <div class="col-header">사업자회원</div>
                    <div class="col-body">
                        <div class="radio-row">
                            <label class="radio-label">
                                <input type="radio" name="auth_group_id" value="biz" onclick="updateFormState('id')"> 기업회원
                            </label>
                        </div>

                        <div id="area-id-biz" class="field-area disabled">
                            <div class="form-row">
                                <label class="form-label">
                                    가입자명 <span class="tooltip-trigger" onclick="toggleTooltip('tt-id')">?</span>
                                </label>
                                <div class="form-input-group">
                                    <input type="text" id="id-biz-name">
                                </div>
                                <div id="tt-id" class="tooltip-box">
                                    <span class="tooltip-close" onclick="toggleTooltip('tt-id')">×</span>
                                    <p>회원가입 시 등록한 기업담당자<br>이름을 입력해 주세요.</p>
                                </div>
                            </div>
                            <div class="form-row">
                                <label class="form-label">사업자등록번호</label>
                                <div class="form-input-group">
                                    <input type="text" maxlength="3"> - <input type="text" maxlength="2"> - <input type="text" maxlength="5">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <button class="btn-submit" onclick="alert('아이디 찾기 요청')">아이디 찾기</button>
        </div>

        <div id="view-pw" class="d-none">
            <h2 class="section-title">회원정보 입력</h2>
            <p class="section-desc">· 비밀번호를 찾기 위해 가입된 아이디와 정보를 입력해 주세요.</p>

            <div class="split-box">
                <div class="member-col">
                    <div class="col-header">개인회원</div>
                    <div class="col-body">
                        <div class="radio-row">
                            <label class="radio-label">
                                <input type="radio" name="auth_group_pw" value="email" checked onclick="updateFormState('pw')"> 이메일 인증
                            </label>
                            <label class="radio-label">
                                <input type="radio" name="auth_group_pw" value="phone" onclick="updateFormState('pw')"> 휴대폰 인증
                            </label>
                        </div>
                        <div id="area-pw-personal" class="field-area">
                            <div class="form-row">
                                <label class="form-label">아이디</label>
                                <div class="form-input-group"><input type="text" placeholder="아이디 입력"></div>
                            </div>
                            <div class="form-row">
                                <label class="form-label">이름</label>
                                <div class="form-input-group"><input type="text" id="pw-name" placeholder="성명 입력"></div>
                            </div>

                            <div id="row-pw-email" class="form-row">
                                <label class="form-label">이메일 주소</label>
                                <div class="form-input-group">
                                    <input type="text" style="width: 25%;" id="pw-email-1"> @ 
                                    <input type="text" style="width: 25%;" id="pw-email-2">
                                    <select style="width: 30%;" onchange="document.getElementById('pw-email-2').value=this.value">
                                        <option value="">선택하세요</option>
                                        <option value="naver.com">naver.com</option>
                                        <option value="hanmail.net">hanmail.net</option>
                                        <option value="daum.net">daum.net</option>
                                        <option value="nate.com">nate.com</option>
                                        <option value="gmail.com">gmail.com</option>
                                        <option value="direct">직접입력</option>
                                    </select>
                                    <button class="btn-auth" onclick="sendAuthCode('pw', 'email')">인증번호 전송</button>
                                </div>
                            </div>

                            <div id="row-pw-phone" class="form-row d-none">
                                <label class="form-label">휴대폰 번호</label>
                                <div class="form-input-group">
                                    <select style="width: 25%;"><option>010</option></select> - 
                                    <input type="text" style="width: 25%;" id="pw-phone-2" maxlength="4"> - 
                                    <input type="text" style="width: 25%;" id="pw-phone-3" maxlength="4">
                                    <button class="btn-auth" onclick="sendAuthCode('pw', 'phone')">인증번호 전송</button>
                                </div>
                            </div>
                            
                            <div id="row-pw-authcode" class="form-row d-none">
                                <label class="form-label">인증번호</label>
                                <div class="form-input-group">
                                    <input type="text" placeholder="인증번호 6자리">
                                    <span class="timer-text" id="timer-pw"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="member-col">
                    <div class="col-header">사업자회원</div>
                    <div class="col-body">
                        <div class="radio-row">
                            <label class="radio-label">
                                <input type="radio" name="auth_group_pw" value="biz" onclick="updateFormState('pw')"> 기업회원
                            </label>
                        </div>
                        <div id="area-pw-biz" class="field-area disabled">
                            <div class="form-row"><label class="form-label">아이디</label><div class="form-input-group"><input type="text"></div></div>
                            <div class="form-row">
                                <label class="form-label">
                                    가입자명 <span class="tooltip-trigger" onclick="toggleTooltip('tt-id2')">?</span>
                                </label>
                                <div class="form-input-group">
                                    <input type="text" id="id-biz-name2">
                                </div>
                                <div id="tt-id2" class="tooltip-box">
                                    <span class="tooltip-close" onclick="toggleTooltip('tt-id2')">×</span>
                                    <p>회원가입 시 등록한 기업담당자<br>이름을 입력해 주세요.</p>
                                </div>
                            </div>
                            <div class="form-row"><label class="form-label">사업자번호</label><div class="form-input-group"><input type="text"> - <input type="text"> - <input type="text"></div></div>
                        </div>
                    </div>
                </div>
            </div>
            <button class="btn-submit" onclick="alert('비밀번호 찾기 요청')">비밀번호 찾기</button>
        </div>
    </div>
	
	<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

    <script>
        // 1. 탭 전환
        function switchTab(mode) {
            document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
            document.getElementById('tab-btn-' + mode).classList.add('active');
            
            document.getElementById('view-id').classList.add('d-none');
            document.getElementById('view-pw').classList.add('d-none');
            document.getElementById('view-' + mode).classList.remove('d-none');
        }

        // 2. 폼 상태 업데이트
        function updateFormState(mode) { 
            const radios = document.getElementsByName('auth_group_' + mode);
            let selectedValue = '';
            for(let r of radios) { if(r.checked) selectedValue = r.value; }

            const personalArea = document.getElementById('area-' + mode + '-personal');
            const bizArea = document.getElementById('area-' + mode + '-biz');
            
            const emailRow = document.getElementById('row-' + mode + '-email');
            const phoneRow = document.getElementById('row-' + mode + '-phone');
            const authRow = document.getElementById('row-' + mode + '-authcode');

            // 인증번호창은 변경 시 숨김
            if(authRow) authRow.classList.add('d-none');

            if (selectedValue === 'biz') {
                personalArea.classList.add('disabled');
                bizArea.classList.remove('disabled');
            } else {
                personalArea.classList.remove('disabled');
                bizArea.classList.add('disabled');

                if (selectedValue === 'email') {
                    emailRow.classList.remove('d-none');
                    phoneRow.classList.add('d-none');
                } else {
                    emailRow.classList.add('d-none');
                    phoneRow.classList.remove('d-none');
                }
            }
        }

        // 3. 인증번호 전송 (이메일/휴대폰 통합)
        function sendAuthCode(mode, type) {
            // mode: 'id' or 'pw'
            // type: 'email' or 'phone'

            let nameInput = document.getElementById(mode + '-name');
            
            // 공통: 이름 입력 확인
            if (!nameInput.value.trim()) {
                alert('이름을 입력해 주세요.');
                nameInput.focus();
                return;
            }

            // 타입별 검증
            if (type === 'email') {
                const email1 = document.getElementById(mode + '-email-1');
                const email2 = document.getElementById(mode + '-email-2');
                if (!email1.value.trim() || !email2.value.trim()) {
                    alert('이메일 주소를 올바르게 입력해 주세요.');
                    if(!email1.value) email1.focus(); else email2.focus();
                    return;
                }
                alert('인증메일이 발송되었습니다.');
            } 
            else if (type === 'phone') {
                const p2 = document.getElementById(mode + '-phone-2');
                const p3 = document.getElementById(mode + '-phone-3');
                if (!p2.value.trim() || !p3.value.trim()) {
                    alert('휴대폰 번호를 올바르게 입력해 주세요.');
                    if(!p2.value) p2.focus(); else p3.focus();
                    return;
                }
                alert('인증번호(SMS)가 발송되었습니다.');
            }

            // 인증번호 입력창 활성화 & 타이머 시작
            const authRow = document.getElementById('row-' + mode + '-authcode');
            const timerSpan = document.getElementById('timer-' + mode);
            
            authRow.classList.remove('d-none');
            
            let time = 180; // 3분
            if (timerSpan.timer) clearInterval(timerSpan.timer);
            
            const tick = () => {
                const min = Math.floor(time / 60);
                const sec = time % 60;
                timerSpan.innerText = `${min}:${sec < 10 ? '0'+sec : sec}`;
                if (time <= 0) {
                    clearInterval(timerSpan.timer);
                    timerSpan.innerText = "시간초과";
                }
                time--;
            };
            tick();
            timerSpan.timer = setInterval(tick, 1000);
        }

        // 4. 툴팁
        function toggleTooltip(id) {
            const el = document.getElementById(id);
            el.style.display = (el.style.display === 'block') ? 'none' : 'block';
        }
    </script>
</body>
</html>