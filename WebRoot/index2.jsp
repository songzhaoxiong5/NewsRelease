<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.szx.bean.*,com.szx.service.impl.*,com.szx.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
pageContext.setAttribute("basePath", basePath);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新闻中国</title>
<link href="css/main.css" rel="stylesheet" type="text/css" />
</head>
<% 
	request.setCharacterEncoding("UTF-8");
	String message=(String)request.getAttribute("message");
	String uname=request.getParameter("uname");
	String upwd=request.getParameter("upwd");
	ArrayList<News_Topic> list=(ArrayList<News_Topic>)request.getAttribute("list");
	ArrayList<News_Content> list1=(ArrayList<News_Content>)request.getAttribute("list1");
	ArrayList<News_Content> list2=(ArrayList<News_Content>)request.getAttribute("list2");
	ArrayList<News_Content> list3=(ArrayList<News_Content>)request.getAttribute("list3");
	ArrayList<News_Content> curList=(ArrayList<News_Content>)request.getAttribute("curList");
	if(list==null||list1==null||list2==null||list3==null||curList==null){
		request.getRequestDispatcher("news_init_index.jsp").forward(request, response);
	}
	Page pageObj=(Page)request.getAttribute("pageObj");
	pageContext.setAttribute("pageIndex", pageObj.getCurrentPageNo());
	pageContext.setAttribute("dynTopic", request.getAttribute("dynTopic"));
	pageContext.setAttribute("totalPages",pageObj.getTotalPageCount());
%>
<body>
<%@ include file="newspages/console_element/top.html" %>
<div id="container">
  <div class="sidebar">
    <h1> <img src="images/title_1.gif" alt="国内新闻" /> </h1>
    <div class="side_list">
      <ul>
      <c:choose>
      	<c:when test="${empty requestScope.list1 }">
      		<c:out value="该板块暂时无新闻"/>
      	</c:when>
      	<c:otherwise>
      		<c:forEach var="content" items="${requestScope.list1}" varStatus="status">
      			<li> <a href='#'><b> ${content.contentTitle}</b></a> </li>
      		</c:forEach>
      	</c:otherwise>
      </c:choose>
      </ul>
    </div>
    <h1> <img src="images/title_2.gif" alt="国际新闻" /> </h1>
    <div class="side_list">
      <ul>
        <c:choose>
      	<c:when test="${empty requestScope.list2 }">
      		<c:out value="该板块暂时无新闻"/>
      	</c:when>
      	<c:otherwise>
      		<c:forEach var="content" items="${requestScope.list2}" varStatus="status">
      			<li> <a href='#'><b> ${content.contentTitle}</b></a> </li>
      		</c:forEach>
      	</c:otherwise>
      </c:choose>
      </ul>
    </div>
    <h1> <img src="images/title_3.gif" alt="娱乐新闻" /> </h1>
    <div class="side_list">
      <ul>
         <c:choose>
      	<c:when test="${empty requestScope.list3 }">
      		<c:out value="该板块暂时无新闻"/>
      	</c:when>
      	<c:otherwise>
      		<c:forEach var="content" items="${requestScope.list3}" varStatus="status">
      			<li> <a href='#'><b> ${content.contentTitle}</b></a> </li>
      		</c:forEach>
      	</c:otherwise>
      </c:choose>
      </ul>
    </div>
  </div>
  <div class="main">
    <div class="class_type"> <img src="images/class_type.gif" alt="新闻中心" /> </div>
    <div class="content">
      <ul class="class_date">
      <c:forEach var="topic" items="${requestScope.list}" varStatus="status">
      	<c:choose>
      		<c:when test="${status.index % 11 == 0}">
      			<li id='class_month'><a href='javascript:;' rel='${topic.topicName}' class='topicAjax'><b> ${topic.topicName} </b></a>
      		</c:when>
      		<c:when test="${status.index % 11 == 10 }">
      			<a href='javascript:;' rel='${topic.topicName}' class='topicAjax'><b> ${topic.topicName} </b></a> </li>
      		</c:when>
      		<c:otherwise>
      			<a href='javascript:;' rel='${topic.topicName}' class='topicAjax'><b> ${topic.topicName} </b></a>
      		</c:otherwise>
      	</c:choose>
      </c:forEach>
      </ul>
      <ul class="classlist">
      	<c:choose>
      		<c:when test="${empty requestScope.curList}">
      			<c:out value="该板块暂时无新闻"/>
      		</c:when>
      		<c:otherwise>
      			<c:forEach var="content" items="${requestScope.curList}" varStatus="status">
      				<c:choose>
      					<c:when test="${status.index%5 == 4}">
      						<li><a href='news_content_control.jsp?contentID=${content.contentID}'>${content.contentTitle}</a><span>${content.releaseTime}</span></li>
        					<li class='space'></li>
      					</c:when>
      					<c:otherwise>
      						<li><a href='news_content_control.jsp?contentID=${content.contentID}'>${content.contentTitle}</a><span>${content.releaseTime}</span></li>
      					</c:otherwise>
      				</c:choose>
      			</c:forEach>
      		</c:otherwise>
      	</c:choose>
      </ul>
    </div>
    <div class="picnews">
      <ul>
        <li> <a href="#"><img src="images/Picture1.jpg" width="249" alt="" /> </a><a href="#">幻想中穿越时空</a> </li>
        <li> <a href="#"><img src="images/Picture2.jpg" width="249" alt="" /> </a><a href="#">国庆多变的发型</a> </li>
        <li> <a href="#"><img src="images/Picture3.jpg" width="249" alt="" /> </a><a href="#">新技术照亮都市</a> </li>
        <li> <a href="#"><img src="images/Picture4.jpg" width="249" alt="" /> </a><a href="#">群星闪耀红地毯</a> </li>
      </ul>
    </div>
  </div>
