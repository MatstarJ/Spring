package com.matstar.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.matstar.domain.Criteria;
import com.matstar.domain.ReplyVO;
import com.matstar.mapper.ReplyMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
	
	private ReplyMapper mapper;
	
	
	//등록
	public int register(ReplyVO vo) {
		
		log.info("register.... " + vo);
		return mapper.insert(vo);
	}
	
	//조회
	@Override
	public ReplyVO get(Long rno) {
		
		log.info("get....."+ rno);
		return mapper.read(rno);
	}

	//수정
	@Override
	public int modify(ReplyVO vo) {
		
		log.info("modify....." + vo);
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		
		log.info("remove....." + rno);
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		
		log.info("get Reply List of Board" + bno);
		return mapper.getListWithPaging(cri, bno);
	}

	
}
