package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Product;

@Mapper
public interface ProductMapper {
	// 제품별 매출액
	public List<Product>selectOrderList(HashMap<String, Object> map);
}
