package com.model2.mvc.service.productImage;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.model2.mvc.service.domain.ProductImage;

@Mapper
public interface ProductImageDao {

	//insert
	public void addProductImage(ProductImage productImage) throws Exception;
	
	//selectList
	public List<ProductImage> getProductImageList(int prodNo) throws Exception ;

	//delete
	public void deleteProductImage(int prodNo) throws Exception ;
}