package com.itwillbs.project.resume.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.resume.dto.ResumeDTO;
import com.itwillbs.project.resume.dto.ResumeEducationDTO;
import com.itwillbs.project.resume.dto.ResumeExperienceDTO;

@Mapper
public interface ResumeMapper {

	// 이력서 저장.(저장 후 resume_Id 리턴)
	void insertResume(ResumeDTO resumeDTO);
	
	// 이력서 저장 - 학력정보.
	void insertResumeEdu(ResumeEducationDTO eduDTO);

	// 이력서 저장 - 학력정보.
	void insertResumeExp(ResumeExperienceDTO expDTO);
	

	// 선택(작성)한 이력서(상세정보) 불러오기.
	ResumeDTO selectResume(Integer resumeId);
	List<ResumeEducationDTO> selectEducationList(int resumeId);
    List<ResumeExperienceDTO> selectExperienceList(int resumeId);
		

	// 이력서 업데이트. 
	int updateResume(ResumeDTO resumeDTO);

	// 내 이력서 리스트를 가져옵니다. selectResumeList() 
	List<ResumeDTO> selectResumeList(Integer userIdx);

	void deleteResumeEdu(int resumeId);

	void deleteResumeExp(int resumeId);

	void insertResumePhoto(FileDTO fileDTO);

	// 내 이력서의 사진을 가져옵니다.(1장)
	FileDTO selectResumePhoto(Integer resumeId);

	void deleteUpPhoto(int resumeId);

}
