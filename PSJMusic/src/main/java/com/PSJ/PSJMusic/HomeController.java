package com.PSJ.PSJMusic;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.PSJ.PSJMusic.music.MusicService;
import com.PSJ.PSJMusic.user.UserService;

@Controller
public class HomeController {
	@Autowired UserService userService;
	@Autowired HomeService homeService;
	@Autowired MusicService musicService;
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session,Locale locale, Model model,String date) {
		date = "main";
		model.addAttribute("vos", musicService.getChartVOS(date));
		model.addAttribute("bannervos", homeService.getBannerList());
		model.addAttribute("tvvos", homeService.getTvList());
		model.addAttribute("magazinevos", homeService.getMagazineList());
		model.addAttribute("noticevos", homeService.getNoticeList());
		return "/index";
	}
	
}
