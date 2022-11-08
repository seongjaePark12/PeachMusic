package com.PSJ.PSJMusic.publicService;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.PSJ.PSJMusic.HomeService;

@Controller
@RequestMapping("/service")
public class ServiceController {
	String msgFlag = "";
	@Autowired HomeService homeService;
	
	// 메거진 폼
	@RequestMapping(value="/magazineMain", method = RequestMethod.GET)
	public String magazineMainGet(Model model) {
		model.addAttribute("mvo", homeService.getMagazine());
		model.addAttribute("magazinevos", homeService.getMagazineList2());
		return "service/magazine";
	}
	
	// 메거진 내용 폼
	@RequestMapping(value="/magazine", method = RequestMethod.GET)
	public String magazineGet(Model model,int idx) {
		model.addAttribute("vo", homeService.getMagazineContent(idx));
		model.addAttribute("rVos", homeService.getMagazineReply(idx));
		homeService.getMagazineUp(idx);
		return "service/magazineContent";
	}
	// 댓글 저장하기
	@ResponseBody
	@RequestMapping(value="/magazineReplyInsert", method = RequestMethod.POST)
	public String magazineReplyInsertPost(MagazinReplyVO rVo) {
		homeService.setReplyInsert(rVo);
		return "";
	}
	// 댓글 수정하기
	@ResponseBody
	@RequestMapping(value="/magazineReplyInsert2", method = RequestMethod.POST)
	public String magazineReplyInsert2Post(MagazinReplyVO rVo) {
		homeService.setReplyInsert2(rVo);
		return "";
	}
	// 댓글 삭제처리
	@ResponseBody
	@RequestMapping(value="/magazineReplyDelete", method = RequestMethod.POST)
	public String magazineReplyDeletePost(int replyIdx) {
		homeService.setReplyDelete(replyIdx);
		return"";
	}
	
	// 비디오 폼
	@RequestMapping(value="/videoMain", method = RequestMethod.GET)
	public String videoMainGet(Model model) {
		model.addAttribute("videovos", homeService.getVideoList());
		return "service/video";
	}
	
	// 비디오 내용 폼
	@RequestMapping(value="/video", method = RequestMethod.GET)
	public String videoGet(Model model,int idx) {
		model.addAttribute("vo", homeService.getVideoContent(idx));
		homeService.getVideoUp(idx);
		return "service/videoContent";
	}
	
	// 질문 리스트 폼
	@RequestMapping(value="/qaList", method = RequestMethod.GET)
	public String qaListGet(Model model,
			@RequestParam(name="what", defaultValue="", required=false) String what,
			@RequestParam(name="pag", defaultValue = "1") int pag,
			@RequestParam(name="pageSize", defaultValue = "10") int pageSize) {
		int totRecCnt = homeService.qaTotRecCnt();// 전체자료 갯수 검색
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize; 
		int curScrStartNo = totRecCnt - startIndexNo;	
		int blockSize = 3; 
	    int curBlock = (pag - 1) / blockSize;	
	    int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
	    List<QuestionVO> questionvos = new ArrayList<QuestionVO>();
		if(what == "") {
			questionvos = homeService.getQuestionList(startIndexNo, pageSize);
			model.addAttribute("questionvos", questionvos);
		}
		else if (what != ""){
			questionvos = homeService.getQuestionListwhat(startIndexNo, pageSize,what);
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
		return "service/qaList";
	}
	// 질문 수정 폼
	@RequestMapping(value="/qaUpdate", method = RequestMethod.GET)
	public String qaUpdateGet(Model model,int idx, int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		QuestionVO vo = homeService.getqaContent(idx);
		if(vo.getSJ_QUESTION_CONTENT().indexOf("src=\"/") != -1) homeService.qaImgCheckUpdate(vo.getSJ_QUESTION_CONTENT());
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		return "service/qaUpdate";
	}
	// 질문 수정
	@RequestMapping(value="/qaUpdate", method = RequestMethod.POST)
	public String qaUpdatePost(QuestionVO vo, int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		// 원본파일들을 board폴더에서 삭제처리한다.
		if(vo.getOriContent().indexOf("src=\"/") != -1)	homeService.qaImgDelete(vo.getOriContent());
		// 원본파일을 수정폼에 들어올때 board폴더에서 ckeditor폴더로 복사해두고, board폴더의 파일은 지웠기에, 아래의 복사처리전에 원본파일위치를 vo.content안의 파일경로를 board폴더에서 ckeditor폴더로 변경처리해줘야한다.
		vo.setSJ_QUESTION_CONTENT(vo.getSJ_QUESTION_CONTENT().replace("/data/ckeditor/question/", "/data/ckeditor/"));
		// 수정된 그림파일을 다시 복사처리한다.(수정된 그림파일의 정보는 content필드에 담겨있다.)('/ckeditor'폴더 -> '/ckeditor/board'폴더로복사) : 처음파일 입력작업과 같은 작업이기에 아래는 처음 입력시의 메소드를 호출했다.
		homeService.qaImgCheck(vo.getSJ_QUESTION_CONTENT());
		// 필요한 파일을 board폴더로 복사했기에 vo.content의 내용도 변경한다.
		vo.setSJ_QUESTION_CONTENT(vo.getSJ_QUESTION_CONTENT().replace("/data/ckeditor/", "/data/ckeditor/question/"));
		// 잘 정비된 vo값만을 DB에 저장시킨다.
		homeService.qaUpdate(vo);
		return"redirect:/msg/qauploUpdateOk$idx="+vo.getSJ_QUESTION_IDX()+"&pag="+pag+"&pageSize="+pageSize;
	}
	// 질문 입력 폼
	@RequestMapping(value="/qaInput", method = RequestMethod.GET)
	public String qaInputGet() {
		return "service/qaInput";
	}
	// 질문 입력 폼
	@RequestMapping(value="/qaInput", method = RequestMethod.POST)
	public String qaInputPost(QuestionVO vo) {
		homeService.qaImgCheck(vo.getSJ_QUESTION_CONTENT());
		vo.setSJ_QUESTION_CONTENT(vo.getSJ_QUESTION_CONTENT().replace("/data/ckeditor/", "/data/ckeditor/question/"));
		homeService.setqaInput(vo);
		return"redirect:/msg/qauploInputOk";
	}
	
	// 질문 내용 폼
	@RequestMapping(value="/qaContent", method = RequestMethod.GET)
	public String qaContentGet(Model model,int idx, int pag, int pageSize) {
		model.addAttribute("vo", homeService.getqaContent(idx));
		model.addAttribute("rVos", homeService.getqaReply(idx));
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		return "service/qaContent";
	}

	
	
}
