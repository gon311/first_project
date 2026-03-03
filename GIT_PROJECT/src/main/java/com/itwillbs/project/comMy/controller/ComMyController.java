package com.itwillbs.project.comMy.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.project.comMy.dto.ComMyDTO;
import com.itwillbs.project.comMy.service.ComMyService;
import com.itwillbs.project.my.dto.MyDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Controller
@RequestMapping("/comMy")
@Log4j2
@RequiredArgsConstructor
public class ComMyController {
	@Autowired
	private ComMyService comMyService;
	
	// 마이페이지 내정보
	@GetMapping("/info")
	public String myInfo(HttpSession session, Model model, ComMyDTO comMyDTO) {
	 
	    //로그인 체크
	    String sId = (String) session.getAttribute("sId"); 
	    if (sId == null) return "redirect:/user/login";
	    
	    model.addAttribute("currentMenu", "info");
	    ComMyDTO user = comMyService.getUser(sId);
	    model.addAttribute("loginUser", user);



	    return "/comMy/info";
	}
	
	// 공고관리
	@GetMapping("/job")
	public String job(HttpSession session, Model model, ComMyDTO comMyDTO) {
	 
	    //로그인 체크
	    String sId = (String) session.getAttribute("sId"); 
	    if (sId == null) return "redirect:/user/login";
	    
	    model.addAttribute("currentMenu", "job");

	    return "/comMy/job";
	}
	
	
	// 결제내역
	@GetMapping("/payment")
	public String payment(HttpSession session, Model model, ComMyDTO comMyDTO) {
	 
	    //로그인 체크
	    String sId = (String) session.getAttribute("sId"); 
	    if (sId == null) return "redirect:/user/login";
	    
	    model.addAttribute("currentMenu", "payment");


	    return "/comMy/payment";
	}
	

	
	
}
