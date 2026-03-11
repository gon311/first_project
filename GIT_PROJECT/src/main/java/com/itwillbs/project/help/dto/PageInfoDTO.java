package com.itwillbs.project.help.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// 페이징 처리에 사용되는 정보를 관리하는 클래스 정의
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PageInfoDTO {
	private Integer listCount; // 전체 게시물 수
	private Integer pageListLimit; // 한 페이지 당 표시할 페이지 번호 갯수
	private Integer maxPage; // 전체 페이지 수(= 최대 페이지 번호)
	private Integer startPage; // 현재 페이지에서 페이지 목록 시작 번호
	private Integer endPage; // 현재 페이지에서 페이지 목록 끝 번호
	private Integer pageNum; // 현재 페이지 번호
}




















