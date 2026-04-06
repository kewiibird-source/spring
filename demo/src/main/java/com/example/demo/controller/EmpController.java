package com.example.demo.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dao.EmpService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class EmpController {
	
	@Autowired
	EmpService empService;
	// 사원리스트
	@RequestMapping("/emp/list.do")
	public String copy(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
		return "/emp/emp-list";
	}
//	ajax 사원 list 호출
	@RequestMapping(value = "/emp/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String empList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int pageSize = Integer.parseInt((String)map.get("pageSize"));
		int offSet = Integer.parseInt((String)map.get("offSet"));
		map.put("pageSize", pageSize);
		map.put("offSet", offSet);
		
		resultMap = empService.getEmpList(map);
		
		return new Gson().toJson(resultMap); 
	}
	
	// 사원추가
	@RequestMapping("/emp/add.do")
	public String add(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/emp/emp-add";
	}
//	ajax add사원추가 호출
	@RequestMapping(value = "/emp/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String check(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = empService.addEmp(map);
		return new Gson().toJson(resultMap); 
	}
	
	// 상세보기
	@RequestMapping("/emp/view.do")
	public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
//		request.setAttribute("empNo", map.get("empNo"));
		request.setAttribute("map", map);
		return "/emp/emp-view";
	}
//	ajax 사원 상세보기 호출
	@RequestMapping(value = "/emp/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String view(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = empService.getEmp(map);
		System.out.println(map);
		return new Gson().toJson(resultMap); 
	}
	
	// 상세보기 -> 삭제
		@RequestMapping(value = "/emp/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String remov(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = empService.removeEmp(map);
			return new Gson().toJson(resultMap); 
		}
}
