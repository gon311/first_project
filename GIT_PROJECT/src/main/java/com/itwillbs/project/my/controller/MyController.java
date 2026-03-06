package com.itwillbs.project.my.controller;

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

import com.itwillbs.project.common.paging.PageRes;
import com.itwillbs.project.my.dto.ApplyCond;
import com.itwillbs.project.my.dto.ApplyRowDTO;
import com.itwillbs.project.my.dto.FavoriteJobCond;
import com.itwillbs.project.my.dto.FavoriteJobRowDTO;
import com.itwillbs.project.my.dto.MyDTO;
import com.itwillbs.project.my.dto.MyResumeDTO;
import com.itwillbs.project.my.dto.PasswordChangeDTO;
import com.itwillbs.project.my.dto.PaymentCond;
import com.itwillbs.project.my.dto.RecommendedCond;
import com.itwillbs.project.my.dto.RecommendedRowDTO;
import com.itwillbs.project.my.dto.MyReviewDTO;
import com.itwillbs.project.my.dto.MyPaymentDTO;
import com.itwillbs.project.my.service.MyService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Controller
@RequestMapping("/my")
@Log4j2
@RequiredArgsConstructor
public class MyController {
	@Autowired
	private MyService myService;
	
    @GetMapping
    public String myEntry(HttpSession session) {
        String sId = (String) session.getAttribute("sId");
        if (sId == null) return "redirect:/user/login";

        MyDTO user = myService.getUser(sId);

        if ("C".equals(user.getUserType())) {
            return "redirect:/comMy/info";
        }
        return "redirect:/my/myInfo";
    }
	
	// 마이페이지 내정보
	@GetMapping("/myInfo")
	public String myInfo(HttpSession session, Model model, MyDTO myDTO) {
	 
	    //로그인 체크
	    String sId = (String) session.getAttribute("sId"); 
	    if (sId == null) return "redirect:/user/login";

	    model.addAttribute("currentMenu", "myInfo");
	    MyDTO user = myService.getUser(sId);
	    model.addAttribute("loginUser", user);

	    return "/my/myInfo";
	}
	

	// 내정보 수정
	@GetMapping("/updateInfo")
	public String updateInfoForm(HttpSession session, Model model) {
	    model.addAttribute("currentMenu", "myInfo");

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login_form";

	    MyDTO user = myService.getUser(sId);
	    model.addAttribute("loginUser", user);

	    return "/my/updateInfo";
	}
	
	@PostMapping("/updateInfo")
	public String updateInfoSubmit(HttpSession session, MyDTO myDTO, RedirectAttributes ra, Model model) {

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login_form";
	    
	    // ------------------------------------------------------
	    // 입력값 검증
	    String userName = myDTO.getUserName() == null ? "" : myDTO.getUserName().trim();
	    String phone    = myDTO.getPhone()    == null ? "" : myDTO.getPhone().trim();

	    // 1) 빈값
	    if (userName.isEmpty() || phone.isEmpty()) {
	        model.addAttribute("currentMenu", "myInfo");
	        model.addAttribute("loginUser", myService.getUser(sId));
	        model.addAttribute("errorMsg", "이름/전화번호는 비워둘 수 없습니다.");
	        return "/my/updateInfo";
	    }

	    // 2) 형식 검증(이름/전화번호)
	    if (!userName.matches("^[가-힣a-zA-Z\\s]{2,20}$")) {
	        model.addAttribute("currentMenu", "myInfo");
	        model.addAttribute("loginUser", myService.getUser(sId));
	        model.addAttribute("errorMsg", "이름은 한글/영문 2~20자만 가능합니다.");
	        return "/my/updateInfo";
	    }

	    if (!phone.matches("^01[0-9]-\\d{3,4}-\\d{4}$")) {
	        model.addAttribute("currentMenu", "myInfo");
	        model.addAttribute("loginUser", myService.getUser(sId));
	        model.addAttribute("errorMsg", "전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)");
	        return "/my/updateInfo";
	    }
	    
	    // ------------------------------------------------------
	    
	    // 조작 방지: 이메일은 세션 기준으로 고정 (WHERE email에 쓸 값)
	    myDTO.setEmail(sId);

	    // 디버깅 로그
	    log.debug("[updateInfo POST] sId={}, userName={}, phone={}",
	            sId, myDTO.getUserName(), myDTO.getPhone());

	    int updated = myService.updateUser(myDTO);
	    log.debug("[updateInfo POST] updatedRows={}", updated);
	    
	    // 업데이트 갱신
	    if (updated > 0) {
	        session.setAttribute("userName", myDTO.getUserName());
	    }
	    

	    ra.addFlashAttribute("msg", updated > 0 ? "저장 완료!" : "저장 실패(변경된 행 0)");


	    return "redirect:/my/myInfo";
	}
	
