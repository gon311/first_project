package com.itwillbs.project.user.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.project.user.dto.BizStatusResponseDTO;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class ApiService {
	
	private final String RESEND_API_URL = "https://api.resend.com/emails";
	
	@Value("${biz.api_key}")
    private String bizApiKey;
	
	// 사업자등록 진위확인
	public String correction(String content) throws IOException {
		// 1. 발급받은 일반 인증키(Encoding 또는 Decoding 둘 중 하나 시도)
        String strUrl = "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=" + bizApiKey;

            URL url = new URL(strUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            // 2. HTTP 설정
            conn.setRequestMethod("POST"); // 대부분의 사업자 API는 POST 방식입니다.
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Accept", "application/json");
            conn.setDoOutput(true);

            // 3. 보낼 데이터 준비 (JSON 형식)
            // 조회하고 싶은 사업자 번호를 넣습니다.
            String jsonInputString = "{ \"b_no\": [\"" + content + "\"] }";
            
            OutputStream os = conn.getOutputStream();
            byte[] input = jsonInputString.getBytes("utf-8");
            os.write(input, 0, input.length);

            // 4. 결과 응답 읽기
            int code = conn.getResponseCode();

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
            StringBuilder response = new StringBuilder();
            String responseLine = null;
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }
            // 5. 결과 출력
            String jsonResponse = response.toString();
            
            // Jackson의 ObjectMapper를 사용해 필요한 값만 쏙 뽑기
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode root = objectMapper.readTree(jsonResponse);

            // "data" 노드가 있고, 최소 하나 이상의 요소가 있는지 확인
            JsonNode dataArray = root.path("data");
            BizStatusResponseDTO resultDTO = new BizStatusResponseDTO();

            if (dataArray.isArray() && dataArray.has(0)) {
                JsonNode dataNode = dataArray.get(0);
                String bStt = dataNode.path("b_stt").asText("");
                String taxType = dataNode.path("tax_type").asText("");
                
                // 데이터를 안전하게 세팅
                resultDTO.setB_stt(dataNode.path("b_stt").asText("")); // 값이 없으면 빈 문자열
                resultDTO.setTax_type(dataNode.path("tax_type").asText(""));
                
                if (bStt.isEmpty() || taxType.contains("등록되지 않은")) {
                	resultDTO.setB_stt("존재하지 않는 사업자 번호입니다."); 
                } else if (bStt.equals("폐업자")) {
                	resultDTO.setB_stt("폐업한 사업자입니다.");
                } else {
                	resultDTO.setB_stt("정상 영업 중인 사업자입니다.");
                }
            }
            return objectMapper.writeValueAsString(resultDTO);
	} // --------------------------------------------------------------- correction 메서드 끝
	
}
