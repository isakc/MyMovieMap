package com.model2.mvc.service.cart;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.model2.mvc.service.domain.Cart;

@Mapper
public interface CartDao {
	//insert
	public void addCart(Cart cart) throws Exception;
	
	//selectOne
	public Cart findCart(Cart cart) throws Exception;
	
	//selectList
	public List<Cart> getCartList(String userId) throws Exception;
	
	//update
	public void updateCart(Cart cart) throws Exception;
	
	//delete
	public void deleteCart(int cartNo) throws Exception;
}