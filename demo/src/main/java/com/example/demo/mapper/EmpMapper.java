package com.example.demo.mapper;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Emp;
import com.example.demo.model.User;

@Mapper
public interface EmpMapper {
	// 사원 리스트
	public List<Emp> selectEmpList(HashMap<String, Object> map);
	
	// 사원 추가
	public int insertEmp(HashMap<String, Object> map);
	
	// 사원 상세보기
	public Emp selectEmp(HashMap<String, Object> map);
	
	// 상세보기 - 사원삭제
	public int deleteEmp(HashMap<String, Object> map);
	
	// 페이징
	public int selectEmpCount(HashMap<String, Object> map);
}
