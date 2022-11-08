package com.PSJ.PSJMusic;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MessageController {
	@RequestMapping(value="/msg/{msgFlag}", method = RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model , HttpSession session) {
			String nick = session.getAttribute("sNickName")==null? "" : (String) session.getAttribute("sNickName");
		if(msgFlag.equals("userNo")) {
			model.addAttribute("msg","로그인 후 이용해주세요");
			model.addAttribute("url","user/login");
		}
		else if(msgFlag.equals("useradminNo")) {
			model.addAttribute("msg","관리자 로그인 후 이용해주세요");
			model.addAttribute("url","user/login");
		}
		else if(msgFlag.equals("memIdCheckNo")) {
			model.addAttribute("msg", "아이디가 중복되었습니다");
			model.addAttribute("url","user/join");
		}
		else if(msgFlag.equals("memEmailCheckNo")) {
			model.addAttribute("msg", "이메일이 중복되었습니다");
			model.addAttribute("url","user/join");
		}
		else if(msgFlag.equals("mypageEmailCheckNo")) {
			model.addAttribute("msg", "이메일이 중복되었습니다");
			model.addAttribute("url","user/myUpdate");
		}
		else if(msgFlag.equals("memJoinOk")) {
			model.addAttribute("msg", "회원가입되셨습니다");
			model.addAttribute("url","user/joinOK");
		}
		else if(msgFlag.equals("loginOk")) {
			model.addAttribute("msg", nick+"님 로그인 되었습니다");
			model.addAttribute("url","/");
		}
		else if(msgFlag.equals("loginNo")) {
			model.addAttribute("msg", "아이디와 비밀번호를 확인해주세요");
			model.addAttribute("url","user/login");
		}
		else if(msgFlag.equals("midConfirmNo")) {
			model.addAttribute("msg", "등록된 아이디가 없습니다");
			model.addAttribute("url","user/midConfirm");
		}
		else if(msgFlag.equals("qauploInputOk")) {
			model.addAttribute("msg", "질문이 등록되었습니다.");
			model.addAttribute("url","service/qaList");
		}
		else if(msgFlag.equals("pwdConfirmNo")) {
			model.addAttribute("msg", "다시 확인해주세요\\n일치하는 회원 정보가 없습니다");
			model.addAttribute("url","user/pwdConfirm");
		}
		else if(msgFlag.equals("memDeleteOk")) {
			model.addAttribute("msg", "회원 탈퇴 되었습니다.\\n안녕히 가십시오");
			model.addAttribute("url","/");
		}
		else if(msgFlag.equals("pwdConfirmOk")) {
			model.addAttribute("msg", "임시비밀번호를 메일로 보냈습니다.\\n메일을 확인하세요");
			model.addAttribute("url","user/login");
		}
		else if(msgFlag.equals("pwdCheckNo")) {
			model.addAttribute("msg", "비밀번호가 다릅니다");
			model.addAttribute("url","user/pwdCheck");
		}
		else if(msgFlag.equals("myUpdateOk")) {
			model.addAttribute("msg", "회원정보가 수정되었습니다");
			model.addAttribute("url","user/main");
		}
		else if(msgFlag.substring(0,11).equals("playlistDel")) {
			model.addAttribute("msg", "삭제 되었습니다.");
			model.addAttribute("url","user/playlist?"+msgFlag.substring(12));
		}
		else if(msgFlag.substring(0,12).equals("musicInputOk")) {
			model.addAttribute("msg", "음악이 등록되었습니다");
			model.addAttribute("url","admin/main?"+msgFlag.substring(13));
		}
		else if(msgFlag.substring(0,15).equals("magazineInputOk")) {
			model.addAttribute("msg", "매거진이 등록되었습니다");
			model.addAttribute("url","admin/main?"+msgFlag.substring(16));
		}
		else if(msgFlag.substring(0,14).equals("qauploUpdateOk")) {
			model.addAttribute("msg", "수정되었습니다");
			model.addAttribute("url","service/qaContent?"+msgFlag.substring(15));
		}
		else if(msgFlag.substring(0,12).equals("videoInputOk")) {
			model.addAttribute("msg", "비디오가 등록되었습니다");
			model.addAttribute("url","admin/main?"+msgFlag.substring(13));
		}
		else if(msgFlag.substring(0,13).equals("noticeInputOk")) {
			model.addAttribute("msg", "공지사항이 등록되었습니다");
			model.addAttribute("url","admin/main?"+msgFlag.substring(14));
		}
		else if(msgFlag.substring(0,14).equals("noticeDeleteOk")) {
			model.addAttribute("msg", "공지사항이 삭제되었습니다");
			model.addAttribute("url","admin/main?"+msgFlag.substring(15));
		}
		else if(msgFlag.substring(0,14).equals("qaqaqaDeleteOk")) {
			model.addAttribute("msg", "질문이 삭제되었습니다");
			model.addAttribute("url","admin/main?"+msgFlag.substring(15));
		}
		else if(msgFlag.substring(0,14).equals("noticeUpdateOk")) {
			model.addAttribute("msg", "공지사항이 수정되었습니다");
			model.addAttribute("url","admin/noticeContent?"+msgFlag.substring(15));
		}
		else if(msgFlag.substring(0,14).equals("magaziUpdateOk")) {
			model.addAttribute("msg", "매거진이 수정되었습니다");
			model.addAttribute("url","admin/magazinContent?"+msgFlag.substring(15));
		}
		else if(msgFlag.substring(0,13).equals("videoUpdateOk")) {
			model.addAttribute("msg", "동영상이 수정되었습니다");
			model.addAttribute("url","admin/videoContent?"+msgFlag.substring(14));
		}
		else if(msgFlag.substring(0,13).equals("bannerInputOk")) {
			model.addAttribute("msg", "배너가 등록되었습니다");
			model.addAttribute("url","admin/main?"+msgFlag.substring(14));
		}
		else if(msgFlag.equals("playlistdel")) {
			model.addAttribute("msg", "삭제 되었습니다");
			model.addAttribute("url","user/playlist");
		}

		
//		else if(msgFlag.substring(0,16).equals("questionUpdateOk")) {
//			model.addAttribute("msg", "수정되었습니다");
//			model.addAttribute("url","support/question?"+msgFlag.substring(17));
//		}
//		else if(msgFlag.substring(0,15).equals("productUpdateOk")) {
//			model.addAttribute("msg", "상품이수정되었습니다");
//			model.addAttribute("url","product/productContent?"+msgFlag.substring(16));
//		}
//
//
//		
		return "include/message";
	}
}
