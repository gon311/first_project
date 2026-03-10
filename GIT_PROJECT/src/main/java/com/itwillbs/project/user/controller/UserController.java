package com.itwillbs.project.user.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	@GetMapping("/login")
	public String login() {
		
		return "/user/login_form";
	}
	
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
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	
	@GetMapping("/regist")
	public String registG() {
		
		return "/user/regist_form";
	}
	
	@PostMapping("/regist")
	public String registP(UserDTO userDTO, BCryptPasswordEncoder passwordEncoder) {
		
		String encryptedPassword = passwordEncoder.encode(userDTO.getPassword());
		userDTO.setPassword(encryptedPassword);
		
		userService.registUser(userDTO);
		
		return "redirect:/";
	}
	
	@GetMapping("/find")
	public String find() {
		
		return "/user/find_form";
	}
	
}
