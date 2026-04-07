package com.example.demo.dao;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.common.Message;
import com.example.demo.mapper.SchoolMapper;
import com.example.demo.model.Dept;
import com.example.demo.model.Professor;
import com.example.demo.model.Student;

@Service
public class SchoolService {
	@Autowired
	SchoolMapper schoolMapper;
	
	public HashMap<String, Object> getProfList(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Professor> list = schoolMapper.selectProfList(map);
			List<Dept> deptList = schoolMapper.selectDeptList(map);
			int totalCount = schoolMapper.selectProfCount(map); // 페이징
			
			resultMap.put("totalCount", totalCount); // 페이징
			resultMap.put("list", list);
			resultMap.put("deptList", deptList);
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_SEARCH); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
	// 학생목록
	public HashMap<String, Object> getStuList(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Student> list = schoolMapper.selectStuList(map);
			List<Dept> deptList = schoolMapper.selectDeptList(map);
			
			resultMap.put("list", list);
			resultMap.put("deptList", deptList);
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_SEARCH); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
	
	// 학과추가
	public HashMap<String, Object> getDeptList(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Dept> list = schoolMapper.selectDeptList(map);
			
			resultMap.put("list", list);
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_SEARCH); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
	
	// 학생 추가
	public HashMap<String, Object> addStu(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int result = schoolMapper.insertStu(map);
			
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_ADD); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
	// 교수 추가
	public HashMap<String, Object> addProf(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int result = schoolMapper.insertProf(map);
			
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_ADD); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
	
	// 학번 중복체크
	public HashMap<String, Object> getStu(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Student info = schoolMapper.selectStu(map);
			if(info != null) {
				resultMap.put("stuFlg", false);
				resultMap.put("message", "이미 사용중인 학번입니다."); // 에러 메세지 만들어놓은거!
			} else {
				resultMap.put("stuFlg", true);				
				resultMap.put("message", "사용 가능한 학번 입니다."); // 에러 메세지 만들어놓은거!
			}
			
//			resultMap.put("list", list); 
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
	// 학생 삭제
	public HashMap<String, Object> removeStu(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int result = schoolMapper.deleteStu(map);
			
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_REMOVE); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
	public HashMap<String, Object> removeAllStu(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int result = schoolMapper.deleteAllStu(map);
			
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_REMOVE); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
	
	// 교수 삭제
	public HashMap<String, Object> removeProf(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int result = schoolMapper.deleteProf(map);
			
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_REMOVE); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
	
	//학생 상세보기
	public HashMap<String, Object> getStuInfo(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Student info = schoolMapper.selectStu(map);
			
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
	//교수 상세보기
	public HashMap<String, Object> getProfInfo(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Professor info = schoolMapper.selectProf(map);
			
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
	
	// 학생 수정
	public HashMap<String, Object> editStu(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int result = schoolMapper.updateStu(map);
			
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_EDIT); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
}