	// 비밀번호 변경 폼
	@GetMapping("/password")
	public String passwordForm(HttpSession session, Model model) {
	    // TODO 1) 로그인 체크 (sId 없으면 로그인 폼으로 redirect)
		String sId = (String)session.getAttribute("sId");
		if (sId == null) return "redirect:/user/login_form";

	    return "/my/password";
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
		    return "redirect:/my/password";
		}

		boolean captchaOk = myService.verifyTurnstile(turnstileToken);

		if (!captchaOk) {
		    ra.addFlashAttribute("errorMsg", "자동입력 방지 검증에 실패했습니다. 다시 시도해주세요.");
		    return "redirect:/my/password";
		}
		
	    // 2) 1차 입력 검증(빈값/공백)
		String curPass = form.getCurrentPassword() == null ? "" : form.getCurrentPassword().trim();
		String newPass = form.getNewPassword() == null ? "" : form.getNewPassword().trim();
		String conPass = form.getNewPasswordConfirm() == null ? "" : form.getNewPasswordConfirm().trim();
		if(curPass.isEmpty() || newPass.isEmpty() || conPass.isEmpty()) {
			ra.addFlashAttribute("errorMsg", "필수 항목을 입력해주세요.");
			return "redirect:/my/password";
		}

	    // 3) 새 비밀번호 확인 일치 체크
		if(!newPass.equals(conPass)) {
			ra.addFlashAttribute("errorMsg", "새 비밀번호가 일치하지 않습니다.");
			return "redirect:/my/password";
		}
		

