package com.itwillbs.project.user.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project.user.dto.UserDTO;
import com.itwillbs.project.user.mapper.UserMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {
	private final UserMapper userMapper;
	
//	public void registUser(UserDTO userDTO) {
//		userMapper.insertUser(userDTO);
//	}
	
	@Transactional // 다 성공하거나, 다 실패해야 함 (원자성)
    public void registUser(UserDTO userDTO) {
        userMapper.insertUser(userDTO);
        
		if(userDTO.getUserType().equals("P")) {
			userMapper.insertUserPe(userDTO);
		} else if(userDTO.getUserType().equals("C")) {
			userMapper.insertUserCo(userDTO);
		}
		
		userMapper.insertUserTR(userDTO);
    }

//	public UserDTO getUser(String email) {
//		return userMapper.selectUser(email);
//	}



	

}




