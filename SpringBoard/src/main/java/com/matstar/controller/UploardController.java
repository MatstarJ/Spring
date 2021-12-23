package com.matstar.controller;

import java.io.Console;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;


import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.matstar.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@RequestMapping("/uploadSample/*")
public class UploardController {

	@GetMapping("/uploadForm")
	public void uploadForm() {
		
		log.info("upload form");
	}
	
	//폼을 이용한 파일 업로드와 저장
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		
		for(MultipartFile multipartFile : uploadFile) {
			
			log.info("-------------------------------------");
			log.info("Upload file Name : " + multipartFile.getOriginalFilename());
			log.info("Upload FIle Size : " + multipartFile.getSize()); 
			
			
			String uploadFolder = "C:\\upload";
			File saveFile = new File(uploadFolder,multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			
		}
		
	}	
	
	//Ajax를 이용하는 파일 업로드
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		
		log.info("upload ajax");
	}
	
	
	
	//년/월일/ 폴더를 만들기 위한 문자열 생성 메서드
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		// sdf의 "-" 문자를 파일 경로 구분자로 바꿔준다.
		//(윈도우 : \\, 리눅스 : /)
		return str.replace("-",File.separator);
	}
	
	
	//섬네일 이미지를 만들기 위해 이미지 파일을 체크하는 메서드
	private boolean checkImageType(File file) {
		try {
			//probeContentType 파일의 컨텐츠 유형을 (MIME타입) 검사하는 메서드
			//file.toPath() 파일경로를포함한 전체 파일이름을 반환
			String contentType = Files.probeContentType(file.toPath());
			log.info("파일타입 확인 :" + contentType);
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	//AttachFileDTO를 만들어 값을 전달해 JSON 데이터를 반환하도록 한다.
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		log.info("update ajax Post......");
		
		List<AttachFileDTO> list = new ArrayList<>();
		
		String uploadFolder = "c:\\upload";
		
		String uploadFolderPath = getFolder();
		
		//년/월/일 폴더 생성
		File uploadPath =new File(uploadFolder,uploadFolderPath);
		
		log.info("uploadFolderPath : " + uploadFolderPath);
		log.info("uploadPath : " + uploadPath);
		
		if(uploadPath.exists() == false) {
			//uploadPath가 존재하지 않으면 폴더 생성
			uploadPath.mkdirs();
		}

		
		for(MultipartFile multipartFile : uploadFile) {
			log.info("----------------------------");
			
			
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			
			AttachFileDTO attachFileDTO = new AttachFileDTO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			log.info("only file name : " + uploadFileName);
			
			attachFileDTO.setFileName(uploadFileName);
			
		
			//UUID 난수 생성
			UUID uuid = UUID.randomUUID();
			
			
			// 파일 중복 방지를 위해 uuid_파일이름 형식으로 변경
			uploadFileName = uuid.toString()+"_"+uploadFileName;
			
			
			
			//File saveFile = new File(uploadFolder,uploadFileName);
		
			
			try {
				File saveFile = new File(uploadPath,uploadFileName);
				
				multipartFile.transferTo(saveFile);
				
				attachFileDTO.setUuid(uuid.toString());
				attachFileDTO.setUploadPath(uploadFolderPath);
				
				//이미지 파일 체크
				if(checkImageType(saveFile)) {
					
					attachFileDTO.setImage(true);
					
					FileOutputStream thumnail = new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
					
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumnail,100,100);
					//Thumbnailator.createThumbnail( new FileInputStream(new File(uploadPath, uploadFileName)), thumbnail, 100, 100 );
					//위의 방법으로 해도 가능
					thumnail.close();
				}
				
				list.add(attachFileDTO);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			
		}// end for
		
		return new ResponseEntity<>(list,HttpStatus.OK);
		
	}
	

//	@PostMapping("/uploadAjaxAction")
//	public void uploadAjaxPost(MultipartFile[] uploadFile) {
		
//		log.info("update ajax Post......");
		
//		String uploadFolder = "c:\\upload";
		

		//년/월/일 폴더 생성
//		File uploadPath =new File(uploadFolder,getFolder());
//		log.info("uploadPath" + uploadPath);
		
//		if(uploadPath.exists() == false) {
			//uploadPath가 존재하지 않으면 폴더 생성
//			uploadPath.mkdirs();
//		}

		
//		for(MultipartFile multipartFile : uploadFile) {
//			log.info("----------------------------");
			
			
//			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
//			log.info("Upload File Size : " + multipartFile.getSize());
			
//			String uploadFileName = multipartFile.getOriginalFilename();
			
//			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			
			//UUID 난수 생성
//			UUID uuid = UUID.randomUUID();
			
			// 파일 중복 방지를 위해 uuid_파일이름 형식으로 변경
//			uploadFileName = uuid.toString()+"_"+uploadFileName;
			
			
			
			//File saveFile = new File(uploadFolder,uploadFileName);
		
			
//			try {
//				File saveFile = new File(uploadPath,uploadFileName);
//				multipartFile.transferTo(saveFile);
				//이미지 파일 체크
//				if(checkImageType(saveFile)) {
//					FileOutputStream thumnail = new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
					
//					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumnail,100,100);
					
//					thumnail.close();
//				}
//			} catch (Exception e) {
//				log.error(e.getMessage());
//			}
			
			
//		}
		
//	}
	
	
	
	//첨부파일의 섬네일을 보여주기 위한 메서드
	//파일의 경로가 포함된 fileName을 파라미터로 받아 byte[]로 전송한다.
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getfile(String fileName) {
		
		log.info("fileName : " + fileName);
		
		File file = new File("c:\\upload\\"+fileName);
		
		log.info("file :"+file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
										
										//file.toPath() 파일경로를포함한 전체 파일이름을 반환
			header.add("Content-Type", Files.probeContentType(file.toPath()));
											//byte배열에 지정내용을 복사한다.
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	
	
	//다운로드 처리
	@GetMapping(value="/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	//@RequestHeader HTTP의 헤더 메시지를 수집
	//User-Agent : Http의 헤더 메시지 중에서 디바이스의 정보를 알 수있는 UserAgent를 이용해 파라미터로 수집한다.
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent,  String fileName){
		
		log.info("download file : " + fileName);
		Resource resource = new FileSystemResource("c:\\upload\\"+fileName);
		log.info("resource : " + resource);
		
		if(resource.exists() == false) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		
		String resourceName = resource.getFilename();
		log.info("resourceName : " + resourceName);
		
		//uuid를 제거한 원래의 파일 이름
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
		log.info("resourceOriginalName : "+ resourceOriginalName);
		
		
		HttpHeaders headers = new HttpHeaders();
		log.info("headers : " + headers);
		
		
		try {
			
			String downloadName = null;
			
			// 브라우저 별로 설정 추가
			if(userAgent.contains("Trident")){
				
				log.info("IE browser");
				
				downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8").replaceAll("\\+", " ");
				
				log.info("IE name : " + downloadName);
				
			}else if(userAgent.contains("Edge")) {
				
				log.info("Edgd browser");
				
				downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8");
				
				log.info("Edge name : " + downloadName);
				
			}else {
				
				log.info("crome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1");
				
				log.info("Crome name : " + downloadName);
			}
			
			
			
			//Content-Disposition : 다운로드 시 저장되는 이름 
			//headers.add("Content-Disposition","attachment; filename="+new String(resourceName.getBytes("UTF-8"),"ISO-8859-1"));
			headers.add("Content-Disposition","attachment; filename="+downloadName);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
	}
	
	
	
	//첨부파일 삭제
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		
		log.info("deleteFile " + fileName);
		
		File file;
		
		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName,"UTF-8"));
			
			file.delete();
			
			if(type.equals("image")) {
				
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				
				log.info("largeFileName : " + largeFileName);
				log.info("path" + file.getAbsolutePath());
				file = new File(largeFileName);
				
				file.delete();
				
			}
			
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
			return new ResponseEntity<>("deleted",HttpStatus.OK);
	}
	
	

		
	}
