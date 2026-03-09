package com.itwillbs.project.store.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.project.admin.dto.MemberDTO;
import com.itwillbs.project.admin.service.AdminService;
import com.itwillbs.project.common.exception.BackwardException;
import com.itwillbs.project.common.exception.LoginRequiredException;
import com.itwillbs.project.store.dto.MemberProductDTO;
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
	public String userStore(Model model, HttpSession session) {
		String userEmail = (String)session.getAttribute("sId");
		
		// 회원 아이디 조회
		MemberDTO userInfo = storeService.getUserInfo(userEmail);
		
//		model.addAttribute("userId", userInfo.getUserId());
		
		session.setAttribute("userInfo", userInfo);
		
		return "store/userStore";
	}
	
	// 기업 요금제
	@GetMapping("/cstore")
	public String comStore(Model model, HttpSession session) {
		String userEmail = (String)session.getAttribute("sId");

		// 회원 아이디 조회
		MemberDTO comInfo = storeService.getUserInfo(userEmail);
//		model.addAttribute("userId", comInfo.getUserId());

		session.setAttribute("comInfo", comInfo);
		
		return "store/comStore";
	}
	
	// 이미 이용권을 보유하고 있는 회원은 이용권이 만료되어야 추가 구매 가능
	// 보유한 이용권 정보 전달
	@ResponseBody
	@GetMapping("/checkRemain")
	public Map<String, Object> checkRemain(@RequestParam long id, HttpSession session) {
		// 로그인 된 회원만 구매하기 페이지 접근 가능
		if(id == 0) { 
			throw new LoginRequiredException("로그인 후 구매할 수 있습니다.");
		}
		
		// 구매자의 회원 유형 확인
		MemberDTO memberInfo = storeService.getUserType(id);
		
		boolean exists = false;
		String posibillity = null;
		
		if(memberInfo.getUserType().equals("구직자 회원")) { // 구직자 회원
			// 구매자가 이용권을 보유하고 있고, 만료되지 않았는지 확인
			exists = storeService.getUserRemain(id);
			
		} else { // 기업회원
			// 구매자가 이용권을 보유하고 있고, 만료되지 않았는지 확인
			MemberProductDTO comProduct = storeService.getComRemain(id);
			
			if(comProduct != null) { // 일반/프리미엄 중 하나라도 가지고 있는 경우
				
				if(comProduct.getProductId().equals("P-C1")) { // 일반 이용권을 가지고 있는 경우
					posibillity ="basic";
					
				} else { // 프리미엄 이용권을 가지고 있는 경우
					posibillity ="premium";
				}
				
			} else { // 이용권이 없는 경우(둘다 구매 가능)
				posibillity = "none";
			}
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("exists", exists);
		result.put("posibillity", posibillity);
		
		return result;
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
	@ResponseBody 
	@PostMapping(value = "/payResponse", produces = "application/json; charset=UTF-8")
	public String payResult(@RequestBody ResponsePaymentDTO responsePaymentDTO
							, Model model
							, PaymentDTO paymentDTO
							, HttpSession session
							, OrderDTO orderDTO) {
		
		OrderDTO order = (OrderDTO) session.getAttribute("orderDTO");
		StoreDTO store = (StoreDTO) session.getAttribute("storeDTO");
		
		session.removeAttribute("orderDTO");
		session.removeAttribute("storeDTO");
		 
		// 주문 정보 삽입 
		storeService.setOrderInfo(order, store);
		
		// 1️ PortOne 서버에서 결제 정보 조회
	    // 클라이언트에서 넘어온 paymentId를 이용해서 실제 결제 정보 확인
	    PortoneDTO paymentInfo = storeService.getPayment(responsePaymentDTO.getPaymentId());
	    
	    // 해당 구매번호와 일치하는 주문 정보 조회
	    OrderDTO orderInfo = storeService.findByPaymentId(responsePaymentDTO.getPaymentId());
	    
	    // 2️ 결제 금액 검증
	    // PortOne 서버에서 받은 결제 금액(paymentInfo.getAmount)와 DB 주문 금액(orderInfo.getProductPrice)이 일치하는지 확인
	    if(paymentInfo.getAmount().getTotal() != orderInfo.getProductPrice()) {
	        // 금액 불일치 시 결제 실패 처리
	        return "mismatch"; 
	    } 
	    
	    // (기업회원의 경우) 일반 이용권 보유 유무 조회
	    MemberProductDTO memberProductDTO = storeService.getMemberProduct(orderInfo.getUserId());
	     
	    // 결제 내역에 저장
	    paymentDTO.setPayId(responsePaymentDTO.getPaymentId());
	    paymentDTO.setUserId(orderInfo.getUserId());          
	    paymentDTO.setProductId(orderInfo.getProductId());    
	    
	    System.out.println("상태 : " + paymentInfo.getStatus());
	    System.out.println("수단 : " + paymentInfo.getMethod().getType());
	    System.out.println("계좌 : " + paymentInfo.getMethod().getBank());
	    
	    // 카드 결제 시
	    if(paymentInfo.getMethod().getType().equals("PaymentMethodCard")) {
	    	if(paymentInfo.getStatus().equals("PAID")) {
	    		// 결제 성공 상태(PAID)인 경우
		    	orderInfo.setStatus("PAID");       			// 주문 상태를 PAID로 업데이트
		        storeService.setOrderStatus(orderInfo);     // DB 반영
		        
		        // 결제 내역에 저장
//			    paymentDTO.setPayId(responsePaymentDTO.getPaymentId());
//			    paymentDTO.setUserId(orderInfo.getUserId());          
//			    paymentDTO.setProductId(orderInfo.getProductId());    
			    paymentDTO.setPayMethod("신용카드");
			    paymentDTO.setCardName(paymentInfo.getMethod().getCard().getName());
			    paymentDTO.setCardNum(paymentInfo.getMethod().getCard().getNumber() + "**********");
			    paymentDTO.setPayDate(paymentInfo.getPaidAt());
			    paymentDTO.setPayPrice(paymentInfo.getAmount().getTotal());
			    paymentDTO.setPayStatus(paymentInfo.getStatus());
			    
			    // 결제 테이블에 주문 정보 저장
			    storeService.setPaymentInfo(paymentDTO);
			    
			    // 이용권 테이블에 구매자의 이용권 정보 저장
			    if(orderInfo.getUserType() == 'P') {
			    	storeService.setUserProduct(paymentDTO);
			    } else if(orderInfo.getUserType() == 'C') {
			    	storeService.setComProduct(paymentDTO);
			    }
			    
			    // 만약, 일반 이용권을 보유중인 기업회원이 프리미엄 이용권을 구매한 경우 일반 이용권은 소멸됨
			    if(paymentDTO.getProductId().equals("P-C2") && memberProductDTO.getUserId() == paymentDTO.getUserId()) {
			    	storeService.changeUseStatus(memberProductDTO.getPayId());
			    }
		     
		    	return "success";     // 결제 성공 페이지 반환
		    	
	    	} else {
	    		return "fail";	// 결제 실패 페이지 반환
	    	}

	    } else if(paymentInfo.getMethod().getType().equals("PaymentMethodVirtualAccount")) {
	    	
	    	 if(paymentInfo.getStatus().equals("VIRTUAL_ACCOUNT_ISSUED")) {
	    		// 입금계좌가 발급된 경우(입금대기)
				orderInfo.setStatus("READY");       			// 주문 상태를 PAID로 업데이트
				storeService.setOrderStatus(orderInfo); 
	    		
	    		paymentDTO.setPayMethod("가상계좌");
		    	paymentDTO.setBankName(paymentInfo.getMethod().getBank());
		    	paymentDTO.setDepositAccount(paymentInfo.getMethod().getAccountNumber());
			    paymentDTO.setIssuedAt(paymentInfo.getMethod().getIssuedAt());
			    paymentDTO.setExpiredAt(paymentInfo.getMethod().getExpiredAt());
			    paymentDTO.setPayPrice(paymentInfo.getAmount().getTotal());
			    paymentDTO.setPayStatus("READY");
			    
			    // 결제 테이블에 주문 정보 저장
			    storeService.setPaymentInfo(paymentDTO);
			    
			    return "success";
			    
	    	} else if(paymentInfo.getStatus().equals("PAID")) {
	    		// 결제 성공 상태(PAID)인 경우
		    	orderInfo.setStatus("PAID");       			// 주문 상태를 PAID로 업데이트
		        storeService.setOrderStatus(orderInfo);     // DB 반영
		        
		        // 결제 내역에 저장
		    	paymentDTO.setDepositName(paymentInfo.getMethod().getRemitterName());
			    paymentDTO.setPayDate(paymentInfo.getPaidAt());
			    paymentDTO.setPayStatus("PAID");

			    // 결제 내역에 반영
			    storeService.changeVirtualAccountInfo(paymentDTO.getDepositName()
			    									, paymentDTO.getPayDate()
			    									, paymentDTO.getPayStatus()
			    									, paymentDTO.getUserId());
			    
			    // 이용권 테이블에 구매자의 이용권 정보 저장
			    if(orderInfo.getUserType() == 'P') {
			    	storeService.setUserProduct(paymentDTO);
			    } else if(orderInfo.getUserType() == 'C') {
			    	storeService.setComProduct(paymentDTO);
			    }
			    
			    // 만약, 일반 이용권을 보유중인 기업회원이 프리미엄 이용권을 구매한 경우 일반 이용권은 소멸됨
			    if(paymentDTO.getProductId().equals("P-C2") && memberProductDTO.getUserId() == paymentDTO.getUserId()) {
			    	storeService.changeUseStatus(memberProductDTO.getPayId());
			    }
		     
		    	return "success";     // 결제 성공 페이지 반환
		    	
	    	} else {
	    		
	    		return "fail";
	    	}
	    }
	     
//	    // 3️ 카드 결제 처리
//	    if("PAID".equals(paymentInfo.getStatus())) {
//	        // 결제 성공 상태(PAID)인 경우
//	    	orderInfo.setStatus("PAID");       			// 주문 상태를 PAID로 업데이트
//	        storeService.setOrderStatus(orderInfo);     // DB 반영
//	        
//	        // 결제 수단 비교
//		    if(paymentInfo.getMethod().getType().equals("CARD")) {
//			    paymentDTO.setPayMethod("신용카드");
//			    paymentDTO.setCardName(paymentInfo.getMethod().getCard().getName());
//			    paymentDTO.setCardNum(paymentInfo.getMethod().getCard().getNumber() + "**********");
//			    paymentDTO.setPayDate(paymentInfo.getPaidAt());
//
//		    } else {
//		    	paymentDTO.setPayMethod("가상계좌");
//		    	paymentDTO.setBankName(paymentInfo.getMethod().getVirtualAccount().getBank());
//		    	paymentDTO.setDepositAccount(paymentInfo.getMethod().getVirtualAccount().getAccountNumber());
//		    	paymentDTO.setDepositName(paymentInfo.getMethod().getVirtualAccount().getRemitterName());
//		    	paymentDTO.setPayDate(paymentInfo.getPaidAt());
//		    	
//		    	
//		    }
//	    
//		    // 결제 내역에 저장
////		    paymentDTO.setPayId(responsePaymentDTO.getPaymentId());
////		    paymentDTO.setUserId(orderInfo.getUserId());          
////		    paymentDTO.setProductId(orderInfo.getProductId());    
////		    paymentDTO.setPayMethod("신용카드");
////		    paymentDTO.setCardName(paymentInfo.getMethod().getCard().getName());
////		    paymentDTO.setCardNum(paymentInfo.getMethod().getCard().getNumber() + "**********");
////		    paymentDTO.setPayDate(paymentInfo.getPaidAt());
//		    paymentDTO.setPayPrice(paymentInfo.getAmount().getTotal());
//		    paymentDTO.setPayStatus(paymentInfo.getStatus());
//		    
//		    // 결제 테이블에 주문 정보 저장
//		    storeService.setPaymentInfo(paymentDTO);
//		    
//		    // 이용권 테이블에 구매자의 이용권 정보 저장
//		    if(orderInfo.getUserType() == 'P') {
//		    	storeService.setUserProduct(paymentDTO);
//		    } else if(orderInfo.getUserType() == 'C') {
//		    	storeService.setComProduct(paymentDTO);
//		    }
//		    
//		    // 만약, 일반 이용권을 보유중인 기업회원이 프리미엄 이용권을 구매한 경우 일반 이용권은 소멸됨
//		    if(paymentDTO.getProductId().equals("P-C2") && memberProductDTO.getUserId() == paymentDTO.getUserId()) {
//		    	storeService.changeUseStatus(memberProductDTO.getPayId());
//		    }
//	     
//	    	return "success";     // 결제 성공 페이지 반환
//	    	
//	    } else { // 가상계좌 - 미입금 시
//	    	orderInfo.setStatus("READY");       		// 주문 상태를 READY로 업데이트
//	        storeService.setOrderStatus(orderInfo);    // DB 반영
//	        
//	        paymentDTO.setPayMethod("가상계좌");
//	        paymentDTO.setBankName(paymentInfo.getMethod().getVirtualAccount().getBank());
//	        paymentDTO.setDepositAccount(paymentInfo.getMethod().getVirtualAccount().getAccountNumber());
//	    	paymentDTO.setDepositName(paymentInfo.getMethod().getVirtualAccount().getRemitterName());
//	        
//	        storeService.setPaymentInfo(paymentDTO);
//	    }
//
	    // 위의 경우 외 실패 처리
	    return "fail";
	}

	
	// 결제에 성공한 경우
	@GetMapping("/paySuccess")
	public String paySuccess(){
		
		return "store/paySuccess";
	}
	
	
	// 결제에 실패한 경우
	@GetMapping("/payFailed")
	public String payFailed() {
		
		return "store/payFailed";
	}
	
 
}























