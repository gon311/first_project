package com.itwillbs.project.job.dto;

import java.time.LocalDateTime;

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
    private String min_exp; // JSP의 name="min_exp"와 매칭
    private String max_exp; // JSP의 name="max_exp"와 매칭
    private String exp_none; // JSP의 name="exp_none"
    private String expYear;      
    
    private String edu;          // 학력 (name="edu") [cite: 28]
    private String salary;       // 급여 (name="salary") [cite: 30]

    // 4. 근무지 정보
    /**
     * 주소 (address 컬럼에 저장)
     * zipcode, address, address_detail을 하나로 합쳐서 저장 
     */
    private AddressDTO address = new AddressDTO(); 
    private Integer isRemote;    // 재택근무 여부 (name="is_remote") [cite: 34]

    // 5. 담당자 정보
    private String mgrName;      // 담당자 이름 (name="mgr_name") [cite: 35]
    private String mgrPhone;     // 담당자 연락처 (name="mgr_phone") [cite: 35]
    private String mgrEmail;     // 담당자 이메일 (name="mgr_email") [cite: 35]
    private Integer isPublic;    // 정보 공개 여부 (name="is_public") [cite: 36]

    // 6. 기간 및 상태
    private LocalDateTime openDate;   // 접수 시작일 (name="open_date") [cite: 36]
    private LocalDateTime closeDate;  // 접수 마감일 (name="close_date") [cite: 36]
    private Integer postStatus;       // 모집 상태 (1: 모집중 등) [cite: 31]
    
    
 // JobDTO 내부
    public String getFullAddress() {
        if(address != null) {
            return "(" + address.getPostCode() + ") " 
                 + address.getAddress1() + " " 
                 + address.getAddress2();
        }
        return null;
    }
    
    /**
     * DB의 exp_year 컬럼에 저장될 값을 생성하는 메서드
     */
    public String getExpYear() {
        // 1. 경력 무관인 경우 (JSP의 exp_none 체크 시 로직 추가 가능)
    	if ("Y".equals(this.exp_none)) {
            return "경력무관";
        }
        // 2. 신입인 경우
        if ("new".equals(this.expType)) {
            return "신입";
        }
        
        // 3. 경력직인 경우 범위를 문자열로 결합 (예: "1~3")
        if (min_exp != null && max_exp != null) {
            return min_exp + "~" + max_exp;
        }
        
        return expYear; // 기본값 리턴
    }
    
 // JobDTO.java 내부 (수정 기능을 위해 추가 권장)
    public void setExpYear(String expYear) {
        this.expYear = expYear;
        // DB에서 가져온 "1~5" 같은 문자열을 다시 min, max 필드에 분리해서 저장
        if (expYear != null && expYear.contains("~")) {
            String[] parts = expYear.split("~");
            this.min_exp = parts[0];
            this.max_exp = parts[1];
        }
    }
    
 // JobDTO.java 내부 추가

    public void setFullAddress(String fullAddress) {
        // 1. 우선 전달받은 전체 주소를 address 필드에 저장 (기본 Setter 동작)
        this.address.setAddress1(fullAddress); // 혹은 별도의 fullAddress 필드가 있다면 저장

        // 2. 데이터 분리 작업 (예: "(06159) 서울 강남구, 10층")
        if (fullAddress != null && fullAddress.contains(")")) {
            try {
                // ( ) 기호를 기준으로 우편번호와 나머지 주소 분리
                String postCode = fullAddress.substring(fullAddress.indexOf("(") + 1, fullAddress.indexOf(")"));
                String remainAddr = fullAddress.substring(fullAddress.indexOf(")") + 1).trim();
                
                // 나머지 주소에서 , 기호를 기준으로 기본주소와 상세주소 분리
                String address1 = remainAddr;
                String address2 = "";
                
                if (remainAddr.contains(",")) {
                    String[] addrParts = remainAddr.split(",", 2);
                    address1 = addrParts[0].trim();
                    address2 = addrParts[1].trim();
                }
                
                // 3. 분리된 값을 AddressDTO 객체에 각각 저장
                if (this.address == null) {
                    this.address = new AddressDTO();
                }
                this.address.setPostCode(postCode);
                this.address.setAddress1(address1);
                this.address.setAddress2(address2);
                
            } catch (Exception e) {
                // 주소 형식이 규격과 다를 경우 예외 처리 (기본주소에 통째로 저장)
                this.address.setAddress1(fullAddress);
            }
        }
    }
    
    
}
