package com.itwillbs.project.admin.service;

import java.math.BigInteger;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.admin.dto.JobPostDTO;
import com.itwillbs.project.admin.dto.MemberDTO;
import com.itwillbs.project.admin.dto.NoticeDTO;
import com.itwillbs.project.admin.dto.PayDTO;
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
	public MemberDTO getUserInfo(BigInteger id) {
		return adminMapper.selectUserInfo(id);
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
	public List<PayDTO> getPayList(PayDTO payDTO) {
		return adminMapper.selectPayList(payDTO);
	}

	// 기업회원 목록 조회
	public List<MemberDTO> getComList(String keyword, String type, String status) {
		return adminMapper.selectComList(keyword, type, status);
	}
	
	// 제출된 공고 목록 조회
	public List<SubmitDTO> getSubmitList(SubmitDTO submitDTO) {
		return adminMapper.selectSubmitList(submitDTO);
	}
	
	// 제출된 공고 상세 조회
	public SubmitDTO getSubmitInfo(BigInteger id) {
		return adminMapper.selectSubmitInfo(id);
	}

	// 결제 내역 상세정보
	public PayDTO getPayInfo(String id) {
		return adminMapper.selectPayInfo(id);
	}

	// 기업회원 상세정보 조회
//	public MemberDTO getComInfo(BigInteger id) {
//		return adminMapper.selectComInfo(id);
//	}

}
