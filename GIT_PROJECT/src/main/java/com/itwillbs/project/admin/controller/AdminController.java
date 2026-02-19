package com.itwillbs.project.admin.controller;

import java.math.BigInteger;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.project.admin.dto.MemberDTO;
import com.itwillbs.project.admin.dto.PayDTO;
import com.itwillbs.project.admin.dto.SearchDTO;
import com.itwillbs.project.admin.dto.SubmitDTO;
import com.itwillbs.project.admin.service.AdminService;

import lombok.Getter;
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
	// 조건별 검색(구현중)
	@PostMapping("/users")
	public String userSearch(SearchDTO searchDTO, RedirectAttributes ra) {
		ra.addAttribute("keyword", searchDTO.getKeyword());
		ra.addAttribute("type", searchDTO.getType());
		ra.addAttribute("status", searchDTO.getStatus());
		System.out.println("searchDTO : " + searchDTO);
		
		return "redirect:/admin/users";
	}
	
	// 구독자 관리 페이지
	@GetMapping("/users")
	public String userList(@RequestParam(value="tab", defaultValue="all") String tab
							, Model model
							, SearchDTO searchDTO) {
		// tab 파라미터가 없으면 기본값 "all"로 설정됨
		model.addAttribute("activeTab", tab); 
		System.out.println("searchDTO 전송 : " + searchDTO);
		List<MemberDTO> userList = adminService.getUserFilter(searchDTO.getKeyword()
																, searchDTO.getType()
																, searchDTO.getStatus());
		model.addAttribute("userList", userList);
		
		 
		return "admin/member/UserList";
			
	}
	
	
	// 구독자 상세정보
	@GetMapping("/info")
	public String userInfo(Model model, MemberDTO dto) {
		System.out.println("dto.getId : " + dto.getId());
		MemberDTO userDTO = adminService.getUserInfo(dto.getId());
		System.out.println("userDTO : " + userDTO);
		
		model.addAttribute("user", userDTO);
		
		return "admin/member/UserInfo";
	}
	
	// 구독자 차단(구현중)
	@GetMapping("/block")
	public String userBlock(MemberDTO dto, RedirectAttributes ra) {
		System.out.println("id : " + dto.getId());
//		adminService.blockUser(dto.getId(), dto.getStatus());
		ra.addAttribute("id", dto.getId());
		
		return "redirect:/admin/info";
	}
	
	//===========================================================================
	// 기업회원 관리 페이지
	@GetMapping("/coms")
	public String comList(@RequestParam(value="tab", defaultValue="all") String tab
							, Model model
							, SearchDTO searchDTO) {
		// tab 파라미터가 없으면 기본값 "all"로 설정됨
		model.addAttribute("activeTab", tab);
		
		
		if(searchDTO.getKeyword() != null || 
			searchDTO.getType() != null || 
			searchDTO.getStatus() != null) {
			
			List<MemberDTO> comDTO = adminService.getUserFilter(searchDTO.getKeyword()
																	, searchDTO.getType()
																	, searchDTO.getStatus());
			
			model.addAttribute("comList", comDTO);
	   
		} else {
			
			List<MemberDTO> comList = adminService.getUser();
			model.addAttribute("comList", comList);
		}
			
		 
		return "admin/member/ComList";
			
	}
	
	//===========================================================================
	// 제출된 공고 관리(보류)
	@GetMapping("/submits")
	public String submitList(SubmitDTO submitDTO, Model model) {
//		List<SubmitDTO> submitList = adminService.getSubmitList(submitDTO);
//		model.addAttribute("submitList", submitList);
		
		return "admin/submit/SubmitList";
	}
	
	
	//===========================================================================
	// 결제 내역
	@GetMapping("/payments")
	public String payList(PayDTO payDTO, Model model) {
		List<PayDTO> payList = adminService.getPayList(payDTO);
		model.addAttribute("payList", payList);
		
		return "admin/pay/PayList"; 
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