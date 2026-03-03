package com.itwillbs.project.store.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project.store.dto.OrderDTO;
import com.itwillbs.project.store.dto.PaymentDTO;
import com.itwillbs.project.store.dto.PortoneDTO;
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
	
	// 구매하기 페이지 - 특정 상품의 "구매하기" 버튼 클릭
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
	    
	    orderInfo.setOrderId(today.format(dtf) + randStr);
	    //----------------------------------------------------------
	    model.addAttribute("orderInfo", orderInfo);
	    //---------------------------------------------------------
		// 구매 상품 정보 조회
		StoreDTO storeInfo = storeService.getStoreInfo(storeDTO.getProductId());
		model.addAttribute("storeInfo", storeInfo);
		
		session.setAttribute("orderDTO", orderInfo);
		session.setAttribute("storeDTO", storeInfo);
		
		return "store/payForm";
	}
	
	//===========================================================================================================
	// 결제 정보 처리
	@PostMapping(value = "/payResponse", produces = "application/json; charset=UTF-8")
//	@GetMapping("/payResponse")
	public String payResult(@RequestBody PortoneDTO portoneDTO, Model model, PaymentDTO paymentDTO, HttpSession session, OrderDTO orderDTO) {
		OrderDTO order = (OrderDTO) session.getAttribute("orderDTO");
		StoreDTO store = (StoreDTO) session.getAttribute("storeDTO");
		
		session.removeAttribute("orderDTO");
		session.removeAttribute("storeDTO");
		 
		// 주문 정보 삽입 
		storeService.setOrderInfo(order, store);
		
		// 1️ PortOne 서버에서 결제 정보 조회
	    // 클라이언트에서 넘어온 paymentId를 이용해서 실제 결제 정보 확인
	    PortoneDTO paymentInfo = storeService.getPayment(portoneDTO.getPaymentId());
	    
	    // 해당 구매번호와 일치하는 주문 정보 조회
	    OrderDTO orderInfo = storeService.findByPaymentId(paymentInfo.getPaymentId());
	    
	    // 2️ 결제 금액 검증
	    // PortOne 서버에서 받은 결제 금액(paymentInfo.getAmount)와 DB 주문 금액(orderInfo.getProductPrice)이 일치하는지 확인
	    if(paymentInfo.getAmount().getTotal() != orderInfo.getProductPrice()) {
	        // 금액 불일치 시 결제 실패 처리
	    	log.info("결제 실패!");
	        return null;
	    } 
	    
	    // 3️ 카드 결제 처리
	    if("PAID".equals(paymentInfo.getStatus())) {
	        // 결제 성공 상태(PAID)인 경우
	    	orderInfo.setStatus("PAID");       // 주문 상태를 PAID로 업데이트
	        storeService.setOrderStatus(orderInfo);    // DB 반영
	    
		    // 결제 내역에 저장
		    paymentDTO.setPayId(portoneDTO.getPaymentId());
		    
		 // DTO에 필요한 DB 컬럼 채우기
	//	    String sId = (String)session.getAttribute("sId");
	//	    long userId = Long.parseLong(sId);
	//	    
		    paymentDTO.setUserId(orderInfo.getUserId());          // 서버에서 알고 있는 회원 PK
		    paymentDTO.setProductId(orderInfo.getProductId());    // 서버에서 알고 있는 상품 PK
		    paymentDTO.setPayMethod("CARD");
		    paymentDTO.setCardName(paymentInfo.getMethod().getCard().getName());
		    paymentDTO.setCardNum(paymentInfo.getMethod().getCard().getNumber());
		    paymentDTO.setPayPrice(paymentInfo.getAmount().getTotal());
		    paymentDTO.setPayDate(paymentInfo.getPaidpayment().getPaidAt());
		    paymentDTO.setPayStatus(paymentInfo.getStatus());
		    
		    // 결제 테이블에 주문 정보 저장
		    storeService.setPaymentInfo(paymentInfo);
	    
	    	return "redirect:/store/paySuccess";     // 결제 성공 페이지 반환
	    }

	    // 4️ 가상계좌 발급 상태 처리
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
	    return "store/payFailed";
	}

	
	@GetMapping("/payResult")
	public String payResult(String code) {
		if(!code.equals("FAILURE_TYPE_PG")) {
			
			return "store/paySuccess";
		}
		
		return "store/payFailed";
	}
	

}























