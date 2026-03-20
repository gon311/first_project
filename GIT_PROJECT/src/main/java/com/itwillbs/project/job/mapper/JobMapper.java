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

	// ===================================================
	// 공고 등록
	void insertJob(JobDTO jobDTO);
	// 공고 이용권 확인
	int checkActiveProduct(Long userId);
	// ===================================================
	// 공고 상세보기 페이지의 이력서 가져오기
	List<ResumeDTO> getMyResume(Long userIdx);
	// 공고 상세보기, 수정페이지에서 재사용
	JobDTO getJobListDetail(Long jobId);
	// 공고 상세보기 파일 관련, 수정페이지에서 수정 시 재사용
	List<FileDTO> selectFileList(Long jobId);
	// ===================================================
	// 공고 수정 기능(DB 파일 정보 조회)
	FileDTO selectFile(Integer fileId);
	// 공고 수정 기능(DB 파일 삭제 기능)
	void deleteFile(Integer fileId);
	// DB에 새 파일 정보 저장
	void insertBoardFiles(@Param("fileList") List<FileDTO> fileList, 
						@Param("jobId") Long jobId, 
						@Param("categoryCode") String categoryCode);
	// 공고 텍스트 정보 업데이트
	int updateJob(JobDTO jobDTO);
	// ===================================================
	// 공고 지원내역 확인
	int checkAlreadyApplied(JobApplicationDTO application);
	// 공고 지원하기
	void insertApplication(JobApplicationDTO applicationDTO);
	// ===================================================
	// 공고 관심 등록
	void insertBookmark(@Param("userIdx") Long userIdx, @Param("jobId") Long jobId);
	// 공고 관심 삭제
	void deleteBookmark(@Param("userIdx") Long userIdx, @Param("jobId") Long jobId);
	// ===================================================
	// 지원자 관리
	void updateApplicationStatus(@Param("appId") int appId, @Param("appStep") String appStep);
	// 지원자 관심등록
	void updateApplicationFavorite(@Param("appId") int appId, @Param("isFavorite") String isFavorite);
	// ===================================================
	// 공고 리스트 조회 (q 파라미터 추가)
	List<JobDTO> getJobListPaging(
			@Param("expType") String expType, 
			@Param("eduType") String eduType,
			@Param("userIdx") Long userIdx,
			@Param("selectedItems") List<String> selectedItems,
			@Param("q") String q,  // 검색어 추가
			@Param("offset") int offset,
			@Param("size") int size      
			);
	// ===================================================
	// 검색 결과에 따른 전체 공고 수 조회 (페이징 계산용)
	int getJobListCount(
			@Param("expType") String expType, 
			@Param("eduType") String eduType,
			@Param("userIdx") Long userIdx,
			@Param("selectedItems") List<String> selectedItems,
			@Param("q") String q   // 검색어 추가
			);
	// ===================================================
	// 공고 리스트의 주소 카테고리 기능
	List<Map<String, String>> getExistingRegions();
	// ===================================================
	// 지원자 목록 조회 (페이징 및 필터 적용)
	List<JobApplicationDTO> getApplicantListPaging(JobCond cond);
	// 필터링된 지원자 전체 수 조회 (페이징용)
	int getApplicantCount(JobCond cond);
	// 전형 단계별 카운트 조회 (상단 탭용)
	List<Map<String, Object>> getApplicantStatusCounts(JobCond cond);
	// ===================================================
	// 공고 제목 가져오기 (기존 유지)
	String getPostingTitle(Long jobId);
	// ===================================================
	int getJobId(String jobId);

    
}
