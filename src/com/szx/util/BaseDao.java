package com.szx.util;

import java.sql.*;

import javax.naming.*;
import javax.sql.DataSource;

import com.szx.util.ConfigManager;

public class BaseDao {
	/**
	 * 所有dao中公共的属性
	 */
	protected static Connection con = null; // 连接对象
	protected static PreparedStatement stmt = null; // 执行sql语句的对象
	protected static ResultSet rs = null; // 返回的结果集

	/**
	 * 所有dao中公共的连接数据库的方法
	 */
	protected static boolean getConnection() {
		try {
			
			// 1.使用反射机制加载驱动包
			Class.forName(ConfigManager.getInstance().getValue("jdbc.driver"));
			// 2.创建与数据库的连接
			con = DriverManager.getConnection(ConfigManager.getInstance()
					.getValue("jdbc.url"), ConfigManager.getInstance()
					.getValue("jdbc.userName"), ConfigManager.getInstance()
					.getValue("jdbc.password"));
//			Context ctx=new InitialContext();
//			DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/news");
//			con=ds.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}

	/**
	 * 释放资源的公共方法
	 */
	protected static boolean closeConnection() {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	/**
	 * 所有增删改的方法
	 * 01.不知道有没有参数
	 * 02.不知道参数的类型
	 * 
	 * 用户传递给我们一个sql语句！根据sql中是否有参数进行赋值！
	 * 
	 */
	protected static int executeUpdate(String sql, Object... params) {
		// 定义影响的行数
		int rowNum = 0;
		if (getConnection()) {// 获取连接
			try {
				stmt = con.prepareStatement(sql);
				// 循环给我们的参数赋值
				for (int i = 0; i < params.length; i++) {
					stmt.setObject(i + 1, params[i]);
				}
				rowNum = stmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				// 释放资源
				closeConnection();
			}
		}
		return rowNum;
	}

	/**
	 * 所有的查询操作
	 * @param sql   用户传递的sql
	 * @param params  可能出现的参数
	 * @return   结果集
	 */
	protected static ResultSet executeQuery(String sql, Object... params) {
		if (getConnection()) {// 获取连接
			try {
				stmt = con.prepareStatement(sql);
				// 循环给我们的参数赋值
				for (int i = 0; i < params.length; i++) {
					stmt.setObject(i + 1, params[i]);
				}
				rs = stmt.executeQuery();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rs;
	}
}
