package com.matstar.controller;


import java.util.ArrayList;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.matstar.domain.SampleDTO;
import com.matstar.domain.SampleDTOList;
import com.matstar.domain.TodoDTO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {
	
	@RequestMapping("")
	public void basic() {
		log.info("basicccccccc.................");
	}
	

	@RequestMapping(value="/basic", method= {RequestMethod.GET,RequestMethod.POST})
	public void basicGet() {
		log.info("basic get only get....");
	}
	
	@GetMapping("/basicOnlyGet")
	public void basicGet2() {
		log.info("basic get only get22....");
	}
	
	@GetMapping("/ex01")
	public String ex01(SampleDTO dto) {
		log.info(""+dto);
		return "ex01";
	}
	
	@GetMapping("/ex02")
	public String ex02(@RequestParam("name") String name, @RequestParam("age") int age) {
		log.info("name : " + name);
		log.info("age" + age);
		return "ex02";
	}
	
	@GetMapping("/ex03List")
	public String ex03List(@RequestParam("ids")ArrayList<String> ids) {
		log.info("ids "+ids);
		return "ex03List";
	}
	
	@GetMapping("/ex04Bean")
	public String ex04Bean(SampleDTOList list) {
		log.info("list dtos" + list);
		return "ex04Bean";
	}
	
	
	/*
	 * @InitBinder public void initBinder(WebDataBinder binder) { SimpleDateFormat
	 * dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	 * binder.registerCustomEditor(java.util.Date.class, new
	 * CustomDateEditor(dateFormat, false)); }
	 */

	@GetMapping("/ex05")
	public String ex05(TodoDTO todo) {
		log.info("todo" + todo);
		return "ex05";
	}
	
	@GetMapping("/ex06")
	public String ex06(SampleDTO dto, int page, @ModelAttribute("page2") int pag) {
		System.out.println(pag);
		
		return "/sample/ex06";
	}
	
	@GetMapping("/ex07")
	@ResponseBody
	public SampleDTO ex07() {
		SampleDTO dto = new SampleDTO();
		dto.setAge(10);
		dto.setName("홍길동");
		
		return dto;
	}
	
	@GetMapping("/ex08")
	public ResponseEntity<String> ex08() {
		String msg = "{\"name:\" : \"홍길동\"}";
		HttpHeaders header = new HttpHeaders();
		header.add("Contentr-Type","application/json;charset=UTF-8");
		
		return new ResponseEntity<>(msg,header,HttpStatus.OK);
	}
	
	@GetMapping("/exUpload")
	public void exUpload() {
		log.info("/exUpload...........");
	}
	
	@PostMapping("/exUploadPost")
	public void exUploadPost(ArrayList<MultipartFile> files) {
	files.forEach(file -> {
		log.info("------------------------------");
		log.info("name : " + file.getOriginalFilename());
		log.info("size :" + file.getSize());
		});
	}
}
