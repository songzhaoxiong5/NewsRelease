package com.szx.dao;
import com.szx.bean.*;
import java.util.*;
public interface ContentDao extends CommonDao<News_Content> {
	public int getTotalCount(Integer topicID);
	public List<News_Content> getPageNewsList(Integer pageNo, Integer pageSize, Integer topicID);
	
}
