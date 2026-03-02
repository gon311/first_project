package com.itwillbs.project.user.service;

import java.io.BufferedReader;
import java.io.OutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class ApiTest {
    public static void main(String[] args) {
        // 1. 발급받은 일반 인증키(Encoding 또는 Decoding 둘 중 하나 시도)
        String serviceKey = "aed02d1200f8bfa365bde9f04956e5ffd36bd59e7e9a26418f565bc86dc2c7a9"; 
        String strUrl = "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=" + serviceKey;

        try {
            URL url = new URL(strUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            // 2. HTTP 설정
            conn.setRequestMethod("POST"); // 대부분의 사업자 API는 POST 방식입니다.
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Accept", "application/json");
            conn.setDoOutput(true);

            // 3. 보낼 데이터 준비 (JSON 형식)
            // 조회하고 싶은 사업자 번호를 넣습니다.
            String jsonInputString = "{ \"b_no\": [\"1248100998\"] }";

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonInputString.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // 4. 결과 응답 읽기
            int code = conn.getResponseCode();
            System.out.println("Response Code : " + code);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
            StringBuilder response = new StringBuilder();
            String responseLine = null;
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }

            // 5. 결과 출력
            System.out.println("결과 데이터: " + response.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
