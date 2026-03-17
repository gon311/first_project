# 📄 자소서 자동 첨삭 온라인 구인·구직 서비스

ChatGPT API를 활용하여 **자기소개서를 자동 분석하고 첨삭 피드백을 제공하는 웹 기반 구인·구직 서비스**입니다.

---

## 1. 프로젝트 개요

### 1.1 프로젝트 배경
- 구직자가 자소서 작성 과정에서 겪는 표현력·구조 문제 해결
- ChatGPT를 활용한 자연어 분석 및 자동 피드백 시스템 구현
- Spring 기반 웹서비스 아키텍처 설계 및 팀 협업 경험 확보

### 1.2 프로젝트 목표
- ChatGPT 연동 자소서 자동 첨삭 기능 구현
- MVC 패턴 기반의 안정적인 백엔드 구조 설계
- 구직자·채용공고·이력서 데이터를 통합 관리하는 구인·구직 서비스 구축

---

## 2. 프로젝트 기간

- **진행 기간**: 2026.02.02 ~ 2026.03.24 (6주)
- **발표일**: 2026.03.24

---

## 3. 팀 구성 및 상세 역할

🛠️ 프로젝트 리더 (Management)
- 이다겸 (팀장)
    - 메인 서비스: 구직자 및 기업용 메인 화면 설계
    - AI 엔진: OpenAI API 연동 자소서 자동 첨삭 시스템 구축
    - 텍스트 최적화: 맞춤법 검사 및 AI 문장 다듬기 로직 구현
- 조수연 (서기)
    - 관리자 메인: 통합 관리자 대시보드 및 통계 구현
    - 게시판 총괄: 채용공고, 커뮤니티, Q&A, FAQ, 공지사항 시스템 관리
    - 운영 지원: 서비스 배너 관리 및 전역 공통 데이터 관리

💻 백엔드 및 서비스 구현 (Development)
- 이재우
    - 사용자 관리: 구직자/기업별 마이페이지 기능 구현
    - 커뮤니티: 게시판 작성, 수정, 삭제 및 댓글 상호작용 로직
- 최선린
    - 관리 서비스: 회원 정보 관리 및 제출된 공고 승인 프로세스
    - 결제 시스템: 유료 서비스 결제 API 연동 및 결제 내역 관리
- 이호철
    - 이력서 엔진: 이력서 및 자기소개서 CRUD(작성·조회·수정·삭제) 기능 전담
- 최승우
    - 인증 보안: 로그인, 회원가입, 아이디/비밀번호 찾기 프로세스
    - 공통 기능: 서비스 전체 공지사항 기능 구현
- 임재호
    - 기업 공고: 공고 등록·수정 및 실시간 지원자 관리 시스템
    - 공고 탐색: 공고 리스트 필터링, 상세 페이지 조회 및 지원하기 기능




---

## 4. 기술 스택

### Backend
- Java 11
- Spring Framework (MVC)
- MyBatis / JPA
- Apache Tomcat

### Frontend
- HTML5
- CSS3
- JavaScript 
- AJAX

### Database
- MySQL

### AI / API
- OpenAI ChatGPT API

### Tools
- Git / GitHub 
- Notion
- Figma
- Canva
- google sheets
- Discord

---

## 5. 주요 기능
👤 구직자 서비스
- AI 이력서 첨삭: OpenAI API를 연동하여 자소서 문항별 내용 분석 및 개선안 제안 (문장 다듬기, 맞춤법 검사).
- 이력서 관리: 이력서 및 자기소개서 작성, 수정, 삭제 및 PDF 저장 기능.
- 채용 공고 탐색: 필터링 기능을 통한 맞춤형 공고 검색 및 즉시 지원.
- 커뮤니티: 구직자 간 정보 공유를 위한 게시판 및 댓글 기능.

🏢 기업 서비스
- 공고 관리: 채용 공고 등록, 수정 및 마감 관리.
- 지원자 관리: 공고별 지원 현황 확인 및 합격/불합격 상태 업데이트.
- 유료 서비스: 상단 노출 배너 등 유료 상품 결제 및 내역 관리.

⚙️ 관리자 서비스
- 대시보드: 전체 회원 수, 신규 공고 수, 결제 현황 등 주요 지표 시각화.
- 콘텐츠 관리: 공지사항, FAQ, Q&A 게시판 운영 및 배너 광고 승인/관리.
- 회원 및 결제: 회원 활동 정지/복구 처리 및 결제 취소/환불 관리.

---

## 6. 시스템 아키텍처
본 서비스는 Spring MVC 패턴을 기반으로 하며, AI 분석을 위해 외부 API와 통신하는 구조입니다.
```
graph TD
    User((사용자)) --> WebBrowser[Web Browser]
    WebBrowser --> Controller[Spring Controller]
    Controller --> Service[Service Layer]
    Service --> Repository[MyBatis/JPA Repository]
    Repository --> DB[(MySQL)]
    
    Service --> AI_Manager[AI Service Manager]
    AI_Manager --> ChatGPT_API{OpenAI API}
    
    subgraph "Server Side (Apache Tomcat)"
    Controller
    Service
    Repository
    AI_Manager
    end
```

## 7. 설계 산출물

- 요구사항 정의서
- 화면 정의서 / 화면 설계서
- 간츠 차트
- ERD
- API 설계서

---

## 8. 프로젝트 구조
표준적인 Spring Maven/Gradle 프로젝트 구조를 따릅니다.
```
src
├── main
│   ├── java
│   │   └── com.project.career
│   │       ├── controller    # API 및 페이지 라우팅
│   │       ├── service       # 비즈니스 로직 및 AI 연동
│   │       ├── mapper        # MyBatis 인터페이스
│   │       └── dto           # 데이터 전송 객체
│   ├── resources
│   │   ├── mappers           # MyBatis XML 쿼리 파일
│   │   ├── application.properties # DB 및 API 키 설정
│   │   └── log4j2.xml       # 로그 설정
│   └── webapp
│       ├── WEB-INF
│       │   └── views         # JSP/HTML 템플릿
│       └── static
│           ├── css           # 스타일시트
│           ├── js            # 프론트엔드 스크립트 (AJAX 등)
│           └── images        # 이미지 리소스
└── pom.xml                   # 의존성 관리 (Maven 기준)
```
---

## 9. 실행 방법
⚙️ 사전 요구 사항
- Java 11 설치
- MySQL 8.0 이상 설치 및 데이터베이스 생성
- OpenAI API Key 발급

🚀 설치 및 실행
1. 저장소 클론
```
git clone https://github.com/gon311/first_project.git
```
2. 데이터베이스 설정
- src/main/resources/application.properties 파일 내 DB 접속 정보 수정
```
db.url=jdbc:mysql://localhost:3306/your_db_name
db.username=your_id
db.password=your_password
```
3. API 키 설정
```
openai.api.key=YOUR_ACTUAL_API_KEY
```
4. 빌드 및 실행
- Maven 사용 시:
```
mvn clean install
mvn spring-boot:run
```
- 브라우저에서 http://localhost:8080 접속
