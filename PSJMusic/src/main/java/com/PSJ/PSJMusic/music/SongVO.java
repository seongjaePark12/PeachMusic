package com.PSJ.PSJMusic.music;

import lombok.Data;

@Data
public class SongVO {
	private int idx;
	private String img;
	private String title;
	private String artist;
	private int SJ_SONG_IDX;
	private String SJ_SONG_IMG;
	private String SJ_SONG_TITLE;
	private String SJ_SONG_ARTIST;
	private String SJ_SONG_ALBUM;
	private String SJ_SONG_DATE;
	private String SJ_SONG_GENRE;
	private String SJ_SONG_WRITE;
	private String SJ_SONG_COMPOSING;
	private String SJ_SONG_ARRANGE;
	private String SJ_SONG_LYRICS;
	private int SJ_SONG_WISHCNT;
	private String SJ_SONG_LIKELIST;
	private int SJ_SONG_ISFILE;
	
	private int SJ_PLAY_CNT;
	private int playCntSum;
	private String date;
}
