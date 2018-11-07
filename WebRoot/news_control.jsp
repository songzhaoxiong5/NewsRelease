<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="UTF-8"%>
<%@ page import="com.szx.bean.*,com.szx.service.impl.*,org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.DiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload,java.text.SimpleDateFormat"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
pageContext.setAttribute("basePath", basePath);
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
  	request.setCharacterEncoding("UTF-8");
  	String opr=request.getParameter("opr");
  	ContentServiceImpl contentService=new ContentServiceImpl();
  	CommentServiceImpl commentService=new CommentServiceImpl();
  	TopicServiceImpl topicService=new TopicServiceImpl();
  	if("del".equals(opr)){
  		String contentID=request.getParameter("contentID");
  		contentService.deleteById(contentID);
  		response.sendRedirect("newspages/admin.jsp");
  	}if("add".equals(opr)){
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
		  							//logger.debug("上传失败，文件类型只能是gif、jpeg、jpg、png");
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
		  				//logger.debug("上传失败，文件太大，全部文件的最大限制是："+upload.getSizeMax()+"bytes!");
		  				request.setAttribute("news", news);
		  				request.getRequestDispatcher("newspages/admin.jsp").forward(request,response);
		  				return;
		  			}catch(Exception e){
		  				e.printStackTrace();
		  				//logger.debug("文件上传发生错误！");
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
		  							//logger.debug("上传失败，文件类型只能是gif、jpeg、jpg、png");
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
		  				//logger.debug("上传失败，文件太大，全部文件的最大限制是："+upload.getSizeMax()+"bytes!");
		  				request.setAttribute("news", news);
		  				request.getRequestDispatcher("newspages/admin.jsp").forward(request,response);
		  				return;
		  			}catch(Exception e){
		  				e.printStackTrace();
		  				//logger.debug("文件上传发生错误！");
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
					//logger.debug("时间解析错误!");
					e.printStackTrace();
				}
	  			comment.setUserName(author);
	  			commentService.update(comment);
	  		}
	  	
  	}
  
  
   %>
  <body>
  </body>
</html>
