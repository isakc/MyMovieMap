package com.model2.mvc.common;

public enum TransactionStatus {
	SELLING("0", "�Ǹ���"),
    PURCHASED("1", "���ſϷ�"),
    SHIPPING("2", "�����"),
    DELIVERED("3", "��ۿϷ�");

    private final String code;
    private final String status;


    TransactionStatus(String code, String status) {
        this.code = code;
        this.status = status;
    }

    public String getCode() {
        return code;
    }
    
    public String getStatus() {
        return status;
    }

    public static String getStatusByCode(String code) {
        for (TransactionStatus status : TransactionStatus.values()) {
            if (status.getCode().equals(code)) {
                return status.getStatus();
            }
        }
        throw new IllegalArgumentException("�߸��� �ڵ�: " + code);
    }
}