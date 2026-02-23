package com.itwillbs.project.user.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project.user.dto.UserDTO;
import com.itwillbs.project.user.mapper.UserMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {
	private final UserMapper userMapper;
	private PasswordEncoder passwordEncoder;
	
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

	public UserDTO getUser(String email) {
		return userMapper.selectUser(email);
	}

	public List<UserDTO> getUserIdList() {
		return userMapper.selectUserIdList();
	}

	public boolean newPassword(String newPass, String sId) {
	    String dbHash = userMapper.selectPassword(sId); // DB에 저장된 해시 비번

	    if (dbHash == null) return false;

	    // 현재 비번 검증
	    if (!passwordEncoder.matches(newPass, dbHash)) return false;

	    // 새 비번 저장: 원문 저장 금지 -> encode 해서 저장
	    String newHash = passwordEncoder.encode(newPass);

	    int updated = userMapper.updatePassword(sId, newHash);
	    return updated > 0;
	}





	

}




