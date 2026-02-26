package com.itwillbs.project.gpt.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.itwillbs.project.gpt.dto.GptGenerateDTO;
import com.itwillbs.project.gpt.mapper.GptGenerateMapper;
import com.openai.client.OpenAIClient;
import com.openai.client.okhttp.OpenAIOkHttpClient;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class GptGenerateService {
	
	private GptGenerateMapper generateMapper;
	private OpenAIClient client;
	
	public GptGenerateService(@Value("${gpt.api_key}") String apiKey) {
		this.client = OpenAIOkHttpClient.builder()
				.apiKey(apiKey)
				.build();
	}
	
	public String generateContent(GptGenerateDTO generateDTO) {		
		GptGenerateDTO dto = generateMapper.selectPromptData(generateDTO.getCoverLetterIdx());
		
		String prompt = String.join("\n", 
				""
				);
		
		
		String generatedContent = null;
		
		return 	generatedContent;

	}

	
	
}
