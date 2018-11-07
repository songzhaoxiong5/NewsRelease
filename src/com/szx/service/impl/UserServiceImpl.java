package com.szx.service.impl;
import java.io.Serializable;
import java.util.List;
import com.szx.bean.News_User;
import com.szx.service.*;
import com.szx.dao.*;
import com.szx.dao.impl.*;

public class UserServiceImpl implements UserService {
	UserDaoImpl userDao=new UserDaoImpl();
	@Override
	public void add(News_User user) {
		// TODO Auto-generated method stub
		int rowNum=userDao.add(user);
		if(rowNum>0){
			System.out.println("用户添加成功！");
		}else{
			System.out.println("用户添加失败！");
		}
	}

	@Override
	public void deleteById(Serializable id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(News_User user) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<News_User> selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public News_User selectOne(String userName,String password) {
		// TODO Auto-generated method stub
		return userDao.selectOne(userName,password);
	}

	@Override
	public boolean userLogin() {
		// TODO Auto-generated method stub
		return userDao.userLogin();
	}

	@Override
	public News_User selectByID(int id) {
		// TODO Auto-generated method stub
		return userDao.selectByID(id);
	}

}
