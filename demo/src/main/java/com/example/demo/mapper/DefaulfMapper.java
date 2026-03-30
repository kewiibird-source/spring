package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Student;
import com.example.demo.model.User;

@Mapper
public interface DefaulfMapper {
	// 추상메소드 => xml 파일의 select id="selectUserList"과 같아야됨
	
	// select 결과가 여러개면 리스트의 형태로 리턴 -> selectXXXlist
	public List<User> selectUserList(HashMap<String, Object> map);
	// 한개 리턴 -> selectXXXlist
	public User selectUser(HashMap<String, Object> map);
	// 삭제
	public int deleteUser(HashMap<String, Object> map);
	// 수정
	public int updateUser(HashMap<String, Object> map);
	// 삽입
	public int insertUser(HashMap<String, Object> map);
	
}
