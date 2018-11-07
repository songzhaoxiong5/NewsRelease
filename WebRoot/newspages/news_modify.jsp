<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.szx.bean.*,com.szx.service.impl.*" %>
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加主题--管理后台</title>
<link href="${pageScope.basePath}css/admin.css" rel="stylesheet" type="text/css" />
</head>
<%
	TopicServiceImpl topicService=new TopicServiceImpl();
	ContentServiceImpl contentService=new ContentServiceImpl();
	ArrayList<News_Topic> topicList=(ArrayList<News_Topic>)topicService.selectAll();
	pageContext.setAttribute("topicList", topicList);
	String newsID=request.getParameter("contentID");
	pageContext.setAttribute("newsID", newsID);//将newsID存在了page中
	request.setAttribute("newsID", newsID);
	pageContext.setAttribute("news",contentService.selectSpecific(Integer.parseInt(newsID)));
	CommentServiceImpl commentService=new CommentServiceImpl();
	List<News_Comment> commentList=commentService.selectByNewsID(Integer.parseInt(newsID));
	pageContext.setAttribute("commentList", commentList);
 %>
<body>
<%@ include file="console_element/top.jsp" %>
<div id="main">
  <%@include file="console_element/left.html"%>
  <div id="opt_area">
    <h1 id="opt_type"> 添加新闻： </h1>
    <form action="newscontrol?opr=modify&type=content"  enctype="multipart/form-data" method="post">
    <input type="hidden" value="${pageScope.newsID}" name="newsID"/>
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
        <textarea name="nsummary" id="nsummary" cols="40" rows="3">${empty pageScope.news?'':pageScope.news.contentSummary}</textarea>
      </p>
      <p>
        <label> 内容 </label>
        <textarea name="ncontent"  id="ncontent" cols="70" rows="10">${empty pageScope.news?'':pageScope.news.content}</textarea>
      </p>
      <p>
        <label> 上传图片 </label>        
        <input type="file" name="nfile"/>
      </p>
      <input type="submit" value="修改" class="opt_sub" />
      <input type="reset" value="重置" class="opt_sub" />
    </form>
    <h1 id="opt_type">修改新闻评论 </h1>
  <ul class="classlist">
        <table width="80%" align="center">
        <c:choose>
        	<c:when test="${ empty pageScope.commentList}">
        		<td colspan="6"> 暂无评论！ </td>
          		<tr>
            	<td colspan="6"><hr/>
           		 </td>
         		</tr>
        	</c:when>
        	<c:otherwise>
        	<c:forEach var="comment" items="${pageScope.commentList}" varStatus="status">
        	<form action="newscontrol?opr=modify&type=comment" method="post">
        			<tr>
              <td> 留言人： 
              <input id="cauthor"  name="cauthor" value="${comment.userName}"/></td>
                <td>IP：
                <input name="cip"  value="${comment.commentIP}" readonly="readonly"/>
              </td>
              <td>留言时间：
              	<input name="time" value="${comment.commentTime}"/>
              </td>
            </tr>
            <tr>
            	<td colspan="6">留言内容：
            	</td>
            </tr>
            <tr>
            	<td colspan="6">
            	<input name="comment"  value="${comment.commentContent}" style="width:620px;"/></td>
            </tr>
            <input name="commentID" type="hidden" value="${comment.commentID}"/>
            <tr>
            <td colspan="3">
            <input type="submit" value="修改" class="opt_sub" /></td>
      		<td colspan="3">
      		<input type="reset" value="重置" class="opt_sub" /></td>
      		</tr>
      	</form>
        	</c:forEach>
        	
        	</c:otherwise>
        </c:choose>
        </table>
      </ul>
  </div>
  
  
</div>
<div id="footer">
  <%@ include file="console_element/bottom.html" %>
</div>
</body>
</html>
