package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.DefaulfMapper;
import com.example.demo.model.User;

@Service
public class Defaultservice {
	// mapper에서 데이터베이스 조회결과를 리턴받는다
	
	@Autowired
	DefaulfMapper defaulfMapper;
	
	public HashMap<String, Object> getUserList(){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<User> list = defaulfMapper.selectUserList();
		
		resultMap.put("list", list);
		resultMap.put("message", "데이터 조회 성공");
		resultMap.put("result", "success");
		
		return resultMap;
	}
	
}
