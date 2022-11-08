package com.PSJ.PSJMusic.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.PSJ.PSJMusic.publicService.BannerVO;
import com.PSJ.PSJMusic.publicService.MagazinReplyVO;
import com.PSJ.PSJMusic.publicService.MagazinVO;
import com.PSJ.PSJMusic.publicService.NoticeVO;
import com.PSJ.PSJMusic.publicService.QuestionReplyVO;
import com.PSJ.PSJMusic.publicService.QuestionVO;
import com.PSJ.PSJMusic.publicService.VideoVO;

public interface HomeDAO {

	public BannerVO getBannerList();

	public ArrayList<VideoVO> getTvList();

	public ArrayList<MagazinVO> getMagazineList();

	public ArrayList<NoticeVO> getNoticeList();

	public MagazinVO getMagazine();

	public MagazinVO getMagazineContent(int idx);

	public ArrayList<VideoVO> getVideoList();

	public VideoVO getVideoContent(int idx);

	public ArrayList<MagazinVO> getMagazineList2();

	public ArrayList<MagazinReplyVO> getMagazineReply(int idx);

	public void setReplyInsert(@Param("rVo")MagazinReplyVO rVo);

	public void setReplyInsert2(@Param("rVo")MagazinReplyVO rVo);

	public void setReplyDelete(@Param("replyIdx")int replyIdx);

	public int qaTotRecCnt();

	public List<QuestionVO> getQuestionList(@Param("startIndexNo")int startIndexNo, @Param("pageSize")int pageSize);

	public List<QuestionVO> getQuestionListwhat(@Param("startIndexNo")int startIndexNo, @Param("pageSize")int pageSize, @Param("what")String what);

	public void setqaInput(@Param("vo")QuestionVO vo);

	public QuestionVO getqaContent(@Param("idx")int idx);

	public List<QuestionReplyVO> getqaReply(@Param("idx")int idx);

	public void qaUpdate(@Param("vo")QuestionVO vo);

	public void getMagazineUp(@Param("idx")int idx);

	public void getVideoUp(@Param("idx")int idx);

}
