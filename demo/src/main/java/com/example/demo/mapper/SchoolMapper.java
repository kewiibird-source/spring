package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Dept;
import com.example.demo.model.Professor;
import com.example.demo.model.Student;
import com.example.demo.model.User;

@Mapper
public interface SchoolMapper {
	// 교수 목록
	public List<Professor> selectProfList(HashMap<String, Object> map);
	// 학생 목록
	public List<Student> selectStuList(HashMap<String, Object> map);
	// 페이징 ( 교수전체수 )
	public int selectProfCount(HashMap<String, Object> map);
	
	// 학과 목록
	public List<Dept> selectDeptList(HashMap<String, Object> map);
	// 학생 추가
	public int insertStu(HashMap<String, Object> map);
	// 교수 추가
	public int insertProf(HashMap<String, Object> map);
	// 학생 한명에 대한 정보
	public Student selectStu(HashMap<String, Object> map);
	// 학생 삭제 
	public int deleteStu(HashMap<String, Object> map);
	// 학생 여려명 삭제
	public int deleteAllStu(HashMap<String, Object> map);
	// 교수 삭제 
	public int deleteProf(HashMap<String, Object> map);
	// 교수 한명에 대한 정보
	public Professor selectProf(HashMap<String, Object> map);
	// 학생 수정
	public int updateStu(HashMap<String, Object> map);
}
