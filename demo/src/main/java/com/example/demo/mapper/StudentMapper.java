package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Student;

@Mapper
public interface StudentMapper {
	public List<Student> selectStudentList();
	
	public int deleteStudent(HashMap<String, Object> map);
}
