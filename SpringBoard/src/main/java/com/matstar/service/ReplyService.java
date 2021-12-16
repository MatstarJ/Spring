package com.matstar.service;

import java.util.List;

import com.matstar.domain.Criteria;
import com.matstar.domain.ReplyPageDTO;
import com.matstar.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long rno);
	
	public List<ReplyVO> getList(Criteria cri, Long bno);
	
	//댓글 페이징처리
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
	
}
