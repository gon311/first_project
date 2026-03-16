package com.itwillbs.project.my.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
@RequiredArgsConstructor
@Log4j2
public class MyService {
	@Autowired
	private MyMapper myMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Value("${turnstile.secret-key}")
	private String turnstileSecretKey;

	private final ObjectMapper objectMapper = new ObjectMapper();
	
	// 내 정보
	public MyDTO getUser(String sId) {
		return myMapper.selectUser(sId);
	}
	
	// 정보 수정
    public int updateUser(MyDTO dto) {
        int cnt1 = myMapper.updateUserBasic(dto);
        int cnt2 = myMapper.updateUserPerson(dto);
        return cnt1 + cnt2;
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
	
	// 추천 카운트
	public int getRecommendedCount(RecommendedCond cond) {
	    return myMapper.selectRecommendedCount(cond);
	}
	
	// 추천 숨김
	public void hideRecommendedJob(long userId, long jobId) {
	    myMapper.updateRecommendedInactive(userId, jobId);
	}
	
    // ✅ 스크랩 + 추천에서 제거 (한번에)
    @Transactional
    public void bookmarkAndHideRecommend(long userId, long jobId) {
        int exists = myMapper.existsBookmark(userId, jobId);
        if (exists == 0) {
            myMapper.insertBookmark(userId, jobId);
        }
        myMapper.updateRecommendedInactive(userId, jobId);
    }
	
	// 추천 토글
	public void toggleJobBookmark(long userId, long jobId) {
	    Long bookmarkId = myMapper.selectBookmarkId(userId, jobId);
	    if (bookmarkId == null) myMapper.insertBookmark(userId, jobId);
	    else myMapper.deleteBookmark(userId, jobId);
	}
	
	// 추천 생성
	@Transactional
	public void refreshRecommendedIfNeeded(long userId) {
	    int need = myMapper.needRecommendRefresh(userId); // 0/1
	    if (need == 1) {
	        myMapper.upsertRecommendedJobs(userId); // 네 추천 UPSERT SQL
	    }
	}
	
	// 캡챠
	public boolean verifyTurnstile(String turnstileToken) {
		
	    if (turnstileToken == null || turnstileToken.trim().isEmpty()) {
	        return false;
	    }

	    try {
	        URL url = new URL("https://challenges.cloudflare.com/turnstile/v0/siteverify");
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setDoOutput(true);
	        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");

	        String params = "secret=" + URLEncoder.encode(turnstileSecretKey, "UTF-8")
	                + "&response=" + URLEncoder.encode(turnstileToken, "UTF-8");

	        try (OutputStream os = conn.getOutputStream()) {
	            os.write(params.getBytes(StandardCharsets.UTF_8));
	        }
	        
	        if (conn.getResponseCode() != 200) {
	            return false;
	        }

	        try (BufferedReader br = new BufferedReader(
	                new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {

	            StringBuilder sb = new StringBuilder();
	            String line;
	            while ((line = br.readLine()) != null) {
	                sb.append(line);
	            }
	            

	            JsonNode jsonNode = objectMapper.readTree(sb.toString());
	            return jsonNode.path("success").asBoolean(false);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	public void deleteUser(String sId) {
		myMapper.deleteUser(sId);
	}


	
	
	


	
	
	

}




