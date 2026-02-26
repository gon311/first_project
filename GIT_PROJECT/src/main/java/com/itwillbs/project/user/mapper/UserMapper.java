package com.itwillbs.project.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.user.dto.UserDTO;

@Mapper
public interface UserMapper {

	//회원가입
	void insertUser(UserDTO userDTO);
	void insertUserPe(UserDTO userDTO);
	void insertUserCo(UserDTO userDTO);
	void insertUserTR(UserDTO userDTO);
	
	// 로그인
	UserDTO selectUser(String email);
	
	// 아이디 찾기
	List<UserDTO> selectUserIdList(UserDTO userDTO);
	
	// 비밀번호 찾기
	String selectPassword(String sId);
	int updatePassword(@Param("sId") String sId,@Param("password") String newHash);



}
