package com.itwillbs.project.help.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.project.board.service.BoardService;
import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.common.dto.FileResourceDTO;
import com.itwillbs.project.common.exception.BackwardException;
import com.itwillbs.project.common.util.FileUtils;
import com.itwillbs.project.help.dto.SupportQnaDTO;
import com.itwillbs.project.help.service.QnaService;

@Controller
@RequestMapping("/help")
public class QnaController {

    @Autowired
    private QnaService qnaService;
    
    
    @Autowired
	private BoardService boardService;

    // 1. 문의 작성 페이지 이동
    @GetMapping("/QnAWrite")
    public String qnaWrite(HttpSession session) {
    	Long sId = (Long) session.getAttribute("userIdx");
        
        if (sId == null) {
        	return "redirect:/user/login";
        }
        
        return "/help/qna_write";
    }

    // 2. 문의 등록 처리 (파일 업로드 포함)
    @PostMapping("/insert")
    public String insertQna(
            @ModelAttribute SupportQnaDTO qna, 
            @RequestParam("uploadFiles") List<MultipartFile> files,
            HttpSession session, 
            RedirectAttributes rttr) {
    	
    	Long sId = (Long) session.getAttribute("userIdx");
	    if (sId == null) {
	        return "redirect:/user/login";
	    }
	    
        qna.setWriterId(sId);
        
        try {
            qnaService.registerQna(qna, files);
            rttr.addFlashAttribute("message", "문의가 성공적으로 접수되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("error", "등록 중 오류가 발생했습니다.");
        }
        
        if ("C".equals(session.getAttribute("userType"))) {
            return "redirect:/comMy/qna";
        }
        
        return "redirect:/my/qna"; // 문의 내역 리스트로 이동
    }
    
    @GetMapping("/list")
    public String qnaList(HttpSession session, Model model) {
    	Long sId = (Long) session.getAttribute("userIdx");
        
        if (sId == null) {
        	return "redirect:/user/login";
        }
        
        List<SupportQnaDTO> list = qnaService.getQnaList(sId);
        model.addAttribute("qnaList", list);
        
        return "/help/qna_list";
    }
    
    @GetMapping("/detail")
    public String qnaDetail(@RequestParam("qnaId") int qnaId, Model model, HttpSession session) {
    	Long sId = (Long) session.getAttribute("userIdx");
        
        if (sId == null) {
        	return "redirect:/user/login";
        }
        
        // 1. qnaId로 DB에서 게시글 정보 가져오기
        SupportQnaDTO qna = qnaService.getQnaDetail(qnaId);
        List<FileDTO> qnaFiles = qnaService.getFileList(qnaId);
        
//        System.out.println("sId : " + sId);
//        System.out.println("writerId : " + writerId);
//        System.out.println("writerId2 : " + qna.getWriterId());
        if (sId != qna.getWriterId()) {
        	throw new BackwardException("비정상적인 접근입니다.");
        }
        
        // 2. JSP로 전달
        model.addAttribute("qna", qna); 
        model.addAttribute("qnaFiles", qnaFiles); 
        
        return "/help/qna_detail";
    }
    
    @GetMapping("/delete")
    public String deleteQna(@RequestParam("qnaId") int qnaId, RedirectAttributes rttr, HttpSession session) {
    	Long sId = (Long) session.getAttribute("userIdx");
        
        if (sId == null) {
        	return "redirect:/user/login";
        }
        try {
            boolean isDeleted = qnaService.removeQna(qnaId, sId);
            
            if (isDeleted) {
                rttr.addFlashAttribute("message", "문의가 정상적으로 삭제되었습니다.");
            } else {
                rttr.addFlashAttribute("error", "답변이 완료된 문의글은 삭제할 수 없습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("error", "삭제 중 오류가 발생했습니다.");
        }
        
        if ("C".equals(session.getAttribute("userType"))) {
            return "redirect:/comMy/qna";
        }
        return "redirect:/my/qna"; // 삭제 후 목록으로 이동
    }
    
    @GetMapping("/image/view")
	public ResponseEntity<Resource> viewEditorImage(@RequestParam String filePath,
	                                                @RequestParam String storedName) {
    	
	    FileDTO fileDTO = new FileDTO();
	    fileDTO.setFilePath(filePath);
	    fileDTO.setStoredName(storedName);

	    FileResourceDTO fileResourceDTO = FileUtils.getImageQna(fileDTO);
	    Resource resource = fileResourceDTO.getResource();

	    return ResponseEntity.ok()
	            .contentType(fileResourceDTO.getContentType())
	            .body(resource);
	}
    
    @GetMapping("/download")
	public ResponseEntity<Resource> downloadFile(@RequestParam Integer fileId) {
	    FileDTO fileDTO = boardService.getFileById(fileId);

	    if (fileDTO == null) {
	        throw new ResponseStatusException(HttpStatus.NOT_FOUND, "파일 정보가 없습니다.");
	    }
	    
	    FileResourceDTO fileResourceDTO = FileUtils.getFileResource(fileDTO);
	    Resource resource = fileResourceDTO.getResource();

	    return ResponseEntity.ok()
	            .contentType(MediaType.APPLICATION_OCTET_STREAM)
	            .header(HttpHeaders.CONTENT_DISPOSITION, fileResourceDTO.getContentDisposition().toString())
	            .body(resource);
	}
    
}