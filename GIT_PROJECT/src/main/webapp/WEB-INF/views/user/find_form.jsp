<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
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

	<form id="findForm" action="<c:url value='/user/findId' />" method="post">
<!-- 		휴대폰 조합 저장 -->
		<input type="hidden" name="phone" id="final-phone"> 

	    <div class="container">
	        <nav class="tab-nav">
	            <button type="button" class="tab-btn active" onclick="switchTab('id')" id="tab-btn-id">아이디 찾기</button>
	            <button type="button" class="tab-btn" onclick="switchTab('pw')" id="tab-btn-pw">비밀번호 찾기</button>
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
	                                <input type="radio" name="authGroupId" value="P" onclick="updateFormState('id')" checked> 휴대폰 인증
	                            </label>
	                        </div>
	
	                        <div id="area-id-personal" class="field-area">
	                            <div class="form-row">
	                                <label class="form-label">이름</label>
	                                <div class="form-input-group">
	                                    <input type="text"  id="id-name" name="userName" placeholder="성명 입력">
	                                </div>
	                            </div>
	
	
	                            <div id="row-id-phone" class="form-row">
	                                <label class="form-label">휴대폰 번호</label>
	                                <div class="form-input-group">
	                                    <select style="width: 25%;" id="id-phone-1"><option>010</option></select> - 
	                                    <input type="text" style="width: 25%;" id="id-phone-2" maxlength="4"> - 
	                                    <input type="text" style="width: 25%;" id="id-phone-3" maxlength="4">
	                                    <button type="button" class="btn-auth" onclick="sendAuthCode('id', 'phone')">인증번호 전송</button>
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
	                                <input type="radio" name="authGroupId" value="C" onclick="updateFormState('id')"> 기업회원
	                            </label>
	                        </div>
	
	                        <div id="area-id-biz" class="field-area disabled">
	                            <div class="form-row">
	                                <label class="form-label">
	                                    가입자명 <span class="tooltip-trigger" onclick="toggleTooltip('tt-id')">?</span>
	                                </label>
	                                <div class="form-input-group">
	                                    <input type="text" name="ceoName" id="id-biz-name">
	                                </div>
	                                <div id="tt-id" class="tooltip-box">
	                                    <span class="tooltip-close" onclick="toggleTooltip('tt-id')">×</span>
	                                    <p>회원가입 시 등록한 기업담당자<br>이름을 입력해 주세요.</p>
	                                </div>
	                            </div>
	                            <div class="form-row"><label class="form-label">사업자번호</label>
	                            	<div class="form-input-group">
								    	<input type="text" name="bizRegNo" id="bizRegNo" 
									           placeholder="000-00-00000" 
									           maxlength="12"
									           pattern="\d{3}-\d{2}-\d{5}"
									           title="사업자등록번호 10자리를 입력해주세요.">
	                            	</div>
	                           </div>
	                        </div>
	                    </div>
	                </div>
	            </div> <button class="btn-submit">아이디 찾기</button>
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
	                                <input type="radio" name="authGroupPw" value="P" onclick="updateFormState('pw')" checked> 휴대폰 인증
	                            </label>
	                        </div>
	                        <div id="area-pw-personal" class="field-area">
	                            <div class="form-row">
	                                <label class="form-label">아이디</label>
	                                <div class="form-input-group"><input type="text" name="email" placeholder="아이디 입력"></div>
	                            </div>
	                            <div class="form-row">
	                                <label class="form-label">이름</label>
	                                <div class="form-input-group"><input type="text" id="pw-name" name="userName" placeholder="성명 입력"></div>
	                            </div>
	
	
	                            <div id="row-pw-phone" class="form-row">
	                                <label class="form-label">휴대폰 번호</label>
	                                <div class="form-input-group">
	                                    <select style="width: 25%;" id="pw-phone-1"><option>010</option></select> - 
	                                    <input type="text" style="width: 25%;" id="pw-phone-2" maxlength="4"> - 
	                                    <input type="text" style="width: 25%;" id="pw-phone-3" maxlength="4">
	                                    <button type="button" class="btn-auth" onclick="sendAuthCode('pw', 'phone')">인증번호 전송</button>
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
	                                <input type="radio" name="authGroupPw" value="C" onclick="updateFormState('pw')"> 기업회원
	                            </label>
	                        </div>
	                        <div id="area-pw-biz" class="field-area disabled">
	                            <div class="form-row"><label class="form-label">아이디</label><div class="form-input-group"><input type="text" name="email"></div></div>
	                            <div class="form-row">
	                                <label class="form-label">
	                                    가입자명 <span class="tooltip-trigger" onclick="toggleTooltip('tt-id2')">?</span>
	                                </label>
	                                <div class="form-input-group">
	                                    <input type="text" name="ceoName" id="id-biz-name2">
	                                </div>
	                                <div id="tt-id2" class="tooltip-box">
	                                    <span class="tooltip-close" onclick="toggleTooltip('tt-id2')">×</span>
	                                    <p>회원가입 시 등록한 기업담당자<br>이름을 입력해 주세요.</p>
	                                </div>
	                            </div>
	                            <div class="form-row"><label class="form-label">사업자번호</label>
	                            	<div class="form-input-group">
								    	<input type="text" name="bizRegNo" id="bizRegNo2" 
									           placeholder="000-00-00000" 
									           maxlength="12"
									           pattern="\d{3}-\d{2}-\d{5}"
									           title="사업자등록번호 10자리를 입력해주세요.">
	                            	</div>
	                           </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            <button class="btn-submit">비밀번호 찾기</button>
	        </div>
	    </div>
	</form>
	<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

    <script>    
		const bizInputs = document.querySelectorAll('input[name="bizRegNo"]');
	    bizInputs.forEach(input => {
	        input.addEventListener('input', function(e) {
	            // 숫자만 남기기
	            let val = e.target.value.replace(/[^0-9]/g, ''); 
	            
	            // 하이픈 포맷팅 (000-00-00000)
	            if (val.length > 3 && val.length <= 5) {
	                val = val.substring(0, 3) + '-' + val.substring(3);
	            } else if (val.length > 5) {
	                val = val.substring(0, 3) + '-' + val.substring(3, 5) + '-' + val.substring(5, 10);
	            }
	            
	            e.target.value = val;
	        });
	    });
		    
        // 1. 탭 전환
		function switchTab(mode) {
		    // 1. 탭 버튼 상태 변경
		    document.querySelectorAll('.tab-nav .tab-btn').forEach(btn => btn.classList.remove('active'));
		    document.getElementById('tab-btn-' + mode).classList.add('active');
		    
		    // 2. 뷰 전환 (아이디 찾기 vs 비밀번호 찾기)
		    const viewId = document.getElementById('view-id');
		    const viewPw = document.getElementById('view-pw');
		    
		    if (mode === 'id') {
		        viewId.classList.remove('d-none');
		        viewPw.classList.add('d-none');
		        // 아이디 찾기 영역은 활성화, 비밀번호 찾기 영역은 비활성화
		        toggleInputs(viewId, false);
		        toggleInputs(viewPw, true);
		    } else {
		        viewId.classList.add('d-none');
		        viewPw.classList.remove('d-none');
		        // 비밀번호 찾기 영역은 활성화, 아이디 찾기 영역은 비활성화
		        toggleInputs(viewPw, false);
		        toggleInputs(viewId, true);
		    }
		    
		    // 3. 폼 액션 변경 (캐멀 케이스 적용)
		    const form = document.getElementById('findForm');
		    form.action = mode === 'id' ? "<c:url value='/user/findId' />" : "<c:url value='/user/findPw' />";
		
		    // 4. 활성화된 탭 내에서도 라디오 선택 상태에 맞춰 다시 세팅 
		    updateFormState(mode);
		}
		
		// 특정 영역 안의 모든 입력 요소를 활성/비활성화 하는 보조 함수
		function toggleInputs(container, isDisabled) {
			const inputs = container.querySelectorAll('input, select, button');
		    
		    inputs.forEach(el => {
		        // 1. 탭 자체를 비활성화해야 하는 경우 (다른 탭으로 이동 시)
		        if (isDisabled) {
		            el.disabled = true;
		        } else {
		            // 2. 현재 탭을 활성화하는 경우
		            // 하지만 부모 요소 중 'field-area disabled' 클래스가 있다면 그 안의 요소는 계속 비활성화 유지
		            const parentArea = el.closest('.field-area');
		            if (parentArea && parentArea.classList.contains('disabled')) {
		                el.disabled = true;
		            } else {
		                el.disabled = false;
		            }
		        }
		    });
		    
		}

        // 2. 폼 상태 업데이트
        function updateFormState(mode) { 
        	
        	const capitalizedMode = mode.charAt(0).toUpperCase() + mode.slice(1);
            const radios = document.getElementsByName('authGroup' + capitalizedMode);
            
            let selectedValue = '';
            for(let r of radios) { if(r.checked) selectedValue = r.value; }

            const personalArea = document.getElementById('area-' + mode + '-personal');
            const bizArea = document.getElementById('area-' + mode + '-biz');
            
            const phoneRow = document.getElementById('row-' + mode + '-phone');
            const authRow = document.getElementById('row-' + mode + '-authcode');

            // 인증번호창은 변경 시 숨김
            if(authRow) authRow.classList.add('d-none');

            if (selectedValue === 'C') {
                personalArea.classList.add('disabled');
                bizArea.classList.remove('disabled');
            } else {
                personalArea.classList.remove('disabled');
                bizArea.classList.add('disabled');

                if (selectedValue === 'P') {
                    phoneRow.classList.remove('d-none');
                } else {
                    phoneRow.classList.add('d-none');
                }
            }
            
            const currentView = document.getElementById('view-' + mode);
            toggleInputs(currentView, false);
            
        }

        // 3. 인증번호 전송 (휴대폰 통합)
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
             const p2 = document.getElementById(mode + '-phone-2');
             const p3 = document.getElementById(mode + '-phone-3');
             if (!p2.value.trim() || !p3.value.trim()) {
                 alert('휴대폰 번호를 올바르게 입력해 주세요.');
                 if(!p2.value) p2.focus(); else p3.focus();
                 return;
             }
             alert('인증번호(SMS)가 발송되었습니다.');

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
        
     	// 폼 제출 시 실행되는 이벤트 리스너
        document.getElementById('findForm').addEventListener('submit', function(e) {
            // 현재 활성화된 탭이 무엇인지 확인 ('id' 또는 'pw')
            const currentMode = document.getElementById('tab-btn-id').classList.contains('active') ? 'id' : 'pw';
            
            // 1. 해당 모드의 휴대폰 입력값 가져오기
            const p1 = document.getElementById(currentMode + '-phone-1').value; // 010 [cite: 46, 68]
            const p2 = document.getElementById(currentMode + '-phone-2').value; // 중간 [cite: 47, 69]
            const p3 = document.getElementById(currentMode + '-phone-3').value; // 끝 [cite: 48, 70]
            
            // 2. 값 합치기 (예: 01012345678)
            const fullPhone = p1 + "-" + p2 + "-" + p3;
            
            // 3. 히든 필드(id="final-phone")에 값 주입 
            document.getElementById('final-phone').value = fullPhone;
            
            // (선택 사항) 제대로 합쳐졌는지 확인용 로그
            console.log("제출되는 전체 번호: " + fullPhone);
        });
        
        // 로드시 셀렉트가 다름
	    window.onload = function() {
	        // 1. EL식으로 가져오는 값 (서버에서 바로 보낼 때)
	        const serverType = "${type}"; 
	        
	        // 2. URL에서 직접 가져오는 값 (redirect로 ?type=C가 붙어올 때)
	        const urlParams = new URLSearchParams(window.location.search);
	        const urlType = urlParams.get('type');

	        const finalType = serverType || urlType;

	        if (finalType === 'id') {
	            switchTab('id');
	        } else {
	            switchTab('pw'); // 기본값 P
	        }
	    };
	    
	    
    </script>
</body>
</html>