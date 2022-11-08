package com.PSJ.PSJMusic.user;

import java.util.ArrayList;
import java.util.List;

import com.PSJ.PSJMusic.music.PlayListVO;
import com.PSJ.PSJMusic.music.PlayVO;
import com.PSJ.PSJMusic.music.SongVO;
import com.PSJ.PSJMusic.publicService.NoticeVO;

public interface UserService {
	public UserVO getIdCheck(String SJ_USER_MID);
	
	public UserVO getEmailCheck(String SJ_USER_EMAIL);

	public void setMemJoin(UserVO vo);

	public UserVO getMidConfirm(String num, String email);

	public UserVO getPwdConfirm(String mid, String name, String email);

	public void setPwdChange(String mid, String pwd);

	public void setMemDelete(String mid);

	public void setMyUpdate(UserVO vo);

	public void setKakaoMemberInputOk(String mid, String pwd, String email, String nickName);

	public int noticeTotRecCnt();

	public List<NoticeVO> getNotice(int startIndexNo, int pageSize);

	public NoticeVO getNoticeContent(int SJ_NOTICE_IDX);

	public List<NoticeVO> getPreNext(int SJ_NOTICE_IDX);

	public List<SongVO> getArtistTape(int SJ_USER_IDX);

	public void setArtistTape(int userIdx, String artist);

	public List<UserVO> getUserVOS();

	public List<PlayVO> getUserBestSongIdx(int userIdx);

	public ArrayList<PlayListVO> getPlayListVOS(int SJ_USER_IDX);

	public PlayListVO getPlayListVO(int idx);

	public void setPlayList(PlayListVO vo);

	public boolean setAddMyList(int idx, int songIdx);

	public void setAddMyListMany(int idx, String songIdxs);

	public void setPlayListDel(int idx);

	public void setPlayListDelSong(int idx, int songIdx);

	public void setPlayListContentUpdate(int idx, String listNm, String comment);

	public void getloginUp();

	public void getjoinUp();
}
