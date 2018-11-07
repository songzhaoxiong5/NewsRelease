package com.szx.service.impl;
import java.io.Serializable;
import java.util.List;
import org.apache.log4j.*;
import com.szx.bean.*;
import com.szx.dao.impl.*;
import com.szx.service.*;
import com.szx.util.Page;
import java.util.*;
public class ContentServiceImpl implements ContentService {
	private Logger logger=Logger.getLogger(ContentServiceImpl.class);
	CommentDaoImpl commentDao=new CommentDaoImpl();
	ContentDaoImpl contentDao=new ContentDaoImpl();
	@Override
	public void add(News_Content content) {
		// TODO Auto-generated method stub
		int rowNum=contentDao.add(content);
		if(rowNum>0){
			logger.debug("新闻添加成功！");
		}else{
			logger.debug("新闻添加失败！");
		}
		
	}

	@Override
	public void deleteById(Serializable id) {
		// TODO Auto-generated method stub
		commentDao.deleteCommentByNewsID(id);
		contentDao.deleteById(id);
		
	}

	@Override
	public void update(News_Content content) {
		// TODO Auto-generated method stub
		int rowNum=contentDao.update(content);
		if(rowNum>0){
			logger.debug("新闻内容修改成功!");
		}else{
			logger.debug("新闻内容修改失败！");
		}
	}

	@Override
	public List<News_Content> selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public News_Content selectOne(Object... object) {
		// TODO Auto-generated method stub
		return null;
	}
	public List<News_Content> selectByID(Serializable id){
		return contentDao.selectByID(id);
	}

	@Override
	public List<News_Content> selectByTopicID(int id) {
		// TODO Auto-generated method stub
		return contentDao.selectByTopicID(id);
	}

	@Override
	public List<News_Content> selectFiniteByTopicID(int id,int begin,int num) {
		// TODO Auto-generated method stub
		return contentDao.selectFiniteByTopicID(id,begin,num);
	}

	@Override
	public News_Content selectSpecific(int id) {
		// TODO Auto-generated method stub
		return contentDao.selectSpecific(id);
	}

	@Override
	public void findPageContent(Page pageObj,Integer topicID) {
		// TODO Auto-generated method stub
		int totalCount=contentDao.getTotalCount(topicID);
		pageObj.setTotalCount(totalCount);
		if(totalCount>0){
			if(pageObj.getCurrentPageNo()>pageObj.getTotalPageCount()){
				pageObj.setCurrentPageNo(pageObj.getTotalPageCount());
			}
			List<News_Content> newsList=contentDao.getPageNewsList(pageObj.getCurrentPageNo(), pageObj.getPageSize(), topicID);
			pageObj.setNewsList(newsList);
		}else{
			pageObj.setCurrentPageNo(0);
			pageObj.setNewsList(new ArrayList<News_Content>());
		}
	}

	
}
