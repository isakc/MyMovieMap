package com.model2.mvc.service.product;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Qualifier;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.ProductImage;

@Mapper
public interface ProductDao {
	
	//insert
	public void addProduct(Product product) throws Exception ;
	
	//selectOne
	public Product findProduct(int prodNo) throws Exception ;

	public Product findProductByProdName(String prodName) throws Exception ;
	
	public int getTotalCount(Search search) throws Exception ;

	//selectList
	public List<Product> getProductList(Search search) throws Exception ;

	//update
	public void updateProduct(Product product) throws Exception ;

	public void updateProductQuantity(int prodNo, int quantity) throws Exception ;
}