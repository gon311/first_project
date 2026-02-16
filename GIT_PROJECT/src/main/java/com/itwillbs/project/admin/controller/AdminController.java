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
import com.itwillbs.project.admin.dto.SearchDTO;
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
	// 구독자 관리 페이지
	@GetMapping("/users")
	public String userList(@RequestParam(value="tab", defaultValue="all") String tab
							, Model model
							, SearchDTO searchDTO) {
		// tab 파라미터가 없으면 기본값 "all"로 설정됨
		model.addAttribute("activeTab", tab);
		
		
		if(searchDTO.getUser_name() != null || 
			searchDTO.getUser_type() != null || 
			searchDTO.getStatus() != null) {
			
			List<MemberDTO> memberDTO = adminService.getUserFilter(searchDTO.getUser_name()
																	, searchDTO.getUser_type()
																	, searchDTO.getStatus());
			
			model.addAttribute("memberList", memberDTO);
	   
		} else {
			
			List<MemberDTO> memberList = adminService.getUser();
			model.addAttribute("memberList", memberList);
		}
			
		 
		return "admin/member/UserList";
			
	}
	
	// 조건별 검색(구현중)
	@PostMapping("/search")
	public String userSearch(SearchDTO searchDTO, RedirectAttributes ra) {
		ra.addAttribute("user_name", searchDTO.getUser_name());
		ra.addAttribute("user_type", searchDTO.getUser_type());
		ra.addAttribute("status", searchDTO.getStatus());
		
		return "redirect:/admin/users";
	}
	
	// 구독자 상세정보
	@GetMapping("/info")
	public String userInfo(BigInteger idx, Model model, MemberDTO dto) {
		dto.setUser_id(idx);
		MemberDTO userDTO = adminService.getUserInfo(dto.getUser_id());
		
		model.addAttribute("user", userDTO);
		
		return "admin/member/UserInfo";
	}
	
	//===========================================================================
	// 제출된 공고 관리
	@GetMapping("/submits")
	public String submitList() {
		return "admin/submit/SubmitList";
	}
	
	
	//===========================================================================
	// 결제 내역
	@GetMapping("/payments")
	public String payList() {
		return "admin/pay/PayList"; 
	}
	
	@GetMapping("/banners")
	public String bannerList() {
		return "admin/banner";
	}
	
	@GetMapping("/data")
	public String dataList() {
		return "admin/data";
	}
	
	
	
}