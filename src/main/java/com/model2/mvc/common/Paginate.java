package com.model2.mvc.common;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Builder  //=> 빌더패턴 이용 상태값설정(???)
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Paginate {
	private int now;    	//현재페이지
	private int total;  	//전체 게시물 수
	private int numBlock;	//한 페이지에 보여질 페이징 블록의 갯수
	private int numPage;	//한 페이지당 보여질 게시물 갯수
	private int totalPage;  //전체 페이지 수
	private int nowBlock;   //현재 블록
	private int totalBlock; //총 페이지 블럭 갯수
	
	public Paginate(int now, int total, int numBlock, int numPage) {
		this.now = now;
		this.total = total;
		this.numBlock = numBlock;
		this.numPage = numPage;
		this.totalPage = (int)Math.ceil((double)total/numPage);
		this.nowBlock = (int)Math.ceil((double)now/numBlock);
		this.totalBlock = (int) Math.ceil((double) totalPage/numBlock);// 총 페이지 블럭 갯수
	}
}