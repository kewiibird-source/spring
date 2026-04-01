package com.example.demo.model;

import lombok.Data;

@Data
public class User {
	String userId;
	String userName;
	String pwd;
	String gender;
	// 대소문자 구분X , db 컬럼 이름은 같아야함
	// 정의한 개수대로 db로 돌려받음
	
//	첨부파일
	int fileNo;
	String filePath;
	String fileName;
	String fileOrgName;
	String fileSize;
	String fileETC;
}
