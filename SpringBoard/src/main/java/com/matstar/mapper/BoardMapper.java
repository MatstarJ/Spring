package com.matstar.mapper;

import java.util.List;

import com.matstar.domain.BoardVO;



public interface BoardMapper {

	public List<BoardVO> getList();
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	
	//Read의 경우 PK를 이용해 처리하므로 BoardVO클래스의 bno를 이용해 처리한다.
	public BoardVO read(Long bno);
	
	//Delete 역시 PK를 이용하므로 Read와 유사하게 처리한다. 
	// 등록, 삭제, 수정과 같은 DML 작업은 몇 건의 데이터가 처리되었는지를 반환값으로 받을 수 있다.
	public int delete(Long bno);
	
	//몇 개의 데이터가 수정되었는지를 처리할 수 있게 int 타입으로 작성한다.
	public int update(BoardVO board);
	
	
}
