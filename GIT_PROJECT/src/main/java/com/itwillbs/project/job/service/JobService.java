package com.itwillbs.project.job.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.job.dto.JobDTO;
import com.itwillbs.project.job.mapper.JobMapper;
import com.itwillbs.project.resume.dto.ResumeDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor

public class JobService {
	@Autowired
	private JobMapper jobMapper;
	
	public void jobInsert(JobDTO jobDTO) {
		jobMapper.insertJob(jobDTO);
	}

	public List<JobDTO> getJobList(String expType, String eduType, List<String> selectedItems) {
	    return jobMapper.getJobList(expType, eduType, selectedItems);
	}

	public List<Map<String, String>> getExistingRegions() {
		return jobMapper.getExistingRegions();
	}

	public JobDTO getJobListDetail(Long jobId) {
		return jobMapper.getJobListDetail(jobId);
	}

	public List<ResumeDTO> getMyResume() {
		return jobMapper.getMyResume();
	}


}
