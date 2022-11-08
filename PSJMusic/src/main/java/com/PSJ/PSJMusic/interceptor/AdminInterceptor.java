package com.PSJ.PSJMusic.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		String id = "admin";
		String id2 = "";
		if(id.equals(mid) == false && id2.equals(mid) == false) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/msg/useradminNo");
			dispatcher.forward(request, response);
			return false;
		}
		return true;
	}
}
