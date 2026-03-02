package com.itwillbs.project.store.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.server.reactive.HttpHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.itwillbs.project.store.dto.OrderDTO;
import com.itwillbs.project.store.dto.PaymentDTO;
import com.itwillbs.project.store.dto.PortoneDTO;
import com.itwillbs.project.store.dto.ResponsePaymentDTO;
import com.itwillbs.project.store.dto.StoreDTO;
import com.itwillbs.project.store.service.StoreService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/store")
@RequiredArgsConstructor
@Log4j2
public class StoreController {
	@Autowired
	private StoreService storeService;
	
	//------------------------------------------------------------
	// 구직자 요금제
	@GetMapping("/ustore")
	public String userStore() {
		
		return "store/userStore";
	}
	
	// 기업 요금제
	@GetMapping("/cstore")
	public String comStore() {
		
		return "store/comStore";
	}
	
	// 구매하기(구현중) - 특정 상품의 "구매하기" 버튼 클릭
	@GetMapping("/pay")
	public String pay(StoreDTO storeDTO, Model model, HttpSession session) {
		// 세션에 저장된 id값을 통해 구매자 정보 출력
		String sId = (String)session.getAttribute("sId");
		
		// 구매자 정보 조회
		OrderDTO orderInfo = storeService.getOrderUser(sId);
		//---------------------------------------------------------
		// 구매 번호 생성
		LocalDate today = LocalDate.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd");
		
	    int randNum = (int)(Math.random() * 100000); // 0~99999 랜덤 숫자, 5자리 고정
	    String randStr = String.format("%05d", randNum);
	    
	    orderInfo.setPayId(today.format(dtf) + randStr);
	    //----------------------------------------------------------
	    
	    System.out.println("orderInfo >>>>>>> " + orderInfo);
	    
	    model.addAttribute("orderInfo", orderInfo);
	    //---------------------------------------------------------
		// 구매 상품 정보 조회
		StoreDTO storeInfo = storeService.getStoreInfo(storeDTO.getProductId());
		model.addAttribute("storeInfo", storeInfo);
		
		
		return "store/payForm";
	}
	
	// 결제 인증
//	@PostMapping(value = "/payResponse", produces = "application/json; charset=UTF-8")
//	public ResponseEntity<?> responsePayment(@RequestBody ResponsePaymentDTO paymentDTO) {
//	    try {
//	    	String paymentId = paymentDTO.getPaymentId();   // 실제로는 paymentId
//	        String merchantUid = paymentDTO.getMerchantUid();
//	        String apiKey = "";
//
//	        RestTemplate restTemplate = new RestTemplate();
//	        HttpHeaders headers = new HttpHeaders();
//	        headers.set("Authorization", "PortOne " + apiKey);
//	        HttpEntity<String> entity = new HttpEntity<>(headers);
//
//	        String url = "https://api.portone.io/v2/payments/" + paymentId;
//
//	        ResponseEntity<Map> portoneResponse =
//	                restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);
//
//	        Map<String, Object> paymentData = portoneResponse.getBody();
//
//	        // 타입 안전 처리
//	        int amount = ((Number) paymentData.get("amount")).intValue();
//	        String paymentStatus = (String) paymentData.get("status");
//
//	        int expectedAmount = getOrderAmountFromDB(merchantUid);
//
//	        if (amount == expectedAmount && "PAID".equals(paymentStatus)) {
//	            updateOrderStatus(merchantUid, "결제완료");
//	            return ResponseEntity.ok("결제 성공");
//	        } else {
//	            updateOrderStatus(merchantUid, "결제실패");
//	            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("결제 검증 실패");
//	        }
//
//	    } catch (Exception e) {
//	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
//	                .body("서버 오류: " + e.getMessage());
//	    }
//	}
	
	@GetMapping("/payResult")
	public String payResult(@RequestParam String paymentId, Model model, PaymentDTO paymentDTO, HttpSession session) {
		// 1️ PortOne 서버에서 결제 정보 조회
	    // 클라이언트에서 넘어온 paymentId를 이용해서 실제 결제 정보 확인
	    PortoneDTO payment = storeService.getPayment(paymentId);
	    
//	    paymentDTO.setPayId(payment.getPaymentId());
//	    
//	 // DTO에 필요한 DB 컬럼 채우기
//	    String sId = (String)session.getAttribute("sId");
//	    
//	    long userId = Long.parseLong(sId);
//	    paymentDTO.setUserId(userId);          // 서버에서 알고 있는 회원 PK
//	    paymentDTO.setProductId(productId);    // 서버에서 알고 있는 상품 PK
//	    paymentDTO.setPayMethod("CARD");
//	    paymentDTO.setCardName(payment.getMethod().getCard().getCompany());
//	    paymentDTO.setCardNum("****" + "1234");
//	    paymentDTO.setPayPrice(String.valueOf(payment.getTotalAmount()));
//	    paymentDTO.setPayDate(LocalDateTime.now());
//	    paymentDTO.setPayStatus(payment.getStatus());

	    // ⚠️ 여기서 order 객체는 기존 주문 테이블 기반 코드
	    //    payment와 금액 비교를 위해 가져온다고 가정
//	    OrderDTO order = storeService.findByPaymentId(paymentId);

	    // 2️ 결제 금액 검증
	    // PortOne 서버에서 받은 결제 금액(payment.getAmount)와 DB 주문 금액(order.getAmount)이 일치하는지 확인
//	    if(payment.getAmount() != order.getAmount()) {
//	        // 금액 불일치 시 결제 실패 처리
//	        return "store/payFail";
//	    }

	    // 3️ 카드 결제 처리
//	    if("PAID".equals(payment.getStatus())) {
//	        // 결제 성공 상태(PAID)인 경우
//	        order.setStatus("PAID");       // 주문 상태를 PAID로 업데이트
//	        orderService.update(order);    // DB 반영
//	        return "store/paySuccess";     // 결제 성공 페이지 반환
//	    }
//
//	    // 4️ 가상계좌 발급 상태 처리
//	    if("READY".equals(payment.getStatus())) {
//	        // 가상계좌가 발급되었지만 아직 입금 전 상태
//	        order.setStatus("READY");      // 주문 상태를 READY로 업데이트
//	        orderService.update(order);    // DB 반영
//
//	        // 가상계좌 정보 모델에 담아서 JSP에서 출력
//	        model.addAttribute("bankName", payment.getVirtualAccount().getBank());
//	        model.addAttribute("accountNumber", payment.getVirtualAccount().getAccountNumber());
//	        model.addAttribute("dueDate", payment.getVirtualAccount().getExpiry().getDueDate());
//
//	        return "store/virtualAccountInfo"; // 입금 안내 페이지
//	    }

	    // 5️ 위 경우 외 실패 처리
	    return "store/payFail";
	}

	
	@GetMapping("/payResult")
	public String payResult() {
		return "/store/paySuccess";
	}
	

}























