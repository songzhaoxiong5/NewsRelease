package com.szx.controller.news;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.szx.bean.News_Comment;
import com.szx.service.impl.CommentServiceImpl;

public class CommentControlServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("进入评论处理");
		PrintWriter out=response.getWriter();
	  	CommentServiceImpl commentService=new CommentServiceImpl();
	  	News_Comment comment=new News_Comment();
	  	String userName=request.getParameter("cauthor");
	  	String IP=request.getParameter("cip");
	  	String content=request.getParameter("ccontent");
	  	comment.setCommentContent(content);
	  	comment.setCommentIP(IP);
	  	comment.setUserName(userName);
	  	comment.setNewsID(Integer.parseInt(request.getParameter("contentID")));
	  	int rowNum=commentService.add(comment);
	  	String result="";
	  	if(rowNum>0){
	  		result="success";
	  	}else{
	  		result="评论添加错误，请稍后再试或联系管理员！";
	  	}
	  SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	  String date=sdf.format(new Date());
	   out.print("{\"result\":\""+result+"\",\"date\":\""+date+"\"}");
	   out.flush();
	   out.close();
	}
	
}
