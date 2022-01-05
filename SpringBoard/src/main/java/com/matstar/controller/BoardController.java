package com.matstar.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.matstar.domain.AttachFileDTO;
import com.matstar.domain.BoardAttachVO;
import com.matstar.domain.BoardVO;
import com.matstar.domain.Criteria;
import com.matstar.domain.PageDTO;
import com.matstar.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	private BoardService service;
	
	
	//전체 리스트 출력
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
		log.info("list" + cri);
		
		int total = service.getTotal(cri);
		
		log.info("total : " + total);
		
		model.addAttribute("list" , service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri,total));
	}
	
	
	//@GetMapping("/list")
	//public void list(Model model) {
	//	log.info("list");
	//	model.addAttribute("list",service.getList());
	//}
	
	
	
	//게시물의 등록 작업은 POST방식으로 처리하지만 화면에서 
	//입력을 받아야 하므로 GET방식으로 입력 페이지를 처리한다.
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register : " + board);
		
		//첨부파일의 유무를 확인한다.
		if(board.getAttachList() != null) {
			
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		

		service.register(board);
		rttr.addFlashAttribute("result",board.getBno());
		
		return "redirect:/board/list";
	}
	
	//조회, 수정 입력 페이지 이동
	// 조회페이지에서 리스트로 이동시 페이지 유지를 위해 Criteria를 파라미터로 받는다.
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, Model model, 
			@ModelAttribute("cri") Criteria cri) {
		
		log.info("/get");
		
		model.addAttribute("board",service.get(bno));
	}
	
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr,
			@ModelAttribute("cri") Criteria cri) {
		log.info("modify:" + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		//페이지 관련 파라미터 처리
			//rttr.addAttribute("pageNum",cri.getPageNum());
			//rttr.addAttribute("amount",cri.getAmount());
		//검색어 유지 파라미터
			//rttr.addFlashAttribute("type",cri.getType());
			//rttr.addFlashAttribute("keyword",cri.getKeyword());
		return "redirect:/board/list"+cri.getListLink();
	}
	
	
	//첨부파일 삭제처리
	private void deleteFiles(List<BoardAttachVO> attachList) {
		
		if(attachList == null || attachList.size() == 0 ) {
			return;
		}
		
		log.info("delete attach files................");
		log.info("Board Controller DeleteFiles() attachList : "+attachList);
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("c:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					
					Path thumNail = Paths.get("c:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
					
					Files.delete(thumNail);
					
				}
				
			} catch (Exception e) {
				log.error("delete file error : " + e.getMessage());
			}
		});
	}
	
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(
			@RequestParam("bno") Long bno, RedirectAttributes rttr,
			@ModelAttribute("cri") Criteria cri, String writer) {
		
		log.info("remove..." + bno);
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		
		if(service.remove(bno)) {
			
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result","success");
		}
		
		//페이지 관련 파라미터 처리
			//rttr.addAttribute("pageNum",cri.getPageNum());
			//rttr.addAttribute("amount",cri.getAmount());
		//검색어 유지 파라미터
			//rttr.addFlashAttribute("type",cri.getType());
			//rttr.addFlashAttribute("keyword",cri.getKeyword());
		return "redirect:/board/list"+cri.getListLink();
	}
	
	
	
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		
		log.info("getAttach List  : " + bno);
		
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);

	}
	
	

	
	
	
	
	
}
