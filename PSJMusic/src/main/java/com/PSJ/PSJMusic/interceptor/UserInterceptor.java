package com.PSJ.PSJMusic.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class UserInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		String id = "";
		if(mid.equals(id) == true) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/msg/userNo");
			dispatcher.forward(request, response);
			return false;
		}
		return true;
	}
}
