package com.itwillbs.project.common.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.common.DTO.FileDTO;

@Mapper
public interface FileMapper {

	FileDTO selectFile(Integer fileId);

}
