package com.itwillbs.project.admin.mapper;

import java.math.BigInteger;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.admin.dto.MemberDTO;
import com.itwillbs.project.admin.dto.NoticeDTO;
import com.itwillbs.project.admin.dto.PayDTO;

@Mapper
public interface AdminMapper {
	// 구직자 회원 전체 목록
	List<MemberDTO> selectUser();
	
	// 구직자 회원 목록 필터링
	List<MemberDTO> selectUserFilter(@Param("keyword") String keyword
								,@Param("type") String type
								,@Param("status") String status);

	// 구직자 회원 상세 정보
	MemberDTO selectUserInfo(BigInteger id);
	
	// 공지사항 리스트 조회
	List<NoticeDTO> getNoticeList(NoticeDTO noticeDTO);

	// 공지사항 상세 조회
	NoticeDTO getNoticeById(int notice_id);
	
	// 공지사항 저장
	void insertNotice(NoticeDTO noticeDTO);
	// 조회수 증가
	void updateReadCount(int notice_id);

	// 결제 목록 조회
	List<PayDTO> selectPayList(PayDTO payDTO);

 
}
