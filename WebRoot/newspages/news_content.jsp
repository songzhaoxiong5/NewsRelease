<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.szx.bean.*,com.szx.service.impl.*" %>
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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<title>新闻中国</title>
	<link href="${pageScope.basePath}css/read.css" rel="stylesheet" type="text/css" />

</head>
<%	
	request.setCharacterEncoding("UTF-8");
	String message=(String)request.getAttribute("message");
	String uname=request.getParameter("uname");
	String upwd=request.getParameter("upwd");
	News_User user=(News_User)session.getAttribute("login");
	News_Content content=(News_Content)request.getAttribute("content");
	ArrayList<News_Comment> commentList=(ArrayList<News_Comment>)request.getAttribute("commentList");
	if(content==null&&commentList==null){
		response.sendRedirect("../news_init_index.jsp");
	}
 %>
<body>
<%@ include file="console_element/top.html" %>
<div id="container">
  <div class="sidebar">
    <h1> <img src="<%=basePath%>images/title_1.gif" alt="国内新闻" /> </h1>
    <div class="side_list">
      <ul>
        <li> <a href='#'><b> 重庆涉黑富豪黎强夫妇庭审答辩言辞相互矛盾 </b></a> </li>
        <li> <a href='#'><b> 发改委：4万亿投资计划不会挤占民间投资空间 </b></a> </li>
        <li> <a href='#'><b> 河南2个乡镇政绩报告内容完全一致引关注 </b></a> </li>
      </ul>
    </div>
    <h1> <img src="<%=basePath%>images/title_2.gif" alt="国际新闻" /> </h1>
    <div class="side_list">
      <ul>
        <li> <a href='#'><b> 日本首相鸠山首次全面阐述新政府外交政策 </b></a> </li>
        <li> <a href='#'><b> 黎巴嫩以色列再次交火互射炮弹 </b></a> </li>
        <li> <a href='#'><b> 伊朗将于30日前就核燃料供应方案作出答复 </b></a> </li>
        <li> <a href='#'><b> 与基地有关组织宣称对巴格达连环爆炸负责 </b></a> </li>
      </ul>
    </div>
    <h1> <img src="<%=basePath%>images/title_3.gif" alt="娱乐新闻" /> </h1>
    <div class="side_list">
      <ul>
        <li> <a href='#'><b> 施瓦辛格启动影视业回迁计划 推进加州经济复苏 </b></a> </li>
        <li> <a href='#'><b> 《沧海》导演回应观众质疑 自信能超越《亮剑》 </b></a> </li>
        <li> <a href='#'><b> 《海角七号》导演新片开机 吴宇森等出席 </b></a> </li>
        <li> <a href='#'><b> 《四大名捕》敦煌热拍 八主演飙戏火花四溅 </b></a> </li>
      </ul>
    </div>
  </div>
  <div class="main">
    <div class="class_type"> <img src="<%=basePath%>images/class_type.gif" alt="新闻中心" /> </div>
    <div class="content">
      <ul class="classlist">
        <table width="80%" align="center">
          <tr width="100%">
            <td colspan="2" align="center"><%=content.getContentTitle() %></td>
          </tr>
          <tr>
            <td colspan="2"><hr />
            </td>
          </tr>
          <tr>
            <td align="center"><%=content.getReleaseTime() %></td>
            <td align="left"><%=content.getAuthor()%> </td>
          </tr>
          <tr>
            <td colspan="2" align="center"></td>
          </tr>
          <tr>
            <td colspan="2"> <%=content.getContent() %> </td>
          </tr>
          <tr>
            <td colspan="2"><hr />
            </td>
          </tr>
        </table>
      </ul>
      <ul class="classlist">
        <table width="80%" align="center">
        <c:choose>
        	<c:when test="${ empty requestScope.commentList}">
        		<td  id="noComment" colspan="6"> 暂无评论！ </td>
          		<tr id="horizontal">
            	<td   colspan="6"><hr/>
           		 </td>
         		</tr>
        	</c:when>
        	<c:otherwise>
        		<c:forEach var="comment" items="${requestScope.commentList}" varStatus="status">
        			<tr>
              <td> 留言人： 
              <input  readonly name="cauthor" value="${comment.userName}"/></td>
                <td>IP：
                <input name="cip" readonly value="${comment.commentIP}" readonly="readonly"/>
              </td>
              <td>留言时间：
              	<input name="time"  readonly value="${comment.commentTime}"/>
              </td>
            </tr>
            <tr>
            	<td colspan="6">留言内容：
            	</td>
            </tr>
            <tr>
            	<td colspan="6">
            	<input name="comment"  readonly value="${comment.commentContent}" style="width:620px;"/></td>
            </tr>
        		</c:forEach>
        	</c:otherwise>
        </c:choose>
        </table>
      </ul>
      <ul class="classlist">
        <form action="" method="post" >
          <table width="80%" align="center">
            <tr>
              <td> 评 论 </td>
            </tr>
            <tr>
              <td> 用户名： </td>
              <td><input id="cauthor" name="cauthor"  value="请输入您的留言姓名"/>
                IP：
                <input id="cip" name="cip"  value="${pageContext.request.remoteAddr}" readonly="readonly"/>
              </td>
            </tr>
            <tr>
              <td colspan="2"><textarea name="ccontent" cols="70" rows="10" id="ccontent"></textarea>
              </td>
            </tr>
            <td><input name="submit" value="发  表" type="button" id="commentSubmit"/>
              </td>
          </table>
          <input type="hidden" value="<%=content.getContentID()%>" name="contentID"/>
        </form>
      </ul>
    </div>
  </div>
</div>
<div id="friend">
  <h1 class="friend_t"> <img src="<%=basePath%>images/friend_ico.gif" alt="合作伙伴" /> </h1>
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
  <%@ include file="console_element/bottom.html" %>
</div>
<script type="text/javascript" src="js/jquery-3.2.1.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		function check(){
			var $cauthor=$("#cauthor");
			var $content=$("#ccontent");
			if($cauthor.val()==""){
				alert("用户名不能为空！");
				return false;
			}else if($content.val()==""){
				alert("评论内容不能为空！");
				return false;
			}
			return true;
		}
		var $formArea=$("ul.classlist").eq(2);//定位提交表单的位置
		var $commentInputs=$formArea.find(":input");//获取表单集合
		var $commentArea=$formArea.prev("ul").children();//定位到展示评论的table
		$("#commentSubmit").click(function(){
			if(check()){
				var paramsArray=$commentInputs.serializeArray();
				var queryString=$.param(paramsArray);
				$.post("comment",queryString,afterComment,"JSON");
			}
			function afterComment(data){
			if(data.result=="success"){
				var $newComment=$("<tr><td> 留言人： <input  readonly name='cauthor' value='"+$("#cauthor").val()+"'/></td><td>IP："
       							+"<input name='cip' readonly  value='"+$("#cip").val()+"'/></td><td>留言时间：<input name='time' readonly value='"+data.date+"'/>"
              					+"</td></tr><tr><td colspan='6'>留言内容：</td></tr><tr><td colspan='6'>"
            					+"<input name='comment' readonly  value='"+$("#ccontent").val()+"' style='width:620px;''/></td></tr>");
				$commentArea.prepend($newComment);
				$("#noComment").remove();
				$("#horizontal").remove();
				$("#cauthor").val("");
				$("#ccontent").val("");
			}else{
				alert(data.result);
			}
		}
		});
		
	});
	  		
</script>
</body>
</html>