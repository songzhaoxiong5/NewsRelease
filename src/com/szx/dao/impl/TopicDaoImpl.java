package com.szx.dao.impl;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.szx.bean.News_Topic;
import com.szx.dao.TopicDao;
import com.szx.util.BaseDao;
import com.szx.util.ResultSetUtil;

public class TopicDaoImpl extends BaseDao implements TopicDao {

	@Override
	public int add(News_Topic topic) {
		// TODO Auto-generated method stub
		String sql="insert into news_topic(topicName) values(?)";
		Object[] params={topic.getTopicName()};
		int result=executeUpdate(sql,params);
		return result;
	}

	@Override
	public int deleteById(Serializable id) {
		// TODO Auto-generated method stub
		String sql="delete from news_topic where topicID=?";
		Object[] params={id};
		int result=executeUpdate(sql,params);		
		return result;
	}

	@Override
	public int update(News_Topic topic) {
		// TODO Auto-generated method stub
		String sql="update News_Topic set topicName=? where topicID=?";
		Object[] params={topic.getTopicName(),topic.getTopicID()};
		int result=executeUpdate(sql,params);
		return result;
	}

	@Override
	public List<News_Topic> selectAll() {
		// TODO Auto-generated method stub
		List<News_Topic> list = new ArrayList<>();
		String sql = "select * from news_topic";
		rs = executeQuery(sql);
		list=ResultSetUtil.eachResultSet(rs, News_Topic.class);
		return list;
	}

	@Override
	public News_Topic selectOne(Object... object) {
		// TODO Auto-generated method stub
		return null;
	}
	public News_Topic selectByName(String topicName){
		News_Topic topic=null;
		String sql="select * from news_topic where topicName=?";
		Object[] params={topicName};
		rs=executeQuery(sql,params);
		try{
			if(rs.next()){
				topic=new News_Topic();
				topic.setTopicID(rs.getInt("topicID"));
				topic.setTopicName(rs.getString("topicName"));
			}
			BaseDao.closeConnection();
		}catch(Exception e){
			e.printStackTrace();
		}
		return topic;
	
	}
	
	
	public int findIDByName(String topicName){
		int topicID=0;
		String sql="select topicID from News_Topic where topicName=?";
		Object[] params={topicName};
		rs=executeQuery(sql,params);
		try{
			if(rs.next()){
				topicID=rs.getInt("topicID");
			}
			BaseDao.closeConnection();
		}catch(Exception e){
			e.printStackTrace();
		}
		return topicID;
	}

	@Override
	public List<Integer> selectAllTopicID() {
		List<Integer> list=new ArrayList<>();
		String sql="select topicID from News_Topic";
		rs=executeQuery(sql);
		try {
			while(rs.next()){
				list.add(rs.getInt("topicID"));
			}
			BaseDao.closeConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}

