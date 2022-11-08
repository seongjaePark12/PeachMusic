package com.PSJ.PSJMusic.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.PSJ.PSJMusic.music.PlayListVO;
import com.PSJ.PSJMusic.music.PlayVO;
import com.PSJ.PSJMusic.publicService.NoticeVO;
import com.PSJ.PSJMusic.user.UserVO;


public interface UserDAO {
	
	public UserVO getIdCheck(@Param("SJ_USER_MID") String SJ_USER_MID);

	public UserVO getEmailCheck(@Param("SJ_USER_EMAIL") String SJ_USER_EMAIL);

	public void setMemJoin(@Param("vo") UserVO vo);

	public UserVO getMidConfirm(@Param("num")String num,@Param("email") String email);

	public UserVO getPwdConfirm(@Param("mid")String mid,@Param("num") String name,@Param("email") String email);

	public void setPwdChange(@Param("mid")String mid,@Param("pwd") String pwd);

	public void setMemDelete(@Param("mid")String mid);

	public void setMyUpdate(@Param("vo")UserVO vo);
	
	public void setKakaoMemberInputOk(@Param("mid") String mid, @Param("pwd") String pwd, @Param("email") String email, @Param("nickName") String nickName);

	public int noticeTotRecCnt();

	public List<NoticeVO> getNotice(@Param("startIndexNo")int startIndexNo,@Param("pageSize") int pageSize);

	public NoticeVO getNoticeContent(@Param("SJ_NOTICE_IDX")int SJ_NOTICE_IDX);

	public List<NoticeVO> getPreNext(@Param("SJ_NOTICE_IDX")int SJ_NOTICE_IDX);

	public String getArtistTape(int SJ_USER_IDX);

	public void setArtistTape(@Param("userIdx")int userIdx,@Param("artist") String artist);

	public List<UserVO> getUserVOS();

	public List<PlayVO> getUserBestSongIdx(int userIdx);

	public ArrayList<PlayListVO> getPlayListVOS(int SJ_USER_IDX);

	public PlayListVO getPlayListVO(@Param("idx")int idx);

	public void setPlayList(@Param("vo")PlayListVO vo);

	public void setUpdateMyList(@Param("idx")int idx, @Param("content")String content);

	public void setPlayListDel(int idx);

	public void setPlayListContentUpdate(@Param("idx")int idx,@Param("listNm") String listNm, @Param("comment")String comment);

	public void getloginUp();

	public void getjoinUp();

}
