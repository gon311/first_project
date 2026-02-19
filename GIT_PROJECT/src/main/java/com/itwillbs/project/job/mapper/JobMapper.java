package com.itwillbs.project.job.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.job.dto.JobDTO;

@Mapper
public interface JobMapper {

	void insertJob(JobDTO jobDTO);


}
