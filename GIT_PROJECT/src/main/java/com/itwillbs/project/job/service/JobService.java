package com.itwillbs.project.job.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.project.common.dto.FileDTO;
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


}
