package com.itwillbs.project.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.project.admin.dto.BannerDTO;
import com.itwillbs.project.admin.dto.CommentDTO;
import com.itwillbs.project.admin.dto.FreeDTO;
import com.itwillbs.project.admin.dto.JobPostDTO;
import com.itwillbs.project.admin.dto.MemberDTO;
import com.itwillbs.project.admin.dto.PaymentPageDTO;
import com.itwillbs.project.admin.dto.QnaDTO;
import com.itwillbs.project.admin.dto.SearchDTO;
import com.itwillbs.project.admin.dto.SubmitDTO;
import com.itwillbs.project.admin.dto.SubmitPageDTO;
import com.itwillbs.project.admin.dto.UserPageDTO;
import com.itwillbs.project.admin.service.AdminService;
import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.store.dto.PaymentDTO;

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
	public String userList(@RequestParam(defaultValue="all") String activeTab
							, @RequestParam(defaultValue="1") Integer pageNum
							, Model model  
							, SearchDTO searchDTO
							, String sort) {
		// tab 파라미터가 없으면 기본값 "all"로 설정됨
		model.addAttribute("activeTab", activeTab); 
		//-----------------------------------------------------
		// 전체 회원 목록 조회
//		String keyword = searchDTO.getKeyword().trim();
		
		UserPageDTO userPageDTO = adminService.getUserList(searchDTO.getKeyword()
															, searchDTO.getType()
															, searchDTO.getStatus()
															, sort
															, pageNum);
		
		model.addAttribute("userList", userPageDTO.getUserList());
		model.addAttribute("pageInfo", userPageDTO.getPageInfoDTO()); 
			
		// 탈퇴회원 조회
		UserPageDTO userWithdrawPageDTO = adminService.getUserWithdraw(searchDTO.getKeyword()
																		, searchDTO.getStartDate()
																		, searchDTO.getEndDate()
																		, sort
																		, pageNum);
		
		model.addAttribute("userWithdraw", userWithdrawPageDTO.getUserList());
		model.addAttribute("withdrawPageInfo", userWithdrawPageDTO.getPageInfoDTO());
		
		
		return "admin/member/userList";
			
	}
	 
	// 구직자 상세정보
	@GetMapping("/users/info")
	public String userInfo(Model model, MemberDTO memberDTO) {
		MemberDTO userDTO = adminService.getUserInfo(memberDTO.getUserId());
		
		// 회원이 보유한 이용권이 없을 경우
		if(userDTO.getProductName() == null) {
			userDTO.setProductName("보유 이용권 없음");
		} 
		
		model.addAttribute("user", userDTO);
		
		// 작성한 게시글 목록 조회
		// 1) 자유게시판
		List<FreeDTO> freeDTO = adminService.getFreeInfo(memberDTO.getUserId());
		model.addAttribute("freeList", freeDTO);
		
		// 2) 1대1 문의
		List<QnaDTO> qnaDTO = adminService.getQnaInfo(memberDTO.getUserId());
		model.addAttribute("qnaList", qnaDTO);
		
		// 3) 작성한 댓글 조희
		List<CommentDTO> commentDTO = adminService.getCommentInfo(memberDTO.getUserId());
		model.addAttribute("commentList", commentDTO);
		 

		return "admin/member/userInfo";
		
	}
	
	// 구직자 차단
	@GetMapping("/users/block")
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
							, @RequestParam(defaultValue="1") Integer pageNum
							, Model model
							, SearchDTO searchDTO
							, String sort) {
		// tab 파라미터가 없으면 기본값 "all"로 설정됨
		model.addAttribute("activeTab", activeTab); 
		//-----------------------------------------------------------
		// 전체 회원 목록 조회
		char userType = 'c';
		
		UserPageDTO comPageDTO = adminService.getComList(searchDTO.getKeyword()
														, searchDTO.getType()
														, searchDTO.getStatus()
														, sort
														, pageNum);
		
		model.addAttribute("comList", comPageDTO.getUserList());
		model.addAttribute("pageInfo", comPageDTO.getPageInfoDTO());
		
		// 탈퇴 회원 목록 조회
		UserPageDTO comWithdrawDTO = adminService.getComWithdraw(searchDTO.getKeyword()
																, searchDTO.getStartDate()
																, searchDTO.getEndDate()
																, sort
																, pageNum);
		
		model.addAttribute("comWithdrawList", comWithdrawDTO.getUserList());
		model.addAttribute("withdrawPageInfo", comWithdrawDTO.getPageInfoDTO());
		 
		return "admin/member/comList";
			
	}
	
	// 기업회원 상세 정보
	@GetMapping("/coms/info")
	public String comInfo(Model model, MemberDTO memberDTO) {
		
		MemberDTO comDTO = adminService.getComInfo(memberDTO.getUserId());
		
		if(comDTO.getProductName() == null) {
			comDTO.setProductName("보유 이용권 없음");
		}
		
		model.addAttribute("com", comDTO);
		
		// 회원이 작성한 글 목록 조회
		// 1) 작성한 공고 조회
		List<JobPostDTO> jobPostDTO = adminService.getJobPostInfo(memberDTO.getUserId());
		model.addAttribute("jobPostlist", jobPostDTO); 
		
		// 2) 1대1 문의
		List<QnaDTO> qnaDTO = adminService.getQnaInfo(memberDTO.getUserId());
		model.addAttribute("qnaList", qnaDTO);
		
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
	public String submitList(SubmitDTO submitDTO, Model model, SearchDTO searchDTO, String sort
								, @RequestParam(defaultValue="1") Integer pageNum) {
		
		SubmitPageDTO submitPageDTO  = adminService.getSubmitList(searchDTO.getStartDate()
																, searchDTO.getEndDate()
																, searchDTO.getKeyword()
																, searchDTO.getSubmitStatus()
																, sort
																, pageNum);
		
		model.addAttribute("submitList", submitPageDTO.getSubmitList());
		model.addAttribute("pageInfo", submitPageDTO.getPageInfoDTO());
		
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
		
		if(comDTO.getProductName() == null) {
			comDTO.setProductName("보유 이용권 없음");
		}
		
		List<FileDTO> detailFile = adminService.getFileList(submitDTO.getJobId());
		
		model.addAttribute("com", comDTO);
		model.addAttribute("detailFile", detailFile);
		
		return "admin/submit/submitInfo";
		
	}
	
	
	// 제출된 공고 처리
	@GetMapping("/submits/status")
	public String submitStatus(long jobId, Integer postCheck, RedirectAttributes ra) {
		// 공고 상태 변경
		SubmitDTO submitDTO = adminService.getSubmitInfo(jobId);
		adminService.changeSubmitStatus(submitDTO.getJobId(), postCheck);
		
		// 공고 승인 시
		if(postCheck == 2) {
			
			// 프리미엄 이용권 구매 기업 공고 배너 관리 페이지로 전송
			BannerDTO bannerDTO = new BannerDTO();
			bannerDTO.setJobId(jobId);
			bannerDTO.setCompId(submitDTO.getCompId());
			adminService.insertBanner(bannerDTO);
		}
		
		ra.addAttribute("jobId", jobId);
		ra.addAttribute("userId", submitDTO.getCompId());
		
		return "redirect:/admin/submits/info";
	}
	
	 
	
	//===========================================================================
	// [ 결제 관리 ]
	// 결제 내역 목록 조회
	@GetMapping("/payments")
	public String payList(Model model, SearchDTO searchDTO, String sort, @RequestParam(defaultValue="1") Integer pageNum) {
		PaymentPageDTO paymentPageDTO = adminService.getPayList(searchDTO.getStartDate()
													, searchDTO.getEndDate()
													, searchDTO.getKeyword()
													, searchDTO.getUserType()
													, searchDTO.getPayStatus()
													, sort
													, pageNum);
		model.addAttribute("payList", paymentPageDTO.getPaymentList());
		model.addAttribute("pageInfo", paymentPageDTO.getPageInfoDTO());
		
		return "admin/payment/payList"; 
	}
	 
	// 결제 내역 상세정보 조회
	@GetMapping("/payments/info")
	public String payInfo(Model model, PaymentDTO payDTO) {
		PaymentDTO payInfo = adminService.getPayInfo(payDTO.getPayId());
		
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
	
	
	//===========================================================================
	// [ 배너 관리 ]
	@GetMapping("/banners")
	public String bannerList(Model model, BannerDTO bannerDTO) {
		List<BannerDTO> adList = adminService.getBannerList(bannerDTO);
//		System.out.println("조회된 배너 개수: " + (adList !=null ? adList.size() : "null"));
//		System.out.println(adList.toString());
		model.addAttribute("adList", adList);
	
		return "admin/banner";
	}

	
	@PostMapping("/updateAdStatus")
	@ResponseBody
	public String updateStatus(@RequestParam("adId") int adId,
							@RequestParam("isDisplay") int isDisplay) {
		try {
			adminService.modifyAdStatus(adId, isDisplay);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		
	}
	
	//===========================================================================
// [ 데이터 관리 ]
	@GetMapping("/data")
	public String dataList() {
		return "admin/data";
	}
	
	// 1. 구직자 유형별 통계
	@GetMapping(value = "/api/user-stats"
			, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> getUserStatusApi() {
		return adminService.getUserStatistics();
	}
	
	// 2. 기업회원 유형별 통계
	@GetMapping("/api/com-stats")
	@ResponseBody
	public Map<String, Object> getComStats() {
	    return adminService.getComStatistics();
	}
	
	// 3. 구직자 결제 통계
	@GetMapping("/api/user-pay-stats")
	@ResponseBody
	public Map<String, Object> getUserPayStatsApi() {
	    return adminService.getUserPayStatistics();
	}
	// 4. 기업별 결제 통게
	@GetMapping("/api/com-pay-stats")
	@ResponseBody
	public Map<String, Object> getComPayStats() {
		return adminService.getComPayStatistics();
	}

}