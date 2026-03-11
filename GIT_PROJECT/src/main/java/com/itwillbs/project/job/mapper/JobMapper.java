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

	List<JobDTO> getJobListPaging2(
	        @Param("expType") String expType, 
	        @Param("eduType") String eduType,
	        @Param("userIdx") Long userIdx,
	        @Param("selectedItems") List<String> selectedItems,
	        @Param("offset") int offset,
	        @Param("size") int size      
	        );
	
	List<Map<String, String>> getExistingRegions();

	JobDTO getJobListDetail(Long jobId);

	List<ResumeDTO> getMyResume(Long userIdx);

	void insertApplication(JobApplicationDTO applicationDTO);

	int checkAlreadyApplied(JobApplicationDTO application);

	void insertBookmark(@Param("userIdx") Long userIdx, @Param("jobId") Long jobId);
	void deleteBookmark(@Param("userIdx") Long userIdx, @Param("jobId") Long jobId);

	void insertBoardFiles(@Param("fileList") List<FileDTO> fileList, @Param("jobId") Long jobId, @Param("categoryCode") String categoryCode);

	int updateJob(JobDTO jobDTO);

	void deleteFile(Integer fileId);

	List<FileDTO> selectFileList(Long jobId);

	FileDTO selectFile(Integer fileId);
	
	int checkActiveProduct(Long userId);
	
	// ===================================================
	// 지원자 관리
	
	List<JobApplicationDTO> getApplicantList(@Param("jobId") Long jobId, @Param("compId") Long compId);

	void updateApplicationStatus(@Param("appId") int appId, @Param("appStep") String appStep);

	void updateApplicationFavorite(@Param("appId") int appId, @Param("isFavorite") String isFavorite);

	String getPostingTitle(Long jobId);
	
	// ===================================================
	
	// JobMapper.java 인터페이스 하단에 추가
	int getApplicantCount(@Param("jobId") Long jobId, @Param("compId") Long compId);

	List<JobApplicationDTO> getApplicantListPaging(
	    @Param("jobId") Long jobId, 
	    @Param("compId") Long compId, 
	    @Param("startRow") int startRow, 
	    @Param("listLimit") int listLimit
	);
	
	// ===================================================
	// 채용 목록(JobList) 페이징 처리 추가
	// 1. 필터링 조건에 맞는 전체 공고 개수 조회
	int getJobListCount(
	    @Param("expType") String expType, 
	    @Param("eduType") String eduType,
	    @Param("userIdx") Long userIdx,
	    @Param("selectedItems") List<String> selectedItems
	);

	// 2. LIMIT 조건이 포함된 페이징 목록 조회
	List<JobDTO> getJobListPaging(
	    @Param("expType") String expType, 
	    @Param("eduType") String eduType,
	    @Param("userIdx") Long userIdx,
	    @Param("selectedItems") List<String> selectedItems,
	    @Param("startRow") int startRow, 
	    @Param("listLimit") int listLimit
	);

	
}
