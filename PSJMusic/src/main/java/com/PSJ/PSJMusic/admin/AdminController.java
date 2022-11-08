package com.PSJ.PSJMusic.admin;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.PSJ.PSJMusic.HomeService;
import com.PSJ.PSJMusic.Method;
import com.PSJ.PSJMusic.music.ChartVO;
import com.PSJ.PSJMusic.music.MusicService;
import com.PSJ.PSJMusic.music.SongVO;
import com.PSJ.PSJMusic.publicService.BannerVO;
import com.PSJ.PSJMusic.publicService.MagazinVO;
import com.PSJ.PSJMusic.publicService.NoticeVO;
import com.PSJ.PSJMusic.publicService.QuestionReplyVO;
import com.PSJ.PSJMusic.publicService.QuestionVO;
import com.PSJ.PSJMusic.publicService.VideoVO;
import com.PSJ.PSJMusic.user.UserService;
import com.PSJ.PSJMusic.user.UserVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	String msgFlag = "";
	@Autowired AdminService adminService;
	@Autowired UserService userService;
	@Autowired MusicService musicService;
	@Autowired HomeService homeService;
	
	@RequestMapping(value="/main", method = RequestMethod.GET)
	public String mainGet(Model model, 
			@RequestParam(value = "sw", defaultValue = "0") int sw, 
			@RequestParam(name="mid", defaultValue="", required=false) String mid,
			@RequestParam(name="song", defaultValue="", required=false) String song,
			@RequestParam(name="what", defaultValue="", required=false) String what,
			@RequestParam(name="pag", defaultValue = "1") int pag,
			@RequestParam(name="pageSize", defaultValue = "10") int pageSize
			){
		// 0: 차트 1:차트 2: 비디오 3: 매거진 4: 회원 5: 공지 6: 질문 7: 배너 8:음악관리 9:음원파일
		if (sw == 0) {
			// 전체통계
			model.addAttribute("musicvo", adminService.getmusicChart());
			model.addAttribute("magazinevo", adminService.getmagazineChart());
			model.addAttribute("videovo", adminService.getvideoChart());
			model.addAttribute("visitvo", adminService.getvisitChart());
			model.addAttribute("joinvo", adminService.getjoinChart());
			// 상위 노래 재생수
			model.addAttribute("musicTopvos", musicService.getRank());
			// 상위 매거진, 비디오 조회수
			model.addAttribute("magazineTopvos", adminService.getmagazineTopChart());
			model.addAttribute("videoTopvos", adminService.getvideoTopChart());
		}
		// 음악 관리
		else if (sw == 1) {
			model.addAttribute("vos", musicService.getChartVOS("all"));
		}
		// 음악
		else if (sw == 8 ||sw == 9) {
			int totRecCnt = musicService.getSongCnt();// 전체자료 갯수 검색
			int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
			int startIndexNo = (pag - 1) * pageSize; 
			int curScrStartNo = totRecCnt - startIndexNo;	
			int blockSize = 3; 
		    int curBlock = (pag - 1) / blockSize;	
		    int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		    List<SongVO> songvos = new ArrayList<SongVO>();
		    songvos = musicService.getSongVOS(startIndexNo, pageSize);
				model.addAttribute("vos", songvos);
			model.addAttribute("pag", pag);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("totPage", totPage);
			model.addAttribute("curScrStartNo", curScrStartNo);
			model.addAttribute("blockSize", blockSize);
			model.addAttribute("curBlock", curBlock);
			model.addAttribute("lastBlock", lastBlock);
		}
		// 비디오 관리
		else if (sw == 2) {
			int totRecCnt = adminService.videoTotRecCnt();// 전체자료 갯수 검색
			int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
			int startIndexNo = (pag - 1) * pageSize; 
			int curScrStartNo = totRecCnt - startIndexNo;	
			int blockSize = 3; 
		    int curBlock = (pag - 1) / blockSize;	
		    int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		    List<VideoVO> videovos = new ArrayList<VideoVO>();
				videovos = adminService.getVideoList(startIndexNo, pageSize);
				model.addAttribute("videovos", videovos);
			model.addAttribute("pag", pag);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("totPage", totPage);
			model.addAttribute("curScrStartNo", curScrStartNo);
			model.addAttribute("blockSize", blockSize);
			model.addAttribute("curBlock", curBlock);
			model.addAttribute("lastBlock", lastBlock);
		}
		//매거진 관리
		else if (sw == 3) {
			int totRecCnt = adminService.MagazinTotRecCnt();// 전체자료 갯수 검색
			int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
			int startIndexNo = (pag - 1) * pageSize; 
			int curScrStartNo = totRecCnt - startIndexNo;	
			int blockSize = 3; 
		    int curBlock = (pag - 1) / blockSize;	
		    int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		    List<MagazinVO> magazinvos = new ArrayList<MagazinVO>();
		    magazinvos = adminService.getMagazinList(startIndexNo, pageSize);
			model.addAttribute("magazinvos", magazinvos);
			model.addAttribute("pag", pag);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("totPage", totPage);
			model.addAttribute("curScrStartNo", curScrStartNo);
			model.addAttribute("blockSize", blockSize);
			model.addAttribute("curBlock", curBlock);
			model.addAttribute("lastBlock", lastBlock);
		}
		// 회원관리
		else if (sw == 4) {
			ArrayList<UserVO> uservos = new ArrayList<UserVO>();
			if(mid == "") {
				uservos = adminService.getMemberList();
				model.addAttribute("uservos", uservos);
			}
			else if (mid != ""){
				uservos = adminService.getMemberListMid(mid);
				model.addAttribute("uservos", uservos);
				model.addAttribute("mid", mid);
			}
		}
		// 공지관리
		else if (sw == 5) {
			int totRecCnt = adminService.noticeTotRecCnt();// 전체자료 갯수 검색
			int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
			int startIndexNo = (pag - 1) * pageSize; 
			int curScrStartNo = totRecCnt - startIndexNo;	
			int blockSize = 3; 
		    int curBlock = (pag - 1) / blockSize;	
		    int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		    List<NoticeVO> noticevos = adminService.getNoticeAdmin(startIndexNo, pageSize);
			model.addAttribute("noticevos", noticevos);
			model.addAttribute("pag", pag);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("totPage", totPage);
			model.addAttribute("curScrStartNo", curScrStartNo);
			model.addAttribute("blockSize", blockSize);
			model.addAttribute("curBlock", curBlock);
			model.addAttribute("lastBlock", lastBlock);
		}
		// 질문관리
		else if (sw == 6) {
			int totRecCnt = adminService.questionTotRecCnt();// 전체자료 갯수 검색
			int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
			int startIndexNo = (pag - 1) * pageSize; 
			int curScrStartNo = totRecCnt - startIndexNo;	
			int blockSize = 3; 
		    int curBlock = (pag - 1) / blockSize;	
		    int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		    List<QuestionVO> questionvos = new ArrayList<QuestionVO>();
			if(what == "") {
				questionvos = adminService.getQuestionList(startIndexNo, pageSize);
				model.addAttribute("questionvos", questionvos);
			}
			else if (what != ""){
				questionvos = adminService.getQuestionListwhat(startIndexNo, pageSize,what);
				model.addAttribute("what", what);
				model.addAttribute("questionvos", questionvos);
			}
			model.addAttribute("pag", pag);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("totPage", totPage);
			model.addAttribute("curScrStartNo", curScrStartNo);
			model.addAttribute("blockSize", blockSize);
			model.addAttribute("curBlock", curBlock);
			model.addAttribute("lastBlock", lastBlock);
		}
		// 배너관리
		else if (sw == 7) {
			List<BannerVO> BannerVos = adminService.getBannerList();
			model.addAttribute("BannerVos", BannerVos);
		}
		model.addAttribute("sw", sw);
		return "admin/main";
	}
	@RequestMapping(value="/main", method = RequestMethod.POST)
	public String mainPost(Model model,
			HttpServletRequest request,
			@RequestParam(value = "sw", defaultValue = "0") int sw, 
			@RequestParam(value = "item") String items) 
					throws FileNotFoundException {
			if (sw == 8) {
				if (items != null) {
					String[] item = items.split("/");
					for (int i=0; i<item.length; i++) {
						int idx = Integer.parseInt(item[i].split("-")[1]);
						String column = item[i].split("-")[0];
						String name = column + "-" + idx;
						String value = request.getParameter(name);
						musicService.setAdminSongUpdate(idx, column, value);
					}
				}
			}
		model.addAttribute("sw", sw);
		return "redirect:/admin/main";
	}
	
	// 음악관리 --------------------------------------------------------------------------
	@RequestMapping("/lyrics")
	@ResponseBody
	public SongVO getlyricsPost(Integer idx) {
		SongVO vo = musicService.getSongInfor(idx);
		if (vo != null) vo.setSJ_SONG_IMG(vo.getSJ_SONG_IMG().replaceFirst("50", "200"));
		return vo;
	}

	@RequestMapping("/addsong")
	@ResponseBody
	public void addsongPost(String img, String title, String artist) {
		musicService.addSongDB(img, title, artist);
	}

	@RequestMapping("/addsongall")
	@ResponseBody
	public void addsongallPost() {
		List<ChartVO> vos = musicService.getChartVOS("all");
		for (int i=0; i<vos.size(); i++) {
			if (vos.get(i).getSJ_CHART_IDX() == 0) {
				musicService.addSongDB(vos.get(i).getSJ_CHART_IMG(), vos.get(i).getSJ_CHART_TITLE(), vos.get(i).getSJ_CHART_ARTIST());
			}
		}
	}

	@RequestMapping("/upload")
	@ResponseBody
	public void uploadPost(int idx, MultipartFile file) throws IOException {
		musicService.songUpload(idx, file);
		musicService.setIsfile(idx);
		musicService.setSongUpdate(idx);
	}

	@RequestMapping("/insertsong")
	@ResponseBody
	public String insertsongPost(SongVO vo) {
		if (musicService.isSong(vo.getSJ_SONG_TITLE(), vo.getSJ_SONG_ARTIST()) != 0) return "no" ;
		
		else {
			musicService.insertSong(vo); 
			return "yes";
		}
	}

	@RequestMapping("/isFileUpdate")
	public String isFileUpdateGet(Model model, int sw, int pag) {
		musicService.isFileUpdate();
		model.addAttribute("sw", sw);
		model.addAttribute("pag", pag);
		return "redirect:/admin/main";
	}

	@RequestMapping("/srch")
	public String srchGet(Model model, String srch, int sw, int pag, String noFile) {
		if (noFile != null && noFile.equals("1")) {
			model.addAttribute("vos", musicService.getSongSrch(null));
		}

		else {
			model.addAttribute("vos", musicService.getSongSrch(srch));
		}
		model.addAttribute("flag", "srch");
		model.addAttribute("sw", sw);
		model.addAttribute("pag", pag);
		return "admin/main";
	}
	
	@RequestMapping("/chartupdate")
	@ResponseBody
	public void chartupdatePost() throws IOException {
		Method method = new Method();
		List<ChartVO> vos = method.getChartTop100();
		for (int i=0; i<vos.size(); i++) {
			int idx = 0;
			if (musicService.getSongIdx(vos.get(i).getSJ_CHART_TITLE(), vos.get(i).getSJ_CHART_ARTIST()) != null) idx = musicService.getSongIdx(vos.get(i).getSJ_CHART_TITLE(), vos.get(i).getSJ_CHART_ARTIST());
			vos.get(i).setSJ_SONG_IDX(idx);
			vos.get(i).setSJ_CHART_ISFILE(musicService.getSongInfor(idx).getSJ_SONG_ISFILE());
		}
		musicService.setChartUpdate(vos);
	}
	
	
	// 동영상관리 --------------------------------------------------------------------------
	// 동영상 등록폼 호출
	@RequestMapping(value="/videoInput", method = RequestMethod.GET)
	public String videoInputGet(Model model) {
		return"admin/video/videoInput";
	}
	// 동영상 등록!
	@RequestMapping(value="/videoInput", method = RequestMethod.POST)
	public String videoInputPost(Model model, VideoVO vo) {
		adminService.videoInput(vo);
		msgFlag = "videoInputOk$sw="+2;
		return "redirect:/msg/"+msgFlag;
	}
	//동영상 선택항목 삭제하기
	@ResponseBody
	@RequestMapping(value="/videoListDel", method = RequestMethod.POST)
	public String videoListDelPost(int idx) {
		adminService.setvideoDelete(idx);
		return"";
	}
	// 동영상 내용보기
	@RequestMapping(value="/videoContent", method = RequestMethod.GET)
	public String videoContentGet(int idx, int pag, int pageSize, Model model) {
		VideoVO vo= adminService.getVideoContent(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		return"admin/video/videoContent";
	}
	//동영상 수정폼 불러오기
	@RequestMapping(value="/videoUpdate",method = RequestMethod.GET)
	public String videoUpdateGet(Model model, int idx, int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		VideoVO vo = adminService.getVideoContent(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		return "admin/video/videoUpdate";
	}
	//동영상 수정내용 DB에 저장하기
	@RequestMapping(value="/videoUpdate",method = RequestMethod.POST)
	public String videoUpdatePost(VideoVO vo, int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		adminService.setVideoUpdate(vo);
		msgFlag = "videoUpdateOk$idx="+vo.getSJ_VIDEO_IDX()+"&pag="+pag+"&pageSize="+pageSize;
		return "redirect:/msg/" + msgFlag;
	}
	
	// 매거진관리 --------------------------------------------------------------------------
	// 매거진 등록폼 호출
	@RequestMapping(value="/magazinInput", method = RequestMethod.GET)
	public String magazinInputGet(Model model) {
		return"admin/magazine/magazineInput";
	}
	// 매거진 등록!
	@RequestMapping(value="/magazinInput", method = RequestMethod.POST)
	public String magazinInputPost(Model model, MagazinVO vo) {
		// 이미지 파일 업로드시에는 ckeditor폴더에서 board폴더로 복사 작업처리
		adminService.magazinImgCheck(vo.getSJ_MAGAZINE_CONTENT());
		// 이미지 복사 작업이 종료되면 실제로 저장된 board폴더명을 DB에 저장시켜줘야한다
		vo.setSJ_MAGAZINE_CONTENT(vo.getSJ_MAGAZINE_CONTENT().replace("/data/ckeditor/", "/data/ckeditor/magazine/"));
		// 이미지 작업과 실제저장폴더를 set처리후, 잘 정비된 vo를 db에 저장한다
		adminService.magazineInput(vo);
		msgFlag = "magazineInputOk$sw="+3;
		return "redirect:/msg/"+msgFlag;
	}
	//매거진 선택항목 삭제하기
	@ResponseBody
	@RequestMapping(value="/magazineListDel", method = RequestMethod.POST)
	public String magazineListDelPost(int idx) {
		adminService.setmagazineDelete(idx);
		return"";
	}
	// 매거진 내용보기
	@RequestMapping(value="/magazinContent", method = RequestMethod.GET)
	public String magazineContentGet(int idx, int pag, int pageSize, Model model) {
		MagazinVO vo= adminService.getMagazineContent(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		return"admin/magazine/magazineContent";
	}
	//매거진 수정폼 불러오기
	@RequestMapping(value="/magazinUpdate",method = RequestMethod.GET)
	public String magazinUpdateGet(Model model, int idx, int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		MagazinVO vo = adminService.getMagazineContent(idx);
		// 수정작업 처리전에 그림파일이 존재한다면 원본파일을 ckeditor폴더로 복사 시켜둔다.
		if(vo.getSJ_MAGAZINE_CONTENT().indexOf("src=\"/") != -1) adminService.magazineImgCheckUpdate(vo.getSJ_MAGAZINE_CONTENT());
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		return "admin/magazine/magazineUpdate";
	}
	//매거진 수정내용 DB에 저장하기
	@RequestMapping(value="/magazinUpdate",method = RequestMethod.POST)
	public String magazinUpdatePost(MagazinVO vo, int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		// 원본파일들을 board폴더에서 삭제처리한다.
		if(vo.getOriContent().indexOf("src=\"/") != -1)	adminService.magazinImgDelete(vo.getOriContent());
		// 원본파일을 수정폼에 들어올때 board폴더에서 ckeditor폴더로 복사해두고, board폴더의 파일은 지웠기에, 아래의 복사처리전에 원본파일위치를 vo.content안의 파일경로를 board폴더에서 ckeditor폴더로 변경처리해줘야한다.
		vo.setSJ_MAGAZINE_CONTENT(vo.getSJ_MAGAZINE_CONTENT().replace("/data/ckeditor/magazine/", "/data/ckeditor/"));
		// 수정된 그림파일을 다시 복사처리한다.(수정된 그림파일의 정보는 content필드에 담겨있다.)('/ckeditor'폴더 -> '/ckeditor/board'폴더로복사) : 처음파일 입력작업과 같은 작업이기에 아래는 처음 입력시의 메소드를 호출했다.
		adminService.noticeImgCheck(vo.getSJ_MAGAZINE_CONTENT());
		// 필요한 파일을 board폴더로 복사했기에 vo.content의 내용도 변경한다.
		vo.setSJ_MAGAZINE_CONTENT(vo.getSJ_MAGAZINE_CONTENT().replace("/data/ckeditor/", "/data/ckeditor/magazine/"));
		// 잘 정비된 vo값만을 DB에 저장시킨다.
		adminService.setMagazinUpdate(vo);
		msgFlag = "magaziUpdateOk$idx="+vo.getSJ_MAGAZINE_IDX()+"&pag="+pag+"&pageSize="+pageSize;
		return "redirect:/msg/" + msgFlag;
	}
	
	// 회원관리 ---------------------------------------------------------------
	//회원 선택항목 삭제하기
	@ResponseBody
	@RequestMapping(value="/memberListDel", method = RequestMethod.POST)
	public String adminMemberDelPost(String delItems) {
		String[] idxs = delItems.split("/");
		for(String idx : idxs) {
			adminService.setMemberDelete(Integer.parseInt(idx));
		}
		return"";
	}
	
	// 공지사항관리 --------------------------------------------------------------------------
	// 공지사항 등록폼 호출
	@RequestMapping(value="/noticeInput", method = RequestMethod.GET)
	public String noticeInputGet() {
		return"admin/notice/noticeInput";
	}
	// 공지사항 입력후 DB저장
	@RequestMapping(value="/noticeInput", method = RequestMethod.POST)
	public String noticeInputPost(NoticeVO vo) {
		// 이미지 파일 업로드시에는 ckeditor폴더에서 board폴더로 복사 작업처리
		adminService.noticeImgCheck(vo.getSJ_NOTICE_CONTENT());
		// 이미지 복사 작업이 종료되면 실제로 저장된 board폴더명을 DB에 저장시켜줘야한다
		vo.setSJ_NOTICE_CONTENT(vo.getSJ_NOTICE_CONTENT().replace("/data/ckeditor/", "/data/ckeditor/notice/"));
		// 이미지 작업과 실제저장폴더를 set처리후, 잘 정비된 vo를 db에 저장한다
		adminService.setNoticeInput(vo);
		msgFlag = "noticeInputOk$sw="+5;
		return"redirect:/msg/"+msgFlag;
	}
	// 공지사항 내용보기
	@RequestMapping(value="/noticeContent", method = RequestMethod.GET)
	public String noticeContentGet(int idx, int pag, int pageSize, Model model) {
		int SJ_NOTICE_IDX = idx;
		// 원본글 가져오기
		NoticeVO vo= adminService.getNoticeContent(SJ_NOTICE_IDX);
		// 이전글, 다음글 가져오기
		List<NoticeVO> pnVos = adminService.getPreNext(SJ_NOTICE_IDX);
		model.addAttribute("pnVos", pnVos);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		return"admin/notice/noticeContent";
	}
	//공지사항 수정폼 불러오기
	@RequestMapping(value="/noticeUpdate",method = RequestMethod.GET)
	public String noticeUpdateGet(Model model, int idx, int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		NoticeVO vo = adminService.getNoticeContent(idx);
		// 수정작업 처리전에 그림파일이 존재한다면 원본파일을 ckeditor폴더로 복사 시켜둔다.
		if(vo.getSJ_NOTICE_CONTENT().indexOf("src=\"/") != -1) adminService.noticeImgCheckUpdate(vo.getSJ_NOTICE_CONTENT());
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		return "admin/notice/noticeUpdate";
	}
	//공지사항 수정내용 DB에 저장하기
	@RequestMapping(value="/noticeUpdate",method = RequestMethod.POST)
	public String boardUpdatePost(NoticeVO vo, int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		// 원본파일들을 board폴더에서 삭제처리한다.
		if(vo.getOriContent().indexOf("src=\"/") != -1)	adminService.noticeImgDelete(vo.getOriContent());
		// 원본파일을 수정폼에 들어올때 board폴더에서 ckeditor폴더로 복사해두고, board폴더의 파일은 지웠기에, 아래의 복사처리전에 원본파일위치를 vo.content안의 파일경로를 board폴더에서 ckeditor폴더로 변경처리해줘야한다.
		vo.setSJ_NOTICE_CONTENT(vo.getSJ_NOTICE_CONTENT().replace("/data/ckeditor/notice/", "/data/ckeditor/"));
		// 수정된 그림파일을 다시 복사처리한다.(수정된 그림파일의 정보는 content필드에 담겨있다.)('/ckeditor'폴더 -> '/ckeditor/board'폴더로복사) : 처음파일 입력작업과 같은 작업이기에 아래는 처음 입력시의 메소드를 호출했다.
		adminService.noticeImgCheck(vo.getSJ_NOTICE_CONTENT());
		// 필요한 파일을 board폴더로 복사했기에 vo.content의 내용도 변경한다.
		vo.setSJ_NOTICE_CONTENT(vo.getSJ_NOTICE_CONTENT().replace("/data/ckeditor/", "/data/ckeditor/notice/"));
		// 잘 정비된 vo값만을 DB에 저장시킨다.
		adminService.setNoticeUpdate(vo);
		msgFlag = "noticeUpdateOk$idx="+vo.getSJ_NOTICE_IDX()+"&pag="+pag+"&pageSize="+pageSize;
		return "redirect:/msg/" + msgFlag;
	}
	//공지사항 삭제처리
	@RequestMapping(value="/noticeDelete")
	public String noticeDeleteGet(int idx,int pag, int pageSize) {
		// 게시글에 사진이 존재한다면 실제 서버파일 시스템에서 사진파일을 삭제처리한다
		NoticeVO vo = adminService.getNoticeContent(idx);
		if(vo.getSJ_NOTICE_CONTENT().indexOf("src=\"/") != -1)	adminService.noticeImgDelete(vo.getSJ_NOTICE_CONTENT());
		// DB애서 실제 게시글을 삭제처리
		adminService.setNoticeServiceDelete(idx);
		msgFlag = "noticeDeleteOk$sw="+5+"&pag="+pag+"&pageSize="+pageSize;
		return "redirect:/msg/" + msgFlag;
	}
	//공지사항 선택항목 삭제하기
	@ResponseBody
	@RequestMapping(value="/noticeListDel", method = RequestMethod.POST)
	public String noticeListDelPost(String delItems) {
		String[] idxs = delItems.split("/");
		for(String idx : idxs) {
			adminService.setNoticeDelete(Integer.parseInt(idx));
		}
		return"";
	}
	//공지사항 선택항목 공지변경
	@ResponseBody
	@RequestMapping(value="/noticeListAnser", method = RequestMethod.POST)
	public String noticeListAnserPost(String anserItems, int SJ_NOTICE_NOTICE) {
		String[] idxs = anserItems.split("/");
		for(String idx : idxs) {
			adminService.setNoticeLevel(Integer.parseInt(idx), SJ_NOTICE_NOTICE);
		}
		return"";
	}
	
	// 질문관리 --------------------------------------------------------------------------
	// 질문폼 호출
	@RequestMapping(value="/questionContent", method = RequestMethod.GET)
	public String questionInputGet(Model model) {
		return"admin/question/questionInput";
	}
	//질문 선택항목 삭제하기
	@ResponseBody
	@RequestMapping(value="/questionListDel", method = RequestMethod.POST)
	public String questionListDelPost(String delItems) {
		String[] idxs = delItems.split("/");
		for(String idx : idxs) {
			adminService.setquestionDelete(Integer.parseInt(idx));
		}
		return"";
	}
	//질문 선택항목 공지변경
	@ResponseBody
	@RequestMapping(value="/questionListWhat", method = RequestMethod.POST)
	public String questionListAnserPost(String anserItems, int SJ_QUESTION_ANSER) {
		String[] idxs = anserItems.split("/");
		for(String idx : idxs) {
			adminService.setquestionLevel(Integer.parseInt(idx), SJ_QUESTION_ANSER);
		}
		return"";
	}
	// 질문 내용 폼
	@RequestMapping(value="/qaContent", method = RequestMethod.GET)
	public String qaContentGet(Model model,int idx) {
		model.addAttribute("vo", homeService.getqaContent(idx));
		model.addAttribute("rVos", homeService.getqaReply(idx));
		return "admin/question/questionContent";
	}
	//질문 삭제처리
	@RequestMapping(value="/qaDelete")
	public String qaDeleteGet(int idx,int pag, int pageSize) {
		QuestionVO vo = homeService.getqaContent(idx);
		if(vo.getSJ_QUESTION_CONTENT().indexOf("src=\"/") != -1) adminService.qaImgDelete(vo.getSJ_QUESTION_CONTENT());
		// DB애서 실제 게시글을 삭제처리
		adminService.setqaServiceDelete(idx);
		msgFlag = "qaqaqaDeleteOk$sw="+7+"&pag="+pag+"&pageSize="+pageSize;
		return "redirect:/msg/" + msgFlag;
	}
	// 질문댓글 저장하기
	@ResponseBody
	@RequestMapping(value="/qaReplyInsert", method = RequestMethod.POST)
	public String qaReplyInsertPost(QuestionReplyVO rVo) {
		adminService.setReplyInsert(rVo);
		return "";
	}
	// 질문댓글 수정하기
	@ResponseBody
	@RequestMapping(value="/qaReplyInsert2", method = RequestMethod.POST)
	public String qaReplyInsert2Post(QuestionReplyVO rVo) {
		adminService.setReplyInsert2(rVo);
		return "";
	}
	// 질문댓글 삭제처리
	@ResponseBody
	@RequestMapping(value="/qaReplyDelete", method = RequestMethod.POST)
	public String qaReplyDeletePost(int replyIdx) {
		adminService.setReplyDelete(replyIdx);
		return"";
	}
	
	// 배너관리 --------------------------------------------------------------------------
	// 배너 등록폼 호출
	@RequestMapping(value="/bannerInput", method = RequestMethod.GET)
	public String bannerInputGet(Model model) {
		return"admin/banner/bannerInput";
	}
	// 배너 등록
	@RequestMapping(value="/bannerInput", method = RequestMethod.POST)
	public String bannerInputPost(MultipartHttpServletRequest file,BannerVO vo) {
		adminService.setBannerInput(file, vo);
		msgFlag = "bannerInputOk$sw="+7;
		return "redirect:/msg/"+msgFlag;
	}
	//배너 선택 변경
	@ResponseBody
	@RequestMapping(value="/bannerChoice", method = RequestMethod.POST)
	public String bannerChoicePost(int idx, String flag) {
		adminService.setBannerChange(idx, flag);
		return"";
	}
	//배너 삭제
	@ResponseBody
	@RequestMapping(value="/bannerDelete", method = RequestMethod.POST)
	public String bannerDeletePost(int idx) {
		adminService.setBannerDel(idx);
		return"";
	}


	
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String originalFilename = upload.getOriginalFilename();
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;
		byte[] bytes = upload.getBytes();
		// ckeditor에서 올린 파일을 서버 파일시스템에 저장시켜준다
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);
		// 서버 파일시스템에 저장된 파일을 화면(textarea)에 출력하기
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + originalFilename;
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");		/*  "atom":"111.png","uploaded":1,"url":""  */
		out.flush();
		outStr.close();
	}
}
