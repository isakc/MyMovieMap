package com.model2.mvc.service.category;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.model2.mvc.service.domain.Category;

@Mapper
public interface CategoryDao {

	//insert
	public void addCategory(Category category) throws Exception;
	
	//selectOne
	public Category findCategory(int categoryNo) throws Exception;
	
	//selectList
	public List<Category> getCategoryList() throws Exception;
}