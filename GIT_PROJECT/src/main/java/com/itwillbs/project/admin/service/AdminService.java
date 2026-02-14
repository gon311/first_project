package com.itwillbs.project.admin.service;

import java.math.BigInteger;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.admin.dto.MemberDTO;
import com.itwillbs.project.admin.mapper.AdminMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminService{

	@Autowired
	private AdminMapper adminMapper;

	// 구직자 전체 목록
	public List<MemberDTO> getUser() {
		return adminMapper.selectUser();
	}
	
	// 구직자 목록 조회 필터링
	public List<MemberDTO> getUserFilter(String user_name, String user_type, String status) {
		return adminMapper.selectUserFilter(user_name, user_type, status);
	}

	// 구직자 상세 정보 조회
	public MemberDTO getUserInfo(BigInteger id) {
		return adminMapper.selectUserInfo(id);
	}
	


}
