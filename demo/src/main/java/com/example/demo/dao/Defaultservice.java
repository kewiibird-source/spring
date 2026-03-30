package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.common.Message;
import com.example.demo.mapper.DefaulfMapper;
import com.example.demo.model.User;

@Service
public class Defaultservice {
	// mapper에서 데이터베이스 조회결과를 리턴받는다
	
	@Autowired
	DefaulfMapper defaulfMapper;
//	=== Mapper 호출 시 ===
//	조회 -> get , 수정 -> edit , 삽입 -> add , 삭제 -> remove
//	ex) 학생목록 : getStudentList, 학생수정 : editStudent ...
//	 여러개 리턴 -> selectXXXList 
//		List<User> list = defaulfMapper.selectUserList();
//	 한개 리턴 -> selectXXX
//		User info = defaultMapper.selectUser();
//	 수정, 삭제, 삽입 -> updateXXX, deleteXXX, insertXXX
//		int result = defaultMapper.updateXXX();
	
	public HashMap<String, Object> 함수이름getItem(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
//			List<User> list = defaulfMapper.selectUserList(map);
//			User info = defaultMapper.selectUser(map);
//			int result = defaultMapper.updateXXX(map);
			
//			resultMap.put("list", list);
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_ADD); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
	
	public HashMap<String, Object> getUserList(){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<User> list = defaulfMapper.selectUserList(resultMap);
		
		resultMap.put("list", list);
		resultMap.put("message", "데이터 조회 성공");
		resultMap.put("result", "success");
		
		return resultMap;
	}
	
}
