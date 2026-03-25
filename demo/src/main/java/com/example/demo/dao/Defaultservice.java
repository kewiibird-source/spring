package com.example.demo.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.DefaulfMapper;

@Service
public class Defaultservice {
	
	@Autowired
	DefaulfMapper defaulfMapper;
	
	public HashMap<String, Object> getUserList(){
		
		defaulfMapper.selectUserList();
		return null;
	}
	
}
