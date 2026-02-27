package com.itwillbs.project.store.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.project.store.dto.OrderDTO;
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
	public String pay(StoreDTO storeDTO, Model model, HttpSession session, OrderDTO orderDTO) {
		// 세션에 저장된 id값을 통해 구매자 정보 출력(구현 예정)
		String sId = (String)session.getAttribute("sId");
		
		// 구매자 정보 조회
		OrderDTO orderInfo = storeService.getOrderUser(sId);
		model.addAttribute("orderInfo", orderInfo);
		
		// 상품 정보
		StoreDTO storeInfo = storeService.getStoreInfo(storeDTO.getProductId());
		model.addAttribute("storeInfo", storeInfo);
		
		return "store/payForm";
	}
	
	
}