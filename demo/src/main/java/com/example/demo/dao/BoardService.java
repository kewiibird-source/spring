package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.BoardMapper;
import com.example.demo.model.Board;

import jakarta.servlet.http.HttpSession;

@Service
public class BoardService {
	// mapper에서 데이터베이스 조회결과를 리턴받는다
	@Autowired
	BoardMapper boardMapper; // boardMapper의 객체
	
	@Autowired
	HttpSession session;
	
	public HashMap<String, Object> getBoardList(HashMap<String, Object> map){ // <= 마찬가지로 괄호안은 나중에 받을값
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Board> list = boardMapper.selectBoardList(map); // boardMapper 객체 안에서 꺼내오기
			
			resultMap.put("list", list);
			resultMap.put("message", "데이터 조회 성공");
			resultMap.put("result", "success");
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("message", "서버 에러!");
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> addBoard(HashMap<String, Object> map){ // <= 마찬가지로 괄호안은 나중에 받을값
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			map.put("sessionId", session.getAttribute("sessionId")); //세션에있는아이디담아서보내기
			boardMapper.insertBoard(map); // boardMapper 객체 안에서 꺼내오기
			System.out.println("insert된 key값 : " + map.get("boardNo")); // ai로 생성된 보드no
			resultMap.put("boardNo", map.get("boardNo"));
			resultMap.put("message", "등록되었습니다!");
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("message", "서버 에러!");
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> getBoard(HashMap<String, Object> map){ // <= 마찬가지로 괄호안은 나중에 받을값
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			if(map.get("kind").equals("view")) {				
				boardMapper.updateCnt(map); // 조회수업데이트
			}
			
			Board info = boardMapper.selectBoard(map); // boardMapper 객체 안에서 꺼내오기
			List<Board> fileList = boardMapper.selectBoardFile(map);
			
			resultMap.put("info", info);
			resultMap.put("fileList", fileList);
			resultMap.put("message", "데이터 조회 성공");
			resultMap.put("result", "success");
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("message", "서버 에러!");
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	public HashMap<String, Object> editBoard(HashMap<String, Object> map){ // <= 마찬가지로 괄호안은 나중에 받을값
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			boardMapper.updateBoard(map); // boardMapper 객체 안에서 꺼내오기
			resultMap.put("message", "수정되었습니다!");
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("message", "서버 에러!");
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	// 파일 업로드
	public HashMap<String, Object> addBoardFile(HashMap<String, Object> map){ // <= 마찬가지로 괄호안은 나중에 받을값
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			boardMapper.insertBoardFile(map); // boardMapper 객체 안에서 꺼내오기
			
			resultMap.put("message", "등록되었습니다!");
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("message", "서버 에러!");
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
}
