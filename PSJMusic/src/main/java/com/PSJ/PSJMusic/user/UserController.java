package com.PSJ.PSJMusic.user;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.PSJ.PSJMusic.Method;
import com.PSJ.PSJMusic.music.MusicService;
import com.PSJ.PSJMusic.music.PlayListVO;
import com.PSJ.PSJMusic.music.SongVO;
import com.PSJ.PSJMusic.publicService.NoticeVO;

@Controller
@RequestMapping("/user")
public class UserController {
	String msgFlag = "";
	@Autowired UserService userService;
	@Autowired MusicService musicService;
	@Autowired BCryptPasswordEncoder passwordEncoder;
	
	// 약관동의 이동
	@RequestMapping(value="/register", method = RequestMethod.GET)
	public String registerGet() {return "user/user/register";}
	// 약관동의 완료 후 회원가입
	@RequestMapping(value="/register", method = RequestMethod.POST)
	public String registerPost() {return "redirect:/user/join";}
	// 회원 가입창 이동
	@RequestMapping(value="/join", method = RequestMethod.GET)
	public String joinGet() {return "user/user/userJoin";}
	// 회원 가입처리하기
	@RequestMapping(value="/join", method = RequestMethod.POST)
	public String joinPost(UserVO vo) {
		// 아이디 중복 체크
		if(userService.getIdCheck(vo.getSJ_USER_MID()) != null) {
			msgFlag = "memIdCheckNo";
			return "redirect:/msg/" + msgFlag;
		}
		// 이메일 중복 체크
		if(userService.getEmailCheck(vo.getSJ_USER_EMAIL()) != null) {
			msgFlag = "memEmailCheckNo";
			return "redirect:/msg/" + msgFlag;
		}
		// 비밀번호 암호화 처리
		vo.setSJ_USER_PWD(passwordEncoder.encode(vo.getSJ_USER_PWD()));
		// DB에 가입회원 등록하기
	    userService.setMemJoin(vo);
	    userService.getjoinUp();
	    return "redirect:/msg/memJoinOk";
	}
	// 회원 가입완료창 이동
	@RequestMapping(value="/joinOK", method = RequestMethod.GET)
	public String joinOkGet() {
		return "user/user/joinOK";
	}
	// 회원 아이디 검색하기
	@ResponseBody
	@RequestMapping(value="/idCheck", method = RequestMethod.POST)
	public String idCheckPost(String SJ_USER_MID) {
		String res = "0";
		UserVO vo = userService.getIdCheck(SJ_USER_MID);
		if(vo != null) res = "1";
		return res;
	}
	// 회원 이메일 검색하기
	@ResponseBody
	@RequestMapping(value="/emailCheck", method = RequestMethod.POST)
	public String emailCheckPost(String SJ_USER_EMAIL) {
		String res = "0";
		UserVO vo = userService.getEmailCheck(SJ_USER_EMAIL);
		if(vo != null) res = "1";
		return res;
	}
	// 로그인창
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String loginGet(HttpServletRequest request) {
		// 로그인폼 호출시 기존에 저장된 쿠키가 있다면 불러와서 mid에 담아서 넘겨준다.
		Cookie[] cookies = request.getCookies();
		String mid = "";
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				mid = cookies[i].getValue();
				request.setAttribute("mid", mid);
				break;
			}
		}
		return "user/user/login";
	}
	// 로그인 인증처리
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String loginPost(@RequestParam(name="idCheck", defaultValue = "", required = false) String idCheck,
			String SJ_USER_MID, String SJ_USER_PWD, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		UserVO vo = userService.getIdCheck(SJ_USER_MID);
		if(vo != null && passwordEncoder.matches(SJ_USER_PWD, vo.getSJ_USER_PWD()) && vo.getSJ_USER_DEL().equals("NO")) {
			// 회원 인증처리된경우에 수행할 내용들을 기술한다.(session에 저장할자료 처리, 쿠키값처리, 그날 방문자수 1 더해주기...)
			session.setAttribute("sVO", vo);
			session.setAttribute("sIdx", vo.getSJ_USER_IDX());
			session.setAttribute("sMid", SJ_USER_MID);
			session.setAttribute("sEmail", vo.getSJ_USER_EMAIL());
			session.setAttribute("sNickName", vo.getSJ_USER_NICKNAME());
			if(idCheck.equals("on")) {
				Cookie cookie = new Cookie("cMid", SJ_USER_MID);
				cookie.setMaxAge(60*60*24*7);		// 쿠키의 만료시간을 7일로 정함(단위:초)
				response.addCookie(cookie);
			}
			else {
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cMid")) {
						cookies[i].setMaxAge(0);		// 기존에 저장된 현재 mid값을 삭제한다.
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			userService.getloginUp();
			return "redirect:/msg/loginOk";
		}
		else {
			return "redirect:/msg/loginNo";
		}
	}
	// 카카오로그인 인증처리
	// 카카오에서 인증처리가 되었다면 이곳은 그대로 로그인처리 시켜준다.
	// 만약 이곳에 가입되어 있지 않다면, 카카오에서 넘어온 정보(여기선, 닉네임과 이메일)로 자동 회원가입시켜준다.
	@RequestMapping(value = "/kakaoLogin", method = RequestMethod.GET)
	public String kakaoLoginGet(Model model,HttpSession session) {
		String email = (String) session.getAttribute("sEmail");
		UserVO vo = userService.getEmailCheck(email);
		if(vo != null && vo.getSJ_USER_DEL().equals("NO")) {
			// 회원 인증처리된경우에 수행할 내용들을 기술한다.(session에 저장할자료 처리, 쿠키값처리...)
			session.setAttribute("sVO", vo);
			session.setAttribute("sMid", vo.getSJ_USER_MID());
			session.setAttribute("sNickName", vo.getSJ_USER_NICKNAME());
			session.setAttribute("sEmail", vo.getSJ_USER_EMAIL());
			model.addAttribute("mid", vo.getSJ_USER_MID());
			model.addAttribute("nickName", vo.getSJ_USER_NICKNAME());
			userService.getloginUp();
			return "redirect:/msg/loginOk";
		}
		else if(vo != null && !vo.getSJ_USER_DEL().equals("NO")) {  // 탈퇴한 회원이라면 로그인 취소처리함.
			return "redirect:/msg/loginNo";
		}
		else {	// 회원 가입되어 있지 않은 회원이라면 자동회원가입처리(닉네임과 이메일만으로 가입처리)한다. 아이디는 이메일앞쪽을 지정해준다.
			String mid = email.substring(0,email.indexOf("@"));
			String nickName = (String) session.getAttribute("sNickName");
			// 비밀번호 암호화 처리
			String pwd = (passwordEncoder.encode("0000"));
			// 자동 회원 가입시켜준다.
			userService.setKakaoMemberInputOk(mid,pwd,email,nickName);
			// 다시 로그인 인증으로 보낸다. - 바로 로그인처리로 보내도 되는데, 현재는 '아이디/비밀번호'등록후 입력과 같이 처리하기 위함이다.
			model.addAttribute("email", email);
			return "redirect:/user/kakaoLogin";
		}
	}
	// 로그아웃
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logoutGet(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	// 아이디 찾기 폼
	@RequestMapping(value="/midConfirm", method = RequestMethod.GET)
	public String midConfirmGet() {
		return "user/user/midConfirm";
	}
	
	// 아이디 찾기
	@RequestMapping(value="/midConfirm", method = RequestMethod.POST)
	public String midConfirmPost(String num, String email, Model model) {
		UserVO vo = userService.getMidConfirm(num, email);
		if(vo != null) {
			String mid = vo.getSJ_USER_MID().substring(0,4)+"**";
			model.addAttribute("mid",mid);
			return "user/user/midConfirm2";
		}
		else {
			msgFlag = "midConfirmNo";
			return "redirect:/msg/" + msgFlag;
		}
	}
	// 비밀번호 찾기 폼
	@RequestMapping(value="/pwdConfirm", method = RequestMethod.GET)
	public String pwdConfirmGet() {
		return "user/user/pwdConfirm";
	}
	// 임시비밀번호 발급해서 메일로보냄
	@RequestMapping(value="/pwdConfirm", method = RequestMethod.POST)
	public String pwdConfirmPost(String mid, String num, String email, Model model) {
		UserVO vo = userService.getPwdConfirm(mid, num, email);
		if(vo != null) {
			// 임시비밀번호를 만들자
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8);
			userService.setPwdChange(mid, passwordEncoder.encode(pwd));
			String content = pwd;
			model.addAttribute("content",content);
			return "redirect:/mail/pwdConfirmSend/"+email+"/"+content+"/";
			//return "user/pwdConfirm2";
		}
		else {
			msgFlag = "pwdConfirmNo";
			return "redirect:/msg/" + msgFlag;
		}
	}
	
	// 마이페이지 폼
	@RequestMapping(value="/main", method = RequestMethod.GET)
	public String mainGet() {
		return "user/mypage/main";
	}
	
	// 비밀번호 체크 홈
	@RequestMapping(value="/pwdCheck", method = RequestMethod.GET)
	public String pwdCheckGet() {
		return "user/mypage/userPwd";
	}
	// 비밀번호 확인 처리
	@RequestMapping(value="/pwdCheck", method = RequestMethod.POST)
	public String pwdCheckPost(String pwd, HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		UserVO vo = userService.getIdCheck(mid);
		if(vo != null && passwordEncoder.matches(pwd, vo.getSJ_USER_PWD())) {
			session.setAttribute("sPwd", pwd);
			model.addAttribute("vo", vo);
			return "redirect:/user/myUpdate";
		}
		else {
			msgFlag = "pwdCheckNo";
			return "redirect:/msg/"+msgFlag;
		}
	}
	
	// 회원 정보 변경폼 불러오기
	@RequestMapping(value="/myUpdate", method = RequestMethod.GET)
	public String memUpdateGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		UserVO vo = userService.getIdCheck(mid);
		model.addAttribute("vo", vo);
		return "user/mypage/userUpdate";
	}
	
	// 회원 정보 변경하기
	@RequestMapping(value="/myUpdate", method = RequestMethod.POST)
	public String myUpdatePost(UserVO vo, HttpSession session) {
		String email = (String) session.getAttribute("sEmail");
		// 이메일 중복체크하기 ( 이메일이 변경되었으면 새롭게 이메일을 세션에 등록시켜준다.)
		if(!email.equals(vo.getSJ_USER_EMAIL())) {
			if(userService.getEmailCheck(vo.getSJ_USER_EMAIL()) != null) {
				msgFlag = "mypageEmailCheckNo";
				return "redirect:/msg/" + msgFlag;
			}
			else {session.setAttribute("sEmail", vo.getSJ_USER_EMAIL());}
		}
		vo.setSJ_USER_PWD(passwordEncoder.encode(vo.getSJ_USER_PWD()));
		System.out.println(vo);
		userService.setMyUpdate(vo);
		return "redirect:/msg/myUpdateOk";
	}
	
	// 이용권 폼
	@RequestMapping(value="/pay", method = RequestMethod.GET)
	public String payGet() {
		return "user/pay/pay";
	}
	
	// 아티스트 추천 폼
	@RequestMapping(value="/artisttape", method = RequestMethod.GET)
	public String artisttapeGet(Model model,HttpSession session) {
		Method method = new Method();
		UserVO vo = (UserVO) session.getAttribute("sVO");
		if (vo != null) {
			List<SongVO> vos = userService.getArtistTape(vo.getSJ_USER_IDX());
			if (vos.size() > 0) {
				model.addAttribute("vos", vos);
				model.addAttribute("thum", method.getImgSize(vos.get(0).getSJ_SONG_IMG(), "200"));
			}
		}
		return "user/mypage/artist";
	}
	@RequestMapping("/artist/{artist}")
	public String artistGet(Model model, @PathVariable String artist) {
		Method method = new Method();
		List<SongVO> vos = new ArrayList<SongVO>();
		artist = artist.replaceAll("\\^", "'");
		vos = musicService.getSrchArtist(artist);
		model.addAttribute("thum", method.getImgSize(vos.get(0).getSJ_SONG_IMG(), "200"));
		model.addAttribute("vos", vos);
		return "main/main";
	}
	// 플레이 리스트
	@RequestMapping(value="/playlist", method = RequestMethod.GET)
	public String playlistGet(HttpSession session, Model model,int idx) {
		ArrayList<PlayListVO> vos = userService.getPlayListVOS(idx);
		model.addAttribute("vos", vos);
		return "user/song/playlist";
	}
	//플레이 리스트 상세보기
	@RequestMapping(value="/playlistcontent", method=RequestMethod.GET)
	public String playlistcontentGet(int idx, Model model) {
		PlayListVO listVO = userService.getPlayListVO(idx);
		ArrayList<SongVO> vos = new ArrayList<SongVO>();
		if (!listVO.getSJ_PLAYLIST_CONTENT().equals("")) {
				String[] idx_list = listVO.getSJ_PLAYLIST_CONTENT().split("/");
				
				for (int i=0; i<idx_list.length; i++) {
					SongVO vo = musicService.getSongInfor(Integer.parseInt(idx_list[i]));
					vos.add(vo);
				}
		}
		model.addAttribute("vo", listVO);
		model.addAttribute("vos", vos);
		return "user/song/playlistcontent";
	}
	// 플레이 리스트 저장
	@RequestMapping("/savelist")
	@ResponseBody
	public void savelistPost(PlayListVO vo, String[] idx_list) {
		userService.setPlayList(vo);
	}
	// 플레이리스트
	@RequestMapping("/getlist")
	@ResponseBody
	public ArrayList<PlayListVO> getlistPost(HttpSession session,int idx) {
		ArrayList<PlayListVO> vos = new ArrayList<PlayListVO>();
		vos = userService.getPlayListVOS(idx);
		return vos;
	}
	// 플레이리스트 불러오기
	@RequestMapping("/addmylist")
	@ResponseBody
	public int addmylistPost(int idx, int songIdx) {
		if (userService.setAddMyList(idx, songIdx)) return 1;
		else return 0;
	}
	// 플레이리스트 다중선택 불러오기
	@RequestMapping("/addmylistmany")
	@ResponseBody
	public void addmylistmanyPost(int idx, String songIdxs) {
		userService.setAddMyListMany(idx, songIdxs);
	}
	// 플레이리스트 지우기
	@RequestMapping("/playlistdel")
	public String playlistdelGet(int idx,int useridx) {
		userService.setPlayListDel(idx);
		msgFlag = "playlistDel$idx="+useridx;
		return "redirect:/msg/"+msgFlag;
	}

	// 플레이리스트 노래 지우기
	@RequestMapping("/playlistdelsong")
	@ResponseBody
	public void playlistdelsongPost(int idx, int songIdx) {
		System.out.println(idx +"/"+songIdx);
		userService.setPlayListDelSong(idx, songIdx);
	}

	// 플레이 리스트 다중선택 노래 지우기
	@RequestMapping("/playlistdelsongs")
	@ResponseBody
	public void playlistdelsongsPost(int idx, String songIdxs) {
		System.out.println(idx +"/"+songIdxs);
		String[] idxs = songIdxs.split("/");
		for (int i=0; i<idxs.length; i++) {
			userService.setPlayListDelSong(idx, Integer.parseInt(idxs[i]));
		}
	}

	//플레이리스트 지우기
	@RequestMapping("/dellist")
	@ResponseBody
	public void dellistPost(int idx, int songIdx) {
		userService.setPlayListDelSong(idx, songIdx);
	}

	// 플레이리스트 업데이트
	@RequestMapping("playlistoneupdate")
	@ResponseBody
	public void playlistoneupdatePost(int idx, String listNm, String comment) {
		userService.setPlayListContentUpdate(idx, listNm, comment);
	}
	
	// 자주듣는노래 폼
	@RequestMapping(value="/bestMusic", method = RequestMethod.GET)
	public String bestMusicGet(Model model,HttpSession session,int idx) {
		Method method = new Method();
		ArrayList<SongVO> vos = musicService.getMyRank(idx);
		if (vos.size() > 0) vos.get(0).setSJ_SONG_IMG(method.getImgSize(vos.get(0).getSJ_SONG_IMG(), "300"));
		if (vos.size() > 1) vos.get(1).setSJ_SONG_IMG(method.getImgSize(vos.get(1).getSJ_SONG_IMG(), "300"));
		if (vos.size() > 2) vos.get(2).setSJ_SONG_IMG(method.getImgSize(vos.get(2).getSJ_SONG_IMG(), "300"));
		model.addAttribute("vos", vos);
		return "user/mypage/mybest";
	}
	
	
	//공지
	// 공지관리
	@RequestMapping(value="/notice", method = RequestMethod.GET)
	public String noticeGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		int totRecCnt = userService.noticeTotRecCnt();// 전체자료 갯수 검색
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize; 
		int curScrStartNo = totRecCnt - startIndexNo;	
		int blockSize = 3; 
	    int curBlock = (pag - 1) / blockSize;	
	    int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
	    List<NoticeVO> noticevos = userService.getNotice(startIndexNo, pageSize);
		model.addAttribute("noticevos", noticevos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStartNo", curScrStartNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		return"user/notice/notice";
	}
	
	// 공지사항 내용보기
	@RequestMapping(value="/noticeContent", method = RequestMethod.GET)
	public String noticeContentGet(int idx, int pag, int pageSize, Model model) {
		int SJ_NOTICE_IDX = idx;
		// 원본글 가져오기
		NoticeVO vo= userService.getNoticeContent(SJ_NOTICE_IDX);
		// 이전글, 다음글 가져오기
		List<NoticeVO> pnVos = userService.getPreNext(SJ_NOTICE_IDX);
		model.addAttribute("pnVos", pnVos);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		return"user/notice/noticeContent";
	}
	
}
