package com.itwillbs.project.common.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
[ 파일 카테고리(file_category) 테이블 정의 ]
카테고리번호(idx) - INT PK AI
카테고리코드(category_code) - 문자열(50), NN
카테고리명(category_name) - 문자열(50), NN

CREATE TABLE file_category (
	idx INT AUTO_INCREMENT PRIMARY KEY,
	category_code VARCHAR(50) NOT NULL,
	category_name VARCHAR(50) NOT NULL
);
---------------------------------------------
[ 파일(file) 테이블 정의 ]
파일ID(PK)(file_id) - 정수, 자동 증가
게시물ID(idx) - 정수(차후 사용자 정보 중 프로필 사진 연동 시 회원번호와 연결도 가능)
카테고리번호(category_idx) - 정수, file_category 테이블의 idx 컬럼 참조
원본파일명(original_file_name) - 문자열(255), NN
실제파일명(real_file_name) - 문자열(255), NN
서브디렉토리명(sub_dir) - 문자열 20, NN
파일크기(file_size) - BIGINT, NN
컨텐츠타입(content_type) - 문자열(20), NN

CREATE TABLE file (
	file_id INT AUTO_INCREMENT PRIMARY KEY,
	idx INT NOT NULL,
	category_idx INT NOT NULL,
	original_file_name VARCHAR(255) NOT NULL,
	real_file_name VARCHAR(255) NOT NULL,
	sub_dir VARCHAR(20) NOT NULL,
	file_size BIGINT NOT NULL,
	content_type VARCHAR(20) NOT NULL,
	FOREIGN KEY (category_idx) REFERENCES file_category(idx) ON DELETE CASCADE
);

*/
// 업로드 파일을 공통으로 관리할 FileDTO 클래스 정의
@Getter
@Setter
@ToString
public class FileDTO {
	private Integer fileId; // 파일 번호
	private Integer idx; // 원본(게시물, 회원)번호
	private Integer categoryIdx; // 카테고리번호
	private String originalFileName; // 원본 파일명
	private String realFileName; // 실제 업로드 파일명
	private String subDir; // 서브디렉토리명
	private Long fileSize; // 파일크기
	private String contentType;
}



















