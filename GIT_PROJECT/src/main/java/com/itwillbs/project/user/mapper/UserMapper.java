package com.itwillbs.project.user.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project.user.dto.UserDTO;

@Mapper
public interface UserMapper {

	void insertUser(UserDTO userDTO);
	void insertUserPe(UserDTO userDTO);
	void insertUserCo(UserDTO userDTO);
	void insertUserTR(UserDTO userDTO);
	
	UserDTO selectUser(String email);



}
