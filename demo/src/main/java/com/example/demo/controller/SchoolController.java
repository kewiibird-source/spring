package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dao.SchoolService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
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
	// 학생목fhr
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
	
	// 학과 목록 
	@RequestMapping(value = "/dept/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String dept(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = schoolService.getDeptList(map);
		return new Gson().toJson(resultMap); 
	}
	
	// 학생추가 버튼
	@RequestMapping("/stu/add.do")
	public String add(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/School/stu-add";
	}
	@RequestMapping(value = "/stu/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String add(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = schoolService.addStu(map);
		return new Gson().toJson(resultMap); 
	}
	// 교수추가 버튼
	@RequestMapping("/prof/add.do")
	public String profAdd(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/School/prof-add";
	}
	@RequestMapping(value = "/prof/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String profAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = schoolService.addProf(map);
		return new Gson().toJson(resultMap); 
	}
	// 학생조회
	@RequestMapping(value = "/stu/check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String check(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = schoolService.getStu(map);
		return new Gson().toJson(resultMap); 
	}
	// 학생삭제
	@RequestMapping(value = "/stu/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String remov(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = schoolService.removeStu(map);
		return new Gson().toJson(resultMap); 
	}
	@RequestMapping(value = "/stu/remove-all.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	// 학생 체크박스로 여려명 삭제
	@ResponseBody
	public String removAll(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String json = map.get("selectList").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		
		System.out.println(map);
		resultMap = schoolService.removeAllStu(map);
		return new Gson().toJson(resultMap); 
	}
	// 교수삭제
	@RequestMapping(value = "/prof/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removProf(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = schoolService.removeProf(map);
		return new Gson().toJson(resultMap); 
	}
	
	// 학생목록 상세보기
	@RequestMapping("/stu/view.do")
	public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		System.out.println(map); //stu-view로 넘어갔을때 콘솔창에 stuNo 찍어주기
		request.setAttribute("map", map);
		return "/School/stu-view";
	}
	@RequestMapping(value = "/stu/info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String info(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = schoolService.getStuInfo(map);
		return new Gson().toJson(resultMap); 
	}
	// 교수목록 상세보기
	@RequestMapping("/prof/view.do")
	public String profview(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		System.out.println(map); 
		request.setAttribute("map", map);
		return "/School/prof-view";
	}
	@RequestMapping(value = "/prof/info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String profinfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = schoolService.getProfInfo(map);
		return new Gson().toJson(resultMap); 
	}
	
	// 학생 상세보기 => 수정
	@RequestMapping("/stu/edit.do")
	public String edit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
		return "/School/stu-edit";
	}
	@RequestMapping(value = "/stu/edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String edit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = schoolService.editStu(map);
		return new Gson().toJson(resultMap); 
	}
	// 교수 상세보기 => 수정
	@RequestMapping("/prof/edit.do")
	public String profedit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map); 
		return "/School/prof-edit";
	}
//	@RequestMapping(value = "/prof/edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
//	@ResponseBody
//	public String profedit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		resultMap = schoolService.editprof(map);
//		return new Gson().toJson(resultMap); 
//	}
	
}
