package com.szx.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;


import org.apache.log4j.*;
public class LoginCheckFilter implements Filter{
	private Logger logger=Logger.getLogger(LoginCheckFilter.class);
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		logger.debug("进入了过滤器-用户登录");
		HttpServletRequest request=(HttpServletRequest)req;
		HttpServletResponse response=(HttpServletResponse)resp;
		HttpSession session=request.getSession(false);
		if((session!=null)&&(session.getAttribute("login")!=null)){
			System.out.println("有loginUser字段");
			System.out.println(session.getAttribute("login"));
			chain.doFilter(req, resp);
			logger.debug("退出了过滤器-用户登录");
		}else{
			response.sendRedirect(request.getContextPath()+"/news_init_index.jsp");
			return;
		}
		
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
