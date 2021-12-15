package com.matstar.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.matstar.domain.Criteria;
import com.matstar.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {

	private Long[] bnoArr = {2061L, 2063L, 2064L, 2066L, 2067L};
	
	@Setter(onMethod_= @Autowired)
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	//등록테스트
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1,10).forEach( i -> {
			ReplyVO vo = new ReplyVO();
		
		
		//게시물 번호
		vo.setBno(bnoArr[i % 5]);
		vo.setReply("댓글 테스트" + i);
		vo.setReplyer("replyer" + i);
		
		mapper.insert(vo);
		
		});
	}
	
	//조회 테스트
	@Test
	public void testRead() {
		long targetRno = 5L;
		ReplyVO vo = mapper.read(targetRno);
		log.info(vo);
	}
	
	//삭제 테스트
	@Test
	public void testDelete() {
		Long targetRno = 1L;
		mapper.delete(targetRno);
	}
	
	//수정 테스트
	@Test
	public void testUpdate() {
		Long targetRno = 21L;
		
		ReplyVO vo = mapper.read(targetRno);
		
		vo.setReply("Update Reply");
		int count = mapper.update(vo);
		log.info("UPDATE COUNT:" + count);
	}
	
	//댓글목록
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		
		replies.forEach(reply -> log.info(reply));
	}
	
	//페이징
	@Test
	public void  testList2() {
		Criteria cri = new Criteria(2,10);
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		
		replies.forEach(null);
	}
}
