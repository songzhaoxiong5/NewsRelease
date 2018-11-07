package com.szx.bean;
import java.io.*;
public class News_Topic implements Serializable {
	private int topicID;
	private String topicName;
	public int getTopicID() {
		return topicID;
	}
	public void setTopicID(int topicID) {
		this.topicID = topicID;
	}
	public String getTopicName() {
		return topicName;
	}
	public void setTopicName(String topicName) {
		this.topicName = topicName;
	}
	@Override
	public String toString() {
		return "News_Topic [topicID=" + topicID + ", topicName=" + topicName
				+ "]";
	}
	
}
