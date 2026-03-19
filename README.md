# 🚀 JobAI: AI-Powered Resume Optimization & Recruitment Platform
A web-based recruitment service integrating OpenAI's GPT for automated resume feedback and data-driven admin insights.

## 📌 Project Overview
JobAI is an all-in-one recruitment platform designed to solve the challenges job seekers face when drafting resumes. By leveraging the OpenAI ChatGPT API, the platform provides real-time, high-quality feedback and sentence optimization.

As a Backend Developer with an Economics background, I focused on building the Admin Business Intelligence (BI) system and a scalable Integrated Board Architecture, ensuring that raw service data is translated into meaningful operational insights.

##🛠 Tech Stack
- **Language** : Java 11
- **Framework** : Spring Framework(MVC), MyBatis / JPA
- **Server** : Apache Tomcat 9.0
- **Frontend** : HTML5, CSS3, JavaScript, AJAX
- **Database** : MySQL
- **AI / API** : OpenAI ChatGPT API, Portone API, Chart.js, Cloudflare Turnstile, Data.GO.kr
- **Tools** : Git / GitHub, Notion, Figma, Canva, google sheets, discord

## 🖥️ Major Functions
👤 Job Seeker Services
- AI-Powered Resume Optimization: Leverages OpenAI API to provide section-by-section analysis and tailored improvement suggestions, including sentence refinement and automated spell-checking.
- Resume Management: Comprehensive lifecycle management for resumes and cover letters (CRUD operations) with an integrated PDF export feature for external applications.
- Job Discovery & Application: Advanced filtering system for personalized job searches, enabling users to find and apply for positions instantly.
- User Community: Interactive boards and comment systems designed for seamless information sharing and networking among job seekers.

🏢 Employer Services
- Job Posting Management: Streamlined tools for registering, editing, and managing the lifecycle of recruitment notices.
- Applicant Tracking System (ATS): Real-time dashboard to monitor applicant status and update hiring outcomes (Pass/Fail) efficiently.
- Premium Services: Integrated payment gateway for purchasing "Top-tier Banner" advertisements to increase posting visibility.

⚙️ Administrator Services 
- Business Intelligence (BI) Dashboard: Visualizes core KPIs—such as total user growth, new recruitment trends, and daily revenue—using data visualization techniques to support decision-making.
- Integrated Content Management: Centralized control over global platform assets, including Notices, FAQ, Q&A boards, and the approval/rejection of corporate banner ads.
- Operational Governance: Robust management of user accounts (Suspension/Recovery) and financial transactions (Refunds/Cancellation) to ensure platform integrity.


## 👤 My Key Contributions
### 1. Admin Business Intelligence (BI) Dashboard
- Data Aggregation: Developed a comprehensive dashboard to monitor service health, including user application trends, recruitment status, and payment statistics.

- Statistical Queries: Applied my Economics analytical skills to write complex SQL queries (Joins, Subqueries, Group By) for generating weekly business reports.

- Operational Efficiency: Implemented AJAX-based real-time data updates, reducing manual page refreshes for administrators.

### 2. Integrated Multi-Board System
- Scalable Architecture: Designed and implemented a unified backend logic for 5+ board types (Job Postings, Community, Q&A, FAQ, Notices, Banner).

- Global Content Management: Managed global data assets and banner systems, allowing admins to control the platform's UI/UX dynamically.

- Data Integrity: Ensured 100% data consistency during high-volume CRUD operations through optimized Service-Layer logic.

### 3. Database Design & Optimization
- ERD Modeling: Participated in designing the relational database schema, focusing on normalization to minimize data redundancy.

- Optimization: Optimized query performance for the recruitment filtering system to ensure fast search results for users.


## 📊 System Architecture
```
graph TD
    User --> WebBrowser[Web Browser]
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

## 💡 Engineering Challenges & Solutions
Challenge: Handling large volumes of unstructured community data while maintaining fast load times for the Admin Dashboard.

Solution: Implemented Pagination and indexed frequently searched columns (e.g., user IDs, post categories) in MySQL, resulting in a 40% improvement in data retrieval speed.

Challenge: Integrating external AI APIs securely.

Solution: Used environment variables and .gitignore to protect sensitive API keys, ensuring zero exposure during the GitHub migration.

## 💡design output
- requirement analysis document
- requirement definition document
- screen definition document
- api document
- ERD
- Gantt Chart
## 🧱structure of project
```
src
├── main
│   ├── java
│   │   └── com.project.career
│   │       ├── controller    # API and page Routing 
│   │       ├── service       # Business Logic & ai linkage
│   │       ├── mapper        # MyBatis interface
│   │       └── dto           # object for data transmission
│   ├── resources
│   │   ├── mappers           # MyBatis XML query file
│   │   ├── application.properties # db&api key settings
│   │   └── log4j2.xml       # log settings
│   └── webapp
│       ├── WEB-INF
│       │   └── views         # JSP/HTML template
│       └── static
│           ├── css           # stylesheet
│           ├── js            # frontend script (AJAX and so on)
│           └── images        # image resources
└── pom.xml                   # dependency maintenance (standard Maven)
```

## 📈 Future Goals
Predictive Analytics: Incorporating econometric models to predict hiring success rates based on user interaction data.

Automated Reporting: Utilizing Spring Batch for automated weekly performance reporting for stakeholders.

##🔗 Contact
Name: Sooyeon Cho (Economics Major, Ewha Womans University)

Email: [sooyeon22@ewha.ac.kr]

LinkedIn: [Your LinkedIn Profile]

Personal Blog/Notes: []
