package com.itwillbs.project.common.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.common.dto.FileDTO;
@Mapper
public interface FileMapper {

	// 파일 상세정보 조회
	FileDTO selectFile(Integer fileId);

}
