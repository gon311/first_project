
package com.itwillbs.project.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.admin.dto.BannerDTO;
import com.itwillbs.project.admin.dto.CommentDTO;
import com.itwillbs.project.admin.dto.FaqDTO;
import com.itwillbs.project.admin.dto.FreeDTO;
import com.itwillbs.project.admin.dto.JobPostDTO;
import com.itwillbs.project.admin.dto.MemberDTO;
import com.itwillbs.project.admin.dto.NoticeDTO;
import com.itwillbs.project.admin.dto.ProductDTO;
import com.itwillbs.project.admin.dto.QnaDTO;
import com.itwillbs.project.admin.dto.SearchDTO;
import com.itwillbs.project.admin.dto.SubmitDTO;
import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.store.dto.PaymentDTO;

@Mapper
public interface AdminMapper {
	
	// 구직자 전체 회원 목록 갯수 조회
	int selectUserListCount(@Param("keyword") String keyword
							, @Param("type") String type
							, @Param("status") String status);

	// 구직자 회원 목록
	List<MemberDTO> selectUserList(@Param("startRow") int startRow
								, @Param("listLimit") int listLimit
								, @Param("keyword") String keyword
								, @Param("type") String type
								, @Param("status") String status
								, @Param("sort") String sort);
	
	// 구직자 탈퇴회원 전체 회원 목록 갯수 조회
	int selectWithdrawListCount(@Param("keyword") String keyword
								, @Param("startDate") String startDate
								, @Param("endDate") String endDate);
	
	// 탈퇴 회원 목록 조회
	List<MemberDTO> selectUserWithdraw(@Param("startRow") int startRow
									, @Param("listLimit") int listLimit
									, @Param("keyword") String keyword
									, @Param("startDate") String startDate
									, @Param("endDate") String endDate
									, @Param("sort") String sort);

	// 회원 상세 정보
	MemberDTO selectUserInfo(long userId);
	
	// 회원 게시글 정보
	List<FreeDTO> selectFreeInfo(long userId);
	
	// 회원 1대1문의글 정보
	List<QnaDTO> selectQnaInfo(long userId);
	
	// 회원 댓글 정보
	List<CommentDTO> selectCommentInfo(long userId);
	
	// 회원 차단
	void updateUserBlock(long userId);
	
	// 회원 차단 해제
	void updateUserUnblock(long userId);
	
	// 탈퇴한 회원 삭제
	void deleteUserInfo(long userId);
	
	// 기업 전체 회원 목록 갯수 조회
	int selectComListCount(@Param("keyword") String keyword
							, @Param("type") String type
							, @Param("status") String status);

	// 기업회원 목록 조회
	List<MemberDTO> selectComList(@Param("startRow") int startRow
								, @Param("listLimit") int listLimit
								, @Param("keyword") String keyword
								, @Param("type") String type
								, @Param("status") String status
								, @Param("sort") String sort);
	
	// 기업 탈퇴회원 전체 회원 목록 갯수 조회
	int selectComWithdrawListCount(@Param("keyword") String keyword
								, @Param("startDate") String startDate
								, @Param("endDate") String endDate);
	
	// 탈퇴 회원 목록 조회
	List<MemberDTO> selectComWithdraw(@Param("startRow") int startRow
									, @Param("listLimit") int listLimit
									, @Param("keyword") String keyword
									, @Param("startDate") String startDate
									, @Param("endDate") String endDate
									, @Param("sort") String sort);
	
	
	
	// 기업회원 상세 정보 조회
	MemberDTO selectComInfo(long userId); 
	
	// 기업 공고 목록 조회
	List<JobPostDTO> selectJobPostInfo(long userId);
	
	//========================================================================
	// 공지사항 리스트 조회
	
	int getNoticeTotalCount(SearchDTO searchDTO);
	
	List<NoticeDTO> getNoticeList(SearchDTO searchDTO);

	// 공지사항 상세 조회
	NoticeDTO getNoticeById(int noticeId);
	
	// 공지사항 저장
	void insertNotice(NoticeDTO noticeDTO);
	
	// 조회수 증가
	void updateReadCount(int noticeId);
	
	void deleteNotice(int noticeId);
	
	void updateNotice(NoticeDTO noticeDTO);

	
	//========================================================================
//	[ 채용공고 관리]
//	채용공고 리스트 개수 조회
	int getJobPostTotalCount(SearchDTO searchDTO);
	
//	채용공고 리스트 조회
	List<JobPostDTO> getJobPostList(SearchDTO searchDTO);
	
//	채용공고 상세 조회
	JobPostDTO getJobPostById(int jobId);
	
	void deleteJobPost(int jobId);
	
