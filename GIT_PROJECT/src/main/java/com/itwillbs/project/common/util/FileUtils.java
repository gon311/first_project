package com.itwillbs.project.common.util;

import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.SecureRandom;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.common.dto.FileResourceDTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
public class FileUtils {
	// 업로드에 사용될 기본 경로들을 필드에 저장
//	private static final String uploadBaseLocation = "/resources/upload";
//	private static final String uploadBaseLocation = "D:/upload";
	private static final String uploadBaseLocation = "/upload";
	private static final String jobFileLocation = "/job";
	
	// ====================================================================================
	// 파일 업로드 처리
	// -------------------------------------------------------
	// 임시) BoardDTO 타입을 파라미터로 전달받기
//	public static List<FileDTO> uploadFile(MultipartFile[] files) throws IOException {
//		// 디렉토리 생성 위해 createDirectories() 메서드 호출
//		String subDir = createDirectories();
//		// ---------------------------------------------------
//		System.out.println("파일 목록 : " + Arrays.toString(files));
//		return null;
//	}
	// -------------------------------------------------------
	// List<MultipartFile> 타입을 파라미터로 전달받기
	public static List<FileDTO> uploadFile(List<MultipartFile> files, String sId) throws IOException {
		// 디렉토리 생성 위해 createDirectories() 메서드 호출
		String subDir = createDirectories(sId);
		// ---------------------------------------------------
//		System.out.println("파일 목록 : " + files);
		// ---------------------------------------------------
		// [ 파일 업로드 처리 ]
		// 복수개의 파일 정보를 관리하는 FileDTO 를 저장할 List<FileDTO> 객체 생성
		List<FileDTO> fileList = new ArrayList<FileDTO>();
		
		// 파일이 저장된 List<MultipartFile> 객체 반복
		for(MultipartFile mFile : files) {
			// 각 파일의 원본 파일명 추출
			String originalFileName = mFile.getOriginalFilename();
//			log.info(">>>>>>>>> originalFileName : " + originalFileName);
			
			// -----------------------------------------------------------------
			// [ 파일명 중복 방지 대책 ]
			// 1) 일반적인 난수 활용 - SecureRandom 객체 활용
//			SecureRandom sr = new SecureRandom();
			// SecureRandom 객체의 nextXXX() 메서드 호출하여 해당 데이터 범위 내의 난수 생성
			// ex) nextInt() : INT 범위의 난수 발생(약 -21억 ~ +21억)
//			System.out.println(sr.nextInt()); // -2147483648 ~ +2147483647
//			System.out.println(sr.nextInt(10)); // 0 ~ 10-1
//			System.out.println(sr.nextInt(10) + 1); // 1 ~ 10
//			System.out.println(sr.nextInt(10000)); // 0 ~ 9999
			
			// 파일명 앞에 생성된 난수와 "_" 기호를 결합
//			String fileName = sr.nextInt(10000) + "_" + originalFileName;
			// ----------------------------
			// 2) UUID(Univerally Unique IDentifier, 범용 고유 식별자) 활용 - UUID 클래스 활용
			// => 128비트 형식(16진수 32자리 => 8-4-4-4-12 패턴)으로 구성되는 값
//			String fileName = UUID.randomUUID() + "_" + originalFileName;
			// 만약, UUID 값 중 앞 8자리만 추출하여 결합할 경우 substring() 메서드 활용
//			String fileName = UUID.randomUUID().toString().substring(0, 8) + "_" + originalFileName;
			// UUID 값 중 뒷자리 12자리 추출
			String fileName = UUID.randomUUID().toString().substring(24) + "_" + originalFileName;
//			log.info(">>>>>>>>> originalFileName : " + fileName);
			
			// 디렉토리와 파일명 결합한 새 Path 객체 생성
			Path uploadDir = Paths.get(uploadBaseLocation, jobFileLocation, sId, subDir).toAbsolutePath().normalize();
			// 기존 Path 객체가 있을 경우 Path 객체의 resolve() 메서드 호출하여 결합할 경로 전달하면 경로 추가 가능
			Path uploadPath = uploadDir.resolve(fileName);
//			log.info(">>>>>>>>> uploadPath : " + uploadPath);
			
			// 임시 저장소(메모리)에 보관된 첨부파일 1개를 실제 생성된 디렉토리로 이동
			// => MultipartFile 객체의 transferTo() 메서드 활용
			mFile.transferTo(uploadPath);
			// -----------------------------------------------------------------
			// 1개 파일 정보를 FileDTO 객체에 저장
			FileDTO fileDTO = new FileDTO();
			fileDTO.setOriginalFileName(originalFileName);
			fileDTO.setRealFileName(fileName);
			fileDTO.setSubDir(subDir);
			fileDTO.setFileSize(mFile.getSize());
			fileDTO.setContentType(mFile.getContentType());
			
			// List<FileDTO> 객체에 1개의 FileDTO 객체 추가
			fileList.add(fileDTO);
		} // List 객체 반복 끝
		
		// 업로드 파일 목록이 저장된 List<FileDTO> 객체 리턴
 		return fileList;
	}
	// ====================================================================================
	// 디렉토리 생성
	private static String createDirectories(String sId) throws IOException {
		// 1. 현재 시스템의 날짜 정보를 가져오기 => java.time.LocalXXX 클래스 활용
		// => 날짜 정보 : LocalDate, 시각 정보 : LocalTime, 날짜 및 시각 정보 : LocalDateTime 
		LocalDate today = LocalDate.now();
//			System.out.println("today : " + today); // today : 2026-02-10
		// -------------------------------------------
		// 2. 날짜 포맷(yyyy-MM-dd)을 디렉토리 형식(yyyy/MM/dd)에 맞게 변경(ex. 2026-02-10 => 2026/02/10)
		// => 단, 윈도우즈 OS 기준 디렉토리 구분자는 원래 백슬래시(\)로 표기하지만
		//    자바 또는 자바스크립트 문자열로 디렉토리 지정 시 이스케이프 문자로 취급되므로
		//    백슬래시 2개(//) 또는 슬래시(/) 기호로 디렉토리 구분자 사용
//			String datePattern = "yyyy/MM/dd";
		
		// LocalXXX 타입의 포맷 변경 시 java.time.format.DateTimeFormatter 클래스 활용하여 포맷팅 할 형식 지정
//			DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		
		// LocalXXX 객체의 format() 메서드 호출하여 DateTimeFormatter 타입 객체를 파라미터로 전달하여 포맷 변환
		String subDir = today.format(dtf);
		System.out.println("subDir : " + subDir);
		// -------------------------------------------
		// 3. 서브디렉토리와 기본 디렉토리들을 조합하여 하나의 디렉토리로 결합하기 위해 Paths.get() 메서드 호출
		Path uploadPath = Paths.get(uploadBaseLocation, jobFileLocation, sId, subDir).toAbsolutePath().normalize();
		System.out.println("uploadPath : " + uploadPath);
		
		// 4. 생성된 Path 객체에 해당하는 디렉토리가 실제로 존재하지 않을 경우 새로 생성
		if(!Files.exists(uploadPath)) {
			Files.createDirectories(uploadPath); // 하위 경로를 포함한 경로 상의 모든 디렉토리 생성(IOException 핸들링 필요 -> throw)
		}
		
		return subDir;
	}
	
