package com.model2.mvc.service.orderDetail;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.model2.mvc.service.domain.OrderDetail;

@Mapper
public interface OrderDetailDao {

	//insert
	public void addOrderDetail(OrderDetail orderDetail) throws Exception;
	
	//selectList
	public List<OrderDetail> getOrderDetailList(int tranNo) throws Exception;

	public List<OrderDetail> getOrderDetailListByProdNo(int prodNo) throws Exception;
}