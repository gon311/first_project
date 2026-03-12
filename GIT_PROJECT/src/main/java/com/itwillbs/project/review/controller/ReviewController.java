package com.itwillbs.project.review.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.project.review.dto.CoverLetterDTO;
import com.itwillbs.project.review.service.ReviewService;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/review")
@Log4j2
public class ReviewController {
	@Autowired
	private ReviewService reviewService;
	
	//1) AI자소서 1단계 페이지(기본 내용 선택창)
	@GetMapping("/registForm") 
	public String registForm() {
		
		return "/review/reviewForm";
	}
		
	// 1-1) 1단계 임시저장 
	@PostMapping("/draftSave")
	@ResponseBody
	public Map<String, Object> draftSave(@ModelAttribute CoverLetterDTO coverLetterDTO, HttpSession session) {
		Long userId = (Long)session.getAttribute("userIdx");
		coverLetterDTO.setUserId(userId);
		reviewService.registForm(coverLetterDTO); 
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", true);
		result.put("message", "임시저장이 완료되었습니다.");
		return result;
	}
	
	// 1-2) 1단계 저장 후 coverLetterIdx를 주소에 넣어서 redirect
	@PostMapping("/registText")
	public String registText(CoverLetterDTO coverLetterDTO, HttpSession session, RedirectAttributes ra) {
		Long userId = (Long)session.getAttribute("userIdx"); //  coverLetterIdx를 조회하기 위한 userId 저장 
		coverLetterDTO.setUserId(userId);
		reviewService.registForm(coverLetterDTO);  
		Long coverLetterIdx = coverLetterDTO.getCoverLetterIdx(); 
		
		// 2단계 페이지에서 타이틀을 보여주기 위해 title 저장 
		ra.addAttribute("title", coverLetterDTO.getTitle());
		
		// coverLetterIdx를 url에 추가해서 reirect 
	    return "redirect:/review/" + coverLetterIdx + "/registText";
	}
	
	// 2) 2단계 작성 
	@GetMapping("/{coverLetterIdx}/registText")
	public String registText(@PathVariable Long coverLetterIdx,
							 @RequestParam String title,
							 Model model) {
		
		model.addAttribute("title", title); // 2단계 페이지의 제목 창에 1단계에서 작성한 제목 그대로 반영 
		
		return "/review/reviewText";
	}
		
	// 3) 3단계 저장
	@PostMapping("/save")
	public String reviewSave(CoverLetterDTO coverLetterDTO, Model model) {
		
		reviewService.saveTotal(coverLetterDTO); // 2단계에서 작성된 내용 sql 테이블에 update 반영
		
		Long coverLetterIdx = coverLetterDTO.getCoverLetterIdx(); // 수정 및 삭제시 coverLetterIdx 필요 
		model.addAttribute("coverLetterIdx", coverLetterIdx);
		
		return "/review/reviewSave";
	}
	
	// 4) 자소서 삭제 
	@PostMapping("/delete")
	public String delete(@RequestParam("coverLetterIdx") Long coverLetterIdx) {
		reviewService.deleteData(coverLetterIdx);
		
		return "redirect:/review/registForm";
	}
	
	// 5) 맞춤법 검사 페이지 이동
	@GetMapping("/spellCheck")
	public String spellCheck() {
		
		return "/review/reviewSpellCheck";
	}
	
	// 5) 표절 검사 페이지 이동
	@GetMapping("/copyCheck")
	public String copyCheck() {
		
		return "/review/reviewCopyCheck";
	}
	

}
