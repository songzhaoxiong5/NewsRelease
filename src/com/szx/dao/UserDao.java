package com.szx.dao;

import com.szx.bean.News_User;

public interface UserDao extends CommonDao<News_User> {
	public boolean userLogin();
}
