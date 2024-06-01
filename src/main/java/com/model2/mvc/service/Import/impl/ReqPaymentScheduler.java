package com.model2.mvc.service.Import.impl;

import java.sql.Date;
import java.util.Calendar;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.Trigger;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.support.PeriodicTrigger;
import org.springframework.stereotype.Component;

@Component
public class ReqPaymentScheduler {
	//�����ٷ�
    private ThreadPoolTaskScheduler scheduler;
    
	@Autowired
	SchedulePayment setSchedulePay;
	
    public void stopScheduler() {
    	//���� ��� �� scheduler shutdown�� ���� ���� ��û ����
        scheduler.shutdown();
    }
 
    public void startScheduler(String customer_uid, int price) {
        scheduler = new ThreadPoolTaskScheduler();
        scheduler.initialize();
        // �����췯�� ���۵Ǵ� �κ� 
        scheduler.schedule(getRunnable(customer_uid, price), getTrigger());
    }
    
    private Runnable getRunnable(String customer_uid, int price){
        return () -> {
        	try {
				setSchedulePay.schedulePay(customer_uid, price);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        };
    }
 
    private Trigger getTrigger() {
        // �۾� �ֱ� ���� 
        return new PeriodicTrigger(10, TimeUnit.SECONDS);
    }
}