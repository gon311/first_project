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
import com.itwillbs.project.comMy.dto.MyQnaDTO;
import com.itwillbs.project.comMy.dto.PasswordChangeDTO;
import com.itwillbs.project.comMy.dto.PaymentCond;
import com.itwillbs.project.comMy.dto.PaymentDTO;
import com.itwillbs.project.comMy.dto.QnaCond;
import com.itwillbs.project.comMy.service.ComMyService;
import com.itwillbs.project.common.paging.PageRes;


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
	
	// 내정보 수정
	@GetMapping("/updateInfo")
	public String updateInfoForm(HttpSession session, Model model) {
	    model.addAttribute("currentMenu", "info");

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login_form";

	    ComMyDTO user = comMyService.getUser(sId);
	    model.addAttribute("loginUser", user);

	    return "/comMy/updateInfo";
	}
	
	
	@PostMapping("/updateInfo")
	public String updateInfoSubmit(HttpSession session, ComMyDTO myDTO, RedirectAttributes ra, Model model) {

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login_form";
	    
	    // ------------------------------------------------------
	    // 입력값 검증
	    String userName = myDTO.getUserName() == null ? "" : myDTO.getUserName().trim();
	    String phone    = myDTO.getPhone()    == null ? "" : myDTO.getPhone().trim();

	    // 1) 빈값
	    if (userName.isEmpty() || phone.isEmpty()) {
	    	model.addAttribute("currentMenu", "info");
	        model.addAttribute("loginUser", comMyService.getUser(sId));
	        model.addAttribute("errorMsg", "이름/전화번호는 비워둘 수 없습니다.");
	        return "/comMy/updateInfo";
	    }

	    // 2) 형식 검증(이름/전화번호)
	    if (!userName.matches("^[가-힣a-zA-Z\\s]{2,20}$")) {
	    	model.addAttribute("currentMenu", "info");
	        model.addAttribute("loginUser", comMyService.getUser(sId));
	        model.addAttribute("errorMsg", "이름은 한글/영문 2~20자만 가능합니다.");
	        return "/comMy/updateInfo";
	    }

	    if (!phone.matches("^(01[016789]|02|0[3-9][0-9]|070|1[0-9]{3})-\\d{3,4}-\\d{4}$")) {
	    	model.addAttribute("currentMenu", "info");
	        model.addAttribute("loginUser", comMyService.getUser(sId));
	        model.addAttribute("errorMsg", "전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)");
	        return "/comMy/updateInfo";
	    }
	    // ------------------------------------------------------
	    
	    // 조작 방지: 이메일은 세션 기준으로 고정 (WHERE email에 쓸 값)
	    myDTO.setEmail(sId);

	    // 디버깅 로그
	    log.debug("[updateInfo POST] sId={}, userName={}, phone={}",
	            sId, myDTO.getUserName(), myDTO.getPhone());

	    int updated = comMyService.updateUser(myDTO);
	    log.debug("[updateInfo POST] updatedRows={}", updated);
	    
	    // 업데이트 갱신
	    if (updated > 0) {
	        session.setAttribute("userName", myDTO.getUserName());
	    }
	    

	    ra.addFlashAttribute("msg", updated > 0 ? "저장 완료!" : "저장 실패(변경된 행 0)");


	    return "redirect:/comMy/info";
	}
	
	// 비밀번호 변경 폼
	@GetMapping("/password")
	public String passwordForm(HttpSession session, Model model) {
	    // TODO 1) 로그인 체크 (sId 없으면 로그인 폼으로 redirect)
		String sId = (String)session.getAttribute("sId");
		if (sId == null) return "redirect:/user/login_form";

	    return "/comMy/password";
	}
	
	@PostMapping("/password")
	public String passwordSubmit(HttpSession session,
	                             PasswordChangeDTO form,
	                             @RequestParam(value = "cf-turnstile-response", required = false) String turnstileToken,
	                             RedirectAttributes ra) {

	    // 1) 로그인 체크
		String sId = (String)session.getAttribute("sId");
		if(sId == null) return "redirect:/user/login_form";
		
		if (turnstileToken == null || turnstileToken.trim().isEmpty()) {
		    ra.addFlashAttribute("errorMsg", "자동입력 방지 확인을 완료해주세요.");
		    return "redirect:/comMy/password";
		}

		boolean captchaOk = comMyService.verifyTurnstile(turnstileToken);

		if (!captchaOk) {
		    ra.addFlashAttribute("errorMsg", "자동입력 방지 검증에 실패했습니다. 다시 시도해주세요.");
		    return "redirect:/comMy/password";
		}

	    // 2) 1차 입력 검증(빈값/공백)
		String curPass = form.getCurrentPassword() == null ? "" : form.getCurrentPassword().trim();
		String newPass = form.getNewPassword() == null ? "" : form.getNewPassword().trim();
		String conPass = form.getNewPasswordConfirm() == null ? "" : form.getNewPasswordConfirm().trim();
		if(curPass.isEmpty() || newPass.isEmpty() || conPass.isEmpty()) {
			ra.addFlashAttribute("errorMsg", "필수 항목을 입력해주세요.");
			return "redirect:/comMy/password";
		}

	    // 3) 새 비밀번호 확인 일치 체크
		if(!newPass.equals(conPass)) {
			ra.addFlashAttribute("errorMsg", "새 비밀번호가 일치하지 않습니다.");
			return "redirect:/comMy/password";
		}
		

	    // 4) 새 비밀번호 정책 정규식 체크
		String pwRule = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,30}$";
		if(!newPass.matches(pwRule)) {
		    ra.addFlashAttribute("errorMsg", "비밀번호는 8~30자, 영문/숫자/특수문자를 포함해야 합니다.");
		    return "redirect:/comMy/password";        
		}
		
		if(curPass.equals(newPass)) {
		    ra.addFlashAttribute("errorMsg", "새 비밀번호는 현재 비밀번호와 달라야 합니다.");
		    return "redirect:/comMy/password";
		}

	    // 서비스 호출 (여기서 현재 비번 맞는지 확인 + 업데이트)
		boolean ok = comMyService.changePassword(sId, curPass, newPass);
		
		if(ok) {
		    ra.addFlashAttribute("msg", "비밀번호가 변경되었습니다.");
		    return "redirect:/comMy/info";
		} else {
		    ra.addFlashAttribute("errorMsg", "현재 비밀번호가 올바르지 않습니다.");
		    return "redirect:/comMy/password";
		}

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
	
	
	// 공고삭제
	@PostMapping("/delete")
	public String deleteJob(@RequestParam Long jobId, HttpSession session) {
		
	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login"; 
	    
	    ComMyDTO user = comMyService.getUser(sId);
	    Long userId = user.getUserId();
	    
	    comMyService.deleteJob(userId, jobId);
	    
	    int deleted = comMyService.deleteJob(jobId, userId);
	    
		
		return "redirect:/comMy/job";
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
	
	
	// 문의 내역
	// 내 문의 내역
	@GetMapping("/qna")
	public String qnaList(HttpSession session,
	                      Model model,
	                      @RequestParam(defaultValue = "all") String status,
	                      @RequestParam(defaultValue = "") String q,
	                      @RequestParam(defaultValue = "1") int page,
	                      @RequestParam(defaultValue = "5") int size) {

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";

	    model.addAttribute("currentMenu", "qna");

	    ComMyDTO user = comMyService.getUser(sId);
	    model.addAttribute("loginUser", user);
	  
	    QnaCond cond = new QnaCond();
	    cond.setUserId(user.getUserId());
	    cond.setStatus(status);
	    cond.setQ(q);
	    cond.getPage().setPage(page);
	    cond.getPage().setSize(size);

	    List<MyQnaDTO> qnaList = comMyService.getQnaList(cond);
	    int total = comMyService.getQnaCount(cond);

	    PageRes pager = PageRes.of(cond.getPage(), total);

	    model.addAttribute("qnaList", qnaList);
	    model.addAttribute("pager", pager);

	    model.addAttribute("status", status);
	    model.addAttribute("q", q);

	    return "/comMy/qna";
	}
	

	
	
}
