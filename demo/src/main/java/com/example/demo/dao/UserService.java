package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.common.Message;
import com.example.demo.mapper.UserMapper;
import com.example.demo.model.User;

@Service
public class UserService {
	
	@Autowired
	UserMapper userMapper;
	
//	로그인
	public HashMap<String, Object> login(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User user = userMapper.selectUser(map);

		if(user != null) {
			if(user.getPwd().equals(map.get("pwd"))) {
				resultMap.put("message", user.getUserName() + "님 환영합니다!");				
			} else {
				resultMap.put("message", "비밀번호를 확인해주세요.");							
			}
			
		} else {
			resultMap.put("message", "없는 아이디 입니다");			
		}
		resultMap.put("result", "success");			
		
		return resultMap;
	}
	
//	회원가입
	public HashMap<String, Object> addUser(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int cnt = userMapper.insertUser(map);
			if(cnt > 0) {
				resultMap.put("message", "회원가입 추카");
			} else {
				resultMap.put("message", "회원가입 실패. 다시 시도하셈");				
			}
			resultMap.put("result", "success");			
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("message", "서버 에러 발생! \n 잠시후 다시 시도하삼");
			resultMap.put("result", "fail");			

		}
		
		return resultMap;
	}
	
//	회원가입 아이디 중복체크
	public HashMap<String, Object> checkUser(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
	
		try {
			User user = userMapper.selectUser(map);
			if(user != null) {			
				resultMap.put("message", "이미 사용중인 아이디 입니다.");			
				resultMap.put("result", false);			
			} else {
				resultMap.put("message", "사용 가능한 아이디 입니다");			
				resultMap.put("result", true);			
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("message", "서버 에러.ㄱ-");
		}	
		
		return resultMap;
	}
	
	
	
	// ==== 복습 구간 ====
	public HashMap<String, Object> getUserList(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<User> list = userMapper.selectUserList(map);
			resultMap.put("list", list);
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_ADD); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
//	삭제하기
	public HashMap<String, Object> removeUser(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int result = userMapper.deleteUser(map);
			
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
