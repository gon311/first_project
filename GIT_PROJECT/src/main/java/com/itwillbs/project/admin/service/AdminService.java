package com.itwillbs.project.admin.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.admin.dto.BannerDTO;
import com.itwillbs.project.admin.dto.CommentDTO;
import com.itwillbs.project.admin.dto.FaqDTO;
import com.itwillbs.project.admin.dto.FreeDTO;
import com.itwillbs.project.admin.dto.JobPostDTO;
import com.itwillbs.project.admin.dto.MemberDTO;
import com.itwillbs.project.admin.dto.NoticeDTO;
import com.itwillbs.project.admin.dto.PayDTO;
import com.itwillbs.project.admin.dto.ProductDTO;
import com.itwillbs.project.admin.dto.QnaDTO;
import com.itwillbs.project.admin.dto.SubmitDTO;
import com.itwillbs.project.admin.mapper.AdminMapper;
import com.itwillbs.project.store.dto.PaymentDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminService{

	@Autowired
	private AdminMapper adminMapper;
	
	// 구직자 목록 조회
	public List<MemberDTO> getUserList(String keyword, String type, String status, String sort) {
		return adminMapper.selectUserList(keyword, type, status, sort); 
	} 

	// 구직자 상세 정보 조회
	public MemberDTO getUserInfo(long userId) {
		return adminMapper.selectUserInfo(userId);
	}
	
	// 회원 게시글 조회
	public List<FreeDTO> getFreeInfo(long userId) {
		return adminMapper.selectFreeInfo(userId);
	}
	
	// 1대1 문의 조희
	public List<QnaDTO> getQnaInfo(long userId) {
		return adminMapper.selectQnaInfo(userId);
	}
	
	// 댓글 조회
	public List<CommentDTO> getCommentInfo(long userId) {
		return adminMapper.selectCommentInfo(userId);
	}
	
	// 회원 차단
	public void blockUser(long userId) {
		adminMapper.updateUserBlock(userId);
	}
	
	// 회원 차단 해제
	public void unblockUser(long userId) {
		adminMapper.updateUserUnblock(userId);
	}
	
	// 탈퇴한 회원 삭제
	public void deleteUser(long userId) {
		adminMapper.deleteUserInfo(userId);
	}
	
	// 탈퇴한 회원 목록
	public List<MemberDTO> getUserWithdraw(String keyword, String startDate, String endDate, String sort) {
		return adminMapper.selectUserWithdraw(keyword, startDate, endDate, sort);
	}
	
	//---------------------------------------------------------------------------------------------
	// 기업회원 목록 조회
	public List<MemberDTO> getComList(String keyword, String type, String status, String sort) {
		return adminMapper.selectComList(keyword, type, status, sort);
	}
	
	// 기업회원 상세 정보 조회
	public MemberDTO getComInfo(long userId) {
		return adminMapper.selectComInfo(userId);
	}
	
	// 기업 공고 정보 조회
	public List<JobPostDTO> getJobPostInfo(long userId) {
		return adminMapper.selectJobPostInfo(userId); 
	}
	
	// 탈퇴한 회원 목록
	public List<MemberDTO> getComWithdraw(String keyword, String startDate, String endDate, String sort) {
		return adminMapper.selectComWithdraw(keyword, startDate, endDate, sort);
	}
	
	//======================================================================================
	// 공지사항 리스트 조회 (DTO 파라미터로 사용)
	public List<NoticeDTO> getNoticeList(NoticeDTO noticeDTO){
		return adminMapper.getNoticeList(noticeDTO);
	}
	
	// 공지사항 상세 조회(DTO 리턴)
	public NoticeDTO getNoticeDetail(int notice_id) {
		adminMapper.updateReadCount(notice_id);
		return adminMapper.getNoticeById(notice_id);
	}
	
	// 공지사항 저장
	public void insertNotice(NoticeDTO noticeDTO) {
		adminMapper.insertNotice(noticeDTO);
	}
	
	// 공지사항 삭제
	public void deleteNotice(int noticeId) {
		adminMapper.deleteNotice(noticeId);
	}
	
	// 공지사항 수정
	public void updateNotice(NoticeDTO noticeDTO) {
		adminMapper.updateNotice(noticeDTO);
	}
	//========================================================================================
	// 채용공고 리스트 조회
	public List<JobPostDTO> getJobPostList(JobPostDTO jobPostDTO) {
		
		return adminMapper.getJobPostList(jobPostDTO);
	}
	// 채용공고 상세 조회
	public JobPostDTO getJobPostDetail(int jobId) {
		return adminMapper.getJobPostById(jobId);
	}
	
	// 채용공고 삭제
	public void deleteJobPost(int jobId) {
		adminMapper.deleteJobPost(jobId);
	}

	//======================================================================================
	// 결제 내역 전체 목록 조회
	public List<PaymentDTO> getPayList(String startDate, String endDate, String keyword, String userType, String payStatus, String sort) {
		return adminMapper.selectPayList(startDate, endDate, keyword, userType, payStatus, sort);
	}
 
	// 결제 내역 상세정보
	public PaymentDTO getPayInfo(String id) {
		return adminMapper.selectPayInfo(id);
	}
	
	// 결제 취소
	public void changePayCancel(long payId) {
		adminMapper.updatePayCancel(payId);
	}
	
	//========================================================================================
	// 제출된 공고 목록 조회
	public List<SubmitDTO> getSubmitList(String startDate, String endDate, String keyword, String submitStatus, String sort) {
		return adminMapper.selectSubmitList(startDate, endDate, keyword, submitStatus, sort);
	}
	
	// 제출된 공고 상세 조회
	public SubmitDTO getSubmitInfo(long jobId) {
		return adminMapper.selectSubmitInfo(jobId);
	}
	
	// 공고 상태 변경
	public void changeSubmitStatus(long jobId, Integer postCheck) {
		adminMapper.updateSubmitStatus(jobId, postCheck);
	}
	
	// 공고 승인 시 사이트에 등록되는 등록일자를 현재로 변경
	public void changeRegDate(long jobId) {
		adminMapper.updateRegDate(jobId);
	}
	
	//========================================================================================
	// 구매할 상품 정보(구매하기 진행)
	public ProductDTO getProductInfo(String productId) {
		return adminMapper.selectProductInfo(productId);
	}
	
	
	
	
	// =======================================================================================
	// 1:1문의글관리 

	public List<QnaDTO> getQnaList(QnaDTO qnaDTO) {

		return adminMapper.getQnaList(qnaDTO);
	}

	public QnaDTO getQnADetail(int qnaId) {
		return adminMapper.getQnaById(qnaId);
	}

	public void registAnswer(QnaDTO qnaDTO) {
		adminMapper.registAnswer(qnaDTO);
	}

	public void deleteQna(int qnaId) {
		adminMapper.deleteQna(qnaId);
	}

	public void deleteQnaAnswer(int qnaId) {
		adminMapper.deleteQnaAnswer(qnaId);
	}

	public void modifyAnswer(QnaDTO qnaDTO) {
		adminMapper.modifyAnswer(qnaDTO);
		
	}
	// =====================================================================================
	// faq 목록 조회
	public List<FaqDTO> getFaqList(FaqDTO faqDTO) {
		return adminMapper.getFaqList(faqDTO);
	}
	
	public List<FaqDTO> getListByUserType(String userType){
		return adminMapper.getListByUserType(userType);
	}
	// faq 글 작성
	public void insertFaq(FaqDTO faqDTO) {
		adminMapper.insertFaq(faqDTO);
	}
	// faq 글 삭제
	public void deleteFaq(int faqId) {
		adminMapper.deleteFaq(faqId);
	}
	// faq 글 수정
	public void updateFaq(FaqDTO faqDTO) {
		adminMapper.updateFaq(faqDTO);
	}


//	=================================================================================================
//	[ 배너 관리 ]
	
	public List<BannerDTO> getBannerList(BannerDTO bannerDTO) {
		return adminMapper.getBannerList(bannerDTO);
	}
	public void insertBanner(BannerDTO bannerDTO) {
		Integer existingCount = adminMapper.countBannerById(bannerDTO.getJobId());
		
		if (existingCount != null && existingCount == 0) {
			adminMapper.insertBanner(bannerDTO);
		} else {
			System.out.println("중복 배너 등록 시도 차단: jobId = " + bannerDTO.getJobId());
		}
		
	}
	
	public void modifyAdStatus(int adId, int isDisplay) {
		adminMapper.updateBannerStatus(adId, isDisplay);
	}
	


//	=================================================================================
//	[ 데이터 관리 ]
//	1. 구직자 유형별 통계
	public Map<String, Object> getUserStatistics(){
		Map<String, Object> result = new HashMap<>();
		result.put("gender", adminMapper.getGenderStats());
		result.put("age", adminMapper.getAgeStats());
		result.put("job", adminMapper.getJobStats());
		return result;
	}
	
//	2. 기업회원 유형별 통계
	public Map<String, Object> getComStatistics() {
	    Map<String, Object> result = new HashMap<>();
	    result.put("postCounts", adminMapper.getComPostStats());
	    result.put("jobFields", adminMapper.getJobFieldStats());
	    result.put("empTypes", adminMapper.getEmpTypeStats());
	    return result;
	}

//	3. 구직자 결제 통계
	public Map<String, Object> getUserPayStatistics() {
	    Map<String, Object> result = new HashMap<>();
	    result.put("products", adminMapper.getProductSalesStats());
	    result.put("methods", adminMapper.getPayMethodStats());
	    result.put("revenue", adminMapper.getDailyRevenueStats());
	    return result;
	}
	
//	4. 기업회원 결제 통계
	public Map<String, Object> getComPayStatistics(){
	    Map<String, Object> result = new HashMap<>();
	    
	    result.put("topCompanies", adminMapper.getTopComRevenue());
	    result.put("products", adminMapper.getComProductStats());
	    result.put("revenue", adminMapper.getComRevenueStats());
	    
	    return result;
		
	}

	

	

	

	

	
	

	

	

	



}
