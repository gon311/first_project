package com.itwillbs.project.board.service;

import java.io.IOException;
import java.util.List;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.project.board.dto.BoardCond;
import com.itwillbs.project.board.dto.BoardDTO;
import com.itwillbs.project.board.mapper.BoardCommentMapper;
import com.itwillbs.project.board.mapper.BoardMapper;
import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.common.mapper.FileMapper;
import com.itwillbs.project.common.util.FileUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@RequiredArgsConstructor
@Log4j2
public class BoardService {

	@Autowired
	private final BoardMapper boardMapper;
	private final FileMapper fileMapper;
	private final BoardCommentMapper boardCommentMapper;

	// 게시물 등록
	public void registBoard(BoardDTO boardDTO, List<MultipartFile> files, List<String> tags) throws IOException {

		// 1. 게시글 먼저 저장
		boardMapper.insertBoard(boardDTO);

		// 2. 태그 저장
		saveBoardTags(boardDTO.getPostId(), tags);

		// 3. 파일 업로드
		List<FileDTO> fileList = FileUtils.uploadBoardFile(files);

		if (!fileList.isEmpty()) {
			fileMapper.insertFiles(fileList, boardDTO.getPostId(), "FREE");
		}
	}

	// 게시물 상세정보 조회
	public BoardDTO getBoard(Long postId) {
		BoardDTO post = boardMapper.selectBoard(postId);

		if (post != null) {
			post.setTagList(boardMapper.selectBoardTags(postId));
		}

		return post;
	}

	public void increaseReadcount(Long postId) {
		boardMapper.updateReadcount(postId);
	}

	// 파일 다운
	public List<FileDTO> getBoardFiles(Long postId) {
		return boardMapper.selectBoardFiles(postId);
	}

	public FileDTO getFileById(Integer fileId) {
		return boardMapper.selectFileById(fileId);
	}
	
	

	// 게시물 목록 조회
	public List<BoardDTO> getBoardList(BoardCond cond) {
	    List<BoardDTO> posts = boardMapper.selectBoardList(cond);

	    if (posts != null) {
	        for (BoardDTO post : posts) {
	            post.setExcerpt(makePreview(post.getContent()));
	        }
	    }

	    return posts;
	}
	
	private String makePreview(String content) {
	    if (content == null || content.isBlank()) {
	        return "";
	    }

	    String preview = content
	            .replaceAll("<[^>]*>", " ")
	            .replaceAll("&nbsp;", " ")
	            .replaceAll("\\s+", " ")
	            .trim();

	    if (preview.length() > 80) {
	        preview = preview.substring(0, 80) + "...";
	    }

	    return preview;
	}
	

	public int getBoardCount(BoardCond cond) {
		return boardMapper.selectBoardCount(cond);
	}

	// 게시글 수정
	public boolean updateBoard(BoardDTO boardDTO,
	                           List<Integer> deleteFileIds,
	                           List<MultipartFile> files,
	                           List<String> tags,
	                           Long userId) throws IOException {

		BoardDTO post = boardMapper.selectBoard(boardDTO.getPostId());

		if (post == null) return false;
		if (!userId.equals(post.getAuthorMemberId())) return false;

		int updateCount = boardMapper.updateBoard(boardDTO);
		if (updateCount <= 0) {
			return false;
		}

		// 기존 태그 삭제 후 재등록
		boardMapper.deleteBoardTags(boardDTO.getPostId());
		saveBoardTags(boardDTO.getPostId(), tags);

		// 삭제할 파일 제거
		deleteBoardFiles(deleteFileIds);
		
		// 본문 에디터 이미지 삭제
		deleteEditorImagesFromContent(post.getContent());

		// 새 파일 추가
		if (files != null && !files.isEmpty()) {
			List<FileDTO> fileList = FileUtils.uploadBoardFile(files);

			for (FileDTO fileDTO : fileList) {
				boardMapper.insertBoardFile(boardDTO.getPostId(), fileDTO);
			}
		}

		return true;
	}

	// 게시글 삭제
	public boolean deleteBoard(Long postId, Long userId) {

		BoardDTO post = boardMapper.selectBoard(postId);

		if (post == null) return false;
		if (!userId.equals(post.getAuthorMemberId())) return false;

		deleteBoardFilesByPostId(postId);
		
		// 본문 에디터 이미지 삭제
		deleteEditorImagesFromContent(post.getContent());

		// 댓글 전체 soft delete
		boardCommentMapper.deleteCommentsByPostId(postId);

		// 태그는 FK ON DELETE CASCADE라 게시글이 진짜 delete면 자동,
		// 지금은 soft delete라 굳이 남겨도 되지만 정리하고 싶으면 아래 사용
		boardMapper.deleteBoardTags(postId);

		return boardMapper.deleteBoard(postId) > 0;
	}
	
	// 본문 안 에디터 이미지 삭제
	private void deleteEditorImagesFromContent(String content) {
		if (content == null || content.isBlank()) {
			return;
		}

		Pattern pattern = Pattern.compile(
				"/board/image/view\\?filePath=([^\"&]+)(?:&|&amp;)storedName=([^\"'>]+)"
		);
		Matcher matcher = pattern.matcher(content);

		while (matcher.find()) {
			try {
				String filePath = URLDecoder.decode(matcher.group(1), StandardCharsets.UTF_8.name());
				String storedName = URLDecoder.decode(matcher.group(2), StandardCharsets.UTF_8.name());

				FileDTO fileDTO = new FileDTO();
				fileDTO.setFilePath(filePath);
				fileDTO.setStoredName(storedName);

				log.info("에디터 이미지 삭제 시도 - filePath: {}, storedName: {}", filePath, storedName);

				FileUtils.deleteBoardFile(fileDTO);

			} catch (Exception e) {
				log.error("에디터 이미지 삭제 실패", e);
			}
		}
	}

	// 태그 저장 공통 메서드
	private void saveBoardTags(Long postId, List<String> tags) {
		if (tags == null || tags.isEmpty()) {
			return;
		}

		for (String tag : tags) {
			if (tag != null && !tag.trim().isEmpty()) {
				boardMapper.insertBoardTag(postId, tag.trim());
			}
		}
	}

	// 파일 삭제
	private void deleteBoardFiles(List<Integer> fileIds) {
		if (fileIds == null || fileIds.isEmpty()) {
			return;
		}

		for (Integer fileId : fileIds) {
			FileDTO fileDTO = boardMapper.selectFileById(fileId);

			if (fileDTO != null) {
				FileUtils.deleteBoardFile(fileDTO);
				boardMapper.deleteBoardFile(fileId);
			}
		}
	}

	// 게시글 전체 파일 삭제
	private void deleteBoardFilesByPostId(Long postId) {
		List<FileDTO> fileList = boardMapper.selectBoardFiles(postId);

		if (fileList == null || fileList.isEmpty()) {
			return;
		}

		for (FileDTO fileDTO : fileList) {
			FileUtils.deleteBoardFile(fileDTO);
			boardMapper.deleteBoardFile(fileDTO.getFileId());
		}
	}
	
	
	// 게시글 작성자 신고
	public boolean reportBoard(Long postId, Long loginUserId) {
	    Long authorUserId = boardMapper.selectAuthorMemberIdByPostId(postId);

	    if (authorUserId == null) return false;

	    // 본인 글 신고 방지
	    if (authorUserId.equals(loginUserId)) return false;

	    return boardMapper.increaseReportReceivedCount(authorUserId) > 0;
	}

}