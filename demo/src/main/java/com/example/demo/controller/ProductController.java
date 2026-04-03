package com.example.demo.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dao.ProductService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ProductController {
	@Autowired
	ProductService productService;
//	결제
	
	@RequestMapping("/product/order.do")
	public String order(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/product/order-chart";
	}
	@RequestMapping("/product/payment.do")
	public String payment(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/product/payment";
	}
	@RequestMapping("/product/auth.do")
	public String auth(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/product/auth";
	}
	@RequestMapping(value = "/product/order.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String orderList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.getOrderList(map);
		return new Gson().toJson(resultMap); 
	}
	
}
