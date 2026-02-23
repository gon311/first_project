package com.itwillbs.project.user.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.project.user.dto.NewPasswordDTO;
import com.itwillbs.project.user.dto.UserDTO;
import com.itwillbs.project.user.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
@Log4j2
public class UserController {
	private final UserService userService;
	
	// 로그인 페이지로 이동
	@GetMapping("/login")
	public String login() {
		
		return "/user/login_form";
	}
	
	// 로그인
	@PostMapping("/login")
	public String loginP(UserDTO userDTO, BCryptPasswordEncoder passwordEncoder,
						 HttpSession session, HttpServletResponse response,
						 RedirectAttributes ra, String rememberId) {
		
		UserDTO dbUser = userService.getUser(userDTO.getEmail());
		System.out.println(dbUser);
		if(dbUser == null || !passwordEncoder.matches(userDTO.getPassword(), dbUser.getPassword())) {
			session.setAttribute("errorMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "redirect:/user/login";
		} else if(dbUser.getStatus().equals("WITHDRAWN")) { // 로그인은 성공이지만, 탈퇴한 회원일 경우
			session.setAttribute("errorMsg", "탈퇴한 회원입니다!");
			return "redirect:/user/login";
		}
		
		session.setAttribute("sId", dbUser.getEmail());
		session.setAttribute("userName", dbUser.getUserName());
		session.setMaxInactiveInterval(60 * 60 * 24);
		
		if(rememberId != null) {
			log.info("아이디 : " + userDTO.getEmail());
			Cookie cookie = new Cookie("remember-id", userDTO.getEmail());
			cookie.setPath("/"); // 현재 서버 범위 내에서 현재 쿠키 접근 가능하도록 설정
			cookie.setMaxAge(60 * 60 * 24 * 30); 
			cookie.setHttpOnly(true);
			response.addCookie(cookie);
		} else { 
			
			Cookie cookie = new Cookie("remember-id", userDTO.getEmail()); 
			cookie.setPath("/");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		
		System.out.println(dbUser.getUserName());
		System.out.println(dbUser);
		
		return "redirect:/";
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	// 회원가입 페이지로 이동
	@GetMapping("/regist")
	public String registG() {
		
		return "/user/regist_form";
	}
	
	// 회원가입
	@PostMapping("/regist")
	public String registP(UserDTO userDTO, BCryptPasswordEncoder passwordEncoder,
						  HttpSession session) {
		
		String encryptedPassword = passwordEncoder.encode(userDTO.getPassword());
		userDTO.setPassword(encryptedPassword);
		
		userService.registUser(userDTO);
		
		session.setAttribute("sId", userDTO.getEmail());
		session.setAttribute("userName", userDTO.getUserName());
		session.setMaxInactiveInterval(60 * 60 * 24);
		
		return "redirect:/";
	}
	
	// 아이디/비밀번호 찾기 페이지로 이동
	@GetMapping("/find")
	public String find() {
		
		return "/user/find_form";
	}
	
	// 아이디 찾기
	@PostMapping("/findId")
	public String findId(Model model) {
		
		List<UserDTO> userIdList = userService.getUserIdList();
		
		model.addAttribute("userIdList", userIdList);
		
		return "/user/find_id";
	}
	
	// 새 비밀번호 작성 페이지
	@PostMapping("/findPw")
	public String findPw() {
		
		return "/user/find_pw";
	}
	
	// 비밀번호 변경
	@PostMapping("/password")
	public String password(NewPasswordDTO form,
						   String sId,
						   HttpSession session,
						   RedirectAttributes ra) {

	    // 2) 1차 입력 검증(빈값/공백)
		String newPass = form.getNewPassword() == null ? "" : form.getNewPassword().trim();
		String conPass = form.getNewPasswordConfirm() == null ? "" : form.getNewPasswordConfirm().trim();
		if(newPass.isEmpty() || conPass.isEmpty()) {
			ra.addFlashAttribute("errorMsg", "필수 항목을 입력해주세요.");
			return "redirect:/user/find_pw";
		}

	    // 3) 새 비밀번호 확인 일치 체크
		if(!newPass.equals(conPass)) {
			ra.addFlashAttribute("errorMsg", "새 비밀번호가 일치하지 않습니다.");
			return "redirect:/user/find_pw";
		}
		

	    // 4) 새 비밀번호 정책 정규식 체크
		String pwRule = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,30}$";
		if(!newPass.matches(pwRule)) {
		    ra.addFlashAttribute("errorMsg", "비밀번호는 8~30자, 영문/숫자/특수문자를 포함해야 합니다.");
		    return "redirect:/user/find_pw";        
		}
		

	    // 서비스 호출 (여기서 현재 비번 맞는지 확인 + 업데이트)
		
		boolean ok = userService.newPassword(newPass, sId);
		
		if(ok) {
		    ra.addFlashAttribute("msg", "비밀번호가 변경되었습니다.");
		    return "redirect:/user/login_form";
		} else {
		    ra.addFlashAttribute("errorMsg", "현재 비밀번호와 동일한 비밀번호는 사용하실 수 없습니다.");
		    return "redirect:/user/find_pw";
		}
	}
	
}
