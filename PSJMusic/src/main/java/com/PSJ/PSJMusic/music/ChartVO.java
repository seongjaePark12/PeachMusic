package com.PSJ.PSJMusic.music;

import lombok.Data;

@Data
public class ChartVO {
	private int SJ_CHART_IDX;
	private String SJ_CHART_IMG;
	private String SJ_CHART_TITLE;
	private String SJ_CHART_ARTIST;
	private int SJ_CHART_RANK;
	private int SJ_SONG_IDX;
	private int SJ_CHART_ISFILE;
	private String SJ_CHART_DATE;
}
