/*
	결제 관련 js
 */
 
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
});

// 폼 제출 시 필수사항 확인
document.payForm.onsubmit = function() {
	if(!document.payForm.payMethod[0].checked && !document.payForm.payMethod[1].checked) {
		document.payForm.payMethod[0].focus();
		return false;
	} else if(document.payForm.payMethod[0].checked && document.payForm.cardCompany.value == "") {
		document.payForm.cardCompany.focus();
		return false;
	} else if(document.payForm.payMethod[0].checked && document.payForm.installment.value == "") {
		document.payForm.installment.focus();
		return false;
	} else if(document.payForm.payMethod[1].checked && document.payForm.bankName.value == "") {
		document.payForm.bankName.focus();
		return false;
	} else if(document.payForm.payMethod[1].checked && document.payForm.depositor.value == "") {
		document.payForm.depositor.focus();
		return false;
	}
	
	//----------------------------------------------------------------------------------------------------
	// [ 결제 진행 ]
	
	async function requestPayment() {
   		try {
   			const response = await PortOne.requestPayment({
			  // Store ID 설정
			  storeId: "store-4ff4af41-85e3-4559-8eb8-0d08a2c6ceec",
			  // 채널 키 설정
			  channelKey: "channel-key-893597d6-e62d-410f-83f9-119f530b4b11",
			  paymentId: `payment-${crypto.randomUUID()}`,
			  orderName: ${storeInfo.productName},
			  totalAmount: ${storeInfo.productPrice},
			  currency: "CURRENCY_KRW",
			  payMethod: "CARD"
			  
			});
   			
   		} catch(error) {
			alert("요청 오류 발생 : " + error);
		}
	}
	
	requestPayment();
}


 






















