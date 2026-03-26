package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Student;
import com.example.demo.model.User;

@Mapper
public interface DefaulfMapper {
	public List<User> selectUserList();
	// db와 연계
	// select 결과가 여러개면 리스트의 형태로
	// public User selectUserList(); 는 단일객체
	// 추상메소드 => xml 파일의 select id="selectUserList"과 같아야됨
}
