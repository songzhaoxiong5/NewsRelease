package com.szx.dao;
import com.szx.bean.*;
import java.util.*;
public interface TopicDao extends CommonDao<News_Topic>{
	public List<Integer> selectAllTopicID();
}
