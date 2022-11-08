package com.PSJ.PSJMusic.music;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.json.simple.parser.ParseException;

public interface MusicService {

	public ArrayList<ChartVO> getChartVOS(String date);

	public String getMinDate();

	public ArrayList<SongVO> getSongVOS(int startNo, int pageSize);

	public int getSongCnt();

	public void setAdminSongUpdate(int idx, String column, String value);

	public SongVO getSongInfor(int idx);

	public void addSongDB(String img, String title, String artist);

	public void songUpload(int idx, MultipartFile file)  throws IOException;

	public void setIsfile(int idx);

	public void setSongUpdate(int idx);

	public int isSong(String SJ_SONG_TITLE, String SJ_SONG_ARTIST);

	public void insertSong(SongVO vo);

	public void isFileUpdate();

	public ArrayList<SongVO> getSongSrch(String srchKwd);

	public Integer getSongIdx(String SJ_CHART_TITLE, String SJ_CHART_ARTIST);

	public void setChartUpdate(List<ChartVO> vos);

	public ArrayList<SongVO> getChartJson() throws FileNotFoundException, IOException, ParseException;

	
	
	public void addLikeList(int idx, String mid);

	public void upLikeCnt(int idx);

	public void downLikeCnt(int idx);

	public void subLikeList(int idx, String mid);

	public String getLikeList(int idx);

	public String getLyrics(int idx);

	public void setPlayCnt(int songIdx, int userIdx);

	public ArrayList<SongVO> getMyRank(int SJ_USER_IDX);

	public ArrayList<SongVO> getRank();

	public List<SongVO> getSrchArtist(String artist);

	public ArrayList<SongVO> getSongSrchplay(String srchKwd);

	public SongVO getSongInfor2(int idx);

	public ArrayList<SongVO> getNewSong();

	public ArrayList<SongVO> getGenreSong(String genre);

}
