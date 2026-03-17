package com.itwillbs.project.gpt.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.project.gpt.dto.CopyCheckDTO;
import com.itwillbs.project.gpt.dto.GptGenerateDTO;
import com.itwillbs.project.gpt.dto.GptResponseDTO;
import com.itwillbs.project.gpt.dto.PassCheckDTO;
import com.itwillbs.project.gpt.dto.SpellCheckDTO;
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
	
	@Autowired
	private GptGenerateMapper generateMapper;
	private final OpenAIClient client;
	
	public GptGenerateService(@Value("${gpt.api_key}") String apiKey) {
		this.client = OpenAIOkHttpClient.builder()
				.apiKey(apiKey)
				.build();
	}
	
	// 생성하기 전 회원권 체크 및 차감 
	@Transactional
	public boolean deductUserPass(Long userId) {
		
		// 이용권 상태 및 잔여 횟수 조회 
		PassCheckDTO passCheckDTO = generateMapper.selectCount(userId);  // status 정보 가져옴 
		
		// 예외 처리 
		if(passCheckDTO == null || "expired".equals(passCheckDTO.getUseStatus()) || passCheckDTO.getRemainingCount() <= 0) {
			return false;
		}
		
		// 횟수 차감 
		generateMapper.updatePersonPass(userId);
	    generateMapper.updateProductRemain(userId);
		
		// 차감 후 0이 되었다면 상태를 expired로 변경 
	    if (passCheckDTO.getRemainingCount() - 1 == 0) {
	        generateMapper.updateStatusToExpired(userId);
	    }
		return true;
	}
	
	public String generateContent(GptGenerateDTO generateDTO) throws JsonProcessingException {		
		
		// 1. DB데이터 조회 
		GptGenerateDTO metaDataDTO = generateMapper.selectPromptData(generateDTO.getCoverLetterIdx());
		log.info(">>>>>>>>>>metaDataDTO : " + metaDataDTO);
		
		if (metaDataDTO == null) {
		    log.error("잘못된 접근: 존재하지 않는 idx({})", generateDTO.getCoverLetterIdx());
		    return "요청하신 정보를 찾을 수 없습니다. 다시 시도해 주세요."; 
		}
		
		// 2. System Message : 역할과 규칙 정의 			
		String systemMessage = String.join("\n",
			    "당신은 10년 차 전문 커리어 컨설턴트입니다.",
			    "사용자가 제공하는 경험이나 이력 정보를 바탕으로, STAR 구조를 내부 논리 구성에만 활용하여",
			    "500자 내외의 전문적인 자기소개서를 작성합니다.",
			    "",
			    "[핵심 원칙]",
			    "1. 톤앤매너: 정중하고 신뢰감 있는 비즈니스 전문 용어를 사용합니다.",
			    "2. 역량 중심: 지원 직무에 필요한 핵심 역량이 문장 곳곳에 드러나게 합니다.",
			    "3. 서술 방식: Situation, Task, Action, Result라는 단어를 직접 표기하지 말고,",
			    "   하나의 자연스러운 단락으로 유기적으로 연결하여 작성합니다.",
			    "4. 성과 중심: 정량적 결과가 있다면 반드시 포함합니다.",
			    "5. 글자 수: 공백 포함 500자 내외를 준수합니다.",
			    "",
			    "[중요 금지 사항]",
			    "- 'Situation:', 'Task:' 등의 라벨을 절대 사용하지 마세요.",
			    "- 항목 구분 형식으로 작성하지 마세요.",
			    "- 설명이나 메타 코멘트를 추가하지 마세요.",
			    "",
			    "[응답 형식]",
			    "반드시 아래 JSON 형식으로만 응답하세요.",
			    "{",
			    "  \"title\": \"직무 역량을 나타내는 강렬한 소제목\",",
			    "  \"content\": \"STAR 논리가 자연스럽게 녹아든 단락형 본문\"",
			    "}"
			);
		
		// 3. User Message : 실제 데이터 주입 
		StringBuilder sb = new StringBuilder();

		sb.append("[지원 정보]\n")
		  .append("- 회사명: ").append(metaDataDTO.getCompanyName()).append("\n")
		  .append("- 회사유형: (").append(metaDataDTO.getCompanyType()).append(")\n")
		  .append("- 산업군: ").append(metaDataDTO.getIndustryName()).append("\n")
		  .append("- 직무: ").append(metaDataDTO.getJobName()).append("\n")
		  .append("- 세부직무: ").append(metaDataDTO.getRoleName()).append("\n")
		  .append("- 경력: ").append(metaDataDTO.getCareerName()).append("\n\n")
		  .append("[자기소개서 질문]\n")
		  .append(metaDataDTO.getQuestionName()).append("\n\n")
		  .append("[지원자 입력 내용]\n")
		  .append(generateDTO.getContent());

		String userMessage = sb.toString();
		
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

	public String spellCheck(String inputText) throws JsonProcessingException {
		
		// 1. 역할과 규칙 정의 
		String systemMessage = String.join("\n", 
				"당신은 10년 차 베테랑 국어 교정교열 전문가입니다.\r\n"
			    + "사용자가 제공하는 텍스트의 맞춤법, 띄어쓰기, 문법을 완벽하게 교정합니다.\r\n"
			    + "\r\n"
			    + "[핵심 원칙]\r\n"
			    + "1. 정확성: 국립국어원 표준 규정을 엄격히 준수합니다.\r\n"
			    + "2. 시각적 강조: 수정되거나 추가된 부분은 반드시 <span style=\"color:red\">수정내용</span> 태그로 감싸서 표시합니다.\r\n"
			    + "3. 원문 유지: 의미가 변하지 않는 한 원문의 문체와 의도를 최대한 존중합니다.\r\n"
			    + "\r\n"
			    + "[응답 형식]\r\n"
			    + "반드시 아래 JSON 형식으로만 응답하며, 앞뒤 설명이나 인사말은 절대 포함하지 마세요.\r\n"
			    + "{\r\n"
			    + "  \"corrected\": \"교정된 내용이 <span style=\\\"color:red\\\">반영된</span> 최종 텍스트\"\r\n"
			    + "}"
		);
		
		// 2. 실제 주입 메세지
		String userMessage = String.format(
				"아래 제공된 텍스트의 맞춤법, 띄어쓰기 및 문법을 분석하여 교정해 주세요.\n\n" +
				"[교정 대상 텍스트]\n%s", 
				inputText
		);
		
		// 3. ChatGPT 요청
		StructuredChatCompletionCreateParams<SpellCheckDTO> params = ChatCompletionCreateParams.builder()
				.model(ChatModel.GPT_4_1_MINI)
				.addSystemMessage(systemMessage)
				.addUserMessage(userMessage)
				.responseFormat(SpellCheckDTO.class)
				.build();
		
		StructuredChatCompletion<SpellCheckDTO> response = client.chat().completions().create(params);
		
		SpellCheckDTO result = 
				response.choices().get(0)
				.message()
				.content()
				.orElse(new SpellCheckDTO());
		
		log.info("result : " + result);
					
		// 4. JSON 문자열로 반환
		ObjectMapper objectMapper = new ObjectMapper();
		
		return objectMapper.writeValueAsString(result);
		
	}

	public String copyCheck(String inputText) throws JsonProcessingException {
		log.info("1. 메서드 진입 성공, inputText: " + inputText);
		
		if (client == null) {
	        log.error("범인 검거! client 객체가 null입니다.");
	    }
		
		// 1. 역할과 규칙 정의 
		String systemMessage = String.join("\n",
				"당신은 사용자의 원문이 가진 핵심 의미와 문맥을 완벽히 보존하면서, "
				+ "독창적이고 세련된 비즈니스 문장으로 재구성하는 [문장 다듬기] 전문가입니다.\r\n"
				+ "사용자가 제공하는 텍스트에서 기존 자료와 표현 방식이 유사해 보이는 구간(표절 의심 가능 구간)을 탐지하고, "
				+ "의미를 유지하며 완전히 새로운 방식으로 재구성(Paraphrasing)합니다. 또한 각 수정의 이유를 전문적으로 설명합니다.\r\n"
				+ "\r\n"
				+ "[핵심 원칙]\r\n"
				+ "1. 문맥 및 의미 보존: 사용자의 구체적인 경험이나 수치, 사실관계는 절대 왜곡하거나 생략하지 않습니다.\r\n"
				+ "2. 독창적 재구성: 흔한 관용구나 상투적인 문구를 지양하고, 유의어 교체 및 문장 구조 변경(도치, 능동 전환 등)을 통해 고유한 문체를 형성합니다.\r\n"
				+ "3. 비즈니스 톤: 구인구직 상황에 적합하도록 격식 있고 신뢰감 있는 어조를 유지합니다.\r\n"
				+ "4. 강조 표기: 수정된 부분에만 <span style='color:#0d6efd; font-weight:bold;'>내용</span> 태그를 적용하여 한눈에 차이를 확인할 수 있게 합니다.\r\n"
				+ "5. 상세한 설명: description은 <ul>, <li> 태그를 포함하며, 각 수정 이유를 명확히 제시합니다.\r\n"
				+ "6. 금지 사항: JSON 외의 텍스트, 마크다운 코드블록(```json 등), 앞뒤 인사말, 설명 문구는 절대로 포함하지 않습니다.\r\n"
				+ "\r\n"
				+ "[응답 형식]\r\n"
				+ "반드시 아래 JSON 구조를 지키되, 모든 값은 JSON 문법에 따라 이스케이프(Escape) 처리된 문자열이어야 합니다.\r\n"
				+ "\r\n"
				+ "{\r\n"
				+ "  \"corrected\": \"재구성된 전체 텍스트. 수정된 부분은 <span style='color:#0d6efd; font-weight:bold;'>강조 태그</span>로 표시.\",\r\n"
				+ "  \"description\": \"<ul><li><b>수정사항 1:</b> 근거 및 방법</li><li><b>수정사항 2:</b> 근거 및 방법</li></ul>\"\r\n"
				+ "}"
		);
		
		// 2. 실제 주입 메세지
		String userMessage = String.format(
				"아래 [교정 대상 텍스트]를 분석하여, 원문의 의미를 유지하면서도 " +
			    "상투적인 표현을 지양하고 독창성을 높여주세요.\n\n" +
			    "[교정 대상 텍스트]\n%s",
				inputText
		);
		log.info("2. 파라미터 빌드 완료");
		
		// 3. ChatGPT 요청
		StructuredChatCompletionCreateParams<CopyCheckDTO> params = ChatCompletionCreateParams.builder()
				.model(ChatModel.GPT_4_1_MINI)
				.addSystemMessage(systemMessage)
				.addUserMessage(userMessage)
				.responseFormat(CopyCheckDTO.class)
				.build();
		
		StructuredChatCompletion<CopyCheckDTO> response = client.chat().completions().create(params);
		log.info("3. ChatGPT 응답 수신 완료");
		
		CopyCheckDTO result = 
				response.choices().get(0)
				.message()
				.content()
				.orElse(new CopyCheckDTO());
		
		log.info("result : " + result);
					
		// 4. JSON 문자열로 반환
		ObjectMapper objectMapper = new ObjectMapper();
		
		return objectMapper.writeValueAsString(result);
	}
	
	
	
	

	
	
}
