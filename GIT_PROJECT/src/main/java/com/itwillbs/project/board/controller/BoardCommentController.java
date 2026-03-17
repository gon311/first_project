package com.itwillbs.project.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.project.board.dto.BoardCommentDTO;
import com.itwillbs.project.board.service.BoardCommentService;
import com.itwillbs.project.my.dto.MyDTO;
import com.itwillbs.project.my.service.MyService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/board/comment")
@RequiredArgsConstructor
public class BoardCommentController {

    private final BoardCommentService boardCommentService;
    private final MyService myService;

    // 댓글 등록
    @PostMapping("/write")
    public String writeComment(BoardCommentDTO commentDTO,
                               HttpSession session,
                               RedirectAttributes ra) {

        String sId = (String) session.getAttribute("sId");
        if (sId == null) return "redirect:/user/login";

        MyDTO user = myService.getUser(sId);
        commentDTO.setAuthorMemberId(user.getUserId());

        boardCommentService.writeComment(commentDTO);

        ra.addFlashAttribute("msg", "댓글이 등록되었습니다.");
        return "redirect:/board/detail?postId=" + commentDTO.getPostId();
    }

    // 댓글 삭제
    @PostMapping("/delete")
    public String deleteComment(@RequestParam Long commentId,
                                @RequestParam Long postId,
                                HttpSession session,
                                RedirectAttributes ra) {

        String sId = (String) session.getAttribute("sId");
        String userType = (String) session.getAttribute("userType");
        
        if (sId == null) return "redirect:/user/login";

        MyDTO user = myService.getUser(sId);

        boolean result = boardCommentService.deleteComment(commentId, user.getUserId(), userType);

        if (!result) {
            ra.addFlashAttribute("msg", "본인 댓글만 삭제할 수 있습니다.");
            return "redirect:/board/detail?postId=" + postId;
        }

        ra.addFlashAttribute("msg", "댓글이 삭제되었습니다.");
        return "redirect:/board/detail?postId=" + postId;
    }
}

