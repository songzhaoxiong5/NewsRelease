<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	request.setCharacterEncoding("UTF-8");
	String redundancy=request.getParameter("redundancy");
	pageContext.setAttribute("basePath", basePath);
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Topic Addition</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageScope.basePath}css/admin.css">


  </head>
  <body>
<%@ include file="console_element/top.jsp" %>  
<div id="main">
<%@ include file="console_element/left.html" %>  
  <div id="opt_area">
    <h1 id="opt_type"> 添加主题： </h1>
    <form action="" method="get">
      <p>
        <label> 主题名称 </label>
        <input name="tname" type="text" class="opt_input" id="tname" value="${empty param.redundancy?'':param.redundancy}"/>
      </p>
      <input name="action" type="hidden" value="addtopic"/>
      <input type="button" value="提交" class="opt_sub" id="addTopicSubmit"/>
      <input type="reset" value="重置" class="opt_sub" onclick="clear()"/>
    </form>
  </div>
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
<div id="footer">
  <%@ include file="console_element/bottom.html" %>
</div>
</body>
</html>
