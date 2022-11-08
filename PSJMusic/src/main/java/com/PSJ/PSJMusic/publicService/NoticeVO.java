package com.PSJ.PSJMusic.publicService;

import lombok.Data;

@Data
public class NoticeVO {
	private int SJ_NOTICE_IDX;
	private String SJ_NOTICE_NAME;
	private String SJ_NOTICE_TITLE;
	private String SJ_NOTICE_CONTENT;
	private String SJ_NOTICE_DATENOW;
	private String SJ_NOTICE_HOSTIP;
	private String SJ_USER_MID;
	private int SJ_NOTICE_NOTICE;
	private int diffTime; // 시간 계산을 위해 저장한 변수(sql에서 시간단위로 계산해서 넘어온 값을 저장) 
	private String oriContent; // 원본 content의 내용을 저장 시켜두기 위한 필드
}