	    // 4) 새 비밀번호 정책 정규식 체크
		String pwRule = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,30}$";
		if(!newPass.matches(pwRule)) {
		    ra.addFlashAttribute("errorMsg", "비밀번호는 8~30자, 영문/숫자/특수문자를 포함해야 합니다.");
		    return "redirect:/my/password";        
		}
		
		if(curPass.equals(newPass)) {
		    ra.addFlashAttribute("errorMsg", "새 비밀번호는 현재 비밀번호와 달라야 합니다.");
		    return "redirect:/my/password";
		}

	    // 서비스 호출 (여기서 현재 비번 맞는지 확인 + 업데이트)
		boolean ok = myService.changePassword(sId, curPass, newPass);
		
		if(ok) {
		    ra.addFlashAttribute("msg", "비밀번호가 변경되었습니다.");
		    return "redirect:/my/myInfo";
		} else {
		    ra.addFlashAttribute("errorMsg", "현재 비밀번호가 올바르지 않습니다.");
		    return "redirect:/my/password";
		}

	}
	
	

	// 이력서 관리(목록)
	@GetMapping("/myResume")
	public String myResume(Model model, HttpSession session) {
	    model.addAttribute("currentMenu", "resume");

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";

	    MyDTO user = myService.getUser(sId);
	    Long userId = user.getUserId();

	    List<MyResumeDTO> myResumes = myService.getMyResumeList(userId);

	    model.addAttribute("myResumes", myResumes);
	    model.addAttribute("isEmpty", myResumes.isEmpty());

	    return "/my/myResume";
	}
	
	// 삭제
	@PostMapping("/resume/delete")
	public String deleteResume(@RequestParam Integer resumeId, HttpSession session) {

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";

	    Long userId = myService.getUser(sId).getUserId();

	    myService.deleteResume(resumeId, userId); // soft delete

	    return "redirect:/my/myResume";
	}


	// 자소서 관리
	@GetMapping("/myReview")
	public String urlmyReview(Model model, HttpSession session) {
	    model.addAttribute("currentMenu", "review"); // 사이드바 '자기소개서 관리' 활성
	    
	    //로그인 체크
	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";
	    
	    // sId -> userId 얻기 (myInfo랑 동일)
	    MyDTO user = myService.getUser(sId);
	    if (user == null) return "redirect:/user/login";
	    Long userId = user.getUserId();
	    
	    // 3) (핵심) 내 이력서 목록 조회
	    List<MyReviewDTO> myReviews = myService.getmyReviewList(userId);
//	    myReviewDTO topReview = myService.getTopReview(userId);
	    
	    // 4) 모델에 담아서 JSP로 전달
	    model.addAttribute("myReviews", myReviews);
//	    model.addAttribute("topResume", topReview);
	    
	    return "/my/myReview";
	}
	
	//삭제
	@PostMapping("/review/delete")
	public String deleteReview(@RequestParam Long coverLetterIdx, HttpSession session) {

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";

	    MyDTO user = myService.getUser(sId);
	    Long userId = user.getUserId();

	    myService.deleteReview(userId, coverLetterIdx);
	    
	    int deleted = myService.deleteReview(coverLetterIdx, userId);
	    log.info("resume delete result: {}", deleted);

	    return "redirect:/my/myReview";
	}
	
	
	// 관심 목록(관심공고)
	@GetMapping("/favorites")
	public String favorites(
	        HttpSession session,
	        Model model,
	        @RequestParam(required = false) String keyword,
	        @RequestParam(defaultValue = "ALL") String status, // 상황 (진행중,마감)
	        @RequestParam(defaultValue = "false") boolean excludeApplied, // 지원한 공고
	        @RequestParam(defaultValue = "1") int page,	// 페이지
	        @RequestParam(defaultValue = "5") int size  // 페이지 크기
	) {
		// 로그인 체크
	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";

	    model.addAttribute("currentMenu", "favorites");

	    MyDTO user = myService.getUser(sId);
	    model.addAttribute("loginUser", user);

	    FavoriteJobCond cond = new FavoriteJobCond();
	    cond.setUserId(user.getUserId());
	    cond.setKeyword(keyword);
	    cond.setStatus(status);
	    cond.setExcludeApplied(excludeApplied);

	    // ✅ 공통 PageReq로 세팅
	    cond.getPage().setPage(page);
	    cond.getPage().setSize(size);

	    // ✅ 조회
	    List<FavoriteJobRowDTO> favorites = myService.getFavoriteJobList(cond);
	    int total = myService.getFavoriteJobCount(cond);

	    // ✅ 페이징 응답
	    PageRes pager = PageRes.of(cond.getPage(), total);

	    model.addAttribute("favorites", favorites);
	    model.addAttribute("pager", pager);

	    // 화면에서 필터 값 유지
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("status", status);
	    model.addAttribute("excludeApplied", excludeApplied);

	    return "/my/favorites";
	}
	
	
	// 공고 삭제
	@PostMapping("/favorites/delete")
	public String deleteFavorite(
	        HttpSession session,
	        @RequestParam(required = false) Long jobId,          // 단일
	        @RequestParam(required = false) List<Long> jobIds,   // 일괄
	        @RequestParam(defaultValue = "1") int page,
	        @RequestParam(defaultValue = "5") int size,
	        @RequestParam(defaultValue = "ALL") String status,
	        @RequestParam(defaultValue = "false") boolean excludeApplied,
	        @RequestParam(required = false) String keyword
	) {
	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";

	    Long userId = myService.getUser(sId).getUserId();

	    // ✅ 1) 일괄 우선
	    if (jobIds != null && !jobIds.isEmpty()) {
	        myService.deleteFavoriteJobs(userId, jobIds);
	    }
	    // ✅ 2) 단일
	    else if (jobId != null) {
	        myService.deleteFavoriteJob(userId, jobId);
	    }

	    // 필터 유지 redirect
	    String redirect = "redirect:/my/favorites?page=" + page
	            + "&size=" + size
	            + "&status=" + status
	            + "&excludeApplied=" + excludeApplied;

	    if (keyword != null && !keyword.isBlank()) {
	        redirect += "&keyword=" + keyword;
	    }
	    return redirect;
	}
	
	// 결제 내역
	@GetMapping("/payment")
	public String paymentList(HttpSession session, 
							  Model model,
							  @RequestParam(defaultValue = "3m") String period,	// 목록(3개월전)
							  @RequestParam(defaultValue = "all") String status, //상태
							  @RequestParam(defaultValue = "") String q, //상태
							  @RequestParam(defaultValue = "1") int page,	// 페이지
							  @RequestParam(defaultValue = "5") int size	// 페이지 크기
							  ) {
	    
		// 로그인 체크
	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";
	    
	    model.addAttribute("currentMenu", "payment"); // 사이드바 '결제 내역' 활성
	    
	    MyDTO user = myService.getUser(sId);
	    model.addAttribute("loginUser", user);
	    
	    PaymentCond cond = new PaymentCond();
	    cond.setUserId(user.getUserId());
	    cond.setPeriod(period);
	    cond.setStatus(status);
	    cond.setQ(q);
	    
	    // ✅ 공통 PageReq로 세팅
	    cond.getPage().setPage(page);
	    cond.getPage().setSize(size);
	    
	    // ✅ 조회
	    List<MyPaymentDTO> payments = myService.getPaymentList(cond);
	    int total = myService.getPaymentCount(cond);
	    
	    // ✅ 페이징 응답
	    PageRes pager = PageRes.of(cond.getPage(), total);
	    
	    model.addAttribute("payments", payments);
	    model.addAttribute("pager", pager);

	    // 화면에서 필터 값 유지
	    model.addAttribute("period", period);
	    model.addAttribute("status", status);
	    model.addAttribute("q", q);
	    
	    return "/my/payment";
	}
	
	
	// 지원내역
	@GetMapping("/apply")
	public String applyList(HttpSession session, Model model,
	                        @RequestParam(defaultValue="all") String tab,
	                        @RequestParam(defaultValue="ALL") String status,
	                        @RequestParam(defaultValue="APPLY_DESC") String sort,
	                        @RequestParam(required=false) String keyword,
	                        @RequestParam(defaultValue="1") int page,
	                        @RequestParam(defaultValue="5") int size) {

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";

	    model.addAttribute("currentMenu", "apply");

	    MyDTO user = myService.getUser(sId);

	    ApplyCond cond = new ApplyCond();
	    cond.setUserId(user.getUserId());
	    cond.setTab(tab);
	    cond.setStatus(status);
	    cond.setSort(sort);
	    cond.setKeyword(keyword);
	    cond.getPage().setPage(page);
	    cond.getPage().setSize(size);

	    // ✅ 조회
	    List<ApplyRowDTO> list = myService.getApplyList(cond);
	    int total = myService.getApplyCount(cond);

	    PageRes pager = PageRes.of(cond.getPage(), total);

	    // ✅ 탭 카운트
	    int cntAll = myService.getApplyTabCount(user.getUserId(), "all");
	    int cntDone = myService.getApplyTabCount(user.getUserId(), "done");
	    int cntFinal = myService.getApplyTabCount(user.getUserId(), "final");

	    model.addAttribute("currentTab", tab);
	    model.addAttribute("cntAll", cntAll);
	    model.addAttribute("cntDone", cntDone);
	    model.addAttribute("cntFinal", cntFinal);

	    model.addAttribute("list", list);
	    model.addAttribute("pager", pager);

	    // 필터 유지
	    model.addAttribute("status", status);
	    model.addAttribute("sort", sort);
	    model.addAttribute("keyword", keyword);

	    return "/my/apply";
	}
	
	// 지원 취소
	@PostMapping("/apply/cancel")
	public String cancelApply(HttpSession session,
	                          @RequestParam Long applyId,
	                          RedirectAttributes ra) {

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";

	    MyDTO user = myService.getUser(sId);

	    int affected = myService.cancelApply(user.getUserId(), applyId);
	    if (affected > 0) ra.addFlashAttribute("msg", "지원이 정상적으로 취소 되었습니다.");
	    else ra.addFlashAttribute("msg", "지원 취소에 실패했습니다.");

	    return "redirect:/my/apply";
	}
	
	

	
	// 추천 내역
	@GetMapping("/recommend")
	public String recommend(HttpSession session, Model model,
	        @RequestParam(defaultValue="1") int page,
	        @RequestParam(defaultValue="5") int size,
	        @RequestParam(defaultValue="PREF") String sort,
	        @RequestParam(defaultValue="false") boolean onlyApplyable) {

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";

	    model.addAttribute("currentMenu", "recommend");

	    MyDTO user = myService.getUser(sId);
	    
	    // 추천 생성
	    myService.refreshRecommendedIfNeeded(user.getUserId());

	    RecommendedCond cond = new RecommendedCond();
	    cond.setUserId(user.getUserId());
	    cond.setSort(sort);
	    cond.setOnlyApplyable(onlyApplyable);

	    cond.getPage().setPage(page);
	    cond.getPage().setSize(size);

	    List<RecommendedRowDTO> list = myService.getRecommendedList(cond);
	    int total = myService.getRecommendedCount(cond);

	    PageRes pager = PageRes.of(cond.getPage(), total);

	    model.addAttribute("list", list);
	    model.addAttribute("pager", pager);
	    model.addAttribute("sort", sort);
	    model.addAttribute("onlyApplyable", onlyApplyable);

	    return "/my/recommend";
	}

	// 추천에서 제외 (RECOMMENDED_JOB.is_active = 0)
	@PostMapping("/recommend/hide")
	public String hideRecommend(HttpSession session,
	        @RequestParam long jobId,
	        @RequestParam(defaultValue="1") int page,
	        @RequestParam(defaultValue="5") int size,
	        @RequestParam(defaultValue="PREF") String sort,
	        @RequestParam(defaultValue="false") boolean onlyApplyable) {

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";

	    MyDTO user = myService.getUser(sId);
	    myService.hideRecommendedJob(user.getUserId(), jobId);

	    return "redirect:/my/recommend?page=" + page
	         + "&size=" + size
	         + "&sort=" + sort
	         + "&onlyApplyable=" + onlyApplyable;
	}

	// 스크랩 토글 (job_bookmark insert/delete)
	@PostMapping("/bookmark/toggle")
	public String toggleBookmark(HttpSession session,
	        @RequestParam long jobId,
	        @RequestParam(defaultValue="1") int page,
	        @RequestParam(defaultValue="5") int size,
	        @RequestParam(defaultValue="PREF") String sort,
	        @RequestParam(defaultValue="false") boolean onlyApplyable) {

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";

	    MyDTO user = myService.getUser(sId);
	    myService.toggleJobBookmark(user.getUserId(), jobId);

	    return "redirect:/my/recommend?page=" + page
	         + "&size=" + size
	         + "&sort=" + sort
	         + "&onlyApplyable=" + onlyApplyable;
	}
	
	// ✅ 스크랩 + 추천에서 제거(사라지는 느낌)
	@PostMapping("/recommend/bookmark")
	public String bookmarkAndHide(HttpSession session,
	        @RequestParam long jobId,
	        @RequestParam(defaultValue="1") int page,
	        @RequestParam(defaultValue="5") int size,
	        @RequestParam(defaultValue="PREF") String sort,
	        @RequestParam(defaultValue="false") boolean onlyApplyable) {

	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) return "redirect:/user/login";

	    MyDTO user = myService.getUser(sId);
	    myService.bookmarkAndHideRecommend(user.getUserId(), jobId);

	    return "redirect:/my/recommend?page=" + page
	         + "&size=" + size
	         + "&sort=" + sort
	         + "&onlyApplyable=" + onlyApplyable;
	}
	
	
	


	
}
