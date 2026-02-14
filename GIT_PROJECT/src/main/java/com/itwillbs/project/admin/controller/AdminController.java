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

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
@Log4j2
public class AdminController {
	@Autowired
	private AdminService adminService;
	
	// 구독자 관리 페이지
	@GetMapping("/users")
	public String userList(@RequestParam(value="tab", defaultValue="all") String tab
							, Model model
							, SearchDTO searchDTO) {
		// tab 파라미터가 없으면 기본값 "all"로 설정됨
	    model.addAttribute("activeTab", tab);
	    
//	    String user_name = null;
//	    String user_type = null;
//	    String status = null;
//	    
//	    if(searchDTO.getName() != null) {
//	    	user_name = searchDTO.getName();
//	    }
//	    if(searchDTO.getType() != null) {
//	    	user_type = searchDTO.getType();
//	    }
//	    if(searchDTO.getStatus() != null) {
//	    	status = searchDTO.getStatus();
//	    }
	    
	    
	    
	    if(searchDTO.getUser_name() != null || searchDTO.getUser_type() != null || searchDTO.getStatus() != null) {
	    	List<MemberDTO> memberDTO = adminService.getUserFilter(searchDTO.getUser_name()
	    			, searchDTO.getUser_type(), searchDTO.getStatus());
	    	
	    	model.addAttribute("memberList", memberDTO);
	   
	    } else {
	    	List<MemberDTO> memberList = adminService.getUser();
	    	model.addAttribute("memberList", memberList);
	    }
	    	
    	 
    	return "admin/member/UserList";
	    	
	    
	    
//	    System.out.println("name === " + searchDTO.getUser_name());
//	    System.out.println("type === " + searchDTO.getUser_type());
//	    System.out.println("status === " + searchDTO.getStatus());
	    
	}
	
	// 조건별 검색
	@PostMapping("/search")
	public String userSearch(SearchDTO searchDTO, RedirectAttributes ra) {
//		System.out.println("name11 === " + searchDTO.getUser_name());
//	    System.out.println("type11 === " + searchDTO.getUser_type());
//	    System.out.println("status11 === " + searchDTO.getStatus());
		
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
}
