package com.itwillbs.project.help.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.help.dto.NoticeDTO;
import com.itwillbs.project.help.mapper.HelpMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HelpService{

	@Autowired
	private HelpMapper helpMapper;
	

	// 공지사항 리스트 조회 (DTO 파라미터로 사용)
	public List<NoticeDTO> getNoticeList(NoticeDTO noticeDTO){
		return helpMapper.getNoticeList(noticeDTO);
	}
	
	// 공지사항 상세 조회(DTO 리턴)
	public NoticeDTO getNoticeDetail(int notice_id) {
		helpMapper.updateReadCount(notice_id);
		return helpMapper.getNoticeById(notice_id);
	}
	


//	=================================================================================


	

	

	

	

	
	

	

	

	



}
