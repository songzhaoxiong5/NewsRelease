package com.szx.dao.impl;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.io.*;
import com.szx.bean.*;
import com.szx.util.*;
import com.szx.dao.*;
public class CommentDaoImpl extends BaseDao implements CommentDao{

	@Override
	public int add(News_Comment comment) {
		// TODO Auto-generated method stub
		String sql="insert into news_comment(userName,newsID,commentIP,commentContent) values(?,?,?,?)";
		Object[] params={comment.getUserName(),comment.getNewsID(),comment.getCommentIP(),comment.getCommentContent()};
		int result=executeUpdate(sql,params);
		return result;
	}

	@Override
	public int deleteById(Serializable id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(News_Comment comment) {
		// TODO Auto-generated method stub
		String sql="update news_comment set userName=?,commentIP=?,commentTime=?,commentContent=? where commentID=?";
		Object[] params={comment.getUserName(),comment.getCommentIP(),comment.getCommentTime(),comment.getCommentContent(),comment.getCommentID()};
		int rowNum=executeUpdate(sql,params);
		return rowNum;
	}

	@Override
	public List<News_Comment> selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public News_Comment selectOne(Object... object) {
		// TODO Auto-generated method stub
		return null;
	}
	public List<News_Comment> selectByNewsID(int id){
		List<News_Comment> list=new ArrayList<News_Comment>();
		String sql="select * from news_comment where newsID=?";
		Object[] params={id};
		rs=executeQuery(sql,params);
		list=ResultSetUtil.eachResultSet(rs, News_Comment.class);
		return list;
	}

	@Override
	public int deleteCommentByNewsID(Serializable newsID) {
		// TODO Auto-generated method stub
		String sql="delete from news_comment where newsID=?";
		Object[] params={newsID};
		return executeUpdate(sql,params);
		
	}
}
