package com.matstar.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.matstar.domain.Criteria;
import com.matstar.domain.ReplyVO;

public interface ReplyMapper {

	//등록
	public int insert(ReplyVO vo);
	
	//조회(특정 댓글 읽기)
	public ReplyVO read(Long rno);
	
	//삭제
	public int delete(Long rno);
	
	//수정
	public int update(ReplyVO reply);
	
	
	//댓글 페이지 처리, 두 개 이상의 데이터를 파라미터로 전달하기 위해 @Param 어노테이션을 사용
	// Map이나 별도의 객체를 사용하는 방법도 있다.
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);
			
				
}
