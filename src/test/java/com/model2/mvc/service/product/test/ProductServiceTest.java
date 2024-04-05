package com.model2.mvc.service.product.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
		"classpath:config/context-aspect.xml",
		"classpath:config/context-mybatis.xml",
		"classpath:config/context-transaction.xml" })
public class ProductServiceTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	//@Test
	public void testInsertProduct() throws Exception {
		
		Product product = new Product();
		product.setProdName("�׽�Ʈ���ǰ");
		product.setProdDetail("�׽�Ʈ");
		product.setManuDate("20240304");
		Category cateogry = new Category();
		cateogry.setCategoryNo(3007);
		cateogry.setParentCategoryNo(3001);
		product.setCategory(cateogry);
		
		//productService.insertProduct(product);
		
		//==> console Ȯ��
		//System.out.println(user);
		
		//==> API Ȯ��
		Assert.assertEquals("�׽�Ʈ���ǰ", product.getProdName());
	}
	
	@Test
	public void testFindProduct() throws Exception {
		
		Product product = new Product();
		
		product = productService.findProduct(10001);
		System.out.println(product.getCategory());

		Assert.assertEquals("������", product.getProdName());
		Assert.assertEquals("������", product.getCategory().getCategoryName());
	}
	
	//@Test
	public void testFindProductByProdName() throws Exception {
		
		Product product = new Product();
		
		product = productService.findProductByProdName("������");
		System.out.println(product);

		Assert.assertEquals("������", product.getProdName());
	}
	
	//@Test
	 public void testUpdateUser() throws Exception{
		 
		Product product = productService.findProduct(10008);
		Assert.assertNotNull(product);
		
		Assert.assertEquals("�ζ��Τ���", product.getProdName());
		Assert.assertEquals("�±�", product.getProdDetail());
		Assert.assertEquals("20121201", product.getManuDate());
		Assert.assertEquals(0, product.getPrice());
		//Assert.assertEquals(null, product.getFileName());
		Assert.assertEquals(3007, product.getCategory().getCategoryNo());
		Assert.assertEquals(0, product.getQuantity());

		product.setProdName("change�ζ���");
		product.setPrice(22222);
		product.setQuantity(10);
		
		//productService.updateProduct(product);
		
		product = productService.findProduct(10008);
		Assert.assertNotNull(product);
		
		//==> API Ȯ��
		Assert.assertEquals("change�ζ���", product.getProdName());
		Assert.assertEquals(22222, product.getPrice());
		Assert.assertEquals(10, product.getQuantity());
	 }
	
	 //@Test
	 public void testGetProudctList() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("");
	 	search.setSearchKeyword("");
	 	
	 	Category category = null;
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	List<Object> isDeliveredList = (List<Object>)map.get("isDeliveredList");
	 	
	 	int totalCount = (Integer)map.get("totalCount");
	 	Assert.assertEquals(3, list.size());
	 	Assert.assertEquals(8, totalCount);
	 }
}