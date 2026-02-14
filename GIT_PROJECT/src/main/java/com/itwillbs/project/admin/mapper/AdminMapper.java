package com.itwillbs.project.admin.mapper;

import java.math.BigInteger;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.admin.dto.MemberDTO;

@Mapper
public interface AdminMapper {
	// 구직자 회원 전체 목록
	List<MemberDTO> selectUser();
	
	// 구직자 회원 목록 필터링
	List<MemberDTO> selectUserFilter(@Param("user_name") String user_name
								,@Param("user_type") String user_type
								,@Param("status") String status);

	// 구직자 회원 상세 정보
	MemberDTO selectUserInfo(BigInteger id);

 
}
