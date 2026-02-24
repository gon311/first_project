package com.itwillbs.project.my.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.itwillbs.project.my.dto.MyDTO;
import com.itwillbs.project.my.dto.MyResumeDTO;
import com.itwillbs.project.my.mapper.MyMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@RequiredArgsConstructor
@Log4j2
public class MyService {
	@Autowired
	private MyMapper myMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	// 내 정보
	public MyDTO getUser(String sId) {
		return myMapper.selectUser(sId);
	}
	
	// 정보 수정
	public int updateUser(MyDTO dto) {
	    return myMapper.updateUser(dto);
	}
	
	
	// 비밀번호 변경
	public boolean changePassword(String sId, String curPass, String newPass) {
	    String dbHash = myMapper.selectPassword(sId); // DB에 저장된 해시 비번

	    if (dbHash == null) return false;

	    // 현재 비번 검증
	    if (!passwordEncoder.matches(curPass, dbHash)) return false;

	    // 새 비번 저장: 원문 저장 금지 -> encode 해서 저장
	    String newHash = passwordEncoder.encode(newPass);

	    int updated = myMapper.updatePassword(sId, newHash);
	    return updated > 0;
	}
	
	// 이력서 내력
	public List<MyResumeDTO> getMyResumeList(Long userId) {
		return myMapper.selectMyResumeList(userId);
	}
	// 대표 설정
	public MyResumeDTO getTopResume(Long userId) {
		 return myMapper.selectTopResume(userId);
	}

}




