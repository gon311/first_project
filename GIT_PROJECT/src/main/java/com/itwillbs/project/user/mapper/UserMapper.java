package com.itwillbs.project.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.user.dto.UserDTO;

@Mapper
public interface UserMapper {

	void insertUser(UserDTO userDTO);
	void insertUserPe(UserDTO userDTO);
	void insertUserCo(@Param("user") UserDTO userDTO);
	void insertUserTR(UserDTO userDTO);
	
	UserDTO selectUser(String email);
	List<UserDTO> selectUserIdList();



}
