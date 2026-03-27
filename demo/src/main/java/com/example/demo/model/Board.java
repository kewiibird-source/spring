package com.example.demo.model;

import lombok.Data;

@Data // <= get set 메소드 롬복!!
public class Board {
	String boardNo;
	String userId;
	String title;
	String contents;
	int cnt;
	int kind;
	String cDateTime;
	String uDateTime;
}
