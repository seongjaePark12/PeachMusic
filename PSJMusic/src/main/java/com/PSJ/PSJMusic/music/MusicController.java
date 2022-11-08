package com.PSJ.PSJMusic.music;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.PSJ.PSJMusic.Method;

@Controller
@RequestMapping("/music")
public class MusicController {
	@Autowired MusicService musicService;
	
	// 차트
	@RequestMapping(value="/chart", method = RequestMethod.GET)
	public String chartGet(Model model, String date) {
		ArrayList<ChartVO> vos = musicService.getChartVOS(date);
		model.addAttribute("vos", vos);
		model.addAttribute("date", date);
		model.addAttribute("minDate", musicService.getMinDate());
		return "music/chart";
	}
	// 음악재생
	@RequestMapping(value="/player", method = RequestMethod.GET)
	public String playerGet(HttpServletRequest request, HttpSession session, Model model, String idx, String idxs, String listIdx, String play) {
		session.setAttribute("sPlayer", true);
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i=0; i<cookies.length; i++) {
				String str = cookies[i].getName();
				if (str.equals("cVol")) {
					model.addAttribute("cVol", cookies[i].getValue());
				}
			}
		}
		if (idx != null) {
			SongVO vo = musicService.getSongInfor(Integer.parseInt(idx));
			Method method = new Method();
			model.addAttribute("vo", vo);
			model.addAttribute("img1000", method.getImgSize(vo.getSJ_SONG_IMG(), "1000"));
			model.addAttribute("img2000", method.getImgSize(vo.getSJ_SONG_IMG(), "2000"));
		}
		else if (idxs != null) {
			String[] idx_list = idxs.split("/");
			List<SongVO> vos = new ArrayList<SongVO>();
			Method method = new Method();
			for (int i=0; i<idx_list.length; i++) {
				SongVO vo = musicService.getSongInfor(Integer.parseInt(idx_list[i]));
				if (vo != null) {
					if (vo.getSJ_SONG_ISFILE() == 1) {
						vos.add(vo);
					}
				}
			}
			model.addAttribute("listIdx", listIdx);
			model.addAttribute("vos", vos);
			model.addAttribute("img1000", method.getImgSize(vos.get(0).getSJ_SONG_IMG(), "1000"));
			model.addAttribute("img2000", method.getImgSize(vos.get(0).getSJ_SONG_IMG(), "2000"));
		}
		model.addAttribute("play", play);
		return "music/player"; 
	}
	
	@RequestMapping(value="/player", method = RequestMethod.POST)
	public SongVO playerPost(int idx) {
		return musicService.getSongInfor(idx);
	}
	
	// 곡정보
	@RequestMapping(value="/songinfor", method = RequestMethod.GET)
	public String inforGet(int idx, Model model) {
		if (idx != 0) {
			SongVO vo = musicService.getSongInfor(idx);
			if (vo != null) vo.setSJ_SONG_IMG(vo.getSJ_SONG_IMG().replaceFirst("50", "300"));
			model.addAttribute("vo", vo);
		}
		return"music/songInfor";
	}
	
	// 최신음악
	@RequestMapping(value="/latest", method = RequestMethod.GET)
	public String latestGet(Model model) {
		model.addAttribute("vos", musicService.getNewSong());
		return"music/songlatest";
	}
	
	// 최신음악
	@RequestMapping(value="/genre", method = RequestMethod.GET)
	public String genreGet(Model model,String genre) {
		model.addAttribute("vos", musicService.getGenreSong(genre));
		return"music/songGenre";
	}
	
	
	// 이달의 노래
	@RequestMapping(value="/songrank", method = RequestMethod.GET)
	public String songrankGet(Model model) {
		Method method = new Method();
		ArrayList<SongVO> vos = musicService.getRank();
		vos.get(0).setSJ_SONG_IMG(method.getImgSize(vos.get(0).getSJ_SONG_IMG(), "300"));
		vos.get(1).setSJ_SONG_IMG(method.getImgSize(vos.get(1).getSJ_SONG_IMG(), "200"));
		vos.get(2).setSJ_SONG_IMG(method.getImgSize(vos.get(2).getSJ_SONG_IMG(), "200"));
		model.addAttribute("vos", vos);
		return"music/songrank";
	}
	
	// 곡검색
	@RequestMapping(value="/musicsech", method = RequestMethod.POST)
	public String musicsechPost(Model model,String srchKwd) {
		model.addAttribute("srchKwd", srchKwd);
		model.addAttribute("srchvos", musicService.getSongSrch(srchKwd));
		return"music/songsrch";
	}
	@RequestMapping(value="/srch", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<SongVO> srchPost(String srchKwd) {
		// SJ_00_00 은 대문자+특수문자라 안나옴
		return musicService.getSongSrchplay(srchKwd);
	}
	
	// 랜덤 곡 재생
	@RequestMapping("randomPlay")
	@ResponseBody
	public SongVO randomPlayPost() {
		Integer idx = (int) (Math.random() * musicService.getSongCnt()) + 260;
		return musicService.getSongInfor(idx);
	}

	// 좋아요
	@RequestMapping("like")
	@ResponseBody
	public void likePost(int idx, HttpSession session) {
		musicService.upLikeCnt(idx);
		musicService.addLikeList(idx, (String) session.getAttribute("sMid"));
	}

	// 좋아요취소
	@RequestMapping("unlike")
	@ResponseBody
	public void unLikePost(int idx, HttpSession session) {
		musicService.downLikeCnt(idx);
		musicService.subLikeList(idx, (String) session.getAttribute("sMid"));
	}

	@RequestMapping("likebtn")
	@ResponseBody
	public String likebtnPost(int idx) {
		return musicService.getLikeList(idx);
	}

	@RequestMapping(value = "lyrics", produces = "application/text; charset=utf-8")
	@ResponseBody
	public String lyricsPost(int idx) {
		return musicService.getLyrics(idx);
	}
	
	@RequestMapping("playcntup")
	@ResponseBody
	public void playcntupPost(HttpSession session, int songIdx, int userIdx) {
		musicService.setPlayCnt(songIdx, userIdx);
	}

	@RequestMapping("close")
	@ResponseBody
	public void clseosPost(HttpSession session) {
		session.setAttribute("sPlayer", false);
	}

	@RequestMapping("/getchart")
	@ResponseBody
	public void getchartPost(Model model) throws FileNotFoundException, IOException, ParseException {
		ArrayList<SongVO> vos = musicService.getChartJson();
		model.addAttribute("vos", vos);
	}
	
	@RequestMapping("/getaddsong")
	@ResponseBody
	public SongVO getaddsongPost(int idx) {
		System.out.println(idx);
		return musicService.getSongInfor2(idx);
	}

	@RequestMapping("/shuffle")
	@ResponseBody
	public List<SongVO> shufflePost(@RequestParam(value="idxs[]") List<Integer> idxs, int curIdx) {
		List<SongVO> vos = new ArrayList<SongVO>();
		Collections.shuffle(idxs);
		int index = idxs.indexOf(curIdx);
		int temp = idxs.get(0);
		idxs.set(0, curIdx);
		idxs.set(index, temp);
		for (int idx : idxs) {
			vos.add(musicService.getSongInfor(idx));
		}
		return vos;
	}

	@RequestMapping("/myvol")
	@ResponseBody
	public void myvolPost(HttpServletResponse response, String vol) {
		Cookie cookie = new Cookie("cVol", vol);
		cookie.setMaxAge(60*60*24*7);
		response.addCookie(cookie);
	}
	

}
    
