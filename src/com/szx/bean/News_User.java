package com.szx.bean;
import java.io.*;

public class News_User implements Serializable{
	private int uid;
	private String uname;
	private String upwd;
	private int utype;
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUpwd() {
		return upwd;
	}
	public void setUpwd(String upwd) {
		this.upwd = upwd;
	}
	public int getUtype() {
		return utype;
	}
	public void setUtype(int utype) {
		this.utype = utype;
	}
	@Override
	public String toString() {
		return "News_User [uid=" + uid + ", uname=" + uname + ", upwd=" + upwd
				+ ", utype=" + utype + "]";
	}
}



/*
uid INT(8) PRIMARY KEY NOT NULL COMMENT '用户编号',
	uname VARCHAR(16) NOT NULL DEFAULT 'admin' COMMENT  '用户名称',
	upwd VARCHAR(128) NOT NULL DEFAULT 'admin' COMMENT  '用户密码',
	utype INT(8) NOT NULL DEFAULT 0 COMMENT '用户类型：0 管理员 1 普通用户'
*/