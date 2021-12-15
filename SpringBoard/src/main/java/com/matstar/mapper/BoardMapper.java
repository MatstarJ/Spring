package com.matstar.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.matstar.domain.BoardVO;
import com.matstar.domain.Criteria;



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
	
	
	//페이지 처리를 위한 메소드
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	//전체 데이터를 구하는 메소드(Criteria를 받지 않아도 문제 없음)
	public int getTotalCount(Criteria cri);
	
	// 댓글 총 갯수 
	// 게시물 번호와 댓글의 증감을 파라미터로 받을 수 있도록 처리한다.
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
}
