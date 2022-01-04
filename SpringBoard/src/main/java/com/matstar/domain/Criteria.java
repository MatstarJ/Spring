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
	
	
	// 1페이지당 10개를 기본 값으로 정한다.
	public Criteria() {
		this(1,10);
	}
	
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	// 검색 조건이 글자로 되어있으므로, 검색 조건을 배열로 만들어서 한번에 처리한다.
	// 검색 조건이 없을 경우, 빈 배열을 만들고, 있을 경우 문자 단위로 나눠 배열에 넣는다.
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
	
	//여러 개의 파라미터를 연결해서 URL의 형태로 만듬
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum",this.pageNum)
				.queryParam("amount",this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword",this.getKeyword());
		
		return builder.toUriString();
	}
	
}

