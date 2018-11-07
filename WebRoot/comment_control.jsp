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
  	request.setCharacterEncoding("utf-8");
  	CommentServiceImpl commentService=new CommentServiceImpl();
  	News_Comment comment=new News_Comment();
  	String userName=request.getParameter("cauthor");
  	String IP=request.getParameter("cip");
  	String content=request.getParameter("ccontent");
  	comment.setCommentContent(content);
  	comment.setCommentIP(IP);
  	comment.setUserName(userName);
  	comment.setNewsID(Integer.parseInt(request.getParameter("contentID")));
  	int rowNum=commentService.add(comment);
  	if(rowNum>0){
  	%>
  	<script type="text/javascript">
  		alert("添加评论成功！");
  		location.href="news_init_index.jsp";
  	</script>
  	<%
  	}else{
  	%>
  	<script type="text/javascript">
  		alert("添加评论失败！");
  		location.href="news_init_index.jsp";
  	</script>
  	<%
  	}
   %>
  <body>
    
  </body>
</html>
