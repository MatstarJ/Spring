package com.matstar.controller;

import java.io.File;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

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
	
	@PostMapping("/uploadAjaxAction")
	public void uploadAjaxPost(MultipartFile[] uploadFile) {
		
		log.info("update ajax Post......");
		
		String uploadFolder = "c:\\upload";
		
		for(MultipartFile multipartFile : uploadFile) {
			log.info("----------------------------");
			
			
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Name : " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			File saveFile = new File(uploadFolder,uploadFileName);
			
			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			
			
		}
		
	}
		
	
		
	}
