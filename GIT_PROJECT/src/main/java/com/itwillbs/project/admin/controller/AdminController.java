package com.itwillbs.project.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.project.admin.dto.JobPostDTO;
import com.itwillbs.project.admin.dto.MemberDTO;
import com.itwillbs.project.admin.dto.PayDTO;
import com.itwillbs.project.admin.dto.ProductDTO;
import com.itwillbs.project.admin.dto.SearchDTO;
import com.itwillbs.project.admin.dto.SubmitDTO;
import com.itwillbs.project.admin.service.AdminService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
@Log4j2
public class AdminController {
	@Autowired
	private AdminService adminService;
	
	//=============================================================
	// [ 구직자 관리 페이지 ]
	// 구직자 회원 목록(정렬 구현중)
	@GetMapping("/users")
	public String userList(@RequestParam(name="activeTab", defaultValue="all") String activeTab
							, Model model
							, SearchDTO searchDTO
							, String sort) {
		// tab 파라미터가 없으면 기본값 "all"로 설정됨
		model.addAttribute("activeTab", activeTab); 
		//-----------------------------------------------------
		// 전체 회원 목록 조회
		List<MemberDTO> userList = adminService.getUserList(searchDTO.getKeyword()
															, searchDTO.getType()
															, searchDTO.getStatus());
		model.addAttribute("userList", userList);
		
		// 탈퇴 회원 목록 조회
		List<MemberDTO> userWithdraw = adminService.getUserWithdraw(searchDTO.getKeyword()
																	, searchDTO.getStartDate()
																	, searchDTO.getEndDate());
		model.addAttribute("userWithdraw", userWithdraw);
		
		return "admin/member/userList";
			
	}
	
	// 구직자 상세정보
	@GetMapping("/users/info")
	public String userInfo(Model model, MemberDTO memberDTO) {
		MemberDTO userDTO = adminService.getUserInfo(memberDTO.getUserId());
		
		model.addAttribute("user", userDTO);

		return "admin/member/userInfo";
		
	}
	
	// 구직자 차단
	@GetMapping("/users//block")
	public String userBlock(MemberDTO memberDTO, RedirectAttributes ra) {
		adminService.blockUser(memberDTO.getUserId());
		ra.addAttribute("userId", memberDTO.getUserId());
		
		return "redirect:/admin/users/info";
	}
	
	// 구직자 차단 해제
	@GetMapping("/users/unblock")
	public String userUnBlock(MemberDTO memberDTO, RedirectAttributes ra) {
		adminService.unblockUser(memberDTO.getUserId());
		ra.addAttribute("userId", memberDTO.getUserId());
		
		return "redirect:/admin/users/info";
	}
	
	// 구직자 회원 삭제(탈퇴 후 3년이 지난 경우)
	@GetMapping("/users/delete")
	public String userDelete(MemberDTO memberDTO) {
		adminService.deleteUser(memberDTO.getUserId());
		
		return "redirect:/admin/users";
	}
	
	
	//===========================================================================
	// [ 기업회원 관리 페이지 ]
	// 기업회원 목록 조회
	@GetMapping("/coms")
	public String comList(@RequestParam(defaultValue="all") String activeTab
							, Model model
							, SearchDTO searchDTO) {
		// tab 파라미터가 없으면 기본값 "all"로 설정됨
		model.addAttribute("activeTab", activeTab); 
		//-----------------------------------------------------------
		// 전체 회원 목록 조회
		List<MemberDTO> comList = adminService.getComList(searchDTO.getKeyword()
														, searchDTO.getType()
														, searchDTO.getStatus());
		model.addAttribute("comList", comList);
		
		// 탈퇴 회원 목록 조회
		List<MemberDTO> comWithdraw = adminService.getComWithdraw(searchDTO.getKeyword()
																, searchDTO.getStartDate()
																, searchDTO.getEndDate());
		model.addAttribute("comWithdraw", comWithdraw);
		 
		return "admin/member/comList";
			
	}
	
	// 기업회원 상세 정보
	@GetMapping("/coms/info")
	public String comInfo(Model model, MemberDTO memberDTO) {
		
		MemberDTO comDTO = adminService.getComInfo(memberDTO.getUserId());
		
		model.addAttribute("com", comDTO);
		
		return "admin/member/comInfo";
			
	}
	
