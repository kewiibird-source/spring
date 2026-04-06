package com.example.demo.controller;

import java.util.HashMap;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MapController {
	@RequestMapping("/map1.do")
	public String map1(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/map/map1";
	}
	@RequestMapping("/map2.do")
	public String map2(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/map/map2";
	}
	@RequestMapping("/map3.do")
	public String map3(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/map/map3";
	}
}
