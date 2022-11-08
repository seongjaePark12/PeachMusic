package com.PSJ.PSJMusic.publicService;

import lombok.Data;

@Data
public class MagazinVO {
	private int SJ_MAGAZINE_IDX;
	private String SJ_MAGAZINE_IMG;
	private String SJ_MAGAZINE_TITLE;
	private String SJ_MAGAZINE_CONTENT;
	private int diffTime; // 시간 계산을 위해 저장한 변수(sql에서 시간단위로 계산해서 넘어온 값을 저장) 
	private String oriContent; // 원본 content의 내용을 저장 시켜두기 위한 필드
	private int SJ_MAGAZINE_VISIT;
}
