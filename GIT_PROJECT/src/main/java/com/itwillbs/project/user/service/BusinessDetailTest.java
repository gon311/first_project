package com.itwillbs.project.user.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class BusinessDetailTest {
    public static void main(String[] args) {
        // 1. 발급받은 인증키 (이미 Encoding 되어 있다면 그대로 사용)
        String serviceKey = "aed02d1200f8bfa365bde9f04956e5ffd36bd59e7e9a26418f565bc86dc2c7a9";
        
        try {
            // 2. URL 생성 (기본정보 조회 예시 - getCorpBasicInfo)
        	// 수정 예시 (Encoding된 키를 직접 쓸 때)
        	StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1130000/BizStatusService/getCorpBasicInfo");
        	urlBuilder.append("?serviceKey=" + serviceKey); 
        	urlBuilder.append("&pageNo=1&numOfRows=10&resultType=json&bzno=1248100998");
        	
            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            // 3. 호출 방식 설정
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");

            // 4. 응답 확인
            System.out.println("Response code: " + conn.getResponseCode());

            BufferedReader rd;
            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
            }
            
            // 5. 결과 데이터 조립
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }
            rd.close();
            conn.disconnect();

            // 6. 결과 출력
            System.out.println("결과 데이터: " + sb.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
