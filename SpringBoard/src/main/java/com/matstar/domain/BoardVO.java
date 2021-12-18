package com.matstar.domain;

import java.util.Date;

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
	
}
