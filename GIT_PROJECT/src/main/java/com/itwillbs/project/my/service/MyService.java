package com.itwillbs.project.my.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.my.dto.MyDTO;
import com.itwillbs.project.my.mapper.MyMapper;

@Service
public class MyService {
	@Autowired
	private MyMapper myMapper;
	
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
	    String dbPass = myMapper.selectPassword(sId); // DB에 저장된 비번(또는 해시)

	    if(dbPass == null) return false;

	    // (지금 단계: 평문 저장이라 가정) 현재 비번 비교
	    if(!dbPass.equals(curPass)) return false;

	    int updated = myMapper.updatePassword(sId, newPass);
	    return updated > 0;
	}

}




