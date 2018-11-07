<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.szx.bean.*,com.szx.service.impl.*" %>
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
	String contentID=request.getParameter("contentID");
	ContentServiceImpl contentService=new ContentServiceImpl();
	CommentServiceImpl commentService=new CommentServiceImpl();
	ArrayList<News_Content> contentList=(ArrayList<News_Content>)contentService.selectByID(Integer.parseInt(contentID));
	ArrayList<News_Comment> commentList=(ArrayList<News_Comment>)commentService.selectByNewsID(Integer.parseInt(contentID));
	request.setAttribute("content", contentList.get(0));
	request.setAttribute("commentList",commentList);
	request.getRequestDispatcher("newspages/news_content.jsp").forward(request,response);
 %>
  <body>
  
  </body>
</html>
