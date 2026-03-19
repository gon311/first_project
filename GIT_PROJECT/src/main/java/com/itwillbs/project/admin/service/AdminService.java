package com.itwillbs.project.admin.service;

import java.util.ArrayList;
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
import com.itwillbs.project.admin.dto.PageInfoDTO;
import com.itwillbs.project.admin.dto.PaymentPageDTO;
import com.itwillbs.project.admin.dto.ProductDTO;
import com.itwillbs.project.admin.dto.QnaDTO;
import com.itwillbs.project.admin.dto.SearchDTO;
import com.itwillbs.project.admin.dto.SubmitDTO;
import com.itwillbs.project.admin.dto.SubmitPageDTO;
import com.itwillbs.project.admin.dto.UserPageDTO;
import com.itwillbs.project.admin.mapper.AdminMapper;
import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.store.dto.PaymentDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminService{

	@Autowired
	private AdminMapper adminMapper;
	
	// 구직자 목록 조회
	public UserPageDTO getUserList(String keyword, String type, String status, String sort, Integer pageNum) {
		// [페이징 처리]
		// 1. 페이징 처리를 위해 조회할 목록 갯수 조절에 사용할 변수 선언
		int listLimit = 10;		// 한 페이지 당 표시할 게시물 갯수
		
		// 회원 목록 중 조회할 페이지의 첫번째 행 번호 계산
		int startRow = (pageNum - 1) * listLimit;
		
		// 2. 실페 뷰페이지에서 페이징 처리를 수행하는데 필요한 계산 작업 및 페이지 목록 조회 작업
		// 1) 전체 회원 목록 갯수 조회
		int listCount = adminMapper.selectUserListCount(keyword, type, status);
		
		// 조회된 회원 수가 0보다 클 경우에만 페이지 계산 및 게시물 목록 조회 처리
		if(listCount == 0) {
//			return null; 
			return new UserPageDTO(new ArrayList<>(), null);
		}
		// 2) 한 페이지에서 표시할 목록 갯수 설정
		int pageListLimit = 5;	// 한 페이지 당 표시할 페이지 목록 번호 갯수
		
		// 3) 최대 페이지 번호 계산
		int maxPage = (int)Math.ceil((double)listCount / listLimit);
		
		// 4) 현재 페이지에서 보여줄 시작 페이지 번호 계산 => 페이지 목록의 맨 앞 번호
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		
		// 5) 현재 페이지에서 보여줄 마지막 페이지 번호 계산 => 페이지 목록의 맨 뒷 번호
		int endPage = startPage + pageListLimit - 1;
		
		// 6) 단, 마지막 페이지 번호 값이 최대 페이지 번호 보다 클 경우 마지막 페이지 번호를 최대 페이지 번호로 교체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 3. 페이징 정보를 관리하는 객체에 pageInfoDTO 객체에 계산 결과 저장
		PageInfoDTO pageInfoDTO = new PageInfoDTO(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		
		// 4. 회원 목록 조회
		List<MemberDTO> userList = adminMapper.selectUserList(startRow, listLimit, keyword, type, status, sort);
		  
		// 5. UserPageDTO 객체에 게시물 목록 정보와 페이징 정보 저장 후 리턴
		return new UserPageDTO(userList, pageInfoDTO);
	} 
	 
	// 탈퇴한 회원 목록
	public UserPageDTO getUserWithdraw(String keyword, String startDate, String endDate, String sort, Integer pageNum) {
		// [페이징 처리]
		// 1. 페이징 처리를 위해 조회할 목록 갯수 조절에 사용할 변수 선언
		int listLimit = 10;		// 한 페이지 당 표시할 게시물 갯수
		
		// 회원 목록 중 조회할 페이지의 첫번째 행 번호 계산
		int startRow = (pageNum - 1) * listLimit; 
		
		// 2. 실페 뷰페이지에서 페이징 처리를 수행하는데 필요한 계산 작업 및 페이지 목록 조회 작업
		// 1) 전체 회원 목록 갯수 조회
		int listCount = adminMapper.selectWithdrawListCount(keyword, startDate, endDate);
		
		// 조회된 회원 수가 0보다 클 경우에만 페이지 계산 및 게시물 목록 조회 처리
		if(listCount == 0) {
			return new UserPageDTO(new ArrayList<>(), null);
		}
		// 2) 한 페이지에서 표시할 목록 갯수 설정
		int pageListLimit = 5;	// 한 페이지 당 표시할 페이지 목록 번호 갯수
		
		// 3) 최대 페이지 번호 계산
		int maxPage = (int)Math.ceil((double)listCount / listLimit);
		
		// 4) 현재 페이지에서 보여줄 시작 페이지 번호 계산 => 페이지 목록의 맨 앞 번호
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		
		// 5) 현재 페이지에서 보여줄 마지막 페이지 번호 계산 => 페이지 목록의 맨 뒷 번호
		int endPage = startPage + pageListLimit - 1;
		
		// 6) 단, 마지막 페이지 번호 값이 최대 페이지 번호 보다 클 경우 마지막 페이지 번호를 최대 페이지 번호로 교체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 3. 페이징 정보를 관리하는 객체에 pageInfoDTO 객체에 계산 결과 저장
		PageInfoDTO pageInfoDTO = new PageInfoDTO(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		
		// 4. 회원 목록 조회
		List<MemberDTO> userList = adminMapper.selectUserWithdraw(startRow, listLimit, keyword, startDate, endDate, sort);
		  
		// 5. UserPageDTO 객체에 게시물 목록 정보와 페이징 정보 저장 후 리턴
		return new UserPageDTO(userList, pageInfoDTO);
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
	
	
	//---------------------------------------------------------------------------------------------
	// 기업회원 목록 조회
	public UserPageDTO getComList(String keyword, String type, String status, String sort, Integer pageNum) {
		// [페이징 처리]
		// 1. 페이징 처리를 위해 조회할 목록 갯수 조절에 사용할 변수 선언
		int listLimit = 10;		// 한 페이지 당 표시할 게시물 갯수
		
		// 회원 목록 중 조회할 페이지의 첫번째 행 번호 계산
		int startRow = (pageNum - 1) * listLimit;
		
		// 2. 실페 뷰페이지에서 페이징 처리를 수행하는데 필요한 계산 작업 및 페이지 목록 조회 작업
		// 1) 전체 회원 목록 갯수 조회
		int listCount = adminMapper.selectComListCount(keyword, type, status);
		
		// 조회된 회원 수가 0보다 클 경우에만 페이지 계산 및 게시물 목록 조회 처리
		if(listCount == 0) {
//					return null; 
			return new UserPageDTO(new ArrayList<>(), null);
		}
		// 2) 한 페이지에서 표시할 목록 갯수 설정
		int pageListLimit = 5;	// 한 페이지 당 표시할 페이지 목록 번호 갯수
		
		// 3) 최대 페이지 번호 계산
		int maxPage = (int)Math.ceil((double)listCount / listLimit);
		
		// 4) 현재 페이지에서 보여줄 시작 페이지 번호 계산 => 페이지 목록의 맨 앞 번호
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		
		// 5) 현재 페이지에서 보여줄 마지막 페이지 번호 계산 => 페이지 목록의 맨 뒷 번호
		int endPage = startPage + pageListLimit - 1;
		
		// 6) 단, 마지막 페이지 번호 값이 최대 페이지 번호 보다 클 경우 마지막 페이지 번호를 최대 페이지 번호로 교체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 3. 페이징 정보를 관리하는 객체에 pageInfoDTO 객체에 계산 결과 저장
		PageInfoDTO pageInfoDTO = new PageInfoDTO(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		
		// 4. 회원 목록 조회
		List<MemberDTO> userList = adminMapper.selectComList(startRow, listLimit, keyword, type, status, sort);
		
		// 5. UserPageDTO 객체에 게시물 목록 정보와 페이징 정보 저장 후 리턴
		return new UserPageDTO(userList, pageInfoDTO);
	}
	
	// 탈퇴한 회원 목록
	public UserPageDTO getComWithdraw(String keyword, String startDate, String endDate, String sort, Integer pageNum) {
		// [페이징 처리]
		// 1. 페이징 처리를 위해 조회할 목록 갯수 조절에 사용할 변수 선언
		int listLimit = 10;		// 한 페이지 당 표시할 게시물 갯수
		
		// 회원 목록 중 조회할 페이지의 첫번째 행 번호 계산
		int startRow = (pageNum - 1) * listLimit; 
		
		// 2. 실페 뷰페이지에서 페이징 처리를 수행하는데 필요한 계산 작업 및 페이지 목록 조회 작업
		// 1) 전체 회원 목록 갯수 조회
		int listCount = adminMapper.selectComWithdrawListCount(keyword, startDate, endDate);
		
		// 조회된 회원 수가 0보다 클 경우에만 페이지 계산 및 게시물 목록 조회 처리
		if(listCount == 0) {
			return new UserPageDTO(new ArrayList<>(), null);
		}
		// 2) 한 페이지에서 표시할 목록 갯수 설정
		int pageListLimit = 5;	// 한 페이지 당 표시할 페이지 목록 번호 갯수
		
		// 3) 최대 페이지 번호 계산
		int maxPage = (int)Math.ceil((double)listCount / listLimit);
		
		// 4) 현재 페이지에서 보여줄 시작 페이지 번호 계산 => 페이지 목록의 맨 앞 번호
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		
		// 5) 현재 페이지에서 보여줄 마지막 페이지 번호 계산 => 페이지 목록의 맨 뒷 번호
		int endPage = startPage + pageListLimit - 1;
		
		// 6) 단, 마지막 페이지 번호 값이 최대 페이지 번호 보다 클 경우 마지막 페이지 번호를 최대 페이지 번호로 교체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 3. 페이징 정보를 관리하는 객체에 pageInfoDTO 객체에 계산 결과 저장
		PageInfoDTO pageInfoDTO = new PageInfoDTO(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		
		// 4. 회원 목록 조회
		List<MemberDTO> userList = adminMapper.selectComWithdraw(startRow, listLimit, keyword, startDate, endDate, sort);
		  
		// 5. UserPageDTO 객체에 게시물 목록 정보와 페이징 정보 저장 후 리턴
		return new UserPageDTO(userList, pageInfoDTO);
	}

	// 기업회원 상세 정보 조회
	public MemberDTO getComInfo(long userId) {
		return adminMapper.selectComInfo(userId);
	}
	
	// 기업 공고 정보 조회
	public List<JobPostDTO> getJobPostInfo(long userId) {
		return adminMapper.selectJobPostInfo(userId); 
	}


	
	//======================================================================================
	// 공지사항 리스트 조회 (DTO 파라미터로 사용)
	public int getNoitceTotalCount(SearchDTO searchDTO) {
		return adminMapper.getNoticeTotalCount(searchDTO);
	}
	
	
	public List<NoticeDTO> getNoticeList(SearchDTO searchDTO){
		return adminMapper.getNoticeList(searchDTO);
	}
	
	// 공지사항 상세 조회(DTO 리턴)
	public NoticeDTO getNoticeDetail(int noticeId) {
		adminMapper.updateReadCount(noticeId);
		return adminMapper.getNoticeById(noticeId);
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
	public List<JobPostDTO> getJobPostList(SearchDTO searchDTO) {
		
		return adminMapper.getJobPostList(searchDTO);
	}
	
	public int getJobPostTotalCount(SearchDTO searchDTO) {
		return adminMapper.getJobPostTotalCount(searchDTO);
	}


	// 채용공고 상세 조회
	public JobPostDTO getJobPostDetail(long jobId) {
		return adminMapper.getJobPostById(jobId);
	}
	
	// 채용공고 삭제
	public void deleteJobPost(long jobId) {
		adminMapper.deleteJobPost(jobId);
	}
	// 채용공고 조회 업로드 파일
	public List<FileDTO> getFileList(long jobId) {
		
		return adminMapper.selectFileList(jobId);
	}


	//======================================================================================
	// 결제 내역 전체 목록 조회
	public PaymentPageDTO getPayList(String startDate, String endDate, String keyword, String userType, String payStatus, String sort, Integer pageNum) {
		// [페이징 처리]
		// 1. 페이징 처리를 위해 조회할 목록 갯수 조절에 사용할 변수 선언
		int listLimit = 10;		// 한 페이지 당 표시할 게시물 갯수
		
		// 결제 내역 목록 중 조회할 페이지의 첫번째 행 번호 계산
		int startRow = (pageNum - 1) * listLimit;
		
		// 2. 실페 뷰페이지에서 페이징 처리를 수행하는데 필요한 계산 작업 및 페이지 목록 조회 작업
		// 1) 전체 결제 내역 목록 갯수 조회
		int listCount = adminMapper.selectPaymentListCount(keyword, startDate, endDate, userType, payStatus);
		
		// 조회된 결제 내역 수가 0보다 클 경우에만 페이지 계산 및 결제 내역 목록 조회 처리
		if(listCount == 0) {
			return new PaymentPageDTO(new ArrayList<>(), null);
		}
		// 2) 한 페이지에서 표시할 목록 갯수 설정
		int pageListLimit = 5;	// 한 페이지 당 표시할 페이지 목록 번호 갯수
		
		// 3) 최대 페이지 번호 계산
		int maxPage = (int)Math.ceil((double)listCount / listLimit);
		
		// 4) 현재 페이지에서 보여줄 시작 페이지 번호 계산 => 페이지 목록의 맨 앞 번호
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		
		// 5) 현재 페이지에서 보여줄 마지막 페이지 번호 계산 => 페이지 목록의 맨 뒷 번호
		int endPage = startPage + pageListLimit - 1;
		
		// 6) 단, 마지막 페이지 번호 값이 최대 페이지 번호 보다 클 경우 마지막 페이지 번호를 최대 페이지 번호로 교체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 3. 페이징 정보를 관리하는 객체에 pageInfoDTO 객체에 계산 결과 저장
		PageInfoDTO pageInfoDTO = new PageInfoDTO(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		 
		// 4. 결제 내역 목록 조회
		List<PaymentDTO> paymentList = adminMapper.selectPaymentList(startRow, listLimit, keyword, startDate, endDate, userType, payStatus, sort);
		  
		// 5. SubmitPageDTO 객체에 게시물 목록 정보와 페이징 정보 저장 후 리턴
		return new PaymentPageDTO(paymentList, pageInfoDTO);
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
	public SubmitPageDTO getSubmitList(String startDate, String endDate, String keyword, String submitStatus, String sort, Integer pageNum) {
		// [페이징 처리]
		// 1. 페이징 처리를 위해 조회할 목록 갯수 조절에 사용할 변수 선언
		int listLimit = 10;		// 한 페이지 당 표시할 게시물 갯수
		
		// 공고 목록 중 조회할 페이지의 첫번째 행 번호 계산
		int startRow = (pageNum - 1) * listLimit;
		
		// 2. 실페 뷰페이지에서 페이징 처리를 수행하는데 필요한 계산 작업 및 페이지 목록 조회 작업
		// 1) 전체 공고 목록 갯수 조회
		int listCount = adminMapper.selectSubmitListCount(keyword, startDate, endDate, submitStatus);
		
		// 조회된 공고 수가 0보다 클 경우에만 페이지 계산 및 게시물 목록 조회 처리
		if(listCount == 0) {
			return new SubmitPageDTO(new ArrayList<>(), null);
		}
		
		// 2) 한 페이지에서 표시할 목록 갯수 설정
		int pageListLimit = 5;	// 한 페이지 당 표시할 페이지 목록 번호 갯수
		
		// 3) 최대 페이지 번호 계산
		int maxPage = (int)Math.ceil((double)listCount / listLimit);
		
		// 4) 현재 페이지에서 보여줄 시작 페이지 번호 계산 => 페이지 목록의 맨 앞 번호
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		
		// 5) 현재 페이지에서 보여줄 마지막 페이지 번호 계산 => 페이지 목록의 맨 뒷 번호
		int endPage = startPage + pageListLimit - 1;
		
		// 6) 단, 마지막 페이지 번호 값이 최대 페이지 번호 보다 클 경우 마지막 페이지 번호를 최대 페이지 번호로 교체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 3. 페이징 정보를 관리하는 객체에 pageInfoDTO 객체에 계산 결과 저장
		PageInfoDTO pageInfoDTO = new PageInfoDTO(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		
		// 4. 공고 목록 조회
		List<SubmitDTO> submitList = adminMapper.selectSubmitList(startRow, listLimit, keyword, startDate, endDate, submitStatus, sort);
		
		  
		// 5. SubmitPageDTO 객체에 게시물 목록 정보와 페이징 정보 저장 후 리턴
		return new SubmitPageDTO(submitList, pageInfoDTO);
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
	
	// ====================================================================================
//	 [자유게시판 관리]
	
	public int getBoardTotalCount(SearchDTO searchDTO) {
		return adminMapper.getBoardTotalCount(searchDTO);
	}

	// 자유게시판 목록 조회
	public List<FreeDTO> getBoardList(SearchDTO searchDTO) {
		return adminMapper.getBoardList(searchDTO);
	}

	// 자유게시판 상세 조회
	public FreeDTO getBoardDetailById(long postId) {
		adminMapper.updateBoardCount(postId);
		
		return adminMapper.getBoardDetail(postId);
	}
	
	// 자유게시판 게시글 삭제
	public void deleteBoard(long postId) {
		
		adminMapper.deleteBoard(postId);
	}

	

	// 자유게시판 댓글 조회
	public List<CommentDTO> getCommentByPostId(long postId) {
		return adminMapper.getCommentByPostId(postId);
	}


	// 자유게시판 댓글 삭제

	public void deleteComment(long commentId) {
		adminMapper.deleteComment(commentId);
	}


	

	
	
	// =======================================================================================
	// 1:1문의글관리 
	
	public int getQnaTotalCount(SearchDTO searchDTO) {
		return adminMapper.getQnaTotalCount(searchDTO);
	}

	public List<QnaDTO> getQnaList(SearchDTO searchDTO) {

		return adminMapper.getQnaList(searchDTO);
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
	public List<FaqDTO> getFaqList(SearchDTO searchDTO) {
		return adminMapper.getFaqList(searchDTO);
	}
	
	public int getFaqTotalCount(SearchDTO searchDTO) {
		return adminMapper.getFaqTotalCount(searchDTO);
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
		int existingCount = adminMapper.countBannerById(bannerDTO.getJobId());
		System.out.println("existingCount: " + existingCount);
		
		if (existingCount == 0) {
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
		result.put("country", adminMapper.getCountryStats());
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
//	전체 결제 통계
	public Map<String, Object> getTotalPayStatistics() {
	    Map<String, Object> result = new HashMap<>();
	    
	    List<Map<String, Object>> statsList = adminMapper.getTotalRevenueStats();
	    
	    List<String> labels = new ArrayList<>();
	    List<Long> values = new ArrayList<>();
	    long totalSum = 0; // 총 합계를 계산할 변수
	    
	    for (Map<String, Object> row : statsList) {
	        String label = String.valueOf(row.get("label"));
	        Long value = ((Number) row.get("value")).longValue();
	        
	        labels.add(label);
	        values.add(value);
	        totalSum += value; 
	    }
	    
	    // 2. 차트용 데이터
	    result.put("labels", labels);
	    result.put("data", values);
	    
	    // 3. '7일간 총 수익금액'
	    result.put("totalSum", totalSum); 
	    
	    return result;
	}




}
