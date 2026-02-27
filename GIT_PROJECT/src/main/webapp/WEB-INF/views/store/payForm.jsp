<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
</head>
<body>
    <%@ include file="/WEB-INF/views/inc/header.jspf" %>
    
    <main>
        <div class="container mt-5 custom-width">
            <h2 class="mb-4 text-center">구매하기</h2>

            <form name="payForm" action="<c:url value='/store/pay' />" method="post" class="needs-validation" novalidate>

                <!-- 주문자 정보 -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h4 class="mb-3">주문자 정보</h4>
                        <div class="mb-3">
                            <label class="form-label">주문자명</label>
                            <input id="userName" type="text" class="form-control" name="userName" value="${orderInfo.userName}" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">전화번호</label>
                            <input id="userPhone" type="text" class="form-control" name="userPhone" value="${orderInfo.phone}" readonly>
                        </div>
                    </div>
                </div>

                <!-- 상품 정보 -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h4 class="mb-3">상품 정보</h4>
                        <div class="mb-3">
                            <label class="form-label">상품명</label>
                            <input id="productName" type="text" class="form-control" name="productName" value="${storeInfo.productName}" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">상품 가격</label>
                            <input id="productPrice" type="text" class="form-control" name="productPrice" value="${storeInfo.productPrice}원" readonly>
                        </div>
                    </div>
                </div>

                <!-- 결제 수단 -->
                <div class="card mb-4">
                    <div class="card-header fw-bold">결제 수단</div>
                    <div id="selectMethod" class="card-body">
                        <div class="form-check mb-2">
                            <input id="credit" class="form-check-input" type="radio" name="payMethod" value="credit" 
                            	onclick="checkMethod()" required>
                            <label class="form-check-label" for="credit">신용카드</label>
                        </div>
                        
                        <!-- 신용카드를 선택한 경우 -->
                        <div id="selectCredit" class="row mb-3 mx-3" style="display:none;">
                            <div class="col-md-6 mb-2">
                                <label class="form-label">카드사 선택</label>
                                <select id="cardCompany" class="form-select" name="cardCompany">
                                    <option value="">카드사 선택</option>
                                    <option value="ss">삼성카드</option>
                                    <option value="sh">신한카드</option>
                                    <option value="kb">KB국민카드</option>
                                    <option value="wr">우리카드</option>
                                    <option value="bc">비씨카드</option>
                                    <option value="rd">롯데카드</option>
                                    <option value="hd">현대카드</option>
                                    <option value="hn">하나카드</option>
                                    <option value="ct">씨티카드</option>
                                    <option value="kk">카카오뱅크</option>
                                    <option value="kj">광주카드</option>
                                    <option value="jb">전북카드</option>
                                    <option value="sb">수협카드</option>
                                    <option value="jj">제주카드</option>
                                    <option value="cu">신협카드</option>
                                    <option value="eb">우체국체크카드</option>
                                    <option value="mg">새마을금고</option>
                                    <option value="kdb">KDB산업체크카드</option>
                                    <option value="nh">NH카드</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">할부 개월 수</label>
                                <select id="installment" class="form-select" name="installment">
                                    <option value="">일시불</option>
                                    <option value="2">2개월</option>
                                    <option value="3">3개월</option>
                                    <option value="4">4개월</option>
                                    <option value="5">5개월</option>
                                    <option value="6">6개월</option>
                                    <option value="7">7개월</option>
                                    <option value="8">8개월</option>
                                    <option value="9">9개월</option>
                                    <option value="10">10개월</option>
                                    <option value="11">11개월</option>
                                    <option value="12">12개월</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-check mb-2">
                            <input id="bank" class="form-check-input" type="radio" name="payMethod" value="bank" onclick="checkMethod()">
                            <label class="form-check-label" for="bank">무통장 입금</label>
                        </div>
                        
                        <!-- 무통장 입금을 선택한 경우 -->
                        <div id="selectBank" class="row mx-3" style="display:none;">
                            <div class="col-md-6 mb-2">
                                <label class="form-label">은행 선택</label>
                                <select class="form-select" name="bankName">
                                    <option value="">은행 선택</option>
                                    <option value="kb">국민은행</option>
                                    <option value="wr">우리은행</option>
                                    <option value="sh">신한은행</option>
                                    <option value="ibk">기업은행</option>
                                    <option value="nh">NH농협은행</option>
                                    <option value="bs">부산은행</option>
                                    <option value="hn">하나은행</option>
                                    <option value="kj">광주은행</option>
                                    <option value="eb">우체국</option>
                                    <option value="im">iM뱅크</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">입금자명</label>
                                <input type="text" id="depositName" class="form-control" name="depositor" required>
                            </div>
                        </div>
                    </div>
                </div>


                <!-- 결제 금액 -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h4 class="mb-3">결제 금액</h4>
                        <div class="row mb-2">
                            <div class="col-6">상품 금액</div>
                            <div class="col-6 text-end">${storeInfo.productPrice}원</div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-6">할인 금액</div>
                            <div class="col-6 text-end">0원</div>
                        </div>
                        <div class="row fw-bold">
                            <div class="col-6">총 결제 금액</div>
                            <div class="col-6 text-end">${storeInfo.productPrice}원</div>
                        </div>
                    </div>
                </div>

                <!-- 약관 -->
				<div class="form-check mb-3">
				    <input class="form-check-input" type="checkbox" id="checkModal" required>
			        <span data-bs-toggle="modal" data-bs-target="#termsModal" style="cursor:pointer; color:inherit; text-decoration:none;">
			            (필수) 유료 서비스 이용 약관 동의
			        </span>
				</div>
				
				<!-- 모달 -->
				<div class="modal fade" id="termsModal" tabindex="-1" aria-hidden="true">
				  <div class="modal-dialog modal-lg modal-dialog-scrollable">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title">유료 서비스 이용 약관</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				      </div>
				      <div class="modal-body">
				        <p>[유료 서비스 이용 약관]</p>
				        <p>제1조 (목적)<br>
							이 약관은 ㈜잡아이(이하 "회사")가 제공하는 채용 관련 상품 및 서비스 거래 플랫폼(이하 "서비스")과 관련하여 회사와 회원의 권리·의무 등 필요한 사항을 규정합니다.</p>
				        <p>제2조 (회원)<br>
							서비스를 이용하려는 개인 또는 법인은 이 약관을 확인하고 동의하게 됩니다.<br>
							서비스를 이용하는 모든 회원은 ㈜잡아이의 「개인회원 약관」 또는 「기업회원 약관」 동의 후 회사로부터 유효한 회원 자격을 부여받아 유지하는 개인 또는 기업회원임을 전제로 합니다. 이러한 사유로 이 약관으로 정하지 않은 사항 중 ㈜사람인의 「개인회원 약관」 또는 「기업회원 약관」으로 규정된 사항은 해당 약관의 적용을 받습니다.</p>
				      	<p>제3조 (상품)<br>
							회사가 이 약관을 기준으로 제공하는 서비스의 구체적인 재화 및 용역(이하 "상품")은 다음과 같습니다.<br>
							① (구직자 회원)구직자 회원의 취업을 보조하기 위하여 이미 작성된 문서의 첨삭 및/또는 신규 문서의 작성 등을 제공(이하 "AI 자소서 첨삭")하는 유상 상품<br>
							② (기업 회원)인재 채용을 위한 공고 등록 및 지원자 관리 등의 유상 상품<br>
							③ (기업 회원)기업 채용 공고의 홍보를 위한 배너 광고 상품</p>
						<p>제4조 (상품 구매)<br>
							① 구매회원은 회사가 제공하는 구매 절차에 따라 상품을 검색 및 선택하고 그 대금을 결제합니다. 회사는 구매회원이 구체적인 상품을 선택할 수 있는 기능을 제공하고, 회원의 선택에 따라 사전 고지된 대금의 결제를 요청합니다.<br>
							② 회사는 회원의 착오 없는 상품 구매를 위하여 결제수단 입력 단계에서 상품명 및 그에 따른 주문금액을 표시합니다.<br>
							③ 전항에도 불구하고 구매회원이 선택한 상품의 구체적인 이용 조건(이용개시 요건 및 그 충족 여부, 사용 가능 여부, 수정/작성/첨삭 등 제공할 AI 자소서 첨삭 유형 등)은 해당 상품의 상세 페이지를 기준으로 합니다. 회사는 구매회원의 상품 상세 페이지 미확인 또는 이러한 상품 거래 조건에 대한 개인회원의 오인 등으로 발생한 구매회원 및 제3자의 손해에 대하여 책임을 부담하지 않습니다.<br>
							④ 구매회원이 회사가 마련한 결제수단 이외의 수단 또는 방법으로 서비스를 이용하거나 상품을 구매하는 행위는 금지됩니다. 이러한 행위가 확인되는 경우 회사는 해당 회원의 서비스 이용을 일시 또는 영구히 정지하거나 해당 회원과의 서비스 이용 계약을 완전히 해제할 수 있습니다. 아울러 이러한 행위로 회사 및 회사의 회원, 제3자 등에게 발생한 일체의 손해에 대한 책임 부담을 청구할 수 있습니다.<br>
							⑤ 회사는 회원의 미납 또는 연체, 확인 중이거나 확정된 부정/불법행위, 기타 진행 중인 분쟁 등을 이유로 특정 구매회원의 상품 구매 및 서비스 이용을 거절할 수 있습니다.</p>
				      	<p>제5조 (청약 철회)<br>
							① 구매회원은 결제완료일로부터 7일까지 상품 구매 청약을 철회할 수 있습니다.<br>
							② 구매회원이 청약 철회 의사를 회사에 표시한 경우 회사는 이 조항에서 규정한 철회 요건에 부합하는지 확인 후 해당 요청을 승인하거나 거절할 수 있습니다.</p>
				      	<p>제6조 (환불)<br>
							① 구매회원은 제공받은 상품이 상세 페이지에서 약정한 수준에 현저히 미달하거나 수량이 극히 부족한 경우 환불을 요청할 수 있습니다. 다만 구매회원의 주관적인 기대치 불충족을 이유로 한 환불은 불가합니다.<br>
							② 회사가 제공하는 상품은 구매회원이 희망하는 결과 도출(취업·이직·승진·합격 등)을 보장하지 않습니다. 이를 이유로 정상적으로 제공이 완료된 상품에 대한 철회·환불·기타 배상 등을 요청하더라도 회사 및 판매회원은 해당 책임을 부담하지 않습니다.<br>
							③ 구매회원이 요청한 환불이 확정된 경우 회사는 확정일로부터 15일 내에 구매회원이 결제한 수단을 취소하거나 사전에 구매회원이 등록한 계좌로 환불합니다. 단, 결제완료일로부터 180일이 경과한 경우에는 구매회원이 등록 및/또는 인증한 계좌로 환불합니다.</p>
				      	<p>제7조 (회사의 의무)<br>
							① 회사는 안정적인 서비스 제공을 위하여 지속적인 모니터링 등 필요한 업무를 수행합니다. 회사는 이를 통해 인지한 불안요소(회원의 부정행위, 기타 안정적 서비스 제공을 저해하는 요소 등)의 해소를 위하여 필요한 조치를 취할 수 있습니다.<br>
							② 회사는 회원의 개인정보, 결제정보 및 기타 정보의 보호를 위하여 관련 법령으로 규정한 보안시스템을 운영합니다. 더불어 이 약관 및 별도로 규정된 「개인정보 처리방침」을 구매회원이 언제든 확인할 수 있도록 공지하고 이를 준수합니다.<br></p>
				      	<p>제8조 (회원의 의무)<br>
							① 구매회원은 회원가입 및 상품 구매시 필요한 정보를 자신의 정보로 정확히 기재하여야 합니다. 회사가 서비스 제공을 위해 구매회원으로부터 수집하는 정보 및 관련 세부사항은 별도로 규정된 「개인정보 처리방침」에 따라 처리됩니다.<br>
							② 구매회원이 상품 구매의사 없이 상품 결제 및 그 철회를 반복하거나 정당한 사유없이 회사가 제공하는 결제 수단에의 입금·취소를 반복하는 등의 행위는 서비스 부정이용 행위에 해당합니다.<br>
							③ 구매회원이 인터넷 브라우저를 통한 인적 접근 이외의 자동화된 수단 또는 이와 유사한 방법으로 실행한 서비스 접근, 이용, 공격 등의 행위는 금지됩니다.<br>
							④ 회사는 관련 법령 및 이 약관에서 금지하는 행위를 서비스 부정이용 행위로 봅니다. 구매회원의 서비스 부정이용 행위가 확인되는 경우 회사는 사전 협의·통지없이 구매회원의 서비스 이용 자격을 정지하고 관련하여 필요한 조치를 취하거나, 그러한 행위로 발생한 회사 및 제3자의 손해 일체에 대한 배상을 청구할 수 있습니다. 다만 구매회원의 고의·과실이 없는 경우에는 정상 사용을 허가할 수 있습니다. 이 경우에도 구매회원의 고의·과실이 없다는 사실에 대한 입증책임은 구매회원이 부담합니다.<br>
							⑤ 회사는 안정적인 서비스 제공 및 회사·회원 등 서비스 사용자의 이익을 위하여 구매회원의 부정행위 행태, 해당 행위의 인지 및 해결과정에서 수집한 정보 등 관련 정보(이하 "부정행위 연관 정보")를 영구히 보관할 수 있습니다.</p>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				      </div>
				    </div>
				  </div>
				</div>

                <!-- 버튼 -->
                <div class="d-flex justify-content-center mb-4">
                    <button id="btnPay" type="submit" class="btn btn-primary" disabled="disabled">구매하기</button>
                </div>
            </form>
        </div>
    </main>
    
    <script type="text/javascript">
    	// 결제 수단 선택에 따라 해당하는 셀렉트 박스 디스플레이
		function checkMethod() {
			if(document.getElementById("credit").checked) {
    			document.getElementById("selectCredit").style.display = "block";
    			document.getElementById("selectBank").style.display = "none";
    		} else if(document.getElementById("bank").checked) {
    			document.getElementById("selectCredit").style.display = "none";
    			document.getElementById("selectBank").style.display = "block";
    		}
    	}
    	
    	// 유료 서비스 약관에 동의했을 경우에만 구매 버튼 활성화
    	document.getElementById("checkModal").addEventListener("click", function() {
    		if(document.getElementById("checkModal").checked) {
    			document.getElementById("btnPay").disabled = false;
    		} else {
    			document.getElementById("btnPay").disabled = true;
    		}
    	}) 
    	
    	
//     	document.payForm.addEventListener("submit", function() {
//     		if(!document.payForm.payMethod[0].checked && !document.payForm.payMethod[1].checked) {
//     			document.payForm.payMethod[0].focus();
//     			return false;
//     		} else if(document.payForm.payMethod[0].checked && document.payForm.cardCompany.value == "") {
//     			document.payForm.cardCompany.focus();
//     			return false;
//     		} else if(document.payForm.payMethod[0].checked && document.payForm.installment.value == "") {
//     			document.payForm.installment.focus();
//     			return false;
//     		} else if(document.payForm.payMethod[1].checked && document.payForm.bankName.value == "") {
//     			document.payForm.bankName.focus();
//     			return false;
//     		} else if(document.payForm.payMethod[1].checked && document.payForm.depositor.value == "") {
//     			document.payForm.depositor.focus();
//     			return false;
//     		}
//     	})
    </script>

</body>
</html>