</div>
<div id="friend">
  <h1 class="friend_t"> <img src="images/friend_ico.gif" alt="合作伙伴" /> </h1>
  <div class="friend_list">
    <ul>
      <li> <a href="#">中国政府网</a> </li>
      <li> <a href="#">中国政府网</a> </li>
      <li> <a href="#">中国政府网</a> </li>
      <li> <a href="#">中国政府网</a> </li>
      <li> <a href="#">中国政府网</a> </li>
      <li> <a href="#">中国政府网</a> </li>
      <li> <a href="#">中国政府网</a> </li>
    </ul>
  </div>
</div>
<div id="footer">
  <p class=""> 24小时客户服务热线：010-68988888 &#160;&#160;&#160;&#160; <a href="#">常见问题解答</a> &#160;&#160;&#160;&#160; 新闻热线：010-627488888 <br />
    文明办网文明上网举报电话：010-627488888 &#160;&#160;&#160;&#160; 举报邮箱： <a href="#">jubao@jb-aptech.com.cn</a> </p>
  <p class="copyright"> Copyright &copy; 1999-2009 News China gov, All Right Reserver <br />
    新闻中国 版权所有 </p>
</div>

<script type="text/javascript" src="js/jquery-3.2.1.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var $newsArea=$("ul.classlist");
		function initPageSelection(){
			if($("#pageSelection2").length==0){
				$newsArea.append("<p align='center'id='newsArea2'>");
				var $newsArea2=$("#newsArea2");
				getPage("国内",1);
		}
		}
		$("a.topicAjax").click(function(){
			getPage($(this).attr("rel"),1);
		});
		function getPage(topicName,pageIndex){
			$.ajax({
				"url":"newscontrol",
				"type":"GET",
				"data":"opr=ajaxShowList&pageIndex="+pageIndex+"&topicName="+topicName,
				"dataType":"json",
				"success":showList
			});
		}
		function showList(data){
			var topicName=data[0].topicName=="null"?"":data[0].topicName;
			var newsList=data[1].newsList;
			$newsArea.empty();
			if(newsList==null){
				$newsArea.html("出现错误，请稍后再试或联系管理员！");
			}else if(newsList.length==0){
				$newsArea.html("当前主题下没有新闻！");
			}else{
				$(newsList).each(function(index,element){
					$newsArea.append("<li><a href='news_content_control.jsp?contentID="+this.contentID+"'>"+this.contentTitle+"</a><span>"+this.releaseTime+"</span></li>");
					if((++index)%5==0){
						$newsArea.append("<li class='space'></li>");
					}
				
				});
			}
			
			$newsArea.append("<p align='center'id='newsArea2'>");
			var $newsArea2=$("#newsArea2");
			if(data[1].totalPageCount==0){
				var $pageSelection=$("<span align='center'>当前页数：[0/"+data[1].totalPageCount+"]&nbsp;</span>").appendTo($newsArea2);
			}else{
				var $pageSelection=$("<span align='center'>当前页数：["+data[1].currentPageNo+"/"+data[1].totalPageCount+"]&nbsp;</span>").appendTo($newsArea2);
			}
			
			
			if(data[1].currentPageNo>1){
				var $first=$("<a href='javascript:;'>首页</a>").click(function(){getPage(topicName,1);});
				var $prev=$("<a href='javascript:;'>上一页</a>").click(function(){getPage(topicName,(data[1].currentPageNo-1));});
				$newsArea2.append($first).append("&nbsp;").append($prev);
			}
			if(data[1].currentPageNo<data[1].totalPageCount){
				var $next=$("<a href='javascript:;'>下一页</a>").click(function(){getPage(topicName,(data[1].currentPageNo+1));});
				var $last=$("<a href='javascript:;'>末页</a>").click(function(){getPage(topicName,data[1].totalPageCount);});
				$newsArea2.append($next).append("&nbsp;").append($last);
			}
			$newsArea.append("</p>");
		}
		initPageSelection();
	});
	

</script>

</body>
</html>
