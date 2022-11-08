package com.PSJ.PSJMusic.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.PSJ.PSJMusic.music.ChartVO;
import com.PSJ.PSJMusic.music.SongVO;

public interface MusicDAO {

	public ArrayList<ChartVO> getChartVOS(String date);
	public String getMinDate();
	public int getSongCnt();
	public ArrayList<SongVO> getSongVOS(@Param("startNo")int startNo, @Param("pageSize")int pageSize);
	
	public void setAdminSongUpdate(@Param("idx") int idx, @Param("column") String column, @Param("value") String value);
	public SongVO getSongInfor(int idx);
	public void addSongDB(@Param("img") String img, @Param("title") String title, @Param("artist") String artist);
	public Integer getSongIdx(@Param("title") String title, @Param("artist") String artist);
	public void setChartSongIdx(@Param("songIdx") int songIdx, @Param("title") String title, @Param("artist") String artist);
	public void setIsfile(int idx);
	public void setIsFileChart(@Param("SJ_SONG_TITLE") String SJ_SONG_TITLE, @Param("SJ_SONG_ARTIST") String SJ_SONG_ARTIST);
	public void setSongUpdate(int idx);
	public int isSong(@Param("SJ_SONG_TITLE") String SJ_SONG_TITLE, @Param("SJ_SONG_ARTIST") String SJ_SONG_ARTIST);
	public void insertSong(@Param("vo")SongVO vo);
	public int getLastIdx();
	public void isFileUpdate(@Param("SJ_SONG_IDX")int SJ_SONG_IDX,@Param("sw") int i);
	public ArrayList<SongVO> getSongSrch(String srchKwd);
	public void setChartUpdate(@Param("vos")List<ChartVO> vos);
	
	public String getLikeList(int idx);
	public void setLikeList(@Param("idx") int idx, @Param("likeList") String likeList);
	public void upLikeCnt(int idx);
	public void downLikeCnt(int idx);
	public String getLyrics(int idx);
	public int isPlayCnt(@Param("songIdx")int songIdx, @Param("userIdx") int userIdx);
	public void setPlayCnt(@Param("songIdx") int songIdx, @Param("userIdx") int userIdx);
	public void addPlayCnt(@Param("songIdx") int songIdx, @Param("userIdx") int userIdx);
	public ArrayList<SongVO> getMyRank(@Param("SJ_USER_IDX")int SJ_USER_IDX);
	public ArrayList<SongVO> getRank();
	public String getThumnail(String artist);
	public ArrayList<SongVO> getSrchArtist(@Param("artist1") String artist1, @Param("artist2") String artist2);
	public ArrayList<SongVO> getSongSrchplay(String srchKwd);
	public SongVO getSongInfor2(int idx);
	public ArrayList<SongVO> getNewSong();
	public ArrayList<SongVO> getGenreSong(@Param("genre")String genre);

	

}
