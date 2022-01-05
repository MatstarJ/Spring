package com.matstar.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.matstar.domain.Criteria;
import com.matstar.domain.ReplyPageDTO;
import com.matstar.domain.ReplyVO;
import com.matstar.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {

	private ReplyService service;
	
	
	//등록
	// JSON 타입으로 된 댓글 데이터를 전송하고 서버에서는 댓글의 처리 결과가
	// 정상적으로 되었는지 문자열로 결과를 알려주도록 한다.
	// 데이터를 json 형태로 받아서 문자열 형태로 반환하도록 처리한다.
	//consumes는 클라이언트가 서버에게 보내는 데이터 타입을 명시한다.
	//produces는 서버가 클라이언트에게 반환하는 데이터 타입을 명시한다.
	// @RequestBody Json타입을 ReplyVO 타입으로 변환
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value ="/new", consumes ="application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
		
		log.info("ReplyVO :" + vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply Insert Count : " + insertCount);
		
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	

	//특정 게시물 댓글 목록 확인
//	@GetMapping(value="/pages/{bno}/{page}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
//	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno) {
		
//		log.info("get List.....");
		
//		Criteria cri = new Criteria(page,10);
		
		
//		log.info("page : "+page);
//		log.info("get Reply List bno : "+bno);
//		log.info(cri);
		
//		return new ResponseEntity<>(service.getList(cri, bno),HttpStatus.OK);
//	}
	
	@GetMapping(value="/pages/{bno}/{page}", produces = {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno) {
		
		Criteria cri = new Criteria(page,10);
		
		log.info("get Reply List bno : " + bno);
		
		log.info("cri :  + cri");
		
		return new ResponseEntity<ReplyPageDTO>(service.getListPage(cri, bno),HttpStatus.OK);
	}
	
	
	
	//댓글 조회
	@GetMapping (value ="/{rno}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {
		
		log.info("get" + rno);
		
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	
	//댓글 삭제
	@PreAuthorize("principal.username == #vo.replyer")
	@DeleteMapping(value ="/{rno}")
	public ResponseEntity<String> remove(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno) {
		
		log.info("remove : " + rno);
		log.info("replyer : " + vo.getReplyer());
		return service.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
				
	}
	
	
	//댓글 수정
	@PreAuthorize("principal.username == #vo.replyer")
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH}, value = "/{rno}", consumes = "application/json",  produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno) {
		
		vo.setRno(rno);
		
		log.info("rno : " + rno);
		
		log.info("modify : " + vo);
		
		return service.modify(vo) ==1 ? new ResponseEntity<>("success",HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	

}
