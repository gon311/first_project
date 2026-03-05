package com.itwillbs.project.my.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.itwillbs.project.my.dto.ApplyCond;
import com.itwillbs.project.my.dto.ApplyRowDTO;
import com.itwillbs.project.my.dto.FavoriteJobCond;
import com.itwillbs.project.my.dto.FavoriteJobRowDTO;
import com.itwillbs.project.my.dto.MyDTO;
import com.itwillbs.project.my.dto.MyResumeDTO;
import com.itwillbs.project.my.dto.MyReviewDTO;
import com.itwillbs.project.my.dto.MyPaymentDTO;
import com.itwillbs.project.my.dto.PaymentCond;
import com.itwillbs.project.my.dto.RecommendedCond;
import com.itwillbs.project.my.dto.RecommendedRowDTO;
import com.itwillbs.project.my.mapper.MyMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@RequiredArgsConstructor
@Log4j2
public class MyService {
	@Autowired
	private MyMapper myMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	// 내 정보
	public MyDTO getUser(String sId) {
		return myMapper.selectUser(sId);
	}
	
	// 정보 수정
	public int updateUser(MyDTO dto) {
	    return myMapper.updateUser(dto);
	}
	
	
	// 비밀번호 변경
	public boolean changePassword(String sId, String curPass, String newPass) {
	    String dbHash = myMapper.selectPassword(sId); // DB에 저장된 해시 비번

	    if (dbHash == null) return false;

	    // 현재 비번 검증
	    if (!passwordEncoder.matches(curPass, dbHash)) return false;

	    // 새 비번 저장: 원문 저장 금지 -> encode 해서 저장
	    String newHash = passwordEncoder.encode(newPass);

	    int updated = myMapper.updatePassword(sId, newHash);
	    return updated > 0;
	}
	
	// 목록
	public List<MyResumeDTO> getMyResumeList(Long userId) {
	    return myMapper.selectMyResumeList(userId);
	}

	// 삭제(soft delete)
	public int deleteResume(Integer resumeId, Long userId) {
	    return myMapper.softDeleteResume(resumeId, userId);
	}
	
	// 자소서
	public List<MyReviewDTO> getmyReviewList(Long userId) {
		return myMapper.selectMyReviewList(userId);
	}
	
	// 자소서 삭제
	public int deleteReview(Long userId, Long coverLetterIdx) {
		return myMapper.deleteReview(userId, coverLetterIdx);
	}
	
	
	// 관심목록
	public List<FavoriteJobRowDTO> getFavoriteJobList(FavoriteJobCond cond) {
	    return myMapper.selectFavoriteJobList(cond);
	}

	public int getFavoriteJobCount(FavoriteJobCond cond) {
	    return myMapper.selectFavoriteJobCount(cond);
	}
	
	public int deleteFavoriteJob(Long userId, Long jobId) {
	    return myMapper.deleteFavoriteJob(userId, jobId);
	}

	public int deleteFavoriteJobs(Long userId, List<Long> jobIds) {
	    return myMapper.deleteFavoriteJobs(userId, jobIds);
	}
	
	// 결제 내역
	
	// 리스트
	public List<MyPaymentDTO> getPaymentList(PaymentCond cond) {
		return myMapper.selectPaymentList(cond);
	}
	
	// 페이징
	public int getPaymentCount(PaymentCond cond) {
		return myMapper.selectPaymentCount(cond);
	}
	
	// 지원내역
	
	// 지원내역 리스트
	public List<ApplyRowDTO> getApplyList(ApplyCond cond) {
		return myMapper.selectApplyList(cond);
	}
	
	// 지원내역 총 개수
	public int getApplyCount(ApplyCond cond) {
		return myMapper.selectApplyCount(cond);
	}
	
	// 탭별 카운트
	public int getApplyTabCount(Long userId, String tab) {
		return myMapper.selectApplyTabCount(userId, tab);
	}
		
	// 취소
	public int cancelApply(Long userId, Long appId) {
	    return myMapper.deleteJobApplication(userId, appId);
	}
	
	// 추천 공고
	public List<RecommendedRowDTO> getRecommendedList(RecommendedCond cond) {
	    return myMapper.selectRecommendedList(cond);
	}

	public int getRecommendedCount(RecommendedCond cond) {
	    return myMapper.selectRecommendedCount(cond);
	}

	public void hideRecommendedJob(long userId, long jobId) {
	    myMapper.updateRecommendedInactive(userId, jobId);
	}

	public void toggleJobBookmark(long userId, long jobId) {
	    Long bookmarkId = myMapper.selectBookmarkId(userId, jobId);
	    if (bookmarkId == null) myMapper.insertBookmark(userId, jobId);
	    else myMapper.deleteBookmark(userId, jobId);
	}


	
	
	


	
	
	

}