	// 기업회원 차단
	@GetMapping("/coms/block")
	public String comBlock(MemberDTO memberDTO, RedirectAttributes ra) {
		adminService.blockUser(memberDTO.getUserId());
		ra.addAttribute("userId", memberDTO.getUserId());
		
		return "redirect:/admin/coms/info";
	}
	
	@GetMapping("/coms/unblock")
	public String comUnBlock(MemberDTO memberDTO, RedirectAttributes ra) {
		adminService.unblockUser(memberDTO.getUserId());
		ra.addAttribute("userId", memberDTO.getUserId());
		
		return "redirect:/admin/coms/info";
	}
	
	//===========================================================================
	// [ 제출된 공고 관리 ](상세정보 구현 예정)
	// 제출된 공고 목록 조회
	@GetMapping("/submits")
	public String submitList(SubmitDTO submitDTO, Model model, SearchDTO searchDTO) {
		
		List<SubmitDTO> submitList = adminService.getSubmitList(searchDTO.getStartDate()
																, searchDTO.getEndDate()
																, searchDTO.getKeyword()
																, searchDTO.getSubmitStatus());
		
		model.addAttribute("submitList", submitList);
		
		return "admin/submit/submitList";
	}
	
	// 제출된 공고 상세정보 조회
	@GetMapping("/submits/info")
	public String submitInfo(Model model, MemberDTO memberDTO, SubmitDTO submitDTO) {
		// 제출된 공고 상세 내용
		SubmitDTO submitInfo = adminService.getSubmitInfo(submitDTO.getJobId());
		
		model.addAttribute("submit", submitInfo);
		
		// 공고를 제출한 기업 정보
		MemberDTO comDTO = adminService.getComInfo(memberDTO.getUserId());
		
		model.addAttribute("com", comDTO);
		
		return "admin/submit/submitInfo";
		
	}
	
	
	// 공고 상태 변경
	@GetMapping("/submits/status")
	public String submitStatus(long jobId, Integer postCheck, RedirectAttributes ra) {
		SubmitDTO submitDTO = adminService.getSubmitInfo(jobId);
		adminService.changeSubmitStatus(submitDTO.getJobId(), postCheck);
		
		ra.addAttribute("jobId", jobId);
		ra.addAttribute("userId", submitDTO.getCompId());
		
		return "redirect:/admin/submits/info";
	}
	
	 
	
	//===========================================================================
	// [ 결제 관리 ]
	// 결제 내역 목록 조회
	@GetMapping("/payments")
	public String payList(PayDTO payDTO, Model model, SearchDTO searchDTO) {
		List<PayDTO> payList = adminService.getPayList(searchDTO.getStartDate()
													, searchDTO.getEndDate()
													, searchDTO.getKeyword()
													, searchDTO.getUserType()
													, searchDTO.getPayStatus());
		model.addAttribute("payList", payList);
		
		return "admin/payment/payList"; 
	}
	
	// 결제 내역 상세정보 조회
	@GetMapping("/payments/info")
	public String payInfo(Model model, PayDTO payDTO) {
		PayDTO payInfo = adminService.getPayInfo(payDTO.getPayId());
		
		model.addAttribute("pay", payInfo);
		
		
		return "admin/payment/payInfo";
		
	}
	
	// 결제 취소
	@GetMapping("/payments/cancel")
	public String payCancel(long payId, RedirectAttributes ra) {
		adminService.changePayCancel(payId);
		ra.addAttribute("payId", payId);
		
		return "redirect:/admin/payments/info";
	}
	
	//-----------------------------------------
	// (사용자 페이지와 매핑 필요)
	// 기업요금제(보류) 
	@GetMapping("/cstore")
	public String comStore() {
		return "admin/store/comStore";
	}
	// 구직자요금제(보류)
	@GetMapping("/ustore")
	public String userStore() {
		return "admin/store/userStore";
	}
	
	// 구매하기(보류)
	@GetMapping("/pay")
	public String pay(String sId, ProductDTO productDTO, Model model) {
		// 세션에 저장된 id값을 통해 구매자 정보 출력
		
		// 상품 정보
		ProductDTO productInfo = adminService.getProductInfo(productDTO.getProductId());
		model.addAttribute("product", productInfo);
		
		return "admin/pay/payForm";
	}
	
	//===========================================================================
	// 배너 관리
	@GetMapping("/banners")
	public String bannerList() {
		return "admin/banner";
	}
	
	//===========================================================================
	// 데이터 관리
	@GetMapping("/data")
	public String dataList() {
		return "admin/data";
	}
	
	
}