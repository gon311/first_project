package com.itwillbs.project.admin.mapper;

import java.math.BigInteger;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.admin.dto.JobPostDTO;
import com.itwillbs.project.admin.dto.MemberDTO;
import com.itwillbs.project.admin.dto.NoticeDTO;
import com.itwillbs.project.admin.dto.PayDTO;
import com.itwillbs.project.admin.dto.ProductDTO;
import com.itwillbs.project.admin.dto.SubmitDTO;

@Mapper
public interface AdminMapper {
	// 구직자 회원 목록
	List<MemberDTO> selectUserList(@Param("keyword") String keyword
								,@Param("type") String type
								,@Param("status") String status);

	// 회원 상세 정보
	MemberDTO selectUserInfo(BigInteger id);
	
	// 탈퇴 회원 목록 조회
	List<MemberDTO> selectUserWithdraw(@Param("keyword") String keyword
									,@Param("startDate") String startDate
									,@Param("endDate") String endDate);
	
	// 기업회원 목록 조회
	List<MemberDTO> selectComList(@Param("keyword") String keyword
								,@Param("type") String type
								,@Param("status") String status);
	
	// 탈퇴 회원 목록 조회
	List<MemberDTO> selectComWithdraw(@Param("keyword") String keyword
									,@Param("startDate") String startDate
									,@Param("endDate") String endDate);
	
	//========================================================================
	// 공지사항 리스트 조회
	List<NoticeDTO> getNoticeList(NoticeDTO noticeDTO);

	// 공지사항 상세 조회
	NoticeDTO getNoticeById(int notice_id);
	
	// 공지사항 저장
	void insertNotice(NoticeDTO noticeDTO);
	
	// 조회수 증가
	void updateReadCount(int notice_id);
	
	//========================================================================
//	채용공고 리스트 조회
	List<JobPostDTO> getJobPostList(JobPostDTO jobPostDTO);
	
//	채용공고 상세 조회
	JobPostDTO getJobPostById(int job_id);
	
	//========================================================================
	// 결제 목록 조회
	List<PayDTO> selectPayList(@Param("startDate") String startDate
								, @Param("endDate") String endDate
								, @Param("keyword") String keyword
								, @Param("userType") String userType
								, @Param("payStatus") String payStatus);

	// 결제 내역 상세 정보 조회
	PayDTO selectPayInfo(String id);

	//========================================================================
	// 제출된 공고 목록 조회
	List<SubmitDTO> selectSubmitList(@Param("startDate") String startDate
									, @Param("endDate") String endDate
									, @Param("keyword") String keyword
									, @Param("submitStatus") String submitStatus);

	// 제출된 공고 상세정보 조회
	SubmitDTO selectSubmitInfo(BigInteger id);

	//========================================================================
	// 구매할 상품 상세 정보 조회(구매하기 진행)
	ProductDTO selectProductInfo(String productId);

	

	


	

 
}
