package com.matstar.mapper;

import java.util.List;

import com.matstar.domain.BoardAttachVO;

public interface BoardAttachMapper {

	public void insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByBno(Long bno);
	
	public void deleteAll(Long bno);
	
	//스케줄을 위한 첨부파일 목록을 가져오는 메서드
	public List<BoardAttachVO> getOldFiles();
	
}
