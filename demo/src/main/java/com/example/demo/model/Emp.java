package com.example.demo.model;

import lombok.Data;

@Data
public class Emp {
	
	String empNo;
	String eName;
	String job;
	String mgr; // 사수이름
	int sal;
	String salGrade; // 급여등급
	String dName; // 부서이름
	
}
