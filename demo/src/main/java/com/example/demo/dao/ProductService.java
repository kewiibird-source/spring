package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.common.Message;
import com.example.demo.mapper.ProductMapper;
import com.example.demo.model.Product;

@Service
public class ProductService {
	@Autowired
	ProductMapper productMapper;
	
	// 제품별 매출액 오더리스트
	public HashMap<String, Object> getOrderList(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Product> list = productMapper.selectOrderList(map);
			
			resultMap.put("list", list);
			resultMap.put("result", "success");
			resultMap.put("message", Message.MSG_SEARCH); // 에러 메세지 만들어놓은거!
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
			resultMap.put("message", Message.MSG_SERVER_ERR); 
		}
		return resultMap;
	}
}
