package com.itwillbs.project.comMy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.comMy.dto.ComJobRowDTO;
import com.itwillbs.project.comMy.dto.ComMyDTO;
import com.itwillbs.project.comMy.dto.JobCond;
import com.itwillbs.project.comMy.dto.MyQnaDTO;
import com.itwillbs.project.comMy.dto.PaymentCond;
import com.itwillbs.project.comMy.dto.PaymentDTO;
import com.itwillbs.project.comMy.dto.QnaCond;

@Mapper
public interface ComMyMapper {
	
	// 계정 보임
	ComMyDTO selectUser(String sId);

	List<ComJobRowDTO> selectJobList(JobCond cond);

	int selectJobCount(JobCond cond);

	
	// 결제내역
	List<PaymentDTO> selectPaymentList(PaymentCond cond);
	int selectPaymentCount(PaymentCond cond);
	
	// 계정 정보 변경
	int updateUser(ComMyDTO myDTO);
	
	// 비밀번호 변경
	String selectPassword(@Param("sId") String sId);
	int updatePassword(@Param("sId") String sId, @Param("password") String password);
	
	// 공고 목록 삭제
	int deleteJob(@Param("userId") Long userId, 
				@Param("jobId") Long jobId);

	int getJopPostingCount(JobCond cond);
	
	int getJopManagementCount(JobCond cond);
	
	// 문의내역
	List<MyQnaDTO> selectQnaList(QnaCond cond);
	int selectQnaCount(QnaCond cond);
	
	
	
	
}