	//========================================================================
	// 결제 목록 전체 갯수 조회
	int selectPaymentListCount(@Param("keyword") String keyword
							, @Param("startDate") String startDate
							, @Param("endDate") String endDate
							, @Param("userType") String userType
							, @Param("payStatus") String payStatus);
	
	// 결제 목록 조회
	List<PaymentDTO> selectPaymentList(@Param("startRow") int startRow
									, @Param("listLimit") int listLimit
									,@Param("startDate") String startDate
									, @Param("endDate") String endDate
									, @Param("keyword") String keyword
									, @Param("userType") String userType
									, @Param("payStatus") String payStatus
									, @Param("sort") String sort); 

	// 결제 내역 상세 정보 조회
	PaymentDTO selectPayInfo(String id);
	
	// 결제 취소
	void updatePayCancel(long payId);

	//========================================================================
	// 제출된 공고 목록 전체 갯수 조회
	int selectSubmitListCount(@Param("keyword") String keyword
							, @Param("startDate") String startDate
							, @Param("endDate") String endDate
							, @Param("submitStatus") String submitStatus);
	
	// 제출된 공고 목록 조회
	List<SubmitDTO> selectSubmitList(@Param("startRow") int startRow
									, @Param("listLimit") int listLimit
									, @Param("startDate") String startDate
									, @Param("endDate") String endDate
									, @Param("keyword") String keyword
									, @Param("submitStatus") String submitStatus
									, @Param("sort") String sort);

	// 제출된 공고 상세정보 조회
	SubmitDTO selectSubmitInfo(long jobId);
	
	// 첨부파일
	List<FileDTO> selectFileList(Long jobId);
	
	// 공고 상태 변경
	void updateSubmitStatus(@Param("jobId") long jobId, @Param("postCheck") Integer postCheck);
	
	//========================================================================
	// 구매할 상품 상세 정보 조회(구매하기 진행)
	ProductDTO selectProductInfo(String productId);
	
	
	
	// ======================================================================
	// 1:1 문의글 관리
	int getQnaTotalCount(SearchDTO searchDTO);

	List<QnaDTO> getQnaList(SearchDTO searchDTO);
	
	QnaDTO getQnaById(int qnaId);

	void registAnswer(QnaDTO qnaDTO);
	
	void deleteQna(int qnaId);
	
	void deleteQnaAnswer(int qnaId);

	void modifyAnswer(QnaDTO qnaDTO);
	// -========================================================================
//	FAQ 관리
	
	int getFaqTotalCount(SearchDTO searchDTO);

	List<FaqDTO> getFaqList(SearchDTO searchDTO);
	
	List<FaqDTO> getListByUserType(String userType);

	void insertFaq(FaqDTO faqDTO);

	void deleteFaq(int faqId);

	void updateFaq(FaqDTO faqDTO);


// ===========================================================================
//	banner 관리
	
	List<BannerDTO> getBannerList(BannerDTO bannerDTO);
	
	Integer countBannerById(long jobId);

	void insertBanner(BannerDTO bannerDTO);
	
	void updateBannerStatus(@Param("adId") int adId
							, @Param("isDisplay") int isDisplay);

//	============================================================================
//	[ 데이터 관리 ]
//	1. 구직자 유형별 통계
	List<Map<String, Object>> getGenderStats();

	List<Map<String, Object>> getAgeStats();

	List<Map<String, Object>> getJobStats();
	
// 	2. 기업회원 유형별 통계
	List<Map<String, Object>> getComPostStats();

	List<Map<String, Object>> getJobFieldStats();

	List<Map<String, Object>> getEmpTypeStats();

//	3. 구직자 결제 통계
	List<Map<String, Object>> getProductSalesStats();

	List<Map<String, Object>> getPayMethodStats();

	List<Map<String, Object>> getDailyRevenueStats();

//	4. 기업회원 결제 통계
	List<Map<String, Object>> getTopComRevenue();

	List<Map<String, Object>> getComProductStats();

	List<Map<String, Object>> getComRevenueStats();

	
// =============================================================
// == [자유게시판 관리] ==

	int getBoardTotalCount(SearchDTO searchDTO);
	
//	자유게시판 목록 조회
	List<FreeDTO> getBoardList(SearchDTO searchDTO);

//	자유게시판 상세 조회
	FreeDTO getBoardDetail(long postId);
	
//	자유게시판 조회수 
	void updateBoardCount(long postId);
	
//	자유게시판 댓글 조회
	List<CommentDTO> getCommentByPostId(long postId);

//	자유게시판 댓글 삭제
	void deleteComment(long commentId);

//	자유게시판 게시글 삭제	
	void deleteBoard(long postId);



	

	

	

	


	






	

	

	

	

	

	

	

	

	


	

 
}
