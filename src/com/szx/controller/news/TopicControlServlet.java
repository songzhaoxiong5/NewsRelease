package com.szx.controller.news;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.*;

import com.szx.bean.News_Content;
import com.szx.bean.News_Topic;
import com.szx.service.impl.ContentServiceImpl;
import com.szx.service.impl.TopicServiceImpl;

public class TopicControlServlet extends HttpServlet {
	private Logger logger=Logger.getLogger(TopicControlServlet.class);
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out=response.getWriter();
		ServletContext application=request.getServletContext();
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String opr=request.getParameter("opr");
		TopicServiceImpl topicService=new TopicServiceImpl();
		ContentServiceImpl contentService=new ContentServiceImpl();
		if("listHtml".equals(opr)){
			ArrayList<News_Topic> list=(ArrayList<News_Topic>)application.getAttribute("topicList");
			StringBuffer topicBuffer=new StringBuffer();
			topicBuffer.append("<ul class='classlist'>");
			for(int i=0;i<list.size();i++){
				News_Topic topic=list.get(i);
				topicBuffer.append("<li>"+topic.getTopicName()+"<span>&#160;&#160;&#160;&#160;<a href='javascript:;' topicID="+topic.getTopicID()+" tName="+topic.getTopicName()+" class='modify'>修改</a> &#160;&#160;&#160;&#160; <a href='javascript:;' topicID="+topic.getTopicID()+" class='delete'>删除</a> </span> </li>");
			}
			topicBuffer.append("</ul>");
			out.print(topicBuffer);
			out.flush();
		}else if("showAll".equals(opr)){
			//ArrayList<News_Topic> list=(ArrayList<News_Topic>)topicService.selectAll();
			ArrayList<News_Topic> list=(ArrayList<News_Topic>)application.getAttribute("topicList");
			StringBuffer topicJSON=new StringBuffer("[");
			for(int i=0;;){
				News_Topic topic=list.get(i);
				topicJSON.append("{\"topicID\":"+topic.getTopicID()+",\"topicName\":\""+topic.getTopicName().replace("\"","&quot;")+"\"");
				if((++i)==list.size()){
					topicJSON.append("}");
					break;
				}else{
					topicJSON.append("},");
				}
			}
			topicJSON.append("]");
			System.out.println(topicJSON);
			out.print(topicJSON);
			out.flush();
		}else if("add".equals(opr)){
			String topicName=request.getParameter("tname");
			System.out.println(topicName);
			String status;
			String message;
			if(topicService.selectByName(topicName)!=null){
				//out.print("<script type='text/javascript'>alert('该主题已经存在！');location.href='newspages/topic_add.jsp?redundancy="+topicName+"';</script>");
				status="exist";
				message="当前主题已存在，请输入不同的主题！";
				out.print("{\"status\":\""+status+"\",\"message\":\""+message+"\",\"redundancy\":\""+topicName+"\"}");
			}else{
				News_Topic topic=new News_Topic();
				topic.setTopicName(topicName);
				topicService.add(topic);
				List<News_Topic> topicList=topicService.selectAll();
				application.setAttribute("topicList", topicList);
				//out.print("<script type='text/javascript'>alert('新主题已经添加成功');location.href='javascript:';</script>");
				status="success";
				message="主题创建成功！";
				out.print("{\"status\":\""+status+"\",\"message\":\""+message+"\"}");
			}
		}else if("del".equals(opr)){
		String tid=request.getParameter("tid");
		String status;
		String message;
		ArrayList<News_Content> list=(ArrayList<News_Content>)contentService.selectByTopicID(Integer.parseInt(tid));
		if(list.isEmpty()){
			topicService.deleteById(tid);
			List<News_Topic> topicList=topicService.selectAll();
			application.setAttribute("topicList", topicList);
			status="success";
			message="已成功删除主题";
		}else{
			status="error";
			message="该主题下还有文章，不能删除！";
			}
		out.print("{\"status\":\""+status+"\",\"message\":\""+message+"\"}");
	}else if("modify".equals(opr)){
		String newTopicName=request.getParameter("topicName");
		String tid=request.getParameter("topicID");
		String status;
		String message;
		String redundancy;
		if(topicService.selectByName(newTopicName)!=null){
			status="exist";
			message="当前主题已存在，请输入不同的主题！";
			redundancy=newTopicName;
			out.print("{\"status\":\""+status+"\",\"message\":\""+message+"\",\"redundancy\":\""+redundancy+"\"}");
		}else{
			News_Topic topic=new News_Topic();
			topic.setTopicID(Integer.parseInt(tid));
			topic.setTopicName(newTopicName);
			topicService.update(topic);
			List<News_Topic> topicList=topicService.selectAll();
			application.setAttribute("topicList", topicList);
			status="success";
			message="已成功更新主题！";
			out.print("{\"status\":\""+status+"\",\"message\":\""+message+"\"}");
			}
	}
		
	}

}
