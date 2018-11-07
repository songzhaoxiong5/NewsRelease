<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
pageContext.setAttribute("basePath", basePath);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>标题修改页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageScope.basePath}css/admin.css">

  </head>
  <%
  	String tname=request.getParameter("topicName");
  	String tid=request.getParameter("topicID"); 
	 
  %>
  <body>
  <%@ include file="console_element/top.jsp" %>
 <div id="main">
 <%@include file="console_element/left.html"%>
  <div id="opt_area">
    <h1 id="opt_type"> 修改主题： </h1>
    <form action="" method="get" onsubmit="return check()">
      <p>
        <label> 主题名称 </label>
        <input name="tname" type="text" class="opt_input" value="${param.topicName}" id="tname"/>
        <input name="tid" type="hidden" value="${param.topicID}" id="tid">
      </p>
      <input name="action" type="hidden" value="addtopic">
      <input type="button" value="提交" class="opt_sub" id="modifySubmitButton"/>
      <input type="reset" value="重置" class="opt_sub" onclick="clear()"/>
    </form>
  </div>
</div>
<div id="footer">
  <%@ include file="console_element/bottom.html" %>
</div>
<script type="text/javascript">
	function check(){
  		if(document.getElementById("tname").value==""){
  			alert("您的输入不能为空！");
  			return false;
  		}
  		return true;
  	}
	function clear(){
  		var tName=document.getElementById("tname");
  		if(tName.value!=""){
  			tName.value="";
  		}
  	}
</script>
  </body>
</html>
