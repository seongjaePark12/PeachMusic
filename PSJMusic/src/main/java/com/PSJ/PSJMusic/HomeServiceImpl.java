package com.PSJ.PSJMusic;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.PSJ.PSJMusic.dao.HomeDAO;
import com.PSJ.PSJMusic.publicService.BannerVO;
import com.PSJ.PSJMusic.publicService.MagazinReplyVO;
import com.PSJ.PSJMusic.publicService.MagazinVO;
import com.PSJ.PSJMusic.publicService.NoticeVO;
import com.PSJ.PSJMusic.publicService.QuestionReplyVO;
import com.PSJ.PSJMusic.publicService.QuestionVO;
import com.PSJ.PSJMusic.publicService.VideoVO;


@Service
public class HomeServiceImpl implements HomeService {
	@Autowired
	HomeDAO homeDAO;

	@Override
	public BannerVO getBannerList() {return homeDAO.getBannerList();}
	@Override
	public ArrayList<VideoVO> getTvList() {return homeDAO.getTvList();}
	@Override
	public ArrayList<MagazinVO> getMagazineList() {return homeDAO.getMagazineList();}
	@Override
	public ArrayList<NoticeVO> getNoticeList() {return homeDAO.getNoticeList();}
	@Override
	public MagazinVO getMagazine() {return homeDAO.getMagazine();}
	@Override
	public MagazinVO getMagazineContent(int idx) {return homeDAO.getMagazineContent(idx);}
	@Override
	public ArrayList<VideoVO> getVideoList() {return homeDAO.getVideoList();}
	@Override
	public VideoVO getVideoContent(int idx) {return homeDAO.getVideoContent(idx);}
	@Override
	public ArrayList<MagazinVO> getMagazineList2() {return homeDAO.getMagazineList2();}
	@Override
	public ArrayList<MagazinReplyVO> getMagazineReply(int idx) {return homeDAO.getMagazineReply(idx);}
	@Override
	public void setReplyInsert(MagazinReplyVO rVo) {homeDAO.setReplyInsert(rVo);}
	@Override
	public void setReplyInsert2(MagazinReplyVO rVo) {homeDAO.setReplyInsert2(rVo);}
	@Override
	public void setReplyDelete(int replyIdx) {homeDAO.setReplyDelete(replyIdx);}
	@Override
	public int qaTotRecCnt() {return homeDAO.qaTotRecCnt();}
	@Override
	public List<QuestionVO> getQuestionList(int startIndexNo, int pageSize) {return homeDAO.getQuestionList(startIndexNo,pageSize);}
	@Override
	public List<QuestionVO> getQuestionListwhat(int startIndexNo, int pageSize, String what) {return homeDAO.getQuestionListwhat(startIndexNo,pageSize,what);}
	@Override
	public void qaImgCheck(String SJ_QUESTION_CONTENT) {
		if(SJ_QUESTION_CONTENT.indexOf("src=\"/") == -1) return;
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		@SuppressWarnings("deprecation")
		String uploadPath = request.getRealPath("/resources/data/ckeditor/");
		int position= 29;
		String nextImg = SJ_QUESTION_CONTENT.substring(SJ_QUESTION_CONTENT.indexOf("src=\"/") + position);
		while(true) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String copyFilePath = "";
			String oriFilePath = uploadPath + imgFile; // 원본 그림이 들어있는 '경로명+파일명'
			copyFilePath = uploadPath + "question/" + imgFile; // 복사가 될 경로명 + 파일명
			fileCopyCheck(oriFilePath, copyFilePath); // 원본그림이 복사될 위치로 복사작업처리하는 메소드
			if(nextImg.indexOf("src=\"/") != -1) {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
			else {
				return;
			}
		}
	}
	@Override
	public void setqaInput(QuestionVO vo) {homeDAO.setqaInput(vo);}
	// 원본이미지를 삭제처리하는곳(notice폴더에서 삭제처리한다.)
	private void fileDelete(String oriFilePath) {
		File delFile = new File(oriFilePath);
		if(delFile.exists()) delFile.delete();
	}
	// 실제 파일(ckeditor폴더)을 board폴더로 복사처리하는곳
	private void fileCopyCheck(String oriFilePath, String copyFilePath){
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		try {
			FileInputStream fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@Override
	public QuestionVO getqaContent(int idx) {return homeDAO.getqaContent(idx);}
	@Override
	public List<QuestionReplyVO> getqaReply(int idx) {return homeDAO.getqaReply(idx);}
	@Override
	public void qaImgCheckUpdate(String SJ_QUESTION_CONTENT) {
		if(SJ_QUESTION_CONTENT.indexOf("src=\"/") == -1) return;
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		@SuppressWarnings("deprecation")
		String uploadPath = request.getRealPath("/resources/data/ckeditor/question/");
		int position = 38;
		String nextImg = SJ_QUESTION_CONTENT.substring(SJ_QUESTION_CONTENT.indexOf("src=\"/") + position);
		boolean sw = true;
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile;	// 원본 그림이 들어있는 '경로명+파일명'
			@SuppressWarnings("deprecation")
			String copyFilePath = request.getRealPath("/resources/data/ckeditor/" + imgFile);	// 복사가 될 '경로명+파일명'
			fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림이 복사될 위치로 복사작업처리하는 메소드
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}	
	}
	@Override
	public void qaImgDelete(String oriContent) {
		if(oriContent.indexOf("src=\"/") == -1) return;
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		@SuppressWarnings("deprecation")
		String uploadPath = request.getRealPath("/resources/data/ckeditor/question/");
		int position = 38;
		String nextImg = oriContent.substring(oriContent.indexOf("src=\"/") + position);
		boolean sw = true;
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile;	// 원본 그림이 들어있는 '경로명+파일명'
			fileDelete(oriFilePath);	// 원본그림을 삭제처리하는 메소드
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}	
	}
	@Override
	public void qaUpdate(QuestionVO vo) {homeDAO.qaUpdate(vo);}
	@Override
	public void getMagazineUp(int idx) {homeDAO.getMagazineUp(idx);}
	@Override
	public void getVideoUp(int idx) {homeDAO.getVideoUp(idx);}
}
