package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Board;

@Mapper
public interface BoardMapper {
	public List<Board> selectBoardList(HashMap<String, Object> map); // <= 괄호안은 나중에 파라미터로 받는값(쿼리에전달)
	
	public int insertBoard(HashMap<String, Object> map);
	
	public Board selectBoard(HashMap<String, Object> map);
	
	public int updateCnt(HashMap<String, Object> map); // 조회수증가 , 게시글view 조회전에 실행
	
	public int updateBoard(HashMap<String, Object> map);
	
	// 파일업로드
	public int insertBoardFile(HashMap<String, Object> map);
	
	// 파일조회
	public List<Board> selectBoardFile(HashMap<String, Object> map); 
}
