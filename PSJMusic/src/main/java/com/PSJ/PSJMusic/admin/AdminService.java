package com.PSJ.PSJMusic.admin;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.PSJ.PSJMusic.music.PlayVO;
import com.PSJ.PSJMusic.publicService.AllChartVO;
import com.PSJ.PSJMusic.publicService.BannerVO;
import com.PSJ.PSJMusic.publicService.MagazinVO;
import com.PSJ.PSJMusic.publicService.NoticeVO;
import com.PSJ.PSJMusic.publicService.QuestionReplyVO;
import com.PSJ.PSJMusic.publicService.QuestionVO;
import com.PSJ.PSJMusic.publicService.VideoVO;
import com.PSJ.PSJMusic.user.UserVO;

public interface AdminService {

	// 회원
	public ArrayList<UserVO> getMemberListMid(String mid);

	public void setMemberDelete(int idx);

	public ArrayList<UserVO> getMemberList();
	
	
	// 공지
	public int noticeTotRecCnt();

	public List<NoticeVO> getNoticeAdmin(int startIndexNo, int pageSize);

	public void setNoticeInput(NoticeVO vo);

	public NoticeVO getNoticeContent(int SJ_NOTICE_IDX);

	public List<NoticeVO> getPreNext(int SJ_NOTICE_IDX);

	public void noticeImgCheckUpdate(String SJ_NOTICE_CONTENT);

	public void noticeImgDelete(String SJ_NOTICE_CONTENT);

	public void noticeImgCheck(String SJ_NOTICE_CONTENT);

	public void setNoticeUpdate(NoticeVO vo);

	public void setNoticeServiceDelete(int idx);

	public void setNoticeDelete(int idx);

	public void setNoticeLevel(int idx, int SJ_NOTICE_NOTICE);

	public void setBannerInput(MultipartHttpServletRequest file, BannerVO vo);

	public List<BannerVO> getBannerList();

	public void setBannerChange(int idx, String flag);

	public void setBannerDel(int idx);

	public int videoTotRecCnt();

	public List<VideoVO> getVideoList(int startIndexNo, int pageSize);

	public int MagazinTotRecCnt();

	public List<MagazinVO> getMagazinList(int startIndexNo, int pageSize);

	public int questionTotRecCnt();

	public List<QuestionVO> getQuestionList(int startIndexNo, int pageSize);

	public List<QuestionVO> getQuestionListwhat(int startIndexNo, int pageSize, String what);

	public void videoInput(VideoVO vo);

	public void magazineInput(MagazinVO vo);

	public void magazinImgCheck(String SJ_MAGAZINE_CONTENT);

	public void setvideoDelete(int idx);

	public void setmagazineDelete(int idx);

	public void setquestionDelete(int idx);

	public void setquestionLevel(int idx, int SJ_QUESTION_ANSER);

	public VideoVO getVideoContent(int idx);

	public MagazinVO getMagazineContent(int idx);

	public void magazineImgCheckUpdate(String SJ_MAGAZINE_CONTENT);

	public void setVideoUpdate(VideoVO vo);

	public void setMagazinUpdate(MagazinVO vo);

	public void qaImgDelete(String SJ_QUESTION_CONTENT);

	public void setqaServiceDelete(int idx);

	public void setReplyInsert(QuestionReplyVO rVo);

	public void setReplyInsert2(QuestionReplyVO rVo);

	public void setReplyDelete(int replyIdx);

	public void magazinImgDelete(String oriContent);

	public PlayVO getmusicChart();

	public MagazinVO getmagazineChart();

	public VideoVO getvideoChart();

	public AllChartVO getvisitChart();

	public AllChartVO getjoinChart();

	public List<MagazinVO> getmagazineTopChart();

	public List<VideoVO> getvideoTopChart();




}
