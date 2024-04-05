package com.model2.mvc.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;

/*
 * FileName : PojoAspectJ.java
 *	:: XML �� ���������� aspect �� ����   
  */
public class RecordMethodTime {

	///Constructor
	public RecordMethodTime() {
		System.out.println("\nCommon :: "+this.getClass()+"\n");
	}
	
	//Around  Advice
	public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable {
			
		long startTime = System.currentTimeMillis();
		
		Object obj = joinPoint.proceed();
		
		long endTime = System.currentTimeMillis();
		System.out.println("�޼ҵ� ����ð�: "+ ((endTime-startTime)/1000)+"��");
		
		return obj;
	}
	
}//end of class