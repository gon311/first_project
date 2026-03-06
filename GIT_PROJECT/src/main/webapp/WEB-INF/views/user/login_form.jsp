<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/views/inc/head.jspf" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	<link href="<c:url value="/resources/css/user/userLogin.css" />" rel="stylesheet" type="text/css">
</head>

<body class="d-flex flex-column min-vh-100">
	<%@ include file="/WEB-INF/views/inc/header.jspf" %>

    <main class="flex-grow-1 d-flex justify-content-center align-items-center py-5">
        
        <div class="login-wrapper bg-white p-5 rounded shadow-sm">
            
            <div class="d-flex custom-tabs mb-4">
                <div class="w-50 text-center tab-btn active" onclick="switchTab('personal')">개인회원</div>
                <div class="w-50 text-center tab-btn" onclick="switchTab('corporate')">기업회원</div>
            </div>

            <div id="personal-content" class="tab-content-area active">
                <form action="<c:url value="/user/login" />" method="post" onsubmit="">
                    <div class="row g-2 mb-3">
                        <div class="col-9">
                            <div class="position-relative mb-2">
                                <i class="fa-regular fa-user position-absolute top-50 start-0 translate-middle-y ms-3 icon-left"></i>
                                <input 
                                	type="text" 
                                	class="form-control form-control-lg ps-5" 
                                	name="email" 
                                	value="${cookie['remember-type'].value == 'P' ? type == 'P' ? errorId : cookie['remember-id'].value : ''}"
                                	placeholder="개인 ID">
                            </div>
                            <div class="position-relative">
                                <i class="fa-solid fa-lock position-absolute top-50 start-0 translate-middle-y ms-3 icon-left"></i>
                                <input type="password" class="password-input form-control form-control-lg ps-5 pe-5" name="password" placeholder="비밀번호">
                                <i class="fa-regular fa-eye-slash position-absolute top-50 end-0 translate-middle-y me-3 password-toggle-icon" id="toggle-password"></i>
                                <input type="hidden" id="hiddenType" name="type" value="P">
                            </div>
                        </div>
                        <div class="col-3">
                            <button class="btn btn-primary w-100 btn-big-login p-0">로그인</button>
                        </div>
	                    <div class="position-relative">
	                        <label><input type="checkbox" name="rememberId" <c:if test="${cookie['remember-type'].value == 'P'}">checked</c:if>> 아이디 기억하기</label>
	                    </div>
	                    <div class="position-relative">
	                        <p id="error">${type != 'C' ? errorMsg : ''}</p>
	                    </div>
                    </div>
                </form>

                <div class="d-flex justify-content-end align-items-center mb-4 text-secondary small">
                    IP보안 <span class="ms-2 toggle-text cursor-pointer">ON</span>
                </div>

                <div class="d-flex justify-content-center gap-3 mb-4">
                    <a href="#" class="social-btn bg-naver"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M16.867 0H7.133C3.196 0 0 3.196 0 7.133v9.734C0 20.804 3.196 24 7.133 24h9.734C20.804 24 24 20.804 24 16.867V7.133C24 3.196 20.804 0 16.867 0zM9.509 17.333H6.459V6.667h3.05l5.041 7.533V6.667h3.05v10.667h-3.05L9.509 9.133v8.2z"/></svg></a>
                    <a href="#" class="social-btn bg-kakao"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path fill="#3C1E1E" d="M12 3c-4.97 0-9 3.185-9 7.115 0 2.557 1.707 4.8 4.27 6.054-.188.702-.682 2.545-.78 2.94-.123.496.182.488.382.356.16-.106 2.5-1.697 3.52-2.403.53.078 1.07.118 1.608.118 4.97 0 9-3.185 9-7.115S16.97 3 12 3z"/></svg></a>
                    <a href="#" class="social-btn bg-facebook"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="<c:url value="user/googleLogin" />" class="social-btn bg-google"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48"><path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/><path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/><path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/><path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/><path fill="none" d="M0 0h48v48H0z"/></svg></a>
                    <a href="#" class="social-btn bg-apple"><i class="fa-brands fa-apple"></i></a>
                </div>

                <div class="text-center text-secondary small">
                    <a href="<c:url value="/user/find?type=id" />" class="text-decoration-none text-secondary">아이디 찾기</a>
                    <span class="mx-2 text-black-50">|</span>
                    <a href="<c:url value="/user/find?type=pw" />" class="text-decoration-none text-secondary">비밀번호 찾기</a>
                    <span class="mx-2 text-black-50">|</span>
                    <a href="<c:url value="/user/regist?id=pe"/>" class="text-decoration-none fw-bold text-primary">회원가입</a>
                </div>
            </div>

            <div id="corporate-content" class="tab-content-area">
                <form action="<c:url value="/user/login" />" method="post" onsubmit="">
                    <div class="row g-2 mb-3">
                        <div class="col-9">
                            <div class="position-relative mb-2">
                                <i class="fa-regular fa-building position-absolute top-50 start-0 translate-middle-y ms-3 icon-left"></i>
                                <input type="text" class="form-control form-control-lg ps-5" name="email" value="${cookie['remember-type'].value == 'C' ? type == 'C' ? errorId : cookie['remember-id'].value : ''}" placeholder="기업 ID">
                            </div>
                            <div class="position-relative">
                                <i class="fa-solid fa-lock position-absolute top-50 start-0 translate-middle-y ms-3 icon-left"></i>
                                <input type="password" class="password-input form-control form-control-lg ps-5" name="password" placeholder="비밀번호">
                                <i class="fa-regular fa-eye-slash position-absolute top-50 end-0 translate-middle-y me-3 password-toggle-icon" id="toggle-password"></i>
                            </div>
                                <input type="hidden" id="hiddenType" name="type" value="C">
                        </div>
                        <div class="col-3">
                            <button class="btn btn-primary w-100 btn-big-login p-0">로그인</button>
                        </div>
                        <div class="position-relative">
	                        <label><input type="checkbox" name="rememberId" <c:if test="${cookie['remember-type'].value == 'C'}">checked</c:if>> 아이디 기억하기</label>
	                    </div>
                        <div class="position-relative">
                        	<p id="error">${type == 'C' ? errorMsg : ''}</p>
                        </div>
                    </div>
                </form>
                <div class="d-flex justify-content-end align-items-center mb-4 text-secondary small">
                    IP보안 <span class="ms-2 toggle-text cursor-pointer">ON</span>
                </div>
                <div class="text-center text-secondary small mt-5">
                    <a href="<c:url value="/user/find?type=id" />" class="text-decoration-none text-secondary">아이디 찾기</a>
                    <span class="mx-2 text-black-50">|</span>
                    <a href="<c:url value="/user/find?type=pw" />" class="text-decoration-none text-secondary">비밀번호 찾기</a>
                    <span class="mx-2 text-black-50">|</span>
                    <a href="<c:url value="/user/regist?id=co" />" class="text-decoration-none fw-bold text-primary">기업회원가입</a>
                </div>
            </div>

        </div>
        </main>

    <%@ include file="/WEB-INF/views/inc/footer.jspf" %>

	<script>
		
	    function switchTab(type) {
	        const tabs = document.querySelectorAll('.tab-btn');
	        const contents = document.querySelectorAll('.tab-content-area');
	        tabs.forEach(t => t.classList.remove('active'));
	        contents.forEach(c => c.classList.remove('active'));
	        if (type === 'personal') {
	            tabs[0].classList.add('active');
	            document.getElementById('personal-content').classList.add('active');
	        } else {
	            tabs[1].classList.add('active');
	            document.getElementById('corporate-content').classList.add('active');
	        }
	    }
	
	    const passwordInputs = document.querySelectorAll('.password-input');
	
	    passwordInputs.forEach(input => {
	        
	        // 현재 입력창(input)의 부모 박스를 찾고, 그 안에 있는 눈 아이콘(icon)을 찾습니다.
	        const wrapper = input.parentElement;
	        const icon = wrapper.querySelector('.password-toggle-icon');
	
	        // 예외 처리: 만약 아이콘이 없는 경우(실수 방지) 건너뜀
	        if (!icon) return;
	
	        // 기능 1: 글자 입력 시 아이콘 보이기/숨기기
	        input.addEventListener('input', function() {
	            if (this.value.length > 0) {
	                icon.style.display = 'block';
	            } else {
	                icon.style.display = 'none';
	            }
	        });
	
	        // 기능 2: 아이콘 클릭 시 비밀번호 토글
	        icon.addEventListener('click', function(e) {
	            e.preventDefault();
	            e.stopPropagation(); // 이벤트 버블링 방지
	
	            if (input.type === 'password') {
	                input.type = 'text';
	                icon.classList.remove('fa-eye-slash');
	                icon.classList.add('fa-eye');
	            } else {
	                input.type = 'password';
	                icon.classList.remove('fa-eye');
	                icon.classList.add('fa-eye-slash');
	            }
	        });
	    });
	    
	    
	    window.onload = function() {
	        // 1. EL식으로 가져오는 값 (서버에서 바로 보낼 때)
	        const serverType = "${type}"; 
	        
	        // 2. URL에서 직접 가져오는 값 (redirect로 ?type=C가 붙어올 때)
	        const urlParams = new URLSearchParams(window.location.search);
	        const urlType = urlParams.get('type');

	        const finalType = serverType || urlType;

	        if (finalType === 'C') {
	            switchTab('corporate');
	        } else {
	            switchTab('personal'); // 기본값 P
	        }
	    };
	</script>
</body>
</html>