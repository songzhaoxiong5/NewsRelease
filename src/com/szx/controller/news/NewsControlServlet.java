package com.szx.controller.news;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import com.google.gson.Gson;
import com.szx.bean.News_Comment;
import com.szx.bean.News_Content;
import com.szx.bean.News_Topic;
import com.szx.service.impl.CommentServiceImpl;
import com.szx.service.impl.ContentServiceImpl;
import com.szx.service.impl.TopicServiceImpl;
import com.szx.util.Page;

public class NewsControlServlet extends HttpServlet {
	private Logger logger=Logger.getLogger(NewsControlServlet.class);
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
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
	  	String opr=request.getParameter("opr");
	  	ContentServiceImpl contentService=new ContentServiceImpl();
	  	CommentServiceImpl commentService=new CommentServiceImpl();
	  	TopicServiceImpl topicService=new TopicServiceImpl();
	  	PrintWriter out=response.getWriter();
	  	//一定注意排除空指针异常，很容易出错
	  	if("list".equals(opr)){
	  		List<News_Topic> topicList = topicService.selectAll();
	  		if(topicList!=null){
	  			StringBuffer newsJSON=new StringBuffer("[");
		  		for(int i=0;;){
		  			List<News_Content> contentList = contentService.selectByTopicID(topicList.get(i).getTopicID());
		  			if(contentList!=null&&contentList.size()!=0){
		  				newsJSON.append("{\"topicID\":"+topicList.get(i).getTopicID()+",");
			  			newsJSON.append("\"newsList\":[");
			  			for(int j=0;;){
			  				//[{"topicID":topicID,"newsList":[{},{},{}]},{},{}]
			  				newsJSON.append("{\"contentTitle\":\""+contentList.get(j).getContentTitle().replace("\"", "&quot;")+"\",\"author\":\""+contentList.get(j).getAuthor().replace("\"", "&quot;")+"\",\"contentID\":"+contentList.get(j).getContentID()+"}");
			  				if((++j)==contentList.size()){
			  					newsJSON.append("]");
			  					break;
			  				}else{
			  					newsJSON.append(",");
			  				}
			  			}
		  			}
		  			if((++i)==topicList.size()){
		  				if(contentList!=null&&contentList.size()!=0){
		  					newsJSON.append("}");
			  				break;
		  				}else{
		  					break;
		  				}
		  			}else if(contentList!=null&&contentList.size()!=0){
		  				newsJSON.append("}");
		  			}
		  			List<News_Content> contentList1=contentService.selectByTopicID(topicList.get(i).getTopicID());//判断下一个内容集合是否为空
	  				if(contentList1!=null&&contentList1.size()!=0){
	  					newsJSON.append(",");
	  				}
		  		}
		  		newsJSON.append("]");
		  		System.out.println(newsJSON);
		  		out.print(newsJSON);
		  		out.flush();
		  		out.close();
	  		}else{
	  			out.print("\"message\":\"当前无新闻\"");
	  			out.flush();
	  			out.close();
	  		}
	  		
	  	}else if("del".equals(opr)){
	  		String contentID=request.getParameter("contentID");
	  		contentService.deleteById(contentID);
	  		response.sendRedirect("newspages/admin.jsp");
	  	}else if("add".equals(opr)){
	  		String uploadFileName="";
	  		String fieldName="";
	  		News_Content news=new News_Content();
	  		boolean isMultipart=ServletFileUpload.isMultipartContent(request);
	  		String uploadFilePath=request.getSession().getServletContext().getRealPath("upload/");
	  		File tempPatchFile=new File("C:\\Tomcat7.0\\temp\\buffer\\");
	  		if(!tempPatchFile.exists()){
	  			tempPatchFile.mkdirs();
	  		}
	  		if(isMultipart){
	  			DiskFileItemFactory factory=new DiskFileItemFactory();
	  			factory.setSizeThreshold(4096);
	  			factory.setRepository(tempPatchFile);
	  			ServletFileUpload upload=new ServletFileUpload(factory);
	  			upload.setFileSizeMax(1024*1024*5);
	  			try{
	  				List<FileItem> items=upload.parseRequest(request);
	  				Iterator<FileItem> iter=items.iterator();
	  				while(iter.hasNext()){
	  					FileItem item=(FileItem)iter.next();
	  					if(item.isFormField()){
	  						fieldName=item.getFieldName();
	  						if("ntid".equals(fieldName)){
	  							int topicID=topicService.findIDByName(item.getString("UTF-8"));
	  							news.setTopicID(topicID);
	  						}else if("ntitle".equals(fieldName)){
	  							news.setContentTitle(item.getString("UTF-8"));
	  						}else if("nauthor".equals(fieldName)){
	  							news.setAuthor(item.getString("UTF-8"));
	  						}else if("nsummary".equals(fieldName)){
	  							news.setContentSummary(item.getString("UTF-8"));
	  						}else if("ncontent".equals(fieldName)){
	  							news.setContent(item.getString("UTF-8"));
	  						}
	  					}else{
			  						String fileName=item.getName();
			  						if(fileName!=null&&!fileName.equals("")){
			  							List<String> fileType=Arrays.asList("gif","jpeg","jpg","png");
			  						String ext=fileName.substring(fileName.lastIndexOf(".")+1);
			  						if(!fileType.contains(ext)&&fileName!=null){
			  							logger.debug("上传失败，文件类型只能是gif、jpeg、jpg、png");
			  							request.setAttribute("news", news);
			  							request.getRequestDispatcher("newspages/admin.jsp").forward(request,response);
			  							return;
			  						}else{		  							
			  								File fullFile=new File(item.getName());
			  								File saveFile=new File(uploadFilePath,fullFile.getName());
			  								item.write(saveFile);		  							
			  						}
			  						}
			  							
			  					}
			  				}
			  				
			  			}catch(FileUploadBase.SizeLimitExceededException ex){
			  				logger.debug("上传失败，文件太大，全部文件的最大限制是："+upload.getSizeMax()+"bytes!");
			  				request.setAttribute("news", news);
			  				request.getRequestDispatcher("newspages/admin.jsp").forward(request,response);
			  				return;
			  			}catch(Exception e){
			  				e.printStackTrace();
			  				logger.debug("文件上传发生错误！");
			  				request.setAttribute("news", news);
			  				request.getRequestDispatcher("newspages/admin.jsp").forward(request,response);
			  				return;
			  			}
			  		}
			 contentService.add(news);
	  		response.sendRedirect("newspages/admin.jsp");
	  		return;
	  	}else if("modify".equals(opr)){
	  			String type=request.getParameter("type");  		
		  		if("content".equals(type)){
			  		String fieldName="";
			  		News_Content news=new News_Content();
			  		boolean isMultipart=ServletFileUpload.isMultipartContent(request);
			  		String uploadFilePath=request.getSession().getServletContext().getRealPath("upload/");
			  		File tempPatchFile=new File("C:\\Tomcat7.0\\temp\\buffer\\");
			  		if(!tempPatchFile.exists()){
			  			tempPatchFile.mkdirs();
			  		}
			  		if(isMultipart){
			  			DiskFileItemFactory factory=new DiskFileItemFactory();
			  			factory.setSizeThreshold(4096);
			  			factory.setRepository(tempPatchFile);
			  			ServletFileUpload upload=new ServletFileUpload(factory);
			  			upload.setFileSizeMax(1024*1024*5);
			  			try{
			  				List<FileItem> items=upload.parseRequest(request);
			  				Iterator<FileItem> iter=items.iterator();
			  				while(iter.hasNext()){
			  					FileItem item=(FileItem)iter.next();
			  					if(item.isFormField()){
			  						fieldName=item.getFieldName();
			  						if("ntid".equals(fieldName)){
			  							int topicID=topicService.findIDByName(item.getString("UTF-8"));
			  							news.setTopicID(topicID);
			  						}else if("ntitle".equals(fieldName)){
			  							news.setContentTitle(item.getString("UTF-8"));
			  						}else if("nauthor".equals(fieldName)){
			  							news.setAuthor(item.getString("UTF-8"));
			  						}else if("nsummary".equals(fieldName)){
			  							news.setContentSummary(item.getString("UTF-8"));
			  						}else if("ncontent".equals(fieldName)){
			  							news.setContent(item.getString("UTF-8"));
			  						}else if("newsID".equals(fieldName)){
			  							news.setContentID(Integer.parseInt(item.getString("UTF-8")));
			  						}
			  					}else{
			  						String fileName=item.getName();
			  						if(fileName!=null&&!fileName.equals("")){
			  							List<String> fileType=Arrays.asList("gif","jpeg","jpg","png");
			  						String ext=fileName.substring(fileName.lastIndexOf(".")+1);
			  						if(!fileType.contains(ext)&&fileName!=null){
			  							logger.debug("上传失败，文件类型只能是gif、jpeg、jpg、png");
			  							request.setAttribute("news", news);
			  							request.getRequestDispatcher("newspages/admin.jsp").forward(request,response);
			  							return;
			  						}else{		  							
			  								File fullFile=new File(item.getName());
			  								File saveFile=new File(uploadFilePath,fullFile.getName());
			  								item.write(saveFile);		  							
			  						}
			  						}
			  							
			  					}
			  				}
			  				
			  			}catch(FileUploadBase.SizeLimitExceededException ex){
			  				logger.debug("上传失败，文件太大，全部文件的最大限制是："+upload.getSizeMax()+"bytes!");
			  				request.setAttribute("news", news);
			  				request.getRequestDispatcher("newspages/admin.jsp").forward(request,response);
			  				return;
			  			}catch(Exception e){
			  				e.printStackTrace();
			  				logger.debug("文件上传发生错误！");
			  				request.setAttribute("news", news);
			  				request.getRequestDispatcher("newspages/admin.jsp").forward(request,response);
			  				return;
			  			}
			  		}
			  		contentService.update(news);
			  		response.sendRedirect("newspages/admin.jsp");
			  		return;
		  		}else if("comment".equals(type)){
		  			News_Comment comment=new News_Comment();
		  			String author=request.getParameter("cauthor");
		  			String IP=request.getParameter("cip");
		  			String commentTime=request.getParameter("time");
		  			String commentContent=request.getParameter("comment");
		  			String commentID=request.getParameter("commentID");
		  			comment.setCommentContent(commentContent);
		  			comment.setCommentID(Integer.parseInt(commentID));
		  			comment.setCommentIP(IP);
		  			SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" ); 
		  			try {
						comment.setCommentTime(sdf.parse(commentTime));
					} catch (Exception e) {
						// TODO Auto-generated catch block
						logger.debug("时间解析错误!");
						e.printStackTrace();
					}
		  			comment.setUserName(author);
		  			commentService.update(comment);
		  			response.sendRedirect("newspages/admin.jsp");
		  		}
		  	
	  	}else if("ajaxShowList".equals(opr)){
	  		String topicName=request.getParameter("topicName");
	  		int topicID=topicService.findIDByName(topicName);
	  		int pageIndex=Integer.parseInt(request.getParameter("pageIndex"));
	  		Page pageObj=new Page();
	  	  	pageObj.setCurrentPageNo(pageIndex);
	  	  	pageObj.setPageSize(15);
	  		List<News_Content> list=null;
	  		pageObj.setNewsList(list);
	  		contentService.findPageContent(pageObj, topicID);
	  		Gson gson=new Gson();
	  		String newsJson=gson.toJson(pageObj);
	  		String json="[{\"topicName\":\""+topicName+"\"},"+newsJson+"]";
	  		System.out.println(json);
	  		out.print(json);
	  	}
	
}
}
