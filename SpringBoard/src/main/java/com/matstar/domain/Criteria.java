package com.matstar.domain;

import lombok.Data;

@Data
public class Criteria {

	//페이지 번호
	private int pageNum;
	
	// 1페이지당 보여줄 데이터 갯수
	private int amount;
	
	
	// 1페이지당 10개
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}

