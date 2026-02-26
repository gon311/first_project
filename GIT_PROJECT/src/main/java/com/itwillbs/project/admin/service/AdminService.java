package com.itwillbs.project.admin.service;

import java.math.BigInteger;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.admin.dto.FaqDTO;
import com.itwillbs.project.admin.dto.JobPostDTO;
import com.itwillbs.project.admin.dto.MemberDTO;
import com.itwillbs.project.admin.dto.NoticeDTO;
import com.itwillbs.project.admin.dto.PayDTO;
import com.itwillbs.project.admin.dto.ProductDTO;
import com.itwillbs.project.admin.dto.QnaDTO;
import com.itwillbs.project.admin.dto.SubmitDTO;
import com.itwillbs.project.admin.mapper.AdminMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminService{

	@Autowired
	private AdminMapper adminMapper;
	
	// 구직자 목록 조회
	public List<MemberDTO> getUserList(String keyword, String type, String status) {
		return adminMapper.selectUserList(keyword, type, status);
	} 

	// 구직자 상세 정보 조회
	public MemberDTO getUserInfo(long userId) {
		return adminMapper.selectUserInfo(userId);
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
	public List<MemberDTO> getUserWithdraw(String keyword, String startDate, String endDate) {
		return adminMapper.selectUserWithdraw(keyword, startDate, endDate);
	}
	
	//---------------------------------------------------------------------------------------------
	// 기업회원 목록 조회
	public List<MemberDTO> getComList(String keyword, String type, String status) {
		return adminMapper.selectComList(keyword, type, status);
	}
	
	// 기업회원 상세 정보 조회
	public MemberDTO getComInfo(long userId) {
		return adminMapper.selectComInfo(userId);
	}
	
	// 탈퇴한 회원 목록
	public List<MemberDTO> getComWithdraw(String keyword, String startDate, String endDate) {
		return adminMapper.selectComWithdraw(keyword, startDate, endDate);
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
	
	//========================================================================================
	// 채용공고 리스트 조회
	public List<JobPostDTO> getJobPostList(JobPostDTO jobPostDTO) {
		
		return adminMapper.getJobPostList(jobPostDTO);
	}
	// 채용공고 상세 조회
	public JobPostDTO getJobPostDetail(int job_id) {
		return adminMapper.getJobPostById(job_id);
	}
	

	//======================================================================================
	// 결제 내역 전체 목록 조회
	public List<PayDTO> getPayList(String startDate, String endDate, String keyword, String userType, String payStatus) {
		return adminMapper.selectPayList(startDate, endDate, keyword, userType, payStatus);
	}

	// 결제 내역 상세정보
	public PayDTO getPayInfo(String id) {
		return adminMapper.selectPayInfo(id);
	}
	
	// 결제 취소
	public void changePayCancel(long payId) {
		adminMapper.updatePayCancel(payId);
	}
	
	//========================================================================================
	// 제출된 공고 목록 조회
	public List<SubmitDTO> getSubmitList(String startDate, String endDate, String keyword, String submitStatus) {
		return adminMapper.selectSubmitList(startDate, endDate, keyword, submitStatus);
	}
	
	// 제출된 공고 상세 조회
	public SubmitDTO getSubmitInfo(long jobId) {
		return adminMapper.selectSubmitInfo(jobId);
	}
	
	// 공고 상태 변경
	public void changeSubmitStatus(long jobId, Integer postCheck) {
		adminMapper.updateSubmitStatus(jobId, postCheck);
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
	// 상태 따라 div 영역 출력
	public List<QnaDTO> getListByStatus(String reStatus) {
		return adminMapper.getListByStatus(reStatus);
	}

	// =====================================================================================
	// faq
	public List<FaqDTO> getFaqList(String category, String keyword, FaqDTO faqDTO) {
		return adminMapper.getFaqList(faqDTO);
	}

	public FaqDTO getFaqDetail(int faqId) {
		// TODO Auto-generated method stub
		return null;
	}

<<<<<<< HEAD
	

	

	

	

	
=======
	public void insertFaq(FaqDTO faqDTO) {
		
		adminMapper.insertFaq(faqDTO);
	}
>>>>>>> branch 'Team-1' of https://github.com/gon311/first_project.git


	

	

	

	

	



}
