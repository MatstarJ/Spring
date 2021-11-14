package com.matstar.domain;

import lombok.Data;

@Data
public class PageDTO {

	//페이지 시작 번호
	private int startPage;
	
	// 페이지 끝 번호
	private int endPage;
	
	//이전, 다음
	private boolean prev, next;
	
	//총 데이터 갯수
	private int total;
	
	//페이지 번호와 페이지당 보여줄 데이터 갯수
	private Criteria cri;
	
	
	
	
	
	public PageDTO(Criteria cri, int total) {
		
		this.cri = cri;
		this.total = total;
		
		//끝 번호는 올림한 페이지 번호에서 10을 나눈후 다시 곱해서 구함.
		//10페이지 기준
		this.endPage = (int) (Math.ceil(cri.getPageNum()/10.0)*10);
		
		//시작 페이지는 끝 페이지에서 9를 뺀 값 (항상 1로 시작)
		this.startPage = this.endPage-9;
		
		// 실제 페이지의 끝 번호, 총 데이터 갯수에서 페이지 당 보여줄 데이터 수를 나눔
		int realEnd = (int)(Math.ceil(total*1.0)/cri.getAmount());
		
		//실제 페이지수가 작으면 끝페이지를 실제 페이지로 처리함
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		//이전 페이지는 시작페이지가 1보다 큰 경우에만 존재한다.
		this.prev = this.startPage > 1;
		
		// 다음 페이지는 끝페이지가 실제 페이지보다 작을 때 존재한다.
		this.next = this.endPage < realEnd;
		
	}
}
