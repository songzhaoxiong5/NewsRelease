package com.szx.bean;

import java.util.Date;

public class News_Comment {
	private int commentID;
	private String userName;
	private int newsID;
	private String commentIP;
	private Date commentTime;
	private String commentContent;
	public int getCommentID() {
		return commentID;
	}
	public void setCommentID(int commentID) {
		this.commentID = commentID;
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getNewsID() {
		return newsID;
	}
	public void setNewsID(int newsID) {
		this.newsID = newsID;
	}
	public String getCommentIP() {
		return commentIP;
	}
	public void setCommentIP(String commentIP) {
		this.commentIP = commentIP;
	}
	public Date getCommentTime() {
		return commentTime;
	}
	public void setCommentTime(Date commentTime) {
		this.commentTime = commentTime;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	
	
}


