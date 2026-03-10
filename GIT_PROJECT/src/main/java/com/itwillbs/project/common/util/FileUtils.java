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

import com.itwillbs.project.common.dto.FileDTO;
import com.itwillbs.project.common.dto.FileResourceDTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
public class FileUtils {
	// 업로드에 사용될 기본 경로들을 필드에 저장
	private static final String uploadBaseLocation = "/upload";
	private static final String boardFileLocation = "/board";
	
	
//	private static final String noticeFileLocation = "/notice";
	
	// 파일 업로드 처리
	public static List<FileDTO> uploadBoardFile(List<MultipartFile> files) throws IOException {
		String filePath = createDirectories();
		
		// 파일 업로드 처리 
		// 복수개 파일 저장, 관리할 List<FileDTO>
		List<FileDTO> fileList = new ArrayList<FileDTO>();
		
		// 파일이 저장된 List<MultipartFile> 객체 반복
		for(MultipartFile mFile : files ) {
			if(mFile.isEmpty()) {
				continue; // 파일이 비어있으면 스킵
			}
			
			String originName = mFile.getOriginalFilename();
	        // 확장자 추출 (table의 file_ext 대응)
	        String fileExt = originName.substring(originName.lastIndexOf(".") + 1);
	        // 저장용 이름 생성
	        String storedName = UUID.randomUUID().toString().substring(24) + "_" + originName;
			
	        // 실제 저장 경로 (물리적 서버 경로)
	        Path uploadDirectory = Paths.get(uploadBaseLocation, boardFileLocation, filePath).toAbsolutePath().normalize();
	        Path uploadPath = uploadDirectory.resolve(storedName);
			
	        // 파일 물리적 저장
	        mFile.transferTo(uploadPath);
	        
	        // 1개 파일 정보를 FileDTO 객체에 저장 
	        FileDTO fileDTO = new FileDTO();
	        fileDTO.setOriginName(originName); 
	        fileDTO.setStoredName(storedName);     
	        fileDTO.setFilePath(filePath);         
	        fileDTO.setFileSize(mFile.getSize());   
	        fileDTO.setFileExt(fileExt);         
	        
	        // List<FileDTO> 객체에 1개의 FileDTO 객체 추가 
	        fileList.add(fileDTO);
		}
		return fileList;
	}
	
	// 파일 다운로드를 위한 실제 파일 가져오기 
	public static FileResourceDTO getFileResource(FileDTO fileDTO) {
		try {
			// 파일 업로드 경로 및 실제 업로드 된 파일명 사용하여 Path 객체 생성 
			Path uploadPath = Paths.get(uploadBaseLocation, boardFileLocation, fileDTO.getFilePath(), fileDTO.getStoredName()).toAbsolutePath().normalize();
			
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