	// ===========================================================================
	// 파일 다운로드를 위한 실제 파일 리소스 가져오기
	public static FileResourceDTO getFileResource(FileDTO fileDTO, String sId) {
		try {
			// 파일 업로드 경로 및 실제 업로드 된 파일명 사용하여 Path 객체 생성
			Path uploadPath = Paths.get(
									uploadBaseLocation, 
									jobFileLocation,
									sId,
									fileDTO.getSubDir(), 
									fileDTO.getRealFileName()
								).toAbsolutePath().normalize();
			log.info(">>>>>> Path 객체 정보 : " + uploadPath);
			
			// 해당 파일에 대한 Resource 객체 생성
			// => 스프링프레임워크에서 외부 리소스(파일 등)를 추상화하여 일관된 방식으로 다루도록 해주는 객체
			// => 1) ClassPathResource : 클래스패스(src/main/java, src/main/resources)에 있는 리소스 로드
			//    2) FileSystemResource : 파일 시스템 경로(ex. D:/upload/xxx) 상의 리소스 로드
			//    3) UrlResource : HTTP, FTP 등의 URL 기반 리소스 로드
			//    4) ServletContextResource : 웹 애플리케이션의 WEB-INF 내부 리소스 로드
			Resource resource = new FileSystemResource(uploadPath);
			log.info(">>>>>> Resource 객체 정보 : " + resource);
			
			// 해당 리소스 경로 및 파일 존재 여부 판별, 실제 접근 가능 여부(읽기 권한)도 판별
			if(!resource.exists() || !resource.isReadable()) {
				throw new ResponseStatusException(HttpStatus.NOT_FOUND, "파일을 찾을 수 없습니다");
			}
			
			// ----------------------------------------
			// 파일의 컨텐츠 타입(MIME) 설정
			// Files.probeContentType() 메서드 활용하여 실제 파일의 타입 알아내기
			String contentType = Files.probeContentType(uploadPath);
			
			// 컨텐츠 타입 정보가 없을 경우 기본값을 일반 바이너리 파일 타입으로 강제 설정(고정)
			if(contentType == null) {
				contentType = "application/octet-stream";
			}
			// ----------------------------------------
			// 다운로드용 파일이라는 정보를 담는 ContentDisposition 객체 생성
			// 파일명에 한글이나 공백 등이 포함되어 있을 경우 별도의 추가 작업(파일명 인코딩 방식을 UTF-8 방식으로 지정) 필요
			ContentDisposition contentDisposition = ContentDisposition.builder("attachment") // 첨부파일(다운로드) 형식으로 지정
					.filename(fileDTO.getOriginalFileName(), StandardCharsets.UTF_8) // 원본 파일명과 인코딩 방식(UTF-8) 지정
					.build(); // 객체 생성
			log.info(">>>>>> ContentDisposition 객체 정보 : " + contentDisposition);
			// ----------------------------------------
			// FileResourceDTO 객체 생성하여 Resource 객체와 ContentDisposition 객체, 컨텐츠타입 문자열 저장 후 리턴
			FileResourceDTO fileResourceDTO = new FileResourceDTO(resource, contentDisposition, contentType);
			return fileResourceDTO;
		} catch (IOException e) {
			e.printStackTrace();
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "파일 다운로드 실패!");
		}
		
	}
	
	
}





























