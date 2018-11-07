package com.szx.util;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.apache.log4j.*;
import com.szx.service.*;
import com.szx.service.impl.*;
import com.szx.bean.*;
import java.util.*;
public class GlobalResourceInitListner implements ServletContextListener {
	private Logger logger=Logger.getLogger(GlobalResourceInitListner.class);
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void contextInitialized(ServletContextEvent event) {
		// TODO Auto-generated method stub
		ServletContext application=event.getServletContext();
		List<News_Topic> topicList=null;
		TopicServiceImpl topicService=new TopicServiceImpl();
		topicList=topicService.selectAll();
		logger.debug("初始化得到"+topicList.size()+"个新闻主题");
		application.setAttribute("topicList", topicList);
		
	}

}
