package com.itwillbs.project.job.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.job.dto.JobDTO;

@Mapper
public interface JobMapper {

	void insertJob(JobDTO jobDTO);

	List<JobDTO> getJobList(
			@Param("expType") String expType, 
			@Param("eduType") String eduType, 
			@Param("selectedItems") List<String> selectedItems
			);

	List<Map<String, String>> getExistingRegions();

	JobDTO getJobListDetail(Long jobId);

}
