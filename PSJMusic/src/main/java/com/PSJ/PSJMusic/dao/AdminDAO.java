package com.PSJ.PSJMusic.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.PSJ.PSJMusic.music.PlayVO;
import com.PSJ.PSJMusic.music.SongVO;
import com.PSJ.PSJMusic.publicService.AllChartVO;
import com.PSJ.PSJMusic.publicService.BannerVO;
import com.PSJ.PSJMusic.publicService.MagazinVO;
import com.PSJ.PSJMusic.publicService.NoticeVO;
import com.PSJ.PSJMusic.publicService.QuestionReplyVO;
import com.PSJ.PSJMusic.publicService.QuestionVO;
import com.PSJ.PSJMusic.publicService.VideoVO;
import com.PSJ.PSJMusic.user.UserVO;

public interface AdminDAO {
	// 회원-------------------------------------------------------------
	public ArrayList<UserVO> getMemberListMid(@Param("mid") String mid);
	public void setMemberDelete(@Param("idx") int idx);
	public ArrayList<UserVO> getMemberList();

	// 공지-------------------------------------------------------------
	public int noticeTotRecCnt();
	public List<NoticeVO> getNoticeAdmin(@Param("startIndexNo")int startIndexNo,@Param("pageSize") int pageSize);
	public void setNoticeInput(@Param("vo")NoticeVO vo);
	public NoticeVO getNoticeContent(@Param("SJ_NOTICE_IDX")int SJ_NOTICE_IDX);
	public List<NoticeVO> getPreNext(@Param("SJ_NOTICE_IDX")int SJ_NOTICE_IDX);
	public void setNoticeUpdate(@Param("vo")NoticeVO vo);
	public void setNoticeServiceDelete(@Param("idx")int idx);
	public void setNoticeDelete(@Param("idx")int idx);
	public void setNoticeLevel(@Param("idx")int idx, @Param("SJ_NOTICE_NOTICE")int SJ_NOTICE_NOTICE);
	
	// 배너-------------------------------------------------------------
	public void setBannerInput(@Param("vo")BannerVO vo);
	public List<BannerVO> getBannerList();
	public void setBannerChange(@Param("idx")int idx, @Param("flag")String flag);
	public void setBannerDel(@Param("idx")int idx);
	
	// 음악-------------------------------------------------------------
	public int songTotRecCnt();
	public List<SongVO> getSongList(@Param("startIndexNo")int startIndexNo,@Param("pageSize") int pageSize);
	public List<SongVO> getSongListsong(@Param("startIndexNo")int startIndexNo, @Param("pageSize")int pageSize, @Param("song")String song);
	public void songInput(@Param("vo")SongVO vo);
	
	// 비디오-------------------------------------------------------------
	public int videoTotRecCnt();
	public List<VideoVO> getVideoList(@Param("startIndexNo")int startIndexNo,@Param("pageSize") int pageSize);
	public void videoInput(@Param("vo")VideoVO vo);
	public void setvideoDelete(@Param("idx")int idx);
	public VideoVO getVideoContent(@Param("idx")int idx);
	public void setVideoUpdate(@Param("vo")VideoVO vo);
	
	// 매거진-------------------------------------------------------------
	public int MagazinTotRecCnt();
	public List<MagazinVO> getMagazinList(@Param("startIndexNo")int startIndexNo,@Param("pageSize") int pageSize);
	public void magazineInput(@Param("vo")MagazinVO vo);
	public void setmagazineDelete(@Param("idx")int idx);
	public MagazinVO getMagazineContent(@Param("idx")int idx);
	public void setMagazinUpdate(@Param("vo")MagazinVO vo);
	
	// 질문-------------------------------------------------------------
	public int questionTotRecCnt();
	public List<QuestionVO> getQuestionList(@Param("startIndexNo")int startIndexNo,@Param("pageSize") int pageSize);
	public List<QuestionVO> getQuestionListwhat(@Param("startIndexNo")int startIndexNo,@Param("pageSize") int pageSize,@Param("what") String what);
	public void setquestionDelete(@Param("idx")int idx);
	public void setquestionLevel(@Param("idx")int idx, @Param("SJ_QUESTION_ANSER")int SJ_QUESTION_ANSER);
	public void setqaServiceDelete(@Param("idx")int idx);
	public void setReplyInsert(@Param("rVo")QuestionReplyVO rVo);
	public void setReplyInsert2(@Param("rVo")QuestionReplyVO rVo);
	public void setReplyDelete(@Param("replyIdx")int replyIdx);
	public PlayVO getmusicChart();
	public MagazinVO getmagazineChart();
	public VideoVO getvideoChart();
	public AllChartVO getvisitChart();
	public AllChartVO getjoinChart();
	public List<MagazinVO> getmagazineTopChart();
	public List<VideoVO> getvideoTopChart();
	
	


	


}
