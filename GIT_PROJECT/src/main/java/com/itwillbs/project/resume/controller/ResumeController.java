package com.itwillbs.project.resume.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.common.util.FileUtils;
import com.itwillbs.project.resume.dto.ResumeDTO;
import com.itwillbs.project.resume.dto.ResumeEducationDTO;
import com.itwillbs.project.resume.dto.ResumeExperienceDTO;
import com.itwillbs.project.resume.service.ResumeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/resume")
@RequiredArgsConstructor
@Log4j2
public class ResumeController {

	@Autowired
	private ResumeService resumeService;
	
	// resume/regist
	// 이력서 등록페이지 - 1.으로 이동 
	@GetMapping("/regist")
	public String resumeRegist(HttpSession session) {
		// int userIdx = Integer.parseInt( session.getAttribute("userIdx").toString());
	    if ( session.getAttribute("userIdx") == null ) {
	        // 세션 정보가 없으면 로그인 페이지로 이동
	        return "redirect:/user/login";
	    }
		
		return "resume/resumeForm";
	}
	
	// 이력서 등록페이지 - 2 (기본정보/사회적/병력/등등...)
	@PostMapping("/regist2")
	public String resumeRegist2(ResumeDTO resumeDTO, HttpServletRequest request) {
		// 이전 페이지에서 넘어온 파라미터 첵크
//		Enumeration<String> paramNames = request.getParameterNames();
//	    while (paramNames.hasMoreElements()) {
//	        String name = paramNames.nextElement();
//	        String value = request.getParameter(name);
////	        System.out.println(name + " = " + value);
//	    }   
	    
		return "resume/resumeRegist2";
	}
	
