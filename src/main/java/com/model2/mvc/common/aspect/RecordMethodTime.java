package com.model2.mvc.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

/*
 * FileName : RecordMethodTime.java
 *	:: XML �� ���������� aspect �� ����   
  */
@Aspect
@Component
public class RecordMethodTime {

	///Constructor
	public RecordMethodTime() {
		System.out.println("\nCommon :: "+this.getClass()+"\n");
	}
	
	//Around  Advice
	@Around("execution(* com.model2.mvc.service..*Impl.*(..) )")
	public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable {
			
		long startTime = System.currentTimeMillis();
		
		Object obj = joinPoint.proceed();
		
		long endTime = System.currentTimeMillis();
		System.out.println("�޼ҵ� ����ð�: "+ ((endTime-startTime)/1000)+"��");
		
		return obj;
	}
	
}//end of class