package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.StudentMapper;
import com.example.demo.model.Student;

@Service
public class StudentService {
	@Autowired
	StudentMapper studentfMapper;
	
	public HashMap<String, Object> getStudentList(){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Student> list = studentfMapper.selectStudentList();
		
		resultMap.put("list", list);
		resultMap.put("message", "데이터 조회 성공");
		resultMap.put("result", "success");
		
		return resultMap;
	}
	
	public HashMap<String, Object> removeStudent(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = studentfMapper.deleteStudent(map);
		if(cnt > 0) {
			resultMap.put("message", "데이터 삭제 성공");
		} else {
			resultMap.put("message", "데이터 삭제 실패");			
		}
		resultMap.put("result", "success"); 
		
		return resultMap;
	}
	
	
}
