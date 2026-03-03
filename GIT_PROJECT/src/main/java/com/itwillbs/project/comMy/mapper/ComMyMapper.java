package com.itwillbs.project.comMy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.comMy.dto.ComJobRowDTO;
import com.itwillbs.project.comMy.dto.ComMyDTO;
import com.itwillbs.project.comMy.dto.JobCond;

@Mapper
public interface ComMyMapper {
	
	// 계정 보임
	ComMyDTO selectUser(String sId);

	List<ComJobRowDTO> selectJobList(JobCond cond);

	int selectJobCount(JobCond cond);
	
	
	
	
}
