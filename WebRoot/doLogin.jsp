<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.szx.bean.*" %>
<%@ page import="com.szx.service.*" %>
<%@ page import="com.szx.service.impl.*" %>
<%@ page import="com.szx.util.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>登录处理页面</title>
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");
        //获取请求数据,并去除空格
        String name = request.getParameter("userName").trim();
        String pwd = request.getParameter("password").trim();//这里的trim方法用来去掉输入前后的空格和一些其他特殊符号
        boolean valid = false;  //判断用户验证是否成功
        if(name==null||name.equals("")){
        	request.setAttribute("message","用户名不能为空！");
        	request.getRequestDispatcher("news_init_index.jsp").forward(request,response);
        }else if(pwd==null||pwd.equals("")){
        	request.setAttribute("message","密码不能为空！");
        	request.getRequestDispatcher("news_init_index.jsp").forward(request,response);
        }else{
        	 UserService userService=new UserServiceImpl();
        		if(userService.selectOne(name,pwd)!=null){
             	valid = true;
             	//设置用户登录信息
             	News_User user=userService.selectOne(name, pwd);
            	session.setAttribute("login",user);
             	//设置session过期时间
            	 session.setMaxInactiveInterval(10*60*60);
        }
        if (valid) {
            //request.getRequestDispatcher("newspages/admin.jsp").forward(request,response);
            response.sendRedirect(path+"/newspages/admin.jsp");
        } else {
        		request.setAttribute("message", "您输入的用户名或密码错误");
                request.getRequestDispatcher("news_init_index.jsp").forward(request,response);
        }
        
        }
        
       
    %>
    </body>
</html>
