package com.itwillbs.project.help.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.help.dto.FaqDTO;
import com.itwillbs.project.help.dto.NoticeDTO;
import com.itwillbs.project.help.dto.NoticePageDTO;
import com.itwillbs.project.help.dto.PageInfoDTO;
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

	public List<FaqDTO> getFaqList(FaqDTO faqDTO) {
		return helpMapper.getFaqList(faqDTO);
	}

	public NoticePageDTO getNoticeList(Integer pageNum, String searchType, String searchKeyword) {
		// [ 페이징 처리 ]
		// 1. 페이징 처리를 위해 조회할 목록 갯수 조절에 사용할 변수 선언
		int listLimit = 10; // 한 페이지 당 표시할 게시물 갯수
		// 글목록 중 조회할 페이지의 첫번째 행 번호 계산(DB 상의 시작 row 번호 = 첫번째 row 는 0번)
		// => 1페이지 : 0번부터 시작, 2페이지 : 3번부터 시작, 3페이지 : 6번부터 시작
		//    즉, 현재 페이지번호 - 1 값에 한 페이지당 표시할 게시물 갯수 곱함
		int startRow = (pageNum - 1) * listLimit;
		
		// 2. 실제 뷰페이지에서 페이징 처리를 수행하는에 필요한 계산 작업 및 페이지 목록 조회 작업
		// 1) BoardMapper selectBoardListCount() 메서드 호출하여 전체 게시물 목록 갯수 조회
		// => 파라미터 : 검색타입, 검색어		리턴타입 : int(listCount)
		int listCount = helpMapper.selectNoticeListCount(searchType, searchKeyword);
		
		// 조회된 게시물 수가 0보다 클 경우에만 페이지 계산 및 게시물 목록 조회 처리하고, 0일 경우 null 리턴
		if(listCount == 0) {
			return null;
		}
		// 2) 한 페이지에서 표시할 목록 갯수 설정
		int pageListLimit = 3; // 한 페이지 당 표시할 페이지 목록(페이지 번호 목록) 갯수
		
		// 3) 최대 페이지 번호 계산
		// => 전체 게시물 갯수(listCount)를 페이지 당 게시물 갯수(listLimit)로 나눔
		//    이 때, 나머지가 0보다 크면 최대 페이지 번호 + 1 처리
//			int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		// 나머지가 있을 경우 무조건 + 1 처리하므로, Math.ceil() 메서드 활용하여 올림 처리 수행하면 간편함
		// 주의! 나눗셈 과정에서 실수 형태로 처리되어야 하므로 최소 하나의 값을 실수로 변환 후 나눗셈 수행해야함
		int maxPage = (int)Math.ceil((double)listCount / listLimit);
		
		// 4) 현재 페이지에서 보여줄 시작 페이지 번호 계산(페이지 목록의 맨 앞 번호)
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		// ex) 현재 페이지 1 : (2 - 1) / 3 * 3 + 1 = 1 
		// ex) 현재 페이지 4 : (4 - 1) / 3 * 3 + 1 = 4
		
		// 5) 현재 페이지에서 보여줄 마지막 페이지 번호 계산(페이지 목록의 맨 뒷 번호)
		int endPage = startPage + pageListLimit - 1;
		
		// 6) 단, 마지막 페이지 번호(endPage) 값이 최대 페이지번호(maxPage) 보다 클 경우
		//    마지막 페이지 번호를 최대 페이지 번호로 교체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 3. 페이징 정보 관리하는 PageInfoDTO 객체에 계산 결과 저장
		PageInfoDTO pageInfoDTO = new PageInfoDTO(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		
		// 4. 게시물 목록 조회
		// BoardMapper - selectBoardList() 메서드 호출
		// => 파라미터 : 시작행번호, 페이지 당 게시물 갯수, 검색타입, 검색어
		List<NoticeDTO> noticeList = helpMapper.selectNoticeList(startRow, listLimit, searchType, searchKeyword);
		
		// 5. BoardPageDTO 객체에 게시물 목록 정보와 페이징 정보 저장 후 리턴

		
		return new NoticePageDTO(noticeList, pageInfoDTO);
	}
	


//	=================================================================================


	

	

	

	

	
	

	

	

	



}
