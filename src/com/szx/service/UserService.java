package com.szx.service;

import java.io.Serializable;
import java.util.List;
import com.szx.bean.*;

public interface UserService {
	/**
	 * 对象的新增
	 * @param t   用户前端传递过来的对象
	 */
	public void add(News_User user);

	/**
	 * 根据参数删除相应的对象
	 * @param id  用户前端传递过来的用户名
	 */
	public void deleteById(Serializable id);

	/**
	 * 修改指定的对象
	 * @param t 用户前端传递过来的对象
	 */
	public void update(News_User user);

	/**
	 * 查询所有的对象
	 * @return 对象集合
	 */
	public List<News_User> selectAll();
	/**
	 * 
	 * @param object查找依据，为不定长参数
	 * @return 返回一个特定类型的对象
	 */
	public News_User selectOne(String userName,String password);
	
	public boolean userLogin();
	public News_User selectByID(int id);
}
