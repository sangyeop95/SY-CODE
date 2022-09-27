package kr.hkit.pms.domain.common;

import lombok.Data;

@Data
public class Criteria {
	// 페이징 처리
	private int pageNum;
	private int amount;
	// 검색 
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		return type == null? new String[] {}: type.split("");
	}
}
