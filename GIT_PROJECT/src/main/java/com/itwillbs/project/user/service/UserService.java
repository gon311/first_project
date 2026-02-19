package com.itwillbs.project.user.service;

import org.springframework.stereotype.Service;

import com.itwillbs.project.user.dto.UserDTO;
import com.itwillbs.project.user.mapper.UserMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {
	private final UserMapper userMapper;
	
	public void registUser(UserDTO userDTO) {
		userMapper.insertUser(userDTO);
	}

}




