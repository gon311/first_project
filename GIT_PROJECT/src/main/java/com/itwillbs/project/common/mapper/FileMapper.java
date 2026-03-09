package com.itwillbs.project.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.common.dto.FileDTO;

@Mapper
public interface FileMapper {

	FileDTO selectFile(Integer fileId);

	void insertFiles(@Param("fileList") List<FileDTO> fileList, 
					 @Param("postId")Long postId, 
					 @Param("categoryCode") String categoryCode);

}
