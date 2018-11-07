package com.szx.dao;

import java.io.Serializable;
import java.util.List;

import com.szx.bean.News_User;

public interface CommonDao<T> {
	/**
	 * 对象的新增
	 * @param t   用户前端传递过来的对象
	 */
	public int add(T t);

	/**
	 * 根据参数删除相应的对象
	 * @param id  用户前端传递过来的用户名
	 */
	public int deleteById(Serializable id);

	/**
	 * 修改指定的对象
	 * @param t 用户前端传递过来的对象
	 */
	public int update(T t);

	/**
	 * 查询所有的对象
	 * @return 对象集合
	 */
	public List<T> selectAll();
	/**
	 * 
	 * @param object查找依据，为不定长参数
	 * @return 返回一个特定类型的对象
	 */
	public T selectOne(Object ...object);
}
