package kr.hkir.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.hkit.domain.BoardDTO;
import kr.hkit.domain.Criteria;
import kr.hkit.mapper.BoardMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardMapper mapper;
	
	//@Test
	//��ü���
	public void testGetList() { 
		for(BoardDTO board : mapper.getList()) {
			log.info(board);
		}
	}
	
	@Test
	//����¡ ó��
	public void testPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(3);
		cri.setAmount(10);
		
		List<BoardDTO> list = mapper.getListWithPaging(cri);
		list.forEach(board->log.info(board.getBno())); //���ٽ�
	}
	
	//@Test
	//C
	public void testInsert() {
		BoardDTO board = new BoardDTO();
		board.setTitle("new1");
		board.setContent("HELLO WORLD!");
		board.setWriter("user07");
		
		mapper.insert(board);	
		log.info(board);
	}
	
	//@Test
	//R
	public void testRead() {
		BoardDTO board = mapper.read(7L);
		log.info(board);
	}
	
	//@Test
	//U
	public void testUpdate() {
		BoardDTO board = new BoardDTO();
		board.setBno(12L);
		board.setTitle("������ ����3");
		board.setContent("������ ����3");
		board.setWriter("������ �۾���3");
		
		log.info("*****Update Count : " + mapper.update(board));
	}
	
	//@Test
	//D
	public void testDelete() {
		log.info("================================");
		log.info("*****Delete Count : " + mapper.delete(10L));
	}
			
}
