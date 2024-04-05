package com.model2.mvc.common;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Builder  //=> �������� �̿� ���°�����(???)
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Paginate {
	private int now;    	//����������
	private int total;  	//��ü �Խù� ��
	private int numBlock;	//�� �������� ������ ����¡ ����� ����
	private int numPage;	//�� �������� ������ �Խù� ����
	private int totalPage;  //��ü ������ ��
	private int nowBlock;   //���� ���
	private int totalBlock; //�� ������ �� ����
	
	public Paginate(int now, int total, int numBlock, int numPage) {
		this.now = now;
		this.total = total;
		this.numBlock = numBlock;
		this.numPage = numPage;
		this.totalPage = (int)Math.ceil((double)total/numPage);
		this.nowBlock = (int)Math.ceil((double)now/numBlock);
		this.totalBlock = (int) Math.ceil((double) totalPage/numBlock);// �� ������ �� ����
	}
}