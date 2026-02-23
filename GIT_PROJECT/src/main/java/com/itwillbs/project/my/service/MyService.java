package com.itwillbs.project.my.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.itwillbs.project.my.dto.MyDTO;
import com.itwillbs.project.my.mapper.MyMapper;

@Service
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

}




