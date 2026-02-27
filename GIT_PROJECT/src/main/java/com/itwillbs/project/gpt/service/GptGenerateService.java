package com.itwillbs.project.gpt.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.project.gpt.dto.GptGenerateDTO;
import com.itwillbs.project.gpt.dto.GptResponseDTO;
import com.itwillbs.project.gpt.mapper.GptGenerateMapper;
import com.openai.client.OpenAIClient;
import com.openai.client.okhttp.OpenAIOkHttpClient;
import com.openai.models.ChatModel;
import com.openai.models.chat.completions.ChatCompletionCreateParams;
import com.openai.models.chat.completions.StructuredChatCompletion;
import com.openai.models.chat.completions.StructuredChatCompletionCreateParams;

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
	
	public String generateContent(GptGenerateDTO generateDTO) throws JsonProcessingException {		
		
		// 1. DB데이터 조회 
		GptGenerateDTO metaDateDTO = generateMapper.selectPromptData(generateDTO.getCoverLetterIdx());
		log.info(">>>>>>>>>>metaDateDTO : " + metaDateDTO);
		
		if (metaDateDTO == null) {
		    log.error("잘못된 접근: 존재하지 않는 idx({})", generateDTO.getCoverLetterIdx());
		    return "요청하신 정보를 찾을 수 없습니다. 다시 시도해 주세요."; 
		}
		
		// 2. System Message : 역할과 규칙 정의 			
		String systemMessage = String.join("\n", 
				"당신은 10년 차 전문 커리어 컨설턴트입니다. \r\n"
				+ "사용자가 제공하는 경험이나 이력 정보를 바탕으로, STAR(Situation, Task, Action, Result) 기법을 활용해 "
				+ "500자 내외의 전문적인 자기소개서를 작성합니다.\r\n"
				+ "\r\n"
				+ "[핵심 원칙]\r\n"
				+ "1. 톤앤매너: 정중하고 신뢰감 있는 비즈니스 전문 용어를 사용합니다.\r\n"
				+ "2. 역량 중심: 지원 직무에 필요한 핵심 역량이 문장 곳곳에 드러나게 합니다.\r\n"
				+ "3. 논리적 구조: STAR 구조를 엄격히 준수하여 성과 중심으로 서술합니다.\r\n"
				+ "4. 글자 수: 공백 포함 500자 내외를 준수합니다.\r\n"
				+ "\r\n"
				+ "[응답 형식]\r\n"
				+ "반드시 아래 JSON 형식으로만 응답하며, 앞뒤 설명이나 인사말은 절대 포함하지 마세요.\r\n"
				+ "{\r\n"
				+ "  \"title\": \"직무 역량을 나타내는 강렬한 소제목\",\r\n"
				+ "  \"content\": \"STAR 기법이 적용된 본문 내용\"\r\n"
				+ "}"
		);
		
		// 3. User Message : 실제 데이터 주입 
		String userMessage = String.format(
				"[지원 정보]\n- 회사명: %s (%s)\n- 산업군: %s\n- 직무: %s\n- 세부직무: %s\n- 경력: %s\n\n" +
	            "[자기소개서 질문]\n%s\n\n" +
	            "[지원자 입력 내용]\n%s",
	            metaDateDTO.getCompanyName(), metaDateDTO.getIndustryName(), metaDateDTO.getJobName(), metaDateDTO.getRoleName(), 
	            metaDateDTO.getCareerName(), 
	            metaDateDTO.getQuestionName(), 
	            generateDTO.getContent()
	    );
		
		// 4. ChatGPT 요청
		StructuredChatCompletionCreateParams<GptResponseDTO> params = ChatCompletionCreateParams.builder()
				.model(ChatModel.GPT_4_1_MINI)
				.addSystemMessage(systemMessage)
				.addUserMessage(userMessage)
				.responseFormat(GptResponseDTO.class)
				.build();
		
		StructuredChatCompletion<GptResponseDTO> response = client.chat().completions().create(params);
		
		GptResponseDTO result = 
				response.choices().get(0)
				.message()
				.content()
				.orElse(new GptResponseDTO());
		
		log.info("result : " + result);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		return objectMapper.writeValueAsString(result);

	}

	
	
}
