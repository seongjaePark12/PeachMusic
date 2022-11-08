package com.PSJ.PSJMusic.user;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.PSJ.PSJMusic.Method;
import com.PSJ.PSJMusic.dao.MusicDAO;
import com.PSJ.PSJMusic.dao.UserDAO;
import com.PSJ.PSJMusic.music.PlayListVO;
import com.PSJ.PSJMusic.music.PlayVO;
import com.PSJ.PSJMusic.music.SongVO;
import com.PSJ.PSJMusic.publicService.NoticeVO;


@Service
public class UserServiceImpl implements UserService {
	@Autowired UserDAO userDAO;
	@Autowired MusicDAO musicDAO;
	
	@Override
	public UserVO getIdCheck(String SJ_USER_MID) {return userDAO.getIdCheck(SJ_USER_MID);}
	@Override
	public UserVO getEmailCheck(String SJ_USER_EMAIL) {return userDAO.getEmailCheck(SJ_USER_EMAIL);}
	@Override
	public void setMemJoin(UserVO vo) {userDAO.setMemJoin(vo);}
	@Override
	public UserVO getMidConfirm(String num, String email) {return userDAO.getMidConfirm(num,email);}
	@Override
	public UserVO getPwdConfirm(String mid, String num, String email) {return userDAO.getPwdConfirm(mid,num,email);}
	@Override
	public void setPwdChange(String mid, String pwd) {userDAO.setPwdChange(mid,pwd);}
	@Override
	public void setMemDelete(String mid) {userDAO.setMemDelete(mid);}
	@Override
	public void setMyUpdate(UserVO vo) {userDAO.setMyUpdate(vo);}
	@Override
	public void setKakaoMemberInputOk(String mid, String pwd, String email, String nickName) {userDAO.setKakaoMemberInputOk(mid, pwd, email, nickName);}
	@Override
	public int noticeTotRecCnt() {return userDAO.noticeTotRecCnt();}
	@Override
	public List<NoticeVO> getNotice(int startIndexNo, int pageSize) {return userDAO.getNotice(startIndexNo,pageSize);}
	@Override
	public NoticeVO getNoticeContent(int SJ_NOTICE_IDX) {return userDAO.getNoticeContent(SJ_NOTICE_IDX);}
	@Override
	public List<NoticeVO> getPreNext(int SJ_NOTICE_IDX) {return userDAO.getPreNext(SJ_NOTICE_IDX);}
	@Override
	public void setArtistTape(int userIdx, String artist) {userDAO.setArtistTape(userIdx, artist);}
	
