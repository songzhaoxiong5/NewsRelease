package com.szx.service;

import java.io.Serializable;
import java.util.List;
import com.szx.bean.*;
import com.szx.dao.impl.*;

public interface CommentService {
	/**
	 * 对象的新增
	 * @param t   用户前端传递过来的对象
	 */
	public int add(News_Comment comment);

	/**
	 * 根据参数删除相应的对象
	 * @param id  用户前端传递过来的用户名
	 */
	public void deleteById(Serializable id);

	/**
	 * 修改指定的对象
	 * @param t 用户前端传递过来的对象
	 */
	public void update(News_Comment comment);

	/**
	 * 查询所有的对象
	 * @return 对象集合
	 */
	public List<News_Comment> selectAll();
	/**
	 * 
	 * @param object查找依据，为不定长参数
	 * @return 返回一个特定类型的对象
	 */
	public News_Comment selectOne(Object ...object);
	
	public List<News_Comment> selectByNewsID(int id);
	
	public int deleteByNewsID(Serializable id);
}
