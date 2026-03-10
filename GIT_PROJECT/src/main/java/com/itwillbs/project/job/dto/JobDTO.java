package com.itwillbs.project.job.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Data
@NoArgsConstructor
public class JobDTO {
	// 1. 기본 식별 정보
    private Long jobId;          // job_id (PK) [cite: 31]
    private Long compId;         // comp_id (FK) [cite: 31]
    private String comName; 	 // 기업명 (com_info 테이블의 com_name)

    // 2. 공고 핵심 내용
    private String title;        // 공고제목 (name="title") [cite: 18]
    private String field;        // 모집분야 (name="field") [cite: 19]
    private String task;         // 주요업무 (name="task") [cite: 21]

    // 3. 고용 조건 및 자격 요건
    private String empType;      // 고용 형태 (name="emp_type") [cite: 23]
    private String probation;    // 수습기간 여부 (name="probation") [cite: 24]
    private String expType;      // 경력 구분 (new/career) (name="exp_type") 
    
    /**
     * 경력 기간 (exp_year 컬럼에 저장)
     * JSP의 min_exp와 max_exp를 "3~5"와 같은 문자열 형식으로 합쳐서 저장 
     */
    private String minExp; // JSP의 name="min_exp"와 매칭
    private String maxExp; // JSP의 name="max_exp"와 매칭
    private String expNone; // JSP의 name="exp_none"
    private String expYear;      
    
    private String edu;          // 학력 (name="edu") [cite: 28]
    private String salary;       // 급여 (name="salary") [cite: 30]

    // 4. 근무지 정보
    /**
     * 주소 (address 컬럼에 저장)
     * zipcode, address, address_detail을 하나로 합쳐서 저장 
     */
    private String address;
    private String isRemote;    // 재택근무 여부 (name="is_remote") [cite: 34]

    // 5. 담당자 정보
    private String mgrName;      // 담당자 이름 (name="mgr_name") [cite: 35]
    private String mgrPhone;     // 담당자 연락처 (name="mgr_phone") [cite: 35]
    private String mgrEmail;     // 담당자 이메일 (name="mgr_email") [cite: 35]
    private String isPublic;    // 정보 공개 여부 (name="is_public") [cite: 36]

    // 6. 기간 및 상태
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate openDate;   // 접수 시작일 (name="open_date") [cite: 36]
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate closeDate;  // 접수 마감일 (name="close_date") [cite: 36]
    private Integer postStatus;       // 모집 상태 (1: 모집중 등) [cite: 31]
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDateTime regDate;  // 공고 등록 일 시간.
    private int postCheck;
    // 추가 할 데이터
    private String companyName;
    private String isScrapped;
    
    /**
     * DB의 exp_year 컬럼에 저장될 값을 생성하는 메서드
     */
    public String getExpYear() {
        // 1. 경력 무관인 경우 (JSP의 exp_none 체크 시 로직 추가 가능)
    	if ("Y".equals(this.expNone)) {
            return "경력무관";
        }
    	
        // 2. 경력직인 경우 범위를 문자열로 결합 (예: "1~3")
        if (minExp != null && maxExp != null) {
            return minExp + "~" + maxExp;
        }
        
        return expYear; // 기본값 리턴
    }
    
 // JobDTO.java 내부 (수정 기능을 위해 추가 권장)
    public void setExpYear(String expYear) {
        this.expYear = expYear;
        // DB에서 가져온 "1~5" 같은 문자열을 다시 min, max 필드에 분리해서 저장
        if (expYear != null && expYear.contains("~")) {
            String[] parts = expYear.split("~");
            this.minExp = parts[0];
            this.maxExp = parts[1];
        }
    }
    
    public String getDisplayAddress() {
        if (this.address == null || this.address.isEmpty()) {
            return "";
        }

        // 1. 특수문자(쉼표, 대괄호 등)를 공백으로 치환하고 양끝 공백 제거
        String cleanAddr = this.address.replaceAll("[,\\[\\]]", " ").trim();
        
        // 2. 공백을 기준으로 단어 분리
        String[] parts = cleanAddr.split("\\s+");
        StringBuilder sb = new StringBuilder();
        int count = 0;

        for (String part : parts) {
            // 3. 우편번호 형태(숫자, 대시 포함 숫자)는 무조건 패스
            if (part.matches("^[0-9\\-]+$")) continue;

            // 4. 글자가 시작되는 지점부터 딱 두 단어만 챙기기 (예: 서울 강남구)
            if (count < 2) {
                if (sb.length() > 0) sb.append(" ");
                sb.append(part);
                count++;
            } else {
                break;
            }
        }

        return sb.toString();
    }
    
    
}
