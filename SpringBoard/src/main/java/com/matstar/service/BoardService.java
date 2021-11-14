package com.matstar.service;

import java.util.List;

import com.matstar.domain.BoardVO;
import com.matstar.domain.Criteria;

public interface BoardService {

	//등록 insert
	public void register(BoardVO board);

	//특정 게시물을 가져옴
	public BoardVO get(Long bno);
	
	//수정 update
	public boolean modify(BoardVO board);
	 
	//삭제 delete
	public boolean remove(Long bno);
	
	//전체 리스트 출력 
	//public List<BoardVO> getList();
	//페이지를 받아올 수 있도록 수정
	public List<BoardVO> getList(Criteria cri);
	
	//전체 데이터 개수 구하기(Criteria를 받지 않아도 문제 없음)
	public int getTotal(Criteria cri);
}
