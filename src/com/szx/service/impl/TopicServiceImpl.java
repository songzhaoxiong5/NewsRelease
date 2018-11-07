package com.szx.service.impl;
import java.io.Serializable;
import java.util.List;

import com.szx.dao.*;
import com.szx.dao.impl.*;
import com.szx.bean.*;
import com.szx.service.*;
public class TopicServiceImpl implements TopicService {
	TopicDaoImpl topicDao=new TopicDaoImpl();
	@Override
	public void add(News_Topic topic) {
		// TODO Auto-generated method stub
		int rowNum=topicDao.add(topic);
		if(rowNum>0){
			System.out.println("标题增加成功!");
		}else{
			System.out.println("标题增加失败！");
		}
	}

	@Override
	public void deleteById(Serializable id) {
		// TODO Auto-generated method stub
		int rowNum=topicDao.deleteById(id);
		if(rowNum>0){
			System.out.println("删除主题成功！");
		}else{
			System.out.println("删除主题失败！");
		}
	}

	@Override
	public void update(News_Topic topic) {
		// TODO Auto-generated method stub
		int rowNum=topicDao.update(topic);
		if(rowNum>0){
			System.out.println("主题修改成功！");
		}else{
			System.out.println("主题修改失败！");
		}
	}

	@Override
	public List<News_Topic> selectAll() {
		// TODO Auto-generated method stub
		return topicDao.selectAll();
	}

	@Override
	public News_Topic selectOne(Object... object) {
		// TODO Auto-generated method stub
		return null;
	}
	public News_Topic selectByName(String topicName){
		return ((TopicDaoImpl)topicDao).selectByName(topicName);
	}

	@Override
	public int findIDByName(String topicName) {
		// TODO Auto-generated method stub
		return topicDao.findIDByName(topicName);
	}

	@Override
	public List<Integer> selectAllTopicID() {
		// TODO Auto-generated method stub
		return topicDao.selectAllTopicID();
	}
	
}
