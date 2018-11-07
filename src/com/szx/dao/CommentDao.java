package com.szx.dao;
import com.szx.bean.*;
import java.io.*;
public interface CommentDao extends CommonDao<News_Comment> {
	public int deleteCommentByNewsID(Serializable id);
}
