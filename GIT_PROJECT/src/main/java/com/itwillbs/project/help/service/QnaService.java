package com.itwillbs.project.help.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.common.util.FileUtils;
import com.itwillbs.project.help.dto.SupportQnaDTO;
import com.itwillbs.project.help.mapper.QnaMapper;

@Service
public class QnaService {

    @Autowired
    private QnaMapper qnaMapper; // [수정] DTO가 아니라 Mapper 인터페이스를 주입받아야 합니다!

    @Transactional
    public void registerQna(SupportQnaDTO qna, List<MultipartFile> files) throws Exception {
        qnaMapper.insertQna(qna); // DB에 글 저장
        
        if (files != null && !files.isEmpty()) {
            List<FileDTO> fileList = FileUtils.uploadQnaFile(files);
            
            for (FileDTO fileDto : fileList) {
                fileDto.setQnaId(qna.getQnaId());
                fileDto.setCategoryIdx(6); 
                qnaMapper.insertFile(fileDto); // DB에 파일 정보 저장
            }
        }
    }
    
    public List<SupportQnaDTO> getQnaList(Long writerId) {
        return qnaMapper.selectQnaList(writerId);
    }

	public SupportQnaDTO getQnaDetail(int qnaId) {
		return qnaMapper.selectQnaDetail(qnaId);
	}
	
	public boolean removeQna(int qnaId, Long sId) throws Exception {
	    // 1. 먼저 해당 글 정보를 가져와서 상태 확인
	    SupportQnaDTO qna = qnaMapper.selectQnaDetail(qnaId);
	    // Service 예시
	    // qna가 없는 경우 예외 처리 추가 (보안)
	    if (qna == null) {
	        throw new Exception("존재하지 않는 게시글입니다.");
	    }

	    // 객체 비교는 equals가 안전합니다.
	    if (!sId.equals(qna.getWriterId())) { 
	        throw new Exception("본인의 글만 삭제할 수 있습니다.");
	    }
	    
	    // 2. 답변 완료(completed) 상태라면 삭제 거부
	    if ("completed".equals(qna.getReStatus())) {
	        return false; // 삭제 실패
	    }
	    
	    // 3. 답변 전(pending) 상태라면 삭제 진행
	    qnaMapper.deleteQna(qnaId);
	    return true; // 삭제 성공
	}

	public List<FileDTO> getFileList(int qnaId) {
		return qnaMapper.getFileList(qnaId);
	}
    
}