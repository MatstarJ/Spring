package com.matstar.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {

	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
	
	
	// 게시물 별 댓글 전체 카운트
	private int replyCnt;
	
	
	//첨부파일 등록을 위한 BoardAttachVO를 처리할 수 있도록 한다.
	private List<BoardAttachVO> attachList;
	
	
}
