package com.itwillbs.project.admin.mapper;

import java.math.BigInteger;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.admin.dto.BannerDTO;
import com.itwillbs.project.admin.dto.FaqDTO;
import com.itwillbs.project.admin.dto.JobPostDTO;
import com.itwillbs.project.admin.dto.MemberDTO;
import com.itwillbs.project.admin.dto.NoticeDTO;
import com.itwillbs.project.admin.dto.PayDTO;
import com.itwillbs.project.admin.dto.ProductDTO;
import com.itwillbs.project.admin.dto.QnaDTO;
import com.itwillbs.project.admin.dto.SubmitDTO;

@Mapper
public interface AdminMapper {


	// 구직자 회원 목록
	List<MemberDTO> selectUserList(@Param("keyword") String keyword
								, @Param("type") String type
								, @Param("status") String status
								, @Param("sort") String sort);

	// 회원 상세 정보
	MemberDTO selectUserInfo(long userId);
	
	// 회원 차단
	void updateUserBlock(long userId);
	
	// 회원 차단 해제
	void updateUserUnblock(long userId);
	
	// 탈퇴한 회원 삭제
	void deleteUserInfo(long userId);
	
	// 탈퇴 회원 목록 조회
	List<MemberDTO> selectUserWithdraw(@Param("keyword") String keyword
									, @Param("startDate") String startDate
									, @Param("endDate") String endDate
									, @Param("sort") String sort);
	
	// 기업회원 목록 조회
	List<MemberDTO> selectComList(@Param("keyword") String keyword
								, @Param("type") String type
								, @Param("status") String status
								, @Param("sort") String sort);
	
	// 기업회원 상세 정보 조회
	MemberDTO selectComInfo(long userId);
	
	// 탈퇴 회원 목록 조회
	List<MemberDTO> selectComWithdraw(@Param("keyword") String keyword
									, @Param("startDate") String startDate
									, @Param("endDate") String endDate
									, @Param("sort") String sort);
	
	//========================================================================
	// 공지사항 리스트 조회
	List<NoticeDTO> getNoticeList(NoticeDTO noticeDTO);

	// 공지사항 상세 조회
	NoticeDTO getNoticeById(int noticeId);
	
	// 공지사항 저장
	void insertNotice(NoticeDTO noticeDTO);
	
	// 조회수 증가
	void updateReadCount(int noticeId);
	
	void deleteNotice(int noticeId);
	
	//========================================================================
//	채용공고 리스트 조회
	List<JobPostDTO> getJobPostList(JobPostDTO jobPostDTO);
	
//	채용공고 상세 조회
	JobPostDTO getJobPostById(int jobId);
	
	void deleteJobPost(int jobId);
	
	//========================================================================
	// 결제 목록 조회
	List<PayDTO> selectPayList(@Param("startDate") String startDate
								, @Param("endDate") String endDate
								, @Param("keyword") String keyword
								, @Param("userType") String userType
								, @Param("payStatus") String payStatus
								, @Param("sort") String sort); 

	// 결제 내역 상세 정보 조회
	PayDTO selectPayInfo(String id);
	
	// 결제 취소
	void updatePayCancel(long payId);

	//========================================================================
	// 제출된 공고 목록 조회
	List<SubmitDTO> selectSubmitList(@Param("startDate") String startDate
									, @Param("endDate") String endDate
									, @Param("keyword") String keyword
									, @Param("submitStatus") String submitStatus
									, @Param("sort") String sort);

	// 제출된 공고 상세정보 조회
	SubmitDTO selectSubmitInfo(long jobId);
	
	// 공고 상태 변경
	void updateSubmitStatus(@Param("jobId") long jobId, @Param("postCheck") Integer postCheck);
	
	//========================================================================
	// 구매할 상품 상세 정보 조회(구매하기 진행)
	ProductDTO selectProductInfo(String productId);
	
	
	
	// ======================================================================
	// 1:1 문의글 관리

	List<QnaDTO> getQnaList(QnaDTO qnaDTO);

	List<QnaDTO> getListByStatus(String reStatus);
	
	QnaDTO getQnaById(int qnaId);

	void registAnswer(QnaDTO qnaDTO);
	
	void deleteQna(int qnaId);
	
	void deleteQnaAnswer(int qnaId);

	void modifyAnswer(QnaDTO qnaDTO);
	// -========================================================================
	// faq 관리

	List<FaqDTO> getFaqList(@Param("userType") String userType
							, @Param("keyword") String keyword);

	void insertFaq(FaqDTO faqDTO);

	void updateNotice(NoticeDTO noticeDTO);

	void deleteFaq(int faqId);

	void updateFaq(FaqDTO faqDTO);

	List<FaqDTO> getFaqList(FaqDTO faqDTO);


	List<BannerDTO> getBannerList();

	void updateBannerStatus(int adId, int isDisplay);









	

	

	

	

	

	

	

	

	


	

 
}
