package com.model2.mvc.service.category.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.category.CategoryDao;
import com.model2.mvc.service.category.CategoryService;

@Service("categoryServiceImpl")
@Transactional
public class CategoryServiceImpl implements CategoryService {
	
	///Field
	@Autowired
	private CategoryDao categoryDao;

	///Constructor
	public CategoryServiceImpl() {
	}

	///Method
	@Override
	public void addCategory(Category category) throws Exception {
		categoryDao.addCategory(category);
	}

	@Override
	public List<Category> getCategoryList() throws Exception {
		return categoryDao.getCategoryList();
	}

	@Override
	public Category findCategory(int categoryNo) throws Exception {
		return categoryDao.findCategory(categoryNo);
	}
}