package com.PSJ.PSJMusic;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.PSJ.PSJMusic.music.ChartVO;
import com.PSJ.PSJMusic.music.MusicService;
import com.PSJ.PSJMusic.music.PlayVO;
import com.PSJ.PSJMusic.user.UserService;
import com.PSJ.PSJMusic.user.UserVO;

@Component
public class Scheduler {
	@Autowired MusicService musicService;
	@Autowired UserService userService;
	
	// 매일 00시 10분 차트 업데이트
	@Scheduled(cron = "0 10 0 * * *")
	public void chartUpdate() throws IOException {
		Method method = new Method();
		List<ChartVO> vos = method.getChartTop100();
		for (int i=0; i<vos.size(); i++) {
			int idx = 0;
			if (musicService.getSongIdx(vos.get(i).getSJ_CHART_TITLE(), vos.get(i).getSJ_CHART_ARTIST()) != null) idx = musicService.getSongIdx(vos.get(i).getSJ_CHART_TITLE(), vos.get(i).getSJ_CHART_ARTIST());
			vos.get(i).setSJ_SONG_IDX(idx);
			vos.get(i).setSJ_CHART_ISFILE(musicService.getSongInfor(idx).getSJ_SONG_ISFILE());
		}
		musicService.setChartUpdate(vos);
		System.out.println("차트 업데이트 : " + musicService.getChartVOS(null).get(0).getSJ_CHART_DATE());
	}
	
	// 매일 10시 30분 아티스트 테잎 업데이트
	@Scheduled(cron = "0 30 10 * * *")
	public void artistTapeUpdate() {
		List<UserVO> userVOS = userService.getUserVOS();
		
		for (int i=0; i<userVOS.size(); i++) {
			ArrayList<Integer> bestUserSongIdx = new ArrayList<Integer>();
			ArrayList<Integer> bestUserSongCnt = new ArrayList<Integer>();
			int userIdx = userVOS.get(i).getSJ_USER_IDX();
			if (userIdx == 0) continue;
			List<PlayVO> playListVOS = userService.getUserBestSongIdx(userIdx);
			
			for (int j=0; j<playListVOS.size(); j++) {
				bestUserSongIdx.add(playListVOS.get(j).getSJ_SONG_IDX());
				bestUserSongCnt.add(playListVOS.get(j).getSJ_PLAY_CNT());
			}

			ArrayList<String> artist_1 = new ArrayList<String>();
			ArrayList<Integer> songCnt_1 = new ArrayList<Integer>();
			for (int j=0; j<bestUserSongIdx.size(); j++) {
				String artist_temp = musicService.getSongInfor(bestUserSongIdx.get(j)).getSJ_SONG_ARTIST();
				if (!artist_1.contains(artist_temp)) {
					artist_1.add(musicService.getSongInfor(bestUserSongIdx.get(j)).getSJ_SONG_ARTIST());
					songCnt_1.add(bestUserSongCnt.get(j));
				}
				else {
					int index_ = artist_1.indexOf(artist_temp);
					songCnt_1.set(index_, songCnt_1.get(index_) + bestUserSongCnt.get(j));
				}
			}
			
			for (int j=0; j<songCnt_1.size(); j++) {
				for (int k=j; k>0; k--) {
					if (songCnt_1.get(k - 1) < songCnt_1.get(k)) {
						int temp = songCnt_1.get(k - 1);
						songCnt_1.set(k - 1, songCnt_1.get(k));
						songCnt_1.set(k, temp);

						String tmp = artist_1.get(k - 1);
						artist_1.set(k - 1, artist_1.get(k));
						artist_1.set(k, tmp);
					}
				}
			}
			
			String artist = "";
			
			for (int j=0; j<artist_1.size(); j++) {
				artist += artist_1.get(j) + "^";
			}
			
			if (!artist.equals("")) {
				userService.setArtistTape(userIdx, artist);
			}
		}
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String formatedNow = now.format(formatter);
		System.out.println("아티스트 테잎 업데이트: " + formatedNow);
	}
	
}
