package com.itwillbs.project.help.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.help.dto.NoticeDTO;

@Mapper
public interface HelpMapper {
	
	//========================================================================
	// 공지사항 리스트 조회
	List<NoticeDTO> getNoticeList(NoticeDTO noticeDTO);

	// 공지사항 상세 조회
	NoticeDTO getNoticeById(int noticeId);
	
	// 조회수 증가
	void updateReadCount(int noticeId);
	

	

	

	

	


	

	

	

	

	


	






	

	

	

	

	

	

	

	

	


	

 
}
