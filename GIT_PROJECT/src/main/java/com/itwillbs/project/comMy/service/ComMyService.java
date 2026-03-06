package com.itwillbs.project.comMy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.itwillbs.project.comMy.dto.ComJobRowDTO;
import com.itwillbs.project.comMy.dto.ComMyDTO;
import com.itwillbs.project.comMy.dto.JobCond;
import com.itwillbs.project.comMy.dto.PaymentCond;
import com.itwillbs.project.comMy.dto.PaymentDTO;
import com.itwillbs.project.comMy.mapper.ComMyMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@RequiredArgsConstructor
@Log4j2
public class ComMyService {
	@Autowired
	private ComMyMapper comMyMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

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
	
}




