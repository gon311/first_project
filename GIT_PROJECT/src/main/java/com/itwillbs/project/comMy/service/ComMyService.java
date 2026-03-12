package com.itwillbs.project.comMy.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.itwillbs.project.comMy.dto.ComJobRowDTO;
import com.itwillbs.project.comMy.dto.ComMyDTO;
import com.itwillbs.project.comMy.dto.JobCond;
import com.itwillbs.project.comMy.dto.PaymentCond;
import com.itwillbs.project.comMy.dto.PaymentDTO;
import com.itwillbs.project.comMy.mapper.ComMyMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
@RequiredArgsConstructor
@Log4j2
public class ComMyService {
	@Autowired
	private ComMyMapper comMyMapper;
	private PasswordEncoder passwordEncoder;
	
	@Value("${turnstile.secret-key}")
	private String turnstileSecretKey;

	private final ObjectMapper objectMapper = new ObjectMapper();

	public ComMyDTO getUser(String sId) {
		return comMyMapper.selectUser(sId);
	}
	
	
	// 공고 리스트
	public List<ComJobRowDTO> getJopList(JobCond cond) {
		return comMyMapper.selectJobList(cond);
	}
	
	// 페이징
	public int getJopCount(JobCond cond) {
		return comMyMapper.selectJobCount(cond);
	}
	
	

	// 리스트
	public List<PaymentDTO> getPaymentList(PaymentCond cond) {
		return comMyMapper.selectPaymentList(cond);
	}

	public int getPaymentCount(PaymentCond cond) {
		return comMyMapper.selectPaymentCount(cond);
	}

	// 정보 수정
	public int updateUser(ComMyDTO myDTO) {
		return comMyMapper.updateUser(myDTO);
	}

	// 비밀번호 변경
	public boolean changePassword(String sId, String curPass, String newPass) {
	    String dbHash = comMyMapper.selectPassword(sId); // DB에 저장된 해시 비번

	    if (dbHash == null) return false;

	    // 현재 비번 검증
	    if (!passwordEncoder.matches(curPass, dbHash)) return false;

	    // 새 비번 저장: 원문 저장 금지 -> encode 해서 저장
	    String newHash = passwordEncoder.encode(newPass);

	    int updated = comMyMapper.updatePassword(sId, newHash);
	    return updated > 0;
	}


	// 캡챠
	public boolean verifyTurnstile(String turnstileToken) {
		
	    if (turnstileToken == null || turnstileToken.trim().isEmpty()) {
	        return false;
	    }

	    try {
	        URL url = new URL("https://challenges.cloudflare.com/turnstile/v0/siteverify");
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setDoOutput(true);
	        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");

	        String params = "secret=" + URLEncoder.encode(turnstileSecretKey, "UTF-8")
	                + "&response=" + URLEncoder.encode(turnstileToken, "UTF-8");

	        try (OutputStream os = conn.getOutputStream()) {
	            os.write(params.getBytes(StandardCharsets.UTF_8));
	        }
	        
	        if (conn.getResponseCode() != 200) {
	            return false;
	        }

	        try (BufferedReader br = new BufferedReader(
	                new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {

	            StringBuilder sb = new StringBuilder();
	            String line;
	            while ((line = br.readLine()) != null) {
	                sb.append(line);
	            }
	            

	            JsonNode jsonNode = objectMapper.readTree(sb.toString());
	            return jsonNode.path("success").asBoolean(false);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	// 공고 삭제
	public int deleteJob(Long userId, Long jobId) {
		return comMyMapper.deleteJob(userId, jobId);
	}


	public int getJopPostingCount(JobCond cond) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	public int getJopManagementCount(JobCond cond) {
		return comMyMapper.getJopManagementCount(cond);
	}
}