	// resume/resumeSave
	// 이력서를 저장.(- 추가 : 학력정보, 경력정보)
	@Transactional
	@PostMapping("/resumeSave") 
	public String resumeSave(ResumeDTO resumeDTO 
								,HttpSession session, HttpServletRequest request
								,@RequestParam("photo") MultipartFile photo) {
		if ( session.getAttribute("userIdx") == null ) {
	        // 세션 정보가 없으면 로그인 페이지로 이동
	        return "redirect:/user/login";
	    }
		
		// 세션에서 sId 꺼내오기(유저아디 - bigint)
	    Integer userIdx = Integer.parseInt( session.getAttribute("userIdx").toString());
	    //System.out.println(">>>> userIdx : "+ userIdx);
	    resumeDTO.setUserId(userIdx);   

	    // 1. resume 저장.
		resumeService.registResume(resumeDTO);
		Integer resumeId = resumeDTO.getResumeId();
		
		// 2. 학력 저장.
		if(resumeDTO.getEducationList() != null) {
	        for(ResumeEducationDTO eduDTO : resumeDTO.getEducationList()) {
	        	eduDTO.setResumeId(resumeId);
	            //resumeMapper.insertEducation(edu);
	            resumeService.registResumeEdu(eduDTO);
	        }
	    }
		
		// 3. 경력 저장.
		if(resumeDTO.getExperienceList() != null) {
	        for(ResumeExperienceDTO expDTO : resumeDTO.getExperienceList()) {
	        	expDTO.setResumeId(resumeId);
	            //resumeMapper.insertEducation(edu);
	            resumeService.registResumeExp(expDTO);
	        }
	    }
		
		// 4. 사진 업로드.
		if(photo != null && !photo.isEmpty()) {
			try {
				// 실제 서버 저장 기본 경로
		        String uploadBaseLocation =
		                request.getServletContext().getRealPath("/resources/images");
				
		        // 파일 업로드
		        FileDTO fileDTO = FileUtils.uploadResumePhoto(photo, uploadBaseLocation);

		        if(fileDTO != null) {
		            fileDTO.setResumeId(resumeId); // 이력서 PK 연결
		            fileDTO.setCategoryIdx(1); // 1 = 이력서 사진
		            resumeService.registResumePhoto(fileDTO);
		        }
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
	    }
		
		// 저장 성공 시 -> 내 이력서 상세 페이지로 redirect.
//		return "/resume/resumeRegist2";
		return "redirect:/resume/resumeView?resumeId=" + resumeId;
	}
	
	// 이력서 상세정보.
	@GetMapping("/resumeView")
	public String resumeView(@RequestParam("resumeId") Integer resumeId
								,HttpSession session
								,Model model) {
		
		 if (resumeId == null) {
		        return "redirect:/resume/list";
		 }
		 ResumeDTO resume = resumeService.getResumeInfo(resumeId);

		 if (resume == null) {
	        return "redirect:/resume/list";
		 }
		 
		 // 2. 이력서 사진 조회(추가방식) (uploaded_file 테이블에서 category_idx=1인 사진 한 장)
		 FileDTO photo = resumeService.getResumePhoto(resumeId); // 서비스에서 조회
		 
		 // 3. 이력서 + 사진 각각 모델에 담기.
		 model.addAttribute("photo", photo); // resumeDTO 대신 별도 속성
		 model.addAttribute("resume", resume);
		 
		 
		 return "resume/resumeView";
	} // 이력서 상세정보 끝.
	
	
	// 수정페이지
	@PostMapping("/resumeModify")
	public String resumeModify(ResumeDTO resumeDTO, RedirectAttributes ra
	                            ,HttpSession session 
	                            ,HttpServletRequest request
	                            ,@RequestParam("photo") MultipartFile photo) {

	    int userIdx = Integer.parseInt(session.getAttribute("userIdx").toString());
	    resumeDTO.setUserId(userIdx);

	    int resultCount = resumeService.modifyResume(resumeDTO);
	    // log.info("resultCount : "+ resultCount);

	    ra.addAttribute("resumeId", resumeDTO.getResumeId());
	    
	    int resumeId = resumeDTO.getResumeId();
	    
	 // 3. 학력 수정
	    if (resumeDTO.getEducationList() != null) {
	        // 기존 학력 데이터 삭제 (선택) 또는 update
	        resumeService.deleteResumeEdu(resumeId);

	        // 새로운 학력 데이터 삽입
	        for (ResumeEducationDTO eduDTO : resumeDTO.getEducationList()) {
	            eduDTO.setResumeId(resumeId);
	            resumeService.registResumeEdu(eduDTO);
	        }
	    }

	    // 4. 경력 수정
	    if (resumeDTO.getExperienceList() != null) {
	        // 기존 경력 데이터 삭제 (선택) 또는 update
	        resumeService.deleteResumeExp(resumeId);

	        // 새로운 경력 데이터 삽입
	        for (ResumeExperienceDTO expDTO : resumeDTO.getExperienceList()) {
	            expDTO.setResumeId(resumeId);
	            resumeService.registResumeExp(expDTO);
	        }
	    }
	    
	    // 사진 수정
	    if(photo != null && !photo.isEmpty()) {
	        try {

	            String uploadBaseLocation =
	                    request.getServletContext().getRealPath("/resources/images");

	            resumeService.deleteResumePhoto(resumeId);

	            FileDTO fileDTO = FileUtils.uploadResumePhoto(photo, uploadBaseLocation);

	            if(fileDTO != null) {
	                fileDTO.setResumeId(resumeId);
	                fileDTO.setCategoryIdx(1);
	                resumeService.registResumePhoto(fileDTO);
	            }

	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }

	    return "redirect:/resume/resumeView";
	}
	
	// 내 이력서 리스트 
	@GetMapping("/resumeList")
	public String resumeList(HttpSession session, Model model) {
		// 로그인 예외처리 
		if ( session.getAttribute("userIdx") == null ) {
	        // 세션 정보가 없으면 로그인 페이지로 이동
	        return "redirect:/user/login";
	    }
		
		int userIdx = Integer.parseInt( session.getAttribute("userIdx").toString()) ;
		
		List<ResumeDTO> resumeList = resumeService.getResumeList(userIdx);
//		System.out.println("이력서 리스트 : "+ resumeList);
		model.addAttribute("resumeList", resumeList );
		
	    return "resume/resumeList"; // 
	}

//	List<ProductDTO> productList = productService.getProductList();
//	System.out.println("상품정보 리스트 : "+ productList);
//	model.addAttribute("productList", productList);	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
