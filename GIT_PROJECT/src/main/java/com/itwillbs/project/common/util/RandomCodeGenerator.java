package com.itwillbs.project.common.util;

import org.apache.commons.lang3.RandomStringUtils;

// 특정 난수 생성에 활용할 클래스 정의
public class RandomCodeGenerator {
	
	public static String getRandomCode(int length) {
		
		return RandomStringUtils.randomAlphanumeric(length);
	}
}



















