<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.szx.bean.*" %>
<%@ page import="com.szx.util.*"%>
<%@ page import="com.szx.service.*" %>
<%@ page import="com.szx.service.impl.*" %>
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
	String opr=request.getParameter("opr");
	TopicServiceImpl topicService=new TopicServiceImpl();
	ContentServiceImpl contentService=new ContentServiceImpl();
	if("showAll".equals(opr)){
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
	}else if("add".equals(opr)){
		String topicName=request.getParameter("tname");
		if(topicService.selectByName(topicName)!=null){
		%>
	<script type="text/javascript">
		alert("该主题已经存在！");
		location.href="<%=basePath%>newspages/topic_add.jsp?redundancy=<%=topicName%>";
	</script>
	<% 
		}else{
			News_Topic topic=new News_Topic();
			topic.setTopicName(topicName);
			topicService.add(topic);
			List<News_Topic> topicList=topicService.selectAll();
			application.setAttribute("topicList", topicList);
	%>	
	<script type="text/javascript">
		alert("新主题已经添加成功！");
		location.href="topic_control.jsp?opr=showAll";
	</script>	
<% 
		
		}
	}
	else if("del".equals(opr)){
	String tid=request.getParameter("tid");
	ArrayList<News_Content> list=(ArrayList<News_Content>)contentService.selectByID(tid);
	if(list.isEmpty()){
		topicService.deleteById(tid);
		List<News_Topic> topicList=topicService.selectAll();
		application.setAttribute("topicList", topicList);

%>
	<script type="text/javascript">
		alert("主题删除成功！");
		location.href="topic_control.jsp?opr=showAll";
	</script>
<% 
	}else{
%>
	<script type="text/javascript">
		alert("该主题下还有文章，不能删除！");
		location.href="topic_control.jsp?opr=showAll";
	</script>
<% 		
		
		}
}else if("modify".equals(opr)){
	String newTopicName=request.getParameter("tname");
	if(topicService.selectByName(newTopicName)!=null){
	String tid=request.getParameter("tid");
	%>

	<script type="text/javascript">
		alert("该主题已存在！");
		location.href="<%=basePath%>newspages/topic_modify.jsp?tName=<%=newTopicName%>&tid=<%=tid%>";
	</script>
<% 
	}else{
		String tid=request.getParameter("tid");
		News_Topic topic=new News_Topic();
		topic.setTopicID(Integer.parseInt(tid));
		topic.setTopicName(newTopicName);
		topicService.update(topic);
		List<News_Topic> topicList=topicService.selectAll();
		application.setAttribute("topicList", topicList);
%>
	<script type="text/javascript">
		alert("主题修改成功！");
		location.href="topic_control.jsp?opr=showAll";
	</script>
<%
		}
	
}
 %>
  <body>
  </body>
</html>
