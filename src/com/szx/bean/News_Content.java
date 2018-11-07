package com.szx.bean;

import java.util.Date;

public class News_Content {
	private int contentID;
	private int topicID;
	private String contentTitle;
	private String contentSummary;
	private String author;
	private String content;
	private Date releaseTime;
	private String url;
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getTopicID() {
		return topicID;
	}
	public void setTopicID(int topicID) {
		this.topicID = topicID;
	}
	public int getContentID() {
		return contentID;
	}
	public void setContentID(int contentID) {
		this.contentID = contentID;
	}
	public String getContentTitle() {
		return contentTitle;
	}
	public void setContentTitle(String contentTitle) {
		this.contentTitle = contentTitle;
	}
	public String getContentSummary() {
		return contentSummary;
	}
	public void setContentSummary(String contentSummary) {
		this.contentSummary = contentSummary;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getReleaseTime() {
		return releaseTime;
	}
	public void setReleaseTime(Date releaseTime) {
		this.releaseTime = releaseTime;
	}
	@Override
	public String toString() {
		return "News_Content [contentID=" + contentID + ", topicID=" + topicID
				+ ", contentTitle=" + contentTitle + ", contentSummary="
				+ contentSummary + ", author=" + author + ", content="
				+ content + ", releaseTime=" + releaseTime + ", url=" + url
				+ "]";
	}
	
	
	
	
}

