package com.model2.mvc.service.purchase;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

@Mapper
public interface PurchaseDao {
	
	//insert
	public int addPurchase(Purchase purchase) throws Exception;
	
	//selectOne
	public Purchase findPurchase(int tranNo) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;
	
	//selectList
	public List<Purchase> getPurchaseList(Search search) throws Exception;
	
	//update
	public void updatePurchase(Purchase purchase) throws Exception;
	
	public void updateTranCode(Purchase purchase) throws Exception;

	public void updateTranCodeByProd(Purchase purchase) throws Exception;
}
