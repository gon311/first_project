package com.itwillbs.project.job.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.common.mapper.FileMapper;
import com.itwillbs.project.common.util.FileUtils;
import com.itwillbs.project.job.dto.JobApplicationDTO;
import com.itwillbs.project.job.dto.JobDTO;
import com.itwillbs.project.job.mapper.JobMapper;
import com.itwillbs.project.resume.dto.ResumeDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor

public class JobService {
	@Autowired
	private JobMapper jobMapper;
	private FileMapper fileMapper;
	
	public void jobInsert(JobDTO jobDTO, List<MultipartFile> files, String sId) throws IOException {
		
		jobMapper.insertJob(jobDTO);
		
		List<FileDTO> fileList = FileUtils.uploadFile(files, sId);
		if(!fileList.isEmpty()) {
			// BoardMapper - insertBoardFiles() 메서드 호출하여 파일 정보 등록
			// => 파라미터 : List 객체, 게시물 번호(BoardDTO - idx)   리턴타입 : void
			jobMapper.insertBoardFiles(fileList, jobDTO.getJobId());
		}
		
	}

	public List<JobDTO> getJobList(String expType, String eduType, Long userIdx, List<String> selectedItems) {
	    return jobMapper.getJobList(expType, eduType, userIdx, selectedItems);
	}

	public List<Map<String, String>> getExistingRegions() {
		return jobMapper.getExistingRegions();
	}

	public JobDTO getJobListDetail(Long jobId) {
		return jobMapper.getJobListDetail(jobId);
	}

	public List<ResumeDTO> getMyResume(Long userIdx) {
		return jobMapper.getMyResume(userIdx);
	}

	public void insertApplication(JobApplicationDTO applicationDTO) {
		jobMapper.insertApplication(applicationDTO);
	}

	public int checkAlreadyApplied(JobApplicationDTO application) {
	    return jobMapper.checkAlreadyApplied(application);
	}

	public void updateBookmark(Long userIdx, Long jobId, String status) {
		if ("Y".equals(status)) {
	        jobMapper.insertBookmark(userIdx, jobId);
	    } else {
	        jobMapper.deleteBookmark(userIdx, jobId);
	    }
	}

	public boolean modifyJob(JobDTO jobDTO, List<MultipartFile> files, List<Integer> deleteFiles, String sId) throws IOException {
	    // 1. 기존 파일 삭제 처리 (체크박스로 선택된 파일들)
	    if (deleteFiles != null && !deleteFiles.isEmpty()) {
	        for (Integer fileId : deleteFiles) {
	            // DB에서 파일 정보 조회 (실제 경로를 알기 위해)
	            FileDTO fileDTO = fileMapper.selectFile(fileId);
	            if (fileDTO != null) {
	                // [필요시 추가] 실제 물리적 경로의 파일 삭제 로직 (FileUtils 등에 구현)
//	                 FileUtils.deleteFile(fileDTO, sId); 
	                
	                // DB에서 파일 레코드 삭제
	                jobMapper.deleteFile(fileId);
	            }
	        }
	    }

	    // 2. 새 파일 업로드 처리
	    // files가 null이 아니고, 실제 파일 데이터가 존재하는 경우에만 처리
	    if (files != null && !files.isEmpty() && !files.get(0).getOriginalFilename().isEmpty()) {
	        List<FileDTO> fileList = FileUtils.uploadFile(files, sId);
	        // DB에 새 파일 정보 저장 (기존에 작성된 insertBoardFiles 활용)
	        jobMapper.insertBoardFiles(fileList, jobDTO.getJobId());
	    }

	    // 3. 공고 텍스트 정보 업데이트
	    return jobMapper.updateJob(jobDTO) > 0;
	}


}
