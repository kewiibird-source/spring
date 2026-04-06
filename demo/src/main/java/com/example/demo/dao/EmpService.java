package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.common.Message;
import com.example.demo.mapper.EmpMapper;
import com.example.demo.model.Emp;

@Service
public class EmpService {
	
	@Autowired
	EmpMapper empMapper;
	
	// emp list
	public HashMap<String, Object> getEmpList(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Emp> list = empMapper.selectEmpList(map);
			int totalCount = empMapper.selectEmpCount(map);
			resultMap.put("list", list);
			resultMap.put("totalCount", totalCount);
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_SEARCH); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
	// 사원추가 add
	public HashMap<String, Object> addEmp(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int result = empMapper.insertEmp(map);
		
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_ADD); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
	
	//사원상세보기
	public HashMap<String, Object> getEmp(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Emp info = empMapper.selectEmp(map);
			
			resultMap.put("info", info);
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_SEARCH); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
	
	//사원상세보기 - 삭제
	public HashMap<String, Object> removeEmp(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int result = empMapper.deleteEmp(map);
			
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_REMOVE); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}

}
