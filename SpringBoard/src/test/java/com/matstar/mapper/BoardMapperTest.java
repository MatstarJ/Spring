package com.matstar.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.matstar.domain.BoardVO;
import com.matstar.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTest {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	// Insert 테스트
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새로운 글");
		board.setContent("작성 내용");
		board.setWriter("newnew");
		
		mapper.insert(board);
		log.info(board);
	}
	
	@Test
	public void testInsertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("새로운 글 selectKey");
		board.setContent("새로 작성하는 내용 selectKey");
		board.setWriter("newnew");
		
		mapper.insertSelectKey(board);
		log.info(board);
	}
	
	@Test
	public void testRead() {
		//존재하는 게시물의 번호로(PK) 테스트
		BoardVO board = mapper.read(5L);
		log.info(board);
	}
	
	@Test
	public void testDelete() {
		log.info("Delete Count : " + mapper.delete(5L));
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		
		board.setBno(5L);
		board.setTitle("수정된 제목");
		board.setContent("수정된 내용");
		board.setWriter("user00");
		
		int count = mapper.update(board);
		log.info("Update Count : "+ count);
	}
	
	//페이징 테스트
	@Test
	public void testPaging() {
		
		Criteria cri = new Criteria();
		
		cri.setPageNum(3);
		cri.setAmount(10);
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board));
	}

	//검색 테스트
	public void testSearch() {
		Criteria cri = new Criteria();
		
		cri.setKeyword("새로");
		cri.setType("TC");
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board -> log.info(board));
	}
}
