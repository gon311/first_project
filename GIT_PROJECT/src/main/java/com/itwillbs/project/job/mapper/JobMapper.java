package com.itwillbs.project.job.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.job.dto.JobDTO;

@Mapper
public interface JobMapper {

	void insertJob(JobDTO jobDTO);

	List<JobDTO> getJobList();


}
