package com.szx.util;
import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
public class ResultSetUtil {
	public static <T>  List<T> eachResultSet(ResultSet rs,Class<T> clazz){
		List<T> list=new ArrayList<>();
		try {
			while(rs.next()){
				try {
					T object=clazz.newInstance();
					Field[] fields=clazz.getDeclaredFields();
					for(Field field:fields){
						field.setAccessible(true);
						field.set(object, rs.getObject(field.getName()));
					}
					list.add(object);
				} catch (InstantiationException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			BaseDao.closeConnection();
		}
		return list;
	}
	public static <T> T setSingle(ResultSet rs, Class<T> clazz){
		T object=null;
		try{
			if(rs.next()){
				object=clazz.newInstance();
				Field[] fields=clazz.getDeclaredFields();
				for(Field field:fields){
					field.setAccessible(true);
					field.set(object, rs.getObject(field.getName()));
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			BaseDao.closeConnection();
		}
		return object;
	}
		
}
