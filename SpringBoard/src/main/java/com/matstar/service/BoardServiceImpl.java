package com.matstar.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.matstar.domain.BoardVO;
import com.matstar.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	private BoardMapper mapper;

	//필요하다면 void 대신 selectKey의 반환값인 int를 사용할 수 있다.
	@Override
	public void register(BoardVO board) {
		
		log.info("register : " + board);
		
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		
		log.info("get : " + bno);
		
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		
		log.info("modify : " + board);
		
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		
		log.info("remove : " + bno);
		
		return mapper.delete(bno)== 1;
	}

	@Override
	public List<BoardVO> getList() {
		
		log.info("getList : " );
		return mapper.getList();
	}
	
}
