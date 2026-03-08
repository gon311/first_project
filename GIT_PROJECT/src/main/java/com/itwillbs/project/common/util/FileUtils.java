package com.itwillbs.project.common.util;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import com.itwillbs.project.common.DTO.FileDTO;
import com.itwillbs.project.common.DTO.FileResourceDTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
public class FileUtils {
	// 업로드에 사용될 기본 경로들을 필드에 저장
	private static final String uploadBaseLocation = "/upload";
	private static final String boardFileLocation = "/board";
//	private static final String noticeFileLocation = "/notice";
	
	// 파일 업로드 처리
	public static List<FileDTO> uploadBoardFile(List<MultipartFile> files) throws IOException {
		String subDir = createDirectories();
		
		// 파일 업로드 처리 
		// 복수개 파일 저장, 관리할 List<FileDTO>
		List<FileDTO> fileList = new ArrayList<FileDTO>();
		
		// 파일이 저장된 List<MultipartFile> 객체 반복
		for(MultipartFile mFile : files ) {
			
			// 각 파일의 원본 파일명 추출 
			String originalFileName = mFile.getOriginalFilename();
			
			// 파일명 중복을 방지하기 위한 난수 및 특수문자 추가 
			String fileName = UUID.randomUUID().toString().substring(24) + "_" + originalFileName;
			
			// 디렉토리와 파일명 결합한 새 Path 객체 생성 
			Path uploadDirectory = Paths.get(uploadBaseLocation, boardFileLocation, subDir).toAbsolutePath().normalize();
			// 기본 Path 객체가 있을 경우, Path 객체의 resolve() 메서드 호출하여 결합할 경로 전달
			Path uploadPath = uploadDirectory.resolve(fileName);
			
			mFile.transferTo(uploadPath);
		}
		return fileList;
	}
	
	// 파일 다운로드를 위한 실제 파일 가져오기 
	public static FileResourceDTO getFileResource(FileDTO fileDTO) {
		try {
			// 파일 업로드 경로 및 실제 업로드 된 파일명 사용하여 Path 객체 생성 
			Path uploadPath = Paths.get(uploadBaseLocation, boardFileLocation, fileDTO.getSubDir(), fileDTO.getStoredName()).toAbsolutePath().normalize();
			
			// 해당 파일에 대한 Resource 객체 생성
			Resource resource = new FileSystemResource(uploadPath);
			
			if(!resource.exists() || !resource.isReadable()) { 
				throw new ResponseStatusException(HttpStatus.NOT_FOUND, "파일을 찾을 수 없습니다");
			}
			
			// 파일의 컨텐츠 타입(MIME) 설정 
			String contentType = Files.probeContentType(uploadPath);
			
			// 컨텐츠 타입 정보가 없을 경우, default value = 일반 바이너리 파일 타입. (고정) 
			if(contentType == null) { 
				contentType = "application/octet-stream";
			}
			
			// 다운로드용 파일이라는 정보를 담는 ContentDisposition 객체 생성
			ContentDisposition contentDisposition = ContentDisposition.builder("attachment") // 첨부파일(다운로드) 형식으로 지정
					.filename(fileDTO.getOriginName(), StandardCharsets.UTF_8)  // 원본 파일명과 인코딩 방식 지정
					.build(); // 객체 생성 
			
			FileResourceDTO fileResourceDTO = new FileResourceDTO(resource, contentDisposition, contentType);
			
			return fileResourceDTO;
			
		} catch (IOException e) {
			e.printStackTrace();
			throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "파일 다운로드 실패");
		}
	}
	
	
	// 디렉토리 생성 
	private static String createDirectories() throws IOException {
		// 1. 현재 시스템의 날짜 정보 가져오기 
		LocalDate today = LocalDate.now();
		
		//2. 날짜포멧(yyyy-MM-dd)을 디렉토리형식(yyyy/MM/dd)에 맞게 변경
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		
		String subDir = today.format(dtf);
		
		// 3. 서브디렉토리와 기본 디렉토리들을 조합, 하나의 디렉토리로 결합
		Path uploadPath = Paths.get(uploadBaseLocation, boardFileLocation, subDir).toAbsolutePath().normalize();
		
		//4. 생성된 Path 객체에 해당하는 디렉토리가 실제로 존재하지 않을 경우 새로 생성
		
		if(!Files.exists(uploadPath)) {
			Files.createDirectories(uploadPath);
		}
		
		return subDir;
	}
}
