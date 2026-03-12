package com.itwillbs.project.job.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.comMy.dto.JobCond;
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

	List<JobDTO> getJobListPaging(
		    @Param("expType") String expType, 
		    @Param("eduType") String eduType,
		    @Param("userIdx") Long userIdx,
		    @Param("selectedItems") List<String> selectedItems,
		    @Param("q") String q,  // 검색어 추가
		    @Param("offset") int offset,
		    @Param("size") int size      
		);
	
	int getJobListCount(
		    @Param("expType") String expType, 
		    @Param("eduType") String eduType,
		    @Param("userIdx") Long userIdx,
		    @Param("selectedItems") List<String> selectedItems,
		    @Param("q") String q   // 검색어 추가
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
	
	// 지원자 목록 조회 (JobCond 객체 하나로 모든 필터 전달)
    List<JobApplicationDTO> getApplicantListPaging(JobCond cond);

    // 검색 조건에 맞는 총 지원자 수
    int getApplicantCount(JobCond cond);

    // 전형 단계별 카운트 (GROUP BY 결과)
    List<Map<String, Object>> getApplicantStatusCounts(JobCond cond);
    
}
