package com.itwillbs.project.admin.service;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.admin.dto.MemberDTO;
import com.itwillbs.project.admin.dto.NoticeDTO;
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
	
	// 공지사항 리스트 조회 (DTO 파라미터로 사용)
	public List<NoticeDTO> getNoticeList(NoticeDTO noticeDTO){
		return adminMapper.getNoticeList(noticeDTO);
	}
	
	// 공지사항 상세 조회(DTO 리턴)
	public NoticeDTO getNoticeDetail(int id) {
		return adminMapper.getNoticeById(id);
	}


}
