package com.PSJ.PSJMusic.user;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/kakao")
public class KakaoController {
  
	  @Autowired KakaoService kakaoService;
	  
	  @RequestMapping(value = "/kakaoLogin", method = RequestMethod.GET)
	  public String kakaoLoginGet() {
	    return "user/user/login";
	  }
	  
	  @ResponseBody
	  @RequestMapping(value = "/kakaoMain", method = RequestMethod.GET)
	  public ModelAndView kakaoMainGet(@RequestParam("code") String code, HttpSession session) {
	    ModelAndView mav = new ModelAndView();
	    
	    // 1. 인증코드 요청하여 전달받기
	    String accessToken = kakaoService.getAccessToken(code);
	    
	    // 2. 인증코드로 토큰 전달하기
	    HashMap<String, Object> userInfor = kakaoService.getUserInfor(accessToken);
	    
	    System.out.println("login infor : " + userInfor.toString());
	    
	    if(userInfor.get("email") != null) {
	      session.setAttribute("sEmail", userInfor.get("email"));
	    }
	    else {		// 이메일이 null이라면 임의의 이메일을 등록시켜주었다. 
	      session.setAttribute("sEmail", "abcd@naver.com");
	    }
	    session.setAttribute("sNickName", userInfor.get("nickname"));
	    session.setAttribute("accessToken", accessToken);
	    mav.setViewName("/user/user/kakaoMain");
	    return mav;
	  }
	  
	  @RequestMapping(value = "/kakaoLogout", method = RequestMethod.GET)
	  public ModelAndView kakaoLogoutGet(HttpSession session) {
	    ModelAndView mav = new ModelAndView();
	    kakaoService.kakaoLogout((String) session.getAttribute("accessToken"));
	    session.removeAttribute("accessToken");
	    mav.setViewName("/index");
	    
	    return mav;
	  }
}
