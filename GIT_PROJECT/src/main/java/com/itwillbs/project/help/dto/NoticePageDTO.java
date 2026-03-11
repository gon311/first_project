package com.itwillbs.project.help.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

// 페이징 처리된 게시물 목록 저장에 사용되는 클래스 정의
@Getter
//@Setter
@ToString
//@NoArgsConstructor
@AllArgsConstructor
public class NoticePageDTO {
	private List<NoticeDTO> noticeList; // 게시물 목록
	private PageInfoDTO pageInfoDTO; // 페이지 정보
}
















