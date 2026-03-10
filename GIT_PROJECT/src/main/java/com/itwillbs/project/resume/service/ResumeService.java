package com.itwillbs.project.resume.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.resume.dto.ResumeDTO;
import com.itwillbs.project.resume.dto.ResumeEducationDTO;
import com.itwillbs.project.resume.dto.ResumeExperienceDTO;
import com.itwillbs.project.resume.mapper.ResumeMapper;

@Service
public class ResumeService {

	@Autowired
	private ResumeMapper resumeMapper;
	
	/* 이력서 저장 요청. */
	public void registResume(ResumeDTO resumeDTO) {
		resumeMapper.insertResume(resumeDTO);
//		return resumeDTO.getResumeId();	// pk 반환.
	}
	
	// 이력서_학력정보 저장
	public void registResumeEdu(ResumeEducationDTO eduDTO) {
		resumeMapper.insertResumeEdu(eduDTO);		
	}

	// 이력서_경력정보 저장 
	public void registResumeExp(ResumeExperienceDTO expDTO) {
		resumeMapper.insertResumeExp(expDTO);	
	}
	

	// 이력서 저장 후 상세정보.
	public ResumeDTO getResumeInfo(Integer resumeId) {

		ResumeDTO resume = resumeMapper.selectResume(resumeId);
		// 이력서 학력정보 상세.
		List<ResumeEducationDTO> educationList =
	            resumeMapper.selectEducationList(resumeId);
		// 이력서 경력정보 상세.
	    List<ResumeExperienceDTO> experienceList =
	            resumeMapper.selectExperienceList(resumeId);
	    
	    resume.setEducationList(educationList);
	    resume.setExperienceList(experienceList);
		
		return resume;
	}
	
	public int modifyResume(ResumeDTO resumeDTO) {
		// 
		return resumeMapper.updateResume(resumeDTO);
	}

	public List<ResumeDTO> getResumeList(int userIdx) {
		// productMapper.selectProductList();
		return resumeMapper.selectResumeList(userIdx);
	}

	public void deleteResumeEdu(int resumeId) {
		resumeMapper.deleteResumeEdu(resumeId);
	};    // 기존 학력 삭제
	public void deleteResumeExp(int resumeId){
		resumeMapper.deleteResumeExp(resumeId);
	};    // 기존 경력 삭제
	
	// 새학력, 경력 저장은 기존거 사용.
}
