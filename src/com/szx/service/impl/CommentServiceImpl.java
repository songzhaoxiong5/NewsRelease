package com.szx.service.impl;
import java.io.Serializable;
import java.util.List;
import com.szx.dao.impl.*;
import com.szx.bean.News_Comment;
import com.szx.service.*;
import org.apache.log4j.*;
public class CommentServiceImpl implements CommentService {
	private Logger logger=Logger.getLogger(CommentServiceImpl.class);
	CommentDaoImpl commentDao=new CommentDaoImpl();
	@Override
	public int add(News_Comment comment) {
		// TODO Auto-generated method stub
		int rowNum=commentDao.add(comment);
		return rowNum;
	}

	@Override
	public void deleteById(Serializable id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(News_Comment comment) {
		// TODO Auto-generated method stub
		int rowNum=commentDao.update(comment);
		if(rowNum>0){
			logger.debug("更新评论成功！");
		}else{
			logger.debug("更新评论失败!");
		}
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

	@Override
	public List<News_Comment> selectByNewsID(int id) {
		// TODO Auto-generated method stub
		return commentDao.selectByNewsID(id);
	}

	@Override
	public int deleteByNewsID(Serializable id) {
		// TODO Auto-generated method stub
		return commentDao.deleteCommentByNewsID(id);
	}

}
