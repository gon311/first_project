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

import com.itwillbs.project.comMy.dto.ComJobRowDTO;
import com.itwillbs.project.comMy.dto.ComMyDTO;
import com.itwillbs.project.comMy.dto.JobCond;
import com.itwillbs.project.comMy.dto.PaymentCond;
import com.itwillbs.project.comMy.dto.PaymentDTO;
import com.itwillbs.project.comMy.service.ComMyService;
import com.itwillbs.project.common.paging.PageRes;
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
	public String job(HttpSession session, Model model,
					  @RequestParam(required = false) String q,
					  @RequestParam(defaultValue = "all") String status,
					  @RequestParam(defaultValue = "1") int page,	// 페이지
					  @RequestParam(defaultValue = "5") int size	// 페이지 크기
					  ) {
	 
	    //로그인 체크
	    String sId = (String) session.getAttribute("sId"); 
	    if (sId == null) return "redirect:/user/login";
	    
	    model.addAttribute("currentMenu", "job");
	    
	    ComMyDTO user = comMyService.getUser(sId);
	    
	    //페이징
	    JobCond cond = new JobCond();
	    cond.setUserId(user.getUserId());
	    cond.setStatus(status);
	    cond.setQ(q);
	    
	    
	    cond.getPage().setPage(page);
	    cond.getPage().setSize(size);
	    
	    // 조회
	    List<ComJobRowDTO> list = comMyService.getJopList(cond);
	    int total = comMyService.getJopCount(cond);
	    
	    PageRes pager = PageRes.of(cond.getPage(), total);
	    
	    
	    // 페이징 응답
	    model.addAttribute("jobs", list);
	    model.addAttribute("pager", pager);
	    
	    // 화면 필터유지
	    model.addAttribute("status", status);
	    model.addAttribute("q", q);
	    
	    return "/comMy/job";
	}
	
	
	// 결제내역
	@GetMapping("/payment")
	public String payment(HttpSession session, 
						  Model model,
						  @RequestParam(defaultValue = "3m") String period,	// 목록(3개월전)
						  @RequestParam(defaultValue = "all") String status, //상태
						  @RequestParam(defaultValue = "") String q, //상태
						  @RequestParam(defaultValue = "1") int page,	// 페이지
						  @RequestParam(defaultValue = "5") int size	// 페이지 크기
						  ) {
	 
	    //로그인 체크
	    String sId = (String) session.getAttribute("sId"); 
	    if (sId == null) return "redirect:/user/login";
	    
	    model.addAttribute("currentMenu", "payment"); // 사이드바 '결제 내역' 활성
	    
	    ComMyDTO user = comMyService.getUser(sId);
	    model.addAttribute("loginUser", user);
	    
	    PaymentCond cond = new PaymentCond();
	    cond.setUserId(user.getUserId());
	    cond.setPeriod(period);
	    cond.setStatus(status);
	    cond.setQ(q);
	    
	    // ✅ 공통 PageReq로 세팅
	    cond.getPage().setPage(page);
	    cond.getPage().setSize(size);
	    
	    // 조회
	    List<PaymentDTO> payments = comMyService.getPaymentList(cond);
	    int total = comMyService.getPaymentCount(cond);
	    
	    // ✅ 페이징 응답
	    PageRes pager = PageRes.of(cond.getPage(), total);
	    
	    model.addAttribute("payments", payments);
	    model.addAttribute("pager", pager);
	    
	    // 화면에서 필터 값 유지
	    model.addAttribute("period", period);
	    model.addAttribute("status", status);
	    model.addAttribute("q", q);
	    

	    return "/comMy/payment";
	}
	

	
	
}
