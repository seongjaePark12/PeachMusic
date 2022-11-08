package com.PSJ.PSJMusic.admin;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.PSJ.PSJMusic.dao.AdminDAO;
import com.PSJ.PSJMusic.music.PlayVO;
import com.PSJ.PSJMusic.publicService.AllChartVO;
import com.PSJ.PSJMusic.publicService.BannerVO;
import com.PSJ.PSJMusic.publicService.MagazinVO;
import com.PSJ.PSJMusic.publicService.NoticeVO;
import com.PSJ.PSJMusic.publicService.QuestionReplyVO;
import com.PSJ.PSJMusic.publicService.QuestionVO;
import com.PSJ.PSJMusic.publicService.VideoVO;
import com.PSJ.PSJMusic.user.UserVO;


@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDAO adminDAO;

	// 회원-------------------------------------------------------------
	@Override
	public ArrayList<UserVO> getMemberListMid(String mid) {return adminDAO.getMemberListMid(mid);}
	@Override
	public void setMemberDelete(int idx) {adminDAO.setMemberDelete(idx);}
	@Override
	public ArrayList<UserVO> getMemberList() {return adminDAO.getMemberList();}
	
	// 공지-------------------------------------------------------------
	@Override
	public int noticeTotRecCnt() {return adminDAO.noticeTotRecCnt();}
	@Override
	public List<NoticeVO> getNoticeAdmin(int startIndexNo, int pageSize) {return adminDAO.getNoticeAdmin(startIndexNo,pageSize);}
	@Override
	public void setNoticeInput(NoticeVO vo) {adminDAO.setNoticeInput(vo);}
	@Override
	public NoticeVO getNoticeContent(int SJ_NOTICE_IDX) {return adminDAO.getNoticeContent(SJ_NOTICE_IDX);}
	@Override
	public List<NoticeVO> getPreNext(int SJ_NOTICE_IDX) {return adminDAO.getPreNext(SJ_NOTICE_IDX);}
	@Override
	public void setNoticeUpdate(NoticeVO vo) {adminDAO.setNoticeUpdate(vo);}
	@Override
	public void setNoticeServiceDelete(int idx) {adminDAO.setNoticeServiceDelete(idx);}
	@Override
	public void setNoticeDelete(int idx) {adminDAO.setNoticeDelete(idx);}
	@Override
	public void setNoticeLevel(int idx, int SJ_NOTICE_NOTICE) {adminDAO.setNoticeLevel(idx,SJ_NOTICE_NOTICE);}
	@Override
	public void noticeImgDelete(String SJ_NOTICE_CONTENT) {
		if(SJ_NOTICE_CONTENT.indexOf("src=\"/") == -1) return;
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		@SuppressWarnings("deprecation")
		String uploadPath = request.getRealPath("/resources/data/ckeditor/notice/");
		int position = 36;
		String nextImg = SJ_NOTICE_CONTENT.substring(SJ_NOTICE_CONTENT.indexOf("src=\"/") + position);
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
	public void noticeImgCheck(String SJ_NOTICE_CONTENT) {
		if(SJ_NOTICE_CONTENT.indexOf("src=\"/") == -1) return;
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		@SuppressWarnings("deprecation")
		String uploadPath = request.getRealPath("/resources/data/ckeditor/");
		int position= 29;
		String nextImg = SJ_NOTICE_CONTENT.substring(SJ_NOTICE_CONTENT.indexOf("src=\"/") + position);
		while(true) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String copyFilePath = "";
			String oriFilePath = uploadPath + imgFile; // 원본 그림이 들어있는 '경로명+파일명'
			copyFilePath = uploadPath + "notice/" + imgFile; // 복사가 될 경로명 + 파일명
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
	public void noticeImgCheckUpdate(String SJ_NOTICE_CONTENT) {
		//             0         1         2         3         4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/PSJmusic/data/ckeditor/211229124318_4.jpg"
		// <img alt="" src="/PSJmusic/data/ckeditor/notice/211229124318_4.jpg"
		if(SJ_NOTICE_CONTENT.indexOf("src=\"/") == -1) return;
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		@SuppressWarnings("deprecation")
		String uploadPath = request.getRealPath("/resources/data/ckeditor/notice/");
		int position = 36;
		String nextImg = SJ_NOTICE_CONTENT.substring(SJ_NOTICE_CONTENT.indexOf("src=\"/") + position);
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
	
	// 배너-------------------------------------------------------------
	@Override
	public List<BannerVO> getBannerList() {return adminDAO.getBannerList();}
	@Override
	public void setBannerInput(MultipartHttpServletRequest mfile,BannerVO vo) {
		try {
			List<MultipartFile> fileList = mfile.getFiles("file");
			String oFileNames = "";
			String sFileNames = "";
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				
				// 서버에 저장될 파일명 작업(파일명을 날짜를 사용하여 중복을 방지처리했다)
				String sFileName = saveFileName(oFileName);	// 서버에 저장될 파일명을 결정해준다.
				// 실제로 서버 파일시스템에 업로드한 파일을 저장한다.
				bannerwriteFile(file, sFileName);		// 서버에 파일 저장처리하기
				// DB에는 업로드 파일명과 실제 저장된 파일명을 저장시켜야 하기에, 여러개의 파일을 '/'와 같이 누적처리했다.
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
			}
			vo.setSJ_BANNER_FILE(oFileNames);
			vo.setSJ_BANNER_RFILE(sFileNames);
			adminDAO.setBannerInput(vo);		// 서버에 파일 저장완료후 DB에 내역을 저장시켜준다.
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	private void bannerwriteFile(MultipartFile file, String sFileName) throws IOException {
		byte[] data = file.getBytes();
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/banner/");
		FileOutputStream fos = new FileOutputStream(uploadPath + sFileName);
		fos.write(data);
		fos.close();
	}

	// 저장되는 파일명의 중복을 방지하기위해 새로 파일명을 만들어준다.
	private String saveFileName(String oFileName) {
		String fileName = "";
		Calendar cal = Calendar.getInstance();
		fileName += cal.get(Calendar.YEAR);
		fileName += cal.get(Calendar.MONTH);
		fileName += cal.get(Calendar.DATE);
		fileName += cal.get(Calendar.HOUR);
		fileName += cal.get(Calendar.MINUTE);
		fileName += cal.get(Calendar.SECOND);
		fileName += cal.get(Calendar.MILLISECOND);
		fileName += "_" + oFileName;
		return fileName;
	}
	@Override
	public void setBannerChange(int idx, String flag) {adminDAO.setBannerChange(idx,flag);}
	@Override
	public void setBannerDel(int idx) {adminDAO.setBannerDel(idx);}
	
	// 음악-------------------------------------------------------------

	
	
	// 비디오-------------------------------------------------------------
	@Override
	public int videoTotRecCnt() {return adminDAO.videoTotRecCnt();}
	@Override
	public List<VideoVO> getVideoList(int startIndexNo, int pageSize) {return adminDAO.getVideoList(startIndexNo,pageSize);}
	@Override
	public void videoInput(VideoVO vo) {adminDAO.videoInput(vo);}
	@Override
	public void setvideoDelete(int idx) {adminDAO.setvideoDelete(idx);}
	@Override
	public VideoVO getVideoContent(int idx) {return adminDAO.getVideoContent(idx);}
	@Override
	public void setVideoUpdate(VideoVO vo) {adminDAO.setVideoUpdate(vo);}
	
	// 매거진-------------------------------------------------------------
	@Override
	public int MagazinTotRecCnt() {return adminDAO.MagazinTotRecCnt();}
	@Override
	public List<MagazinVO> getMagazinList(int startIndexNo, int pageSize) {return adminDAO.getMagazinList(startIndexNo,pageSize);}
	@Override
	public void magazineInput(MagazinVO vo) {adminDAO.magazineInput(vo);}
	@Override
	public MagazinVO getMagazineContent(int idx) {return adminDAO.getMagazineContent(idx);}
	@Override
	public void magazinImgCheck(String SJ_MAGAZINE_CONTENT) {
		if(SJ_MAGAZINE_CONTENT.indexOf("src=\"/") == -1) return;
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		@SuppressWarnings("deprecation")
		String uploadPath = request.getRealPath("/resources/data/ckeditor/");
		int position= 29;
		String nextImg = SJ_MAGAZINE_CONTENT.substring(SJ_MAGAZINE_CONTENT.indexOf("src=\"/") + position);
		while(true) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String copyFilePath = "";
			String oriFilePath = uploadPath + imgFile; // 원본 그림이 들어있는 '경로명+파일명'
			copyFilePath = uploadPath + "magazine/" + imgFile; // 복사가 될 경로명 + 파일명
			fileCopyCheck(oriFilePath, copyFilePath); // 원본그림이 복사될 위치로 복사작업처리하는 메소드
			if(nextImg.indexOf("src=\"/") != -1) {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}		
	}
	@Override
	public void magazineImgCheckUpdate(String SJ_MAGAZINE_CONTENT) {
		//             0         1         2         3         4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/PSJmusic/data/ckeditor/211229124318_4.jpg"
		// <img alt="" src="/PSJmusic/data/ckeditor/magazine/211229124318_4.jpg"
		if(SJ_MAGAZINE_CONTENT.indexOf("src=\"/") == -1) return;
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		@SuppressWarnings("deprecation")
		String uploadPath = request.getRealPath("/resources/data/ckeditor/magazine/");
		int position = 38;
		String nextImg = SJ_MAGAZINE_CONTENT.substring(SJ_MAGAZINE_CONTENT.indexOf("src=\"/") + position);
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
	public void setMagazinUpdate(MagazinVO vo) {adminDAO.setMagazinUpdate(vo);}
	@Override
	public void setmagazineDelete(int idx) {adminDAO.setmagazineDelete(idx);}
	@Override
	public void magazinImgDelete(String oriContent) {
		if(oriContent.indexOf("src=\"/") == -1) return;
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		@SuppressWarnings("deprecation")
		String uploadPath = request.getRealPath("/resources/data/ckeditor/magazine/");
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
	
	// 질문-------------------------------------------------------------
	@Override
	public int questionTotRecCnt() {return adminDAO.questionTotRecCnt();}
	@Override
	public List<QuestionVO> getQuestionList(int startIndexNo, int pageSize) {return adminDAO.getQuestionList(startIndexNo,pageSize);}
	@Override
	public List<QuestionVO> getQuestionListwhat(int startIndexNo, int pageSize, String what) {return adminDAO.getQuestionListwhat(startIndexNo,pageSize,what);}
	@Override
	public void setquestionDelete(int idx) {adminDAO.setquestionDelete(idx);}
	@Override
	public void setquestionLevel(int idx, int SJ_QUESTION_ANSER) {adminDAO.setquestionLevel(idx,SJ_QUESTION_ANSER);}
	@Override
	public void qaImgDelete(String SJ_QUESTION_CONTENT) {
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
	public void setqaServiceDelete(int idx) {adminDAO.setqaServiceDelete(idx);}
	@Override
	public void setReplyInsert(QuestionReplyVO rVo) {adminDAO.setReplyInsert(rVo);}
	@Override
	public void setReplyInsert2(QuestionReplyVO rVo) {adminDAO.setReplyInsert2(rVo);}
	@Override
	public void setReplyDelete(int replyIdx) {adminDAO.setReplyDelete(replyIdx);}
	@Override
	public PlayVO getmusicChart() {return adminDAO.getmusicChart();}
	@Override
	public MagazinVO getmagazineChart() {return adminDAO.getmagazineChart();}
	@Override
	public VideoVO getvideoChart() {return adminDAO.getvideoChart();}
	@Override
	public AllChartVO getvisitChart() {return adminDAO.getvisitChart();}
	@Override
	public AllChartVO getjoinChart() {return adminDAO.getjoinChart();}
	@Override
	public List<MagazinVO> getmagazineTopChart() {return adminDAO.getmagazineTopChart();}
	@Override
	public List<VideoVO> getvideoTopChart() {return adminDAO.getvideoTopChart();}

}
