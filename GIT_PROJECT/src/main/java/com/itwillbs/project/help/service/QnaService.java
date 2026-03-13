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
    
}