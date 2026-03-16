package com.itwillbs.project.job.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.project.comMy.dto.JobCond;
import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.common.mapper.FileMapper;
import com.itwillbs.project.common.util.FileUtils;
import com.itwillbs.project.job.dto.JobApplicationDTO;
import com.itwillbs.project.job.dto.JobDTO;
import com.itwillbs.project.job.dto.JobPageDTO;
import com.itwillbs.project.job.dto.PageInfoDTO;
import com.itwillbs.project.job.mapper.JobMapper;
import com.itwillbs.project.resume.dto.ResumeDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor

public class JobService {
	@Autowired
	private JobMapper jobMapper;
	@Autowired
	private FileMapper fileMapper;
	
	// ===================================================
	// 공고 등록
	public void jobInsert(JobDTO jobDTO, List<MultipartFile> files, String sId) throws IOException {
		jobMapper.insertJob(jobDTO);
		List<FileDTO> fileList = FileUtils.uploadBoardFile(files);
		if(!fileList.isEmpty()) {
			fileMapper.insertJobFiles(fileList, jobDTO.getJobId(), "JOB_POSTING");
		}
	}
	// 공고 이용권 확인
	public boolean isActiveProduct(Long userId) {
		return jobMapper.checkActiveProduct(userId) > 0;
	}

	// ===================================================
	// 공고 상세보기 페이지의 이력서 가져오기
	public List<ResumeDTO> getMyResume(Long userIdx) {
		return jobMapper.getMyResume(userIdx);
	}
	// 공고 상세보기, 수정페이지에서 재사용
	public JobDTO getJobListDetail(Long jobId) {
		return jobMapper.getJobListDetail(jobId);
	}
	// 공고 상세보기 파일 관련, 수정페이지에서 수정 시 재사용
	public List<FileDTO> getFileList(Long jobId) {
		return jobMapper.selectFileList(jobId);
	}
	
	// ===================================================
	// 공고 수정 기능
	public boolean modifyJob(JobDTO jobDTO, List<MultipartFile> files, List<Integer> deleteFiles, String sId) throws IOException {
		// 1. 기존 파일 삭제 처리 (체크박스로 선택된 파일들)
		if (deleteFiles != null && !deleteFiles.isEmpty()) {
			for (Integer fileId : deleteFiles) {
				// DB에서 파일 정보 조회 (실제 경로를 알기 위해)
				System.out.println(fileId);
				FileDTO fileDTO = jobMapper.selectFile(fileId);
				if (fileDTO != null) {
//	                 FileUtils.deleteFile(fileDTO, sId); 
					
					jobMapper.deleteFile(fileId);
				}
			}
		}
		
		// 2. 새 파일 업로드 처리
		// files가 null이 아니고, 실제 파일 데이터가 존재하는 경우에만 처리
		if (files != null && !files.isEmpty() && !files.get(0).getOriginalFilename().isEmpty()) {
			List<FileDTO> fileList = FileUtils.uploadBoardFile(files);
			// DB에 새 파일 정보 저장 (기존에 작성된 insertBoardFiles 활용)
			jobMapper.insertBoardFiles(fileList, jobDTO.getJobId(), "jobPosting");
		}
		// 3. 공고 텍스트 정보 업데이트
		return jobMapper.updateJob(jobDTO) > 0;
	}
	
	// ===================================================
	// 공고 지원내역 확인
	public int checkAlreadyApplied(JobApplicationDTO application) {
		return jobMapper.checkAlreadyApplied(application);
	}
	// 공고 지원하기
	public void insertApplication(JobApplicationDTO applicationDTO) {
		jobMapper.insertApplication(applicationDTO);
	}
	
	// ===================================================
	// 공고 관심등록
	public void updateBookmark(Long userIdx, Long jobId, String status) {
		if ("Y".equals(status)) {
			jobMapper.insertBookmark(userIdx, jobId);
		} else {
			jobMapper.deleteBookmark(userIdx, jobId);
		}
	}
	
	// ===================================================
	// 지원자 관리
	public void updateApplicationStatus(int appId, String appStep) {
		// 전형 상태(서류대기, 면접진행 등) 업데이트
		jobMapper.updateApplicationStatus(appId, appStep);
	}
	// 지원자 관심등록
	public void updateApplicationFavorite(int appId, String isFavorite) {
		// 관심 지원자(별표) 여부 업데이트
		jobMapper.updateApplicationFavorite(appId, isFavorite);
	}
	// ===================================================
	// 공고 리스트 조회 (q 파라미터 추가)
	public List<JobDTO> getJobListPaging(String expType, String eduType, Long userIdx, List<String> selectedItems, String q, int page, int size) {
		int offset = (page - 1) * size;
		return jobMapper.getJobListPaging(expType, eduType, userIdx, selectedItems, q, offset, size);
	}
	
	// ===================================================
	// 검색 결과에 따른 전체 공고 수 조회 (페이징 계산용)
	public int getJobListCount(String expType, String eduType, Long userIdx, List<String> selectedItems, String q) {
		return jobMapper.getJobListCount(expType, eduType, userIdx, selectedItems, q);
	}
	
	// ===================================================
	// 공고 리스트의 주소 카테고리 기능
	public List<Map<String, String>> getExistingRegions() {
		return jobMapper.getExistingRegions();
	}
	
	// ===================================================
	// 지원자 목록 조회 (페이징 및 필터 적용)
	public List<JobApplicationDTO> getApplicantListPaging(JobCond cond) {
		// JobCond 내의 PageReq가 offset 계산을 자동으로 수행합니다.
		// LIMIT #{page.offset}, #{page.size} 처럼 사용될 예정입니다.
		return jobMapper.getApplicantListPaging(cond);
	}
	
	// 필터링된 지원자 전체 수 조회 (페이징용)
	public int getApplicantCount(JobCond cond) {
		return jobMapper.getApplicantCount(cond);
	}
	
	// 전형 단계별 카운트 조회 (상단 탭용)
	public Map<String, Integer> getApplicantStatusCounts(JobCond cond) {
		// 1. 매퍼 호출 (이제 jobId, q, careerType 등이 담긴 cond를 보냅니다)
		List<Map<String, Object>> counts = jobMapper.getApplicantStatusCounts(cond);
		// 2. 결과 맵 초기화 (데이터가 없어도 화면에 0으로 나오게 하기 위함)
		Map<String, Integer> resultMap = new HashMap<>();
		resultMap.put("waitCount", 0);
		resultMap.put("passCount", 0);
		resultMap.put("interviewCount", 0);
		resultMap.put("finalCount", 0);
		resultMap.put("failCount", 0);
		
		// 3. 루프를 돌며 DB에서 가져온 값 매핑
		if (counts != null) {
			for (Map<String, Object> map : counts) {
				String step = (String) map.get("app_step");
				// DB 컬럼명 'cnt' 혹은 'COUNT(*)'에 맞춰 가져오기
				int count = ((Number) map.get("cnt")).intValue();
				
				switch (step) {
				case "서류대기": resultMap.put("waitCount", count); break;
				case "서류통과": resultMap.put("passCount", count); break;
				case "면접진행": resultMap.put("interviewCount", count); break;
				case "최종합격": resultMap.put("finalCount", count); break;
				case "불합격": resultMap.put("failCount", count); break;
				}
			}
		}
		return resultMap;
	}
	
	// 공고 제목 가져오기 (기존 유지)
    public String getPostingTitle(Long jobId) {
        return jobMapper.getPostingTitle(jobId);
    }
	// ===================================================

}
