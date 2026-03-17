package com.itwillbs.project.help.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.admin.dto.NoticeDTO;
import com.itwillbs.project.admin.dto.SearchDTO;
import com.itwillbs.project.help.mapper.HelpMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HelpService{

	@Autowired
	private HelpMapper helpMapper;
	

	// 공지사항 리스트 조회 (DTO 파라미터로 사용)
	public int getNoitceTotalCount(SearchDTO searchDTO) {
		return helpMapper.getNoticeTotalCount(searchDTO);
	}
	
	public List<NoticeDTO> getNoticeList(SearchDTO searchDTO){
		return helpMapper.getNoticeList(searchDTO);
	}
	
	// 공지사항 상세 조회(DTO 리턴)
	public NoticeDTO getNoticeDetail(int notice_id) {
		helpMapper.updateReadCount(notice_id);
		return helpMapper.getNoticeById(notice_id);
	}
	


//	=================================================================================


	

	

	

	

	
	

	

	

	



}
