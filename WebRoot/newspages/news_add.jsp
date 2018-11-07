<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.szx.bean.*,com.szx.service.impl.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
pageContext.setAttribute("basePath", basePath);
TopicServiceImpl topicService=new TopicServiceImpl();
ArrayList<News_Topic> topicList=(ArrayList<News_Topic>)topicService.selectAll();
pageContext.setAttribute("topicList", topicList);
pageContext.setAttribute("news",request.getAttribute("news"));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
 <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加主题--管理后台</title>
<link href="${pageScope.basePath}css/admin.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@ include file="console_element/top.jsp" %>
<div id="main">
  <%@include file="console_element/left.html"%>
   <div id="msg" style="display:none; position:absolute; z-index:5; background-color:pink; font-size:16px; padding:5px 20px;"></div>
  <div id="opt_area">
    <h1 id="opt_type"> 添加新闻： </h1>
    <form action="${pageScope.basePath}news_control.jsp?opr=add"  enctype="multipart/form-data" method="post">
      <p>
        <label> 主题 </label>
        <select name="ntid" id="ntid" value="${empty pageScope.news?'':pageScope.news.topicID}">
             <c:forEach var="topic" items="${pageScope.topicList}" varStatus="status">
             	<option value="${topic.topicName}">${topic.topicName }</option>
             </c:forEach>
        </select>
      </p>
      <p>
        <label> 标题 </label>
        <input name="ntitle" id="ntitle" type="text" class="opt_input" value="${empty pageScope.news?'':pageScope.news.contentTitle}"/>
      </p>
      <p>
        <label> 作者 </label>
        <input name="nauthor" id="nauthor" name="nauthor" type="text" class="opt_input" value="${empty pageScope.news?'':pageScope.news.author}"/>
      </p>
      <p>
        <label> 摘要 </label>
        <textarea name="nsummary" id="nsummary" cols="40" rows="3" value="${empty pageScope.news?'':pageScope.news.contentSummary}"></textarea>
      </p>
      <p>
        <label> 内容 </label>
        <textarea name="ncontent"  id="ncontent" cols="70" rows="10" value="${empty pageScope.news?'':pageScope.news.content}"></textarea>
      </p>
      <p>
        <label> 上传图片 </label>        
        <input type="file" name="nfile"/>
      </p>
      <input name="action" type="hidden" value="addnews"/>
      <input type="submit" value="提交" class="opt_sub" />
      <input type="reset" value="重置" class="opt_sub" />
    </form>
  </div>
</div>
<div id="footer">
  <%@ include file="console_element/bottom.html" %>
</div>
<script type="text/javascript" src="js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="js/admin2.js"></script>
</body>
</html>
