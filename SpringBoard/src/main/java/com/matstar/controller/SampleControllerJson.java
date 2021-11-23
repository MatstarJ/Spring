package com.matstar.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.matstar.domain.SampleJsonVO;
import com.matstar.domain.Ticket;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/samplejson")
@Log4j
public class SampleControllerJson {

	@GetMapping( value = "/getText", produces = "text/plain; charset=UTF-8")
	public String getText() {
		
		log.info("MIME Type : " + MediaType.TEXT_PLAIN_VALUE);
		return "안녕하세요";
	}
	
	@GetMapping(value="/getsample", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
	public SampleJsonVO getSample() {
		return new SampleJsonVO(112,"스타","로드");
	}
	
	@GetMapping(value="/getList")
	public List<SampleJsonVO> getList() {
		return IntStream.range(1, 10).mapToObj(i -> new SampleJsonVO(i, i+"first", i+"Last"))
				.collect(Collectors.toList());   //(스트림의 작업결과)Stream elements를 List로 변경
	}
	
	@GetMapping(value="/getMap")
	public Map<String,SampleJsonVO> getMap() {
		
		Map<String,SampleJsonVO> map = new HashMap<>();
		map.put("First", new SampleJsonVO(111,"그루트","주니어"));
		
		return map;
	}
	
	@GetMapping(value="/check", params = {"height","weight"})
	public ResponseEntity<SampleJsonVO> check(Double height, Double weight) {
		SampleJsonVO vo = new SampleJsonVO(0,"" + height, "" + weight);
		ResponseEntity<SampleJsonVO> result = null;
		
		if(height < 150) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		}else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		return result;
	}
	
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(@PathVariable("cat") String cat, @PathVariable("pid") Integer pid) {
			
			return new String[] { "category : " + cat, "productid : " + pid};
		
	}
	
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		log.info("convert... ticket"+ ticket);
		
		return ticket;
	}
	
}
