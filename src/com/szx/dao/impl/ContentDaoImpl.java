package com.szx.dao.impl;
import java.io.Serializable;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.szx.util.*;
import com.szx.bean.*;
import com.szx.dao.ContentDao;
public class ContentDaoImpl extends BaseDao implements ContentDao {

	@Override
	public int add(News_Content content) {
		// TODO Auto-generated method stub
		String sql="insert into news_content(topicID,contentTitle,contentSummary,author,content,url) values(?,?,?,?,?,?)";
		Object[] params={content.getTopicID(),content.getContentTitle(),content.getContentSummary(),content.getAuthor(),content.getContent(),content.getUrl()};
		int rowNum=super.executeUpdate(sql, params);
		return rowNum;
	}

	@Override
	public int deleteById(Serializable id) {
		// TODO Auto-generated method stub
		String sql="delete from news_content where contentID=?";
		Object[] params={id};
		return executeUpdate(sql,params);
	}

	@Override
	public int update(News_Content content) {
		// TODO Auto-generated method stub
		String sql="update news_content set topicID=?,contentTitle=?,contentSummary=?,author=?,content=? where contentID=?";
		Object[] params={content.getTopicID(),content.getContentTitle(),content.getContentSummary(),content.getAuthor(),content.getContent(),content.getContentID()};
		int rowNum=executeUpdate(sql,params);
		return rowNum;
	}

	@Override
	public List<News_Content> selectAll() {
		// TODO Auto-generated method stub
		List<News_Content> list = new ArrayList<>();
		String sql = "select * from news_content";
		rs = executeQuery(sql);
		list=ResultSetUtil.eachResultSet(rs, News_Content.class);
		return list;
	}

	@Override
	public News_Content selectOne(Object... object) {
		// TODO Auto-generated method stub
		return null;
	}
	public News_Content selectSpecific(int id){
		News_Content content=null;
		String sql="select * from news_content where contentID=?";
		Object[] params={id};
		rs=executeQuery(sql,params);
		content=ResultSetUtil.setSingle(rs, News_Content.class);
		return content;
	}
	
	public List<News_Content> selectByID(Serializable id){
		List<News_Content> list=new ArrayList<News_Content>();
		String sql="select * from news_content where contentID=?";
		Object[] params={id};
		rs=executeQuery(sql,params);
		list=ResultSetUtil.eachResultSet(rs, News_Content.class);
		return list;
	}
	
	public List<News_Content> selectByTopicID(int id){
		List<News_Content> list=null;
		String sql="select * from news_content where topicID=?";
		Object[] params={id};
		rs=executeQuery(sql,params);
		list=ResultSetUtil.eachResultSet(rs, News_Content.class);
		return list;
	}
	
	public List<News_Content> selectFiniteByTopicID(int id,int begin,int num){
		List<News_Content> list=null;
		String sql="select * from news_content where topicID=? order by releaseTime desc limit ?,?";
		Object[] params={id,begin,num};
		rs=executeQuery(sql,params);
		list=ResultSetUtil.eachResultSet(rs, News_Content.class);
		return list;
	}

	@Override
	public int getTotalCount(Integer topicID) {
		// TODO Auto-generated method stub
		int count=-1;
		String sql="select count(contentID) from news_content where topicID=?";
		Object[] params={topicID};
		rs=executeQuery(sql,topicID);
		try {
			if(rs.next()){
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public List<News_Content> getPageNewsList(Integer pageNo, Integer pageSize, Integer topicID) {
		// TODO Auto-generated method stub
		List<News_Content> newsList=new ArrayList<>();
		String sql="select * from news_content where topicID=? order by releaseTime desc limit ?,?";
		Object[] params={topicID,(pageNo-1)*pageSize,pageSize};
		rs=executeQuery(sql,params);
		newsList=ResultSetUtil.eachResultSet(rs, News_Content.class);
		return newsList;
	}
	
	
	
}
