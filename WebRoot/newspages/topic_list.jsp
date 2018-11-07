<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.szx.bean.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("basePath", basePath);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>主题列表页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageScope.basePath}css/admin.css"/>

  </head>
  <%
 	request.setCharacterEncoding("UTF-8"); 
  	ArrayList<News_Topic> list=(ArrayList<News_Topic>)request.getAttribute("list"); 
  	//request.setAttribute("list", list);
  %>
  <body>
  	<%@ include file="console_element/top.jsp" %> 
	<div id="main">
	<%@include file="console_element/left.html"%>
	  <div id="opt_area"> 
	    <ul class="classlist">
	    	<c:forEach var="topic" items="${requestScope.list}" varStatus="status">
	    		<li>${topic.topicName}<span>                                              
	        &#160;&#160;&#160;&#160; <a href="<%=basePath%>newspages/topic_modify.jsp?tid=${topic.topicID}&tName=${topic.topicName}&opr=modify">修改</a> &#160;&#160;&#160;&#160; <a href="<%=basePath%>topic_control.jsp?tid=${topic.topicID }&opr=del" >删除</a> </span> </li>
	    	</c:forEach>
	    </ul>  
	  </div>
    </div>
    <div id="footer">
  	<%@ include file="console_element/bottom.html" %>
	</div>
	
	<script type="text/javascript" src="js/jquery-3.2.1.js"></script>
	<script type="text/javascript">
	
	</script>
  </body>
</html>
