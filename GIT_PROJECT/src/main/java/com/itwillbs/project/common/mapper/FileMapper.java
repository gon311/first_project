package com.itwillbs.project.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project.common.dto.FileDTO;

@Mapper
public interface FileMapper {

	FileDTO selectFile(Integer fileId);

	void insertFiles(@Param("fileList") List<FileDTO> fileList, 
					 @Param("postId")Long postId, 
					 @Param("categoryCode") String categoryCode);

	void insertJobFiles(@Param("fileList") List<FileDTO> fileList,
						@Param("jobId") Long jobId, 
						@Param("categoryCode") String categoryCode);

}
