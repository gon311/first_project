package com.itwillbs.project.comMy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.itwillbs.project.comMy.dto.ComMyDTO;
import com.itwillbs.project.comMy.mapper.ComMyMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@RequiredArgsConstructor
@Log4j2
public class ComMyService {
	@Autowired
	private ComMyMapper comMyMapper;

	public ComMyDTO getUser(String sId) {
		return comMyMapper.selectUser(sId);
	}
	
}




