package com.PSJ.PSJMusic;

import java.util.ArrayList;
import java.util.List;

import com.PSJ.PSJMusic.publicService.BannerVO;
import com.PSJ.PSJMusic.publicService.MagazinReplyVO;
import com.PSJ.PSJMusic.publicService.MagazinVO;
import com.PSJ.PSJMusic.publicService.NoticeVO;
import com.PSJ.PSJMusic.publicService.QuestionReplyVO;
import com.PSJ.PSJMusic.publicService.QuestionVO;
import com.PSJ.PSJMusic.publicService.VideoVO;

public interface HomeService {

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

	public void setReplyInsert(MagazinReplyVO rVo);

	public void setReplyInsert2(MagazinReplyVO rVo);

	public void setReplyDelete(int replyIdx);

	public int qaTotRecCnt();

	public List<QuestionVO> getQuestionList(int startIndexNo, int pageSize);

	public List<QuestionVO> getQuestionListwhat(int startIndexNo, int pageSize, String what);

	public void qaImgCheck(String SJ_QUESTION_CONTENT);

	public void setqaInput(QuestionVO vo);

	public QuestionVO getqaContent(int idx);

	public List<QuestionReplyVO> getqaReply(int idx);

	public void qaImgCheckUpdate(String SJ_QUESTION_CONTENT);

	public void qaImgDelete(String oriContent);

	public void qaUpdate(QuestionVO vo);

	public void getMagazineUp(int idx);

	public void getVideoUp(int idx);

}
