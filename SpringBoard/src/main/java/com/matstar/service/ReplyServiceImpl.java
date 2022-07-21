package com.matstar.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.matstar.domain.Criteria;
import com.matstar.domain.ReplyPageDTO;
import com.matstar.domain.ReplyVO;
import com.matstar.mapper.BoardMapper;
import com.matstar.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	
	private ReplyMapper mapper;
	
	private BoardMapper boardMapper;
	
	
	//등록
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		
		log.info("register.... " + vo);
		
		//기존의 등록에 댓글의 갯수 추가를 위한 추가 설정 (+트랜잭션처리)
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}
	
	//삭제
	@Transactional
	@Override
	public int remove(Long rno) {
		
		log.info("remove....." + rno);
		
		//댓글번호를 받아서 댓글을 조회한다.
		ReplyVO vo = mapper.read(rno);
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(rno);
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
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		
		log.info("get Reply List of Board" + bno);
		return mapper.getListWithPaging(cri, bno);
	}

	//댓글 페이지 처리
	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		
		return new ReplyPageDTO(
				mapper.getCountByBno(bno),
				mapper.getListWithPaging(cri, bno)
				);
	}
	
}
