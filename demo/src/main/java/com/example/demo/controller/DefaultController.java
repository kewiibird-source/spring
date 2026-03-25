package com.example.demo.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dao.Defaultservice;
import com.google.gson.Gson;

@Controller
public class DefaultController {
	
	@Autowired
	Defaultservice defaultservice;

	@RequestMapping("/default.do")
	public String test(Model model) throws Exception{
		return "/default";
	}
	
	@RequestMapping("/test.do")
	public String test2(Model model) throws Exception{
		return "/test";
	}
	
	@RequestMapping(value = "/test.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
//		Defaultservice obj = new Defaultservice();
//		자바 관점에서 객체를 만들어야 메소드를 호출할수있죠
//		상단에 @Autowired로 선언하면?
		defaultservice.getUserList();
		
		
		
		System.out.println("test.dox 호출 됨 !!");
		System.out.println(map);
		
		resultMap.put("result", "success");
		resultMap.put("hello", "word");
		return new Gson().toJson(resultMap); 
	}
	
}
