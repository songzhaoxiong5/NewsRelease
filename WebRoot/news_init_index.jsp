<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.szx.bean.*,com.szx.service.*,com.szx.service.impl.*,com.szx.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Processing...</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  <%
  	ContentServiceImpl contentService=new ContentServiceImpl();
  	TopicServiceImpl topicService=new TopicServiceImpl();
  	ArrayList<News_Topic> list=(ArrayList<News_Topic>)application.getAttribute("topicList");
  	ArrayList<News_Content> list1=(ArrayList<News_Content>)contentService.selectFiniteByTopicID(topicService.findIDByName("国内"),0,5);
  	ArrayList<News_Content> list2=(ArrayList<News_Content>)contentService.selectFiniteByTopicID(topicService.findIDByName("国际"),0,5);
  	ArrayList<News_Content> list3=(ArrayList<News_Content>)contentService.selectFiniteByTopicID(topicService.findIDByName("娱乐"),0,5);
  	ArrayList<News_Content> curList=null;
  	String dynTopic=request.getParameter("dynTopic");
  	String pageIndex=request.getParameter("pageIndex");
  	if(pageIndex==null||(pageIndex=pageIndex.trim()).length()==0){
  		pageIndex="1";
  	}
  	int currentPageNo=Integer.parseInt(pageIndex);
  	if(currentPageNo<1){
  		currentPageNo=1;
  	}
  	Page pageObj=new Page();
  	pageObj.setCurrentPageNo(currentPageNo);
  	pageObj.setPageSize(15);
  	if(dynTopic==null){
  		contentService.findPageContent(pageObj, topicService.findIDByName("国内"));
  		curList=(ArrayList<News_Content>)pageObj.getNewsList();
  		dynTopic="国内";
  	}else{
  		contentService.findPageContent(pageObj, topicService.findIDByName(dynTopic));
  		curList=(ArrayList<News_Content>)pageObj.getNewsList();
  	}
  	request.setAttribute("list",list);
  	request.setAttribute("list1",list1);
  	request.setAttribute("list2",list2);
  	request.setAttribute("list3",list3);
  	request.setAttribute("pageObj", pageObj);
  	request.setAttribute("curList",curList);
  	request.setAttribute("dynTopic",dynTopic);//保存主题信息在request中用于控制分页
  	request.getRequestDispatcher("index2.jsp").forward(request,response);
  	
   %>
  <body>
    
  </body>
</html>
