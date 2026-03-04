package com.itwillbs.project.job.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.job.dto.JobApplicationDTO;
import com.itwillbs.project.job.dto.JobDTO;
import com.itwillbs.project.resume.dto.ResumeDTO;

@Mapper
public interface JobMapper {

	void insertJob(JobDTO jobDTO);

	List<JobDTO> getJobList(
			@Param("expType") String expType, 
			@Param("eduType") String eduType,
			@Param("userIdx") Long userIdx,
			@Param("selectedItems") List<String> selectedItems
			);

	List<Map<String, String>> getExistingRegions();

	JobDTO getJobListDetail(Long jobId);

	List<ResumeDTO> getMyResume(Long userIdx);

	void insertApplication(JobApplicationDTO applicationDTO);

	int checkAlreadyApplied(JobApplicationDTO application);

	void insertBookmark(@Param("userIdx") Long userIdx, @Param("jobId") Long jobId);
	void deleteBookmark(@Param("userIdx") Long userIdx, @Param("jobId") Long jobId);

	void insertBoardFiles(@Param("fileList") List<FileDTO> fileList, @Param("jobId") Long jobId);

	int updateJob(JobDTO jobDTO);

	void deleteFile(Integer fileId);

	List<FileDTO> selectFileList(Long jobId);

	FileDTO selectFile(Integer fileId);


}
