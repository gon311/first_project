package com.itwillbs.project.my.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/my")
@Log4j2
@RequiredArgsConstructor
public class MyController {
	
	
	// 마이페이지 내정보
	@GetMapping("/myInfo")
	public String myInfo(Model model) {
	    model.addAttribute("currentMenu", "myInfo"); // ✅ 사이드바 active
	    return "/my/myInfo";
	}

	// 내정보 수정 화면
	@GetMapping("/updateInfo")
	public String updateInfoForm(Model model) {
	    model.addAttribute("currentMenu", "myInfo"); // ✅ 수정도 내정보 탭 active 유지
	    return "/my/updateInfo";
	}

	
	@GetMapping("/myResume")
	public String myResume(Model model) {
	    model.addAttribute("currentMenu", "resume"); // 사이드바 '이력서/자기소개서 관리' 활성
	    return "/my/myResume";
	}
	
	@GetMapping("/favorites")
	public String favorites(Model model) {
	    model.addAttribute("currentMenu", "favorites"); // 사이드바 관심목록 active
	    return "/my/favorites";
	}
	
	
	@GetMapping("/apply")
	public String applyList(Model model,
	                        @RequestParam(defaultValue="all") String tab) {

	    model.addAttribute("currentMenu", "apply");
	    model.addAttribute("currentTab", tab);

	    // TODO 나중에 숫자/리스트를 채우면 됨
	    model.addAttribute("cntAll", 0);
	    model.addAttribute("cntDone", 0);
	    model.addAttribute("cntFinal", 0);

	    return "/my/apply";
	}
	
	@GetMapping("/payment")
	public String paymentList(Model model) {
	    model.addAttribute("currentMenu", "payment"); // 사이드바 결제내역 active
	    return "/my/payment";
	}
	
	@GetMapping("/recommend")
	public String recommend(Model model) {
	    model.addAttribute("currentMenu", "recommend"); // 사이드바 active
	    return "/my/recommend";
	}


	
}
