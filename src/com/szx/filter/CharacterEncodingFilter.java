package com.szx.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import org.apache.log4j.*;

public class CharacterEncodingFilter implements Filter {
	private Logger logger=Logger.getLogger(CharacterEncodingFilter.class);
	private String charset=null;
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		logger.debug("进入过滤器-CharacterEncoding");
		if(charset!=null){
		request.setCharacterEncoding(charset);
		response.setCharacterEncoding(charset);
		response.setContentType("text/html;charset=utf-8");
		}
		chain.doFilter(request, response);
		logger.debug("退出过滤器-CharacterEncoding");
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		// TODO Auto-generated method stub
		String initParam=config.getInitParameter("charset");
		if(initParam!=null&&(initParam=initParam.trim())!=null){
			logger.debug("配置初始化参数");
			charset=initParam;
		}
			
		
	}

}
