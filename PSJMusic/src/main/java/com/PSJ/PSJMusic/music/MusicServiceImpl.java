package com.PSJ.PSJMusic.music;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.PSJ.PSJMusic.Method;
import com.PSJ.PSJMusic.dao.MusicDAO;
import com.PSJ.PSJMusic.dao.UserDAO;
import com.google.gson.Gson;

@Service
public class MusicServiceImpl implements MusicService {
	@Autowired UserDAO userDAO;
	@Autowired MusicDAO musicDAO;
	
	@Override
	public int getSongCnt() {return musicDAO.getSongCnt();}
	@Override
	public ArrayList<ChartVO> getChartVOS(String date) {return musicDAO.getChartVOS(date);}
	@Override
	public String getMinDate() {return musicDAO.getMinDate();}
	@Override
	public ArrayList<SongVO> getSongVOS(int startNo, int pageSize) {return musicDAO.getSongVOS(startNo, pageSize);}
	@Override
	public void setAdminSongUpdate(int idx, String column, String value) {musicDAO.setAdminSongUpdate(idx, column, value);}
	@Override
	public SongVO getSongInfor(int idx) {return musicDAO.getSongInfor( idx);}
	@Override
	public SongVO getSongInfor2(int idx) {return musicDAO.getSongInfor2( idx);}
	@Override
	public void addSongDB(String img, String title, String artist) {
		musicDAO.addSongDB(img, title, artist);
		int songIdx = musicDAO.getSongIdx(title, artist);
		musicDAO.setChartSongIdx(songIdx, title, artist);
	}
	@Override
	public void songUpload(int idx, MultipartFile file) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/music/");
		String fileNm = musicDAO.getSongInfor(idx).getSJ_SONG_TITLE() + " - " + musicDAO.getSongInfor(idx).getSJ_SONG_ARTIST() + ".mp3";
		fileNm = fileNm.replaceAll("[\\\\/:*?\"<>|]", "");
		byte[] data = file.getBytes();
		FileOutputStream fos = new FileOutputStream(uploadPath + fileNm);
		fos.write(data);
		fos.close();		
	}
	@Override
	public void setIsfile(int idx) {
		musicDAO.setIsfile(idx);
		musicDAO.setIsFileChart(musicDAO.getSongInfor(idx).getSJ_SONG_TITLE(), musicDAO.getSongInfor(idx).getSJ_SONG_ARTIST());
	}
	@Override
	public void setSongUpdate(int idx) {musicDAO.setSongUpdate(idx);}
	@Override
	public int isSong(String SJ_SONG_TITLE, String SJ_SONG_ARTIST) {return musicDAO.isSong(SJ_SONG_TITLE, SJ_SONG_ARTIST);}
	@Override
	public void insertSong(SongVO vo) {musicDAO.insertSong(vo);}
	@Override
	public void isFileUpdate() {
		Method method = new Method();
		int last = musicDAO.getLastIdx();
		for (int i=0; i<last + 1; i++) {
			SongVO vo = musicDAO.getSongInfor(i);
			if (vo != null) {
				if (method.isFile(vo.getSJ_SONG_TITLE(), vo.getSJ_SONG_ARTIST())) {
					musicDAO.isFileUpdate(vo.getSJ_SONG_IDX(), 1);
				}
			}
		}	
	}
	@Override
	public ArrayList<SongVO> getSongSrch(String srchKwd) {return musicDAO.getSongSrch(srchKwd);}
	@Override
	public Integer getSongIdx(String SJ_CHART_TITLE, String SJ_CHART_ARTIST) {return musicDAO.getSongIdx(SJ_CHART_TITLE, SJ_CHART_ARTIST);}
	@Override
	public void setChartUpdate(List<ChartVO> vos) {musicDAO.setChartUpdate(vos);}
	@Override
	public ArrayList<SongVO> getChartJson() throws FileNotFoundException, IOException, ParseException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String path = request.getSession().getServletContext().getRealPath("json/song_json.json");
		
		JSONParser parser = new JSONParser();
		Reader reader = new FileReader(path);
		JSONObject jsonObject = (JSONObject) parser.parse(reader);
		JSONArray songs = (JSONArray) jsonObject.get("songs");
		
		Gson gson = new Gson();
		ArrayList<SongVO> vos = new ArrayList<SongVO>();
		for (int i=0; i<songs.size(); i++) {
			SongVO vo = new SongVO();
			JSONObject song = (JSONObject) songs.get(i);
			vo = gson.fromJson(song.toJSONString(), SongVO.class);
			int idx = musicDAO.getSongIdx(song.get("title").toString(), song.get("artist").toString());
			vo.setSJ_SONG_IDX(idx);
			vo.setSJ_SONG_ISFILE(musicDAO.getSongInfor(idx).getSJ_SONG_ISFILE());
			vos.add(vo);
		}
		return vos;
	}
	@Override
	public void addLikeList(int idx, String mid) {
		String likeList = "";
		if (musicDAO.getLikeList(idx) != null) likeList = musicDAO.getLikeList(idx);
		likeList += mid + "/";
		musicDAO.setLikeList(idx, likeList);
	}
	@Override
	public void upLikeCnt(int idx) {
		musicDAO.upLikeCnt(idx);
	}
	@Override
	public void downLikeCnt(int idx) {
		musicDAO.downLikeCnt(idx);
	}
	@Override
	public void subLikeList(int idx, String mid) {
		String likeList = musicDAO.getLikeList(idx);
		likeList = likeList.replace(mid + "/", "");
		musicDAO.setLikeList(idx, likeList);
	}
	@Override
	public String getLikeList(int idx) {
		return musicDAO.getLikeList(idx);
	}
	@Override
	public String getLyrics(int idx) {
		return musicDAO.getLyrics(idx);
	}
	@Override
	public void setPlayCnt(int songIdx, int userIdx) {
		if (musicDAO.isPlayCnt(songIdx, userIdx) == 0) {
			musicDAO.setPlayCnt(songIdx, userIdx);
		}
		musicDAO.addPlayCnt(songIdx, userIdx);	
	}
	@Override
	public ArrayList<SongVO> getMyRank(int SJ_USER_IDX) {
		return musicDAO.getMyRank(SJ_USER_IDX);
	}
	@Override
	public ArrayList<SongVO> getRank() {
		return musicDAO.getRank();
	}
	@Override
	public List<SongVO> getSrchArtist(String artist) {
		ArrayList<SongVO> vos = new ArrayList<SongVO>();
		if (artist.contains("(")) {
			String artist1 = artist.split("\\(")[0].trim();
			String artist2 = artist.substring(artist.indexOf("(") + 1, artist.indexOf(")"));
			vos = musicDAO.getSrchArtist(artist1, artist2);
		}
		else {
			vos = musicDAO.getSrchArtist(artist, null);
		}
		
		return vos;
	}
	@Override
	public ArrayList<SongVO> getSongSrchplay(String srchKwd) {
		return musicDAO.getSongSrchplay(srchKwd);
	}
	@Override
	public ArrayList<SongVO> getNewSong() {return musicDAO.getNewSong();}
	@Override
	public ArrayList<SongVO> getGenreSong(String genre) {return musicDAO.getGenreSong(genre);}

	
}
