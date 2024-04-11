package com.model2.mvc.service.domain;

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
public class Movie {
	///Field
	private String movieCd;
	private String movieNm;
	private String movieNmEn;
	private String movieNmOg;
	private String prdtYear;
	private String showTm;
	private String openDt;
	private String prdtStatNm;
	private String typeNm;
	private String nations;
	private String nationNm;
	private String genreNm;
	private String directors;
	private String peopleNm;
	private String peopleNmEn;
	private String actors;
	private String cast;
	private String castEn;
	private String showTypes;
	private String showTypeGroupNm;
	private String showTypeNm;
	private String audits;
	private String auditNo;
	private String watchGradeNm;
	private String companys;
	private String companyCd;
	private String companyNm;
	private String companyNmEn;
	private String companyPartNm;
	private String staffs;
	private String staffRoleNm;
}