package com.PSJ.PSJMusic.publicService;

import lombok.Data;

@Data
public class QuestionVO {
	private int SJ_QUESTION_IDX;
	private String SJ_USER_MID;
	private String SJ_QUESTION_TITLE;
	private String SJ_QUESTION_WHAT;
	private String SJ_QUESTION_CONTENT;
	private String SJ_QUESTION_DATE;
	private int SJ_QUESTION_ANSER;
	private int diffTime;
	private String oriContent; // 원본 content의 내용을 저장 시켜두기 위한 필드
}
