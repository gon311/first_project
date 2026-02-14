package com.itwillbs.project.admin.mapper;

import java.math.BigInteger;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.admin.dto.MemberDTO;

@Mapper
public interface AdminMapper {

	List<MemberDTO> selectUserFilter(@Param("user_name") String user_name
								,@Param("user_type") String user_type
								,@Param("status") String status);

	MemberDTO selectUserInfo(BigInteger id);

	List<MemberDTO> selectUser();
 
}
