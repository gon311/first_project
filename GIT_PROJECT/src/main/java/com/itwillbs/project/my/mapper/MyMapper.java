package com.itwillbs.project.my.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.my.dto.MyDTO;
import com.itwillbs.project.my.dto.MyResumeDTO;
import com.itwillbs.project.my.dto.MyReviewDTO;

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

	List<MyReviewDTO> selectMyReviewList(@Param("userId") Long userId);
	
	

}
