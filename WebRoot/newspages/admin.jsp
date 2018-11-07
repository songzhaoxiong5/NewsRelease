<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.szx.bean.*,com.szx.service.impl.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
pageContext.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>编辑新闻--管理后台</title>
<link href="${pageScope.basePath}css/admin.css" rel="stylesheet" type="text/css" />
 <base href="<%=basePath%>">
</head>
<%
	News_User login = (News_User)session.getAttribute("login");
	  if (login == null){
		response.sendRedirect("../index.jsp");
	}
%>
<body>
	 <%@ include file="console_element/top.jsp" %>
	<div id="main">
	 <%@include file="console_element/left.html"%>
	  <div id="msg" style="display:none;position:absolute;z-index:5;background-color:pink; font-size:16px; padding:5px 20px;"></div>
	  <div id="opt_area"> 
	    <ul class="classlist">
	    </ul>
	     <%@ include file="console_element/pageSelection.jsp" %>
	  </div>
	<div id="footer">
  		<%@ include file="console_element/bottom.html" %>
	</div>
	
	<script type="text/javascript" src="js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="js/admin.js"></script>
</body>
</html>
