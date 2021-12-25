package com.matstar.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.matstar.domain.BoardAttachVO;
import com.matstar.domain.BoardVO;
import com.matstar.domain.Criteria;
import com.matstar.mapper.BoardAttachMapper;
import com.matstar.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	private BoardMapper mapper;
	
	private BoardAttachMapper attachMapper;

	//필요하다면 void 대신 selectKey의 반환값인 int를 사용할 수 있다.
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		
		log.info("register..." + board);
		
		mapper.insertSelectKey(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		
		board.getAttachList().forEach(attach -> {
			
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
		
	}

	@Override
	public BoardVO get(Long bno) {
		
		log.info("get...."+bno);
		
		return mapper.read(bno);
	}
	
	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		
		log.info("modify....."+ board);
		
		attachMapper.deleteAll(board.getBno());
		
		boolean modifyResult = mapper.update(board)==1;
		
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		
		log.info("remove......."+bno);
		
		attachMapper.deleteAll(bno);
		
		return mapper.delete(bno)==1;
	}

	//페이지를 받아올 수 있도록 수정
	@Override
	public List<BoardVO> getList(Criteria cri) {
		
		log.info(" get List with criteria : " + cri);
		
		return mapper.getListWithPaging(cri);
	}
	/*
	 * @Override public List<BoardVO> getList() {
	 * 
	 * log.info("getList.......");
	 * 
	 * return mapper.getList(); }
	 */
	
	
	//전체 데이터 개수 구하기(Criteria를 받지 않아도 문제 없음)
	@Override
	public int getTotal(Criteria cri) {
		
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		
		log.info("get Attach list by bno" + bno);
		
		return attachMapper.findByBno(bno);
	}
}
