package com.example.demo.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dao.SchoolService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class SchoolController {
	@Autowired
	SchoolService schoolService;
	
	@RequestMapping("/prof/list.do")
	public String prof(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/School/prof-list";
	}
//	ajax가 호출하는 주소
	@RequestMapping(value = "/prof/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String prof(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = schoolService.getProfList(map);
		return new Gson().toJson(resultMap); 
	}
	
	@RequestMapping("/stu/list.do")
	public String stu(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/School/stu-list";
	}
	@RequestMapping(value = "/stu/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stu(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = schoolService.getStuList(map);
		return new Gson().toJson(resultMap); 
	}
}
