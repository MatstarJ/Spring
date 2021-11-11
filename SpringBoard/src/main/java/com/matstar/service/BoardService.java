package com.matstar.service;

import java.util.List;

import com.matstar.domain.BoardVO;

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
	public List<BoardVO> getList();
}
