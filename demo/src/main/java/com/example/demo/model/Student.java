package com.example.demo.model;

import lombok.Data;

@Data
public class Student {
	// student 테이블
	String stuNo;
	String stuName;
	String stuDept;
	String stuGrade;
	String stuGender;
	
	
	// stu 테이블
	String name;
	String id;
	int grade;
	String jumin;
	String birthday;
	String tel;
	String deptNo1;
	String deptNo2;
	String profNo;
	
	String dName1; // 대학
	String dName2; // 학부
	String dName3; // 학과
	
	String subdName1; // 부전공 대학
	String subdName2; // 부전공 학부
	String subdName3; // 부전공 학과
	
	String profName; // 담당교수 이름
}

