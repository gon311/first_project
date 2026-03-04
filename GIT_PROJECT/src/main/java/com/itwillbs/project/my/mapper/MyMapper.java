package com.itwillbs.project.my.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.my.dto.ApplyCond;
import com.itwillbs.project.my.dto.ApplyRowDTO;
import com.itwillbs.project.my.dto.FavoriteJobCond;
import com.itwillbs.project.my.dto.FavoriteJobRowDTO;
import com.itwillbs.project.my.dto.MyDTO;
import com.itwillbs.project.my.dto.MyPaymentDTO;
import com.itwillbs.project.my.dto.MyResumeDTO;
import com.itwillbs.project.my.dto.MyReviewDTO;
import com.itwillbs.project.my.dto.PaymentCond;
import com.itwillbs.project.my.dto.RecommendedCond;
import com.itwillbs.project.my.dto.RecommendedRowDTO;

@Mapper
public interface MyMapper {
	
	// 계정 보이기
	MyDTO selectUser(String sId);
	
	// 계정 정보 변경
	int updateUser(MyDTO myDTO);
	
	// 비밀번호 변경
	String selectPassword(@Param("sId") String sId);
	int updatePassword(@Param("sId") String sId, @Param("password") String password);

	List<MyResumeDTO> selectMyResumeList(@Param("userId") Long userId);

	MyResumeDTO selectTopResume(@Param("userId") Long userId);

	// 이력서 삭제
	int softDeleteResume(@Param("resumeMyId") Long resumeMyId,
			@Param("userId") Long userId);
	
	// 자소서 리뷰
	List<MyReviewDTO> selectMyReviewList(@Param("userId") Long userId);
	
	// 자소서 삭제
	int deleteReview(@Param("userId") Long userId,
            @Param("coverLetterIdx") Long coverLetterIdx);
	
	
	// 관심목록
	List<FavoriteJobRowDTO> selectFavoriteJobList(FavoriteJobCond cond);
	int selectFavoriteJobCount(FavoriteJobCond cond);
	// 관심목록 삭제
	int deleteFavoriteJob(@Param("userId") Long userId,
            @Param("jobId") Long jobId);

	int deleteFavoriteJobs(@Param("userId") Long userId,
            @Param("jobIds") List<Long> jobIds);

	//결제내역
	List<MyPaymentDTO> selectPaymentList(PaymentCond cond);
	int selectPaymentCount(PaymentCond cond);
	
	//지원내역
	List<ApplyRowDTO> selectApplyList(ApplyCond cond);
	int selectApplyCount(ApplyCond cond);
    int selectApplyTabCount(@Param("userId") Long userId,
            				@Param("tab") String tab);

    int deleteJobApplication(@Param("userId") Long userId,
            				 @Param("appId") Long appId);
    
    
    // 추천공고
    List<RecommendedRowDTO> selectRecommendedList(RecommendedCond cond);
    int selectRecommendedCount(RecommendedCond cond);

    int updateRecommendedInactive(@Param("userId") long userId, @Param("jobId") long jobId);

    Long selectBookmarkId(@Param("userId") long userId, @Param("jobId") long jobId);
    int insertBookmark(@Param("userId") long userId, @Param("jobId") long jobId);
    int deleteBookmark(@Param("userId") long userId, @Param("jobId") long jobId);


}
