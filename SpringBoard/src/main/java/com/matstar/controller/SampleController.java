package com.matstar.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
}