	@Override
	public List<SongVO> getArtistTape(int SJ_USER_IDX) {
		List<SongVO> vos = new ArrayList<SongVO>(); 
		String artists = userDAO.getArtistTape(SJ_USER_IDX);
		if (artists != null) {
			String[] artistArr = artists.split("\\^");
			Method method = new Method();
			int cnt = 0;
			// 여기서 갯수 설정 해야 할 듯
			for (String artist : artistArr) {
				SongVO vo = new SongVO();
				vo.setSJ_SONG_ARTIST(artist);
				String img_ = musicDAO.getThumnail(artist);
				if (img_ != null) vo.setSJ_SONG_IMG(method.getImgSize(img_, "200"));
				vos.add(vo);
				cnt++;
				if (cnt > 7) break;
			}
		}
		return vos;
	}
	@Override
	public List<UserVO> getUserVOS() {return userDAO.getUserVOS();}
	@Override
	public List<PlayVO> getUserBestSongIdx(int userIdx) {return userDAO.getUserBestSongIdx(userIdx);}
	@Override
	public ArrayList<PlayListVO> getPlayListVOS(int SJ_USER_IDX) {
		Method method = new Method();
		ArrayList<PlayListVO> vos = userDAO.getPlayListVOS(SJ_USER_IDX);
		for (int i=0; i<vos.size(); i++) {
			if (!vos.get(i).getSJ_PLAYLIST_CONTENT().equals("")) {
				String idxs[] = vos.get(i).getSJ_PLAYLIST_CONTENT().split("/");
				if (idxs.length >= 4) {
					vos.get(i).setThum1(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[0])).getSJ_SONG_IMG(), "100"));
					vos.get(i).setThum2(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[1])).getSJ_SONG_IMG(), "100"));
					vos.get(i).setThum3(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[2])).getSJ_SONG_IMG(), "100"));
					vos.get(i).setThum4(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[3])).getSJ_SONG_IMG(), "100"));
				}
				else if (idxs.length == 3) {
					vos.get(i).setThum1(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[0])).getSJ_SONG_IMG(), "100"));
					vos.get(i).setThum2(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[1])).getSJ_SONG_IMG(), "100"));
					vos.get(i).setThum3(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[2])).getSJ_SONG_IMG(), "100"));
				}
				else if (idxs.length == 2) {
					vos.get(i).setThum1(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[0])).getSJ_SONG_IMG(), "100"));
					vos.get(i).setThum2(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[1])).getSJ_SONG_IMG(), "100"));
				}
				else if (idxs.length == 1) {
					vos.get(i).setThum1(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[0])).getSJ_SONG_IMG(), "200"));
				}
			}
		}
		return vos;
	}
	@Override
	public PlayListVO getPlayListVO(int idx) {
		Method method = new Method();
		PlayListVO vo = userDAO.getPlayListVO(idx);
		if (!vo.getSJ_PLAYLIST_CONTENT().equals("")) {
			String idxs[] = vo.getSJ_PLAYLIST_CONTENT().split("/");
			if (idxs.length >= 4) {
				vo.setThum1(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[0])).getSJ_SONG_IMG(), "100"));
				vo.setThum2(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[1])).getSJ_SONG_IMG(), "100"));
				vo.setThum3(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[2])).getSJ_SONG_IMG(), "100"));
				vo.setThum4(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[3])).getSJ_SONG_IMG(), "100"));
			}
			else if (idxs.length == 3) {
				vo.setThum1(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[0])).getSJ_SONG_IMG(), "100"));
				vo.setThum2(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[1])).getSJ_SONG_IMG(), "100"));
				vo.setThum3(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[2])).getSJ_SONG_IMG(), "100"));
			}
			else if (idxs.length == 2) {
				vo.setThum1(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[0])).getSJ_SONG_IMG(), "100"));
				vo.setThum2(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[1])).getSJ_SONG_IMG(), "100"));
			}
			else if (idxs.length == 1) {
				vo.setThum1(method.getImgSize(musicDAO.getSongInfor(Integer.parseInt(idxs[0])).getSJ_SONG_IMG(), "200"));
			}
		}
		return vo;
	}
	@Override
	public void setPlayList(PlayListVO vo) {userDAO.setPlayList(vo);}
	@Override
	public boolean setAddMyList(int idx, int songIdx) {
		String content = userDAO.getPlayListVO(idx).getSJ_PLAYLIST_CONTENT();
		if (!content.contains(Integer.toString(songIdx))) {
			content += songIdx + "/";
			userDAO.setUpdateMyList(idx, content);
			return true;
		}
		return false;
	}
	@Override
	public void setAddMyListMany(int idx, String songIdxs) {
		String[] songIdxList = songIdxs.split("/");
		String content = userDAO.getPlayListVO(idx).getSJ_PLAYLIST_CONTENT();
		for (int i=0; i<songIdxList.length; i++) {
			if (!content.contains(songIdxList[i])) {
				content += songIdxList[i] + "/";
			}
		}
		userDAO.setUpdateMyList(idx, content);
	}
	@Override
	public void setPlayListDel(int idx) {userDAO.setPlayListDel(idx);}
	@Override
	public void setPlayListDelSong(int idx, int songIdx) {
		System.out.println(idx +"/"+songIdx);
		String content = userDAO.getPlayListVO(idx).getSJ_PLAYLIST_CONTENT();
		System.out.println(content);
		content = content.replace(songIdx + "/", "");
		userDAO.setUpdateMyList(idx, content);
	}
	@Override
	public void setPlayListContentUpdate(int idx, String listNm, String comment) {userDAO.setPlayListContentUpdate(idx, listNm, comment);}
	@Override
	public void getloginUp() {userDAO.getloginUp();}
	@Override
	public void getjoinUp() {userDAO.getjoinUp();}
}
