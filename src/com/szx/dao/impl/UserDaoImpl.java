package com.szx.dao.impl;
import java.io.Serializable;
import java.sql.SQLException;
import java.util.*;

import com.szx.util.*;
import com.szx.bean.News_User;
import com.szx.dao.*;
public class UserDaoImpl extends BaseDao implements UserDao {

	@Override
	public int add(News_User t) {
		// TODO Auto-generated method stub
		int result=0;
		try{
			String sql="Insert into News_Users(`uname`,upwd,utype) values(?,?,?)";
			result=executeUpdate(sql,t.getUname(),t.getUpwd(),t.getUtype());
		}catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int deleteById(Serializable id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(News_User t) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<News_User> selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public News_User selectOne(Object...object) {
		// TODO Auto-generated method stub
		String sql = "select * from news_users where uname=? and upwd=?";
		rs = executeQuery(sql,(String)object[0],(String)object[1]);
		News_User user=null;
		try {
			if(rs.next()){
				user=new News_User();
					user.setUname(rs.getString("uname"));
					user.setUpwd(rs.getString("upwd"));
					return user;
				} 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}finally{
			BaseDao.closeConnection();
		}
		
		
		return null;
	}

	@Override
	public boolean userLogin() {
		// TODO Auto-generated method stub
		return false;
	}
	public News_User selectByID(int id){
		News_User user=null;
		String sql="select * from news_user where userId=?";
		Object[] params={id};
		rs=executeQuery(sql,params);
		user=ResultSetUtil.setSingle(rs, News_User.class);
		return user;
	}
}
