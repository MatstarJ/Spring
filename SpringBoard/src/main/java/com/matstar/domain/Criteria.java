package com.matstar.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class Criteria {

	//페이지 번호
	private int pageNum;
	
	// 1페이지당 보여줄 데이터 갯수
	private int amount;
	
	
	//검색 조건
	private String type;
	
	//검색어 
	private String keyword;
	
	
	// 1페이지당 10개를 기본 값으로 정
	public Criteria() {
		this(1,10);
	}
	
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	//검색 조건을 배열로 만들어서 처리함
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
	
	//여러 개의 파라미터를 연결해서 URL의 형태로 만듬
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", getType())
				.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}
	
}

