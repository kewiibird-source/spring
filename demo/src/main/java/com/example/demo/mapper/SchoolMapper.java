package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Professor;
import com.example.demo.model.Student;

@Mapper
public interface SchoolMapper {
	// 교수 목록
	public List<Professor> selectProfList(HashMap<String, Object> map);
	// 학생 목록
	public List<Student> selectStuList(HashMap<String, Object> map);
	
}
