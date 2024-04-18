DROP TABLE productImages CASCADE CONSTRAINTS;
DROP TABLE orderDetails CASCADE CONSTRAINTS;
DROP TABLE transaction CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE categories;
DROP TABLE users CASCADE CONSTRAINTS;
DROP TABLE cart;

DROP SEQUENCE seq_product_prod_no;
DROP SEQUENCE seq_transaction_tran_no;
DROP SEQUENCE seq_categories_category_no;
DROP SEQUENCE seq_orderdetails_order_no;
DROP SEQUENCE seq_productImages_img_no;

CREATE SEQUENCE seq_product_prod_no	 	 INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_transaction_tran_no	 INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_categories_category_no INCREMENT BY 1 START WITH 3000;
CREATE SEQUENCE seq_orderdetails_order_no INCREMENT BY 1 START WITH 3000;
CREATE SEQUENCE seq_cart_cart_no INCREMENT BY 1 START WITH 3000;
CREATE SEQUENCE seq_productImages_img_no INCREMENT BY 1 START WITH 10000;

CREATE TABLE users ( 
	user_id 			VARCHAR2(20)		NOT NULL,
	user_name 	VARCHAR2(50)		NOT NULL,
	password 		VARCHAR2(10)		NOT NULL,
	role 				VARCHAR2(5) 		DEFAULT 'user',
	ssn 					VARCHAR2(13),
	cell_phone	 VARCHAR2(14),
	addr 				VARCHAR2(100),
	email 				VARCHAR2(50),
	reg_date 		DATE,
	PRIMARY KEY(user_id)
);

CREATE TABLE categories(
	category_no NUMBER NOT NULL,
	parent_category_no NUMBER,
	category_name VARCHAR2(100),
	reg_date	 DATE,
	PRIMARY KEY(category_no)
);


CREATE TABLE product ( 
	prod_no 					NUMBER 				NOT NULL,
	prod_name 				VARCHAR2(100) 	NOT NULL,
	prod_detail 				VARCHAR2(1000),
	manufacture_day	 VARCHAR2(8),
	price 							NUMBER(10),
	category_no NUMBER REFERENCES categories(category_no),
	quantity NUMBER,
	reg_date 					DATE,
	PRIMARY KEY(prod_no)
);

CREATE TABLE transaction ( 
	tran_no 						NUMBER 			NOT NULL,
	buyer_id 					VARCHAR2(20)	NOT NULL REFERENCES users(user_id),
	payment_option		 CHAR(3),
	receiver_name 		 VARCHAR2(20),
	receiver_phone		 VARCHAR2(14),
	demailaddr 				VARCHAR2(100),
	dlvy_request 			VARCHAR2(100),
	tran_status_code	 CHAR(3),
	order_data 				DATE,
	dlvy_date 				DATE,
	PRIMARY KEY(tran_no)
);

CREATE TABLE cart (
    cart_no NUMBER NOT NULL,
    user_id VARCHAR2(20) NOT NULL REFERENCES users(user_id),
    prod_no NUMBER NOT NULL REFERENCES product(prod_no),
    quantity NUMBER NOT NULL,
    PRIMARY KEY(cart_no)
);

CREATE TABLE orderDetails(
	order_no NUMBER NOT NULL,
	tran_no NUMBER NOT NULL REFERENCES transaction(tran_no),
	prod_no NUMBER NOT NULL REFERENCES product(prod_no),
	quantity NUMBER,
	reg_date DATE,
	PRIMARY KEY(order_no)
);

CREATE TABLE productImages(
	img_no NUMBER NOT NULL,
	file_name VARCHAR2(200),
	prod_no NUMBER NOT NULL REFERENCES product(prod_no),
	PRIMARY KEY(img_no)
);


INSERT 
INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date ) 
VALUES ( 'admin', 'admin', '1234', 'admin', NULL, NULL, '����� ���ʱ�', 'admin@mvc.com',TO_DATE('2012/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS')); 

INSERT 
INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date ) 
VALUES ( 'manager', 'manager', '1234', 'admin', NULL, NULL, NULL, 'manager@mvc.com', TO_DATE('2012/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'));          

INSERT INTO users 
VALUES ( 'user01', 'SCOTT', '1111', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user02', 'SCOTT', '2222', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user03', 'SCOTT', '3333', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user04', 'SCOTT', '4444', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user05', 'SCOTT', '5555', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user06', 'SCOTT', '6666', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user07', 'SCOTT', '7777', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user08', 'SCOTT', '8888', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user09', 'SCOTT', '9999', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user10', 'SCOTT', '1010', 'user', NULL, NULL, NULL, NULL, SYSDATE); 

INSERT INTO users 
VALUES ( 'user11', 'SCOTT', '1111', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user12', 'SCOTT', '1212', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user13', 'SCOTT', '1313', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user14', 'SCOTT', '1414', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user15', 'SCOTT', '1515', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user16', 'SCOTT', '1616', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user17', 'SCOTT', '1717', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user18', 'SCOTT', '1818', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user19', 'SCOTT', '1919', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user20', 'SCOTT', '2020', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user21', 'SCOTT', '2121', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user22', 'SCOTT', '2222', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO users 
VALUES ( 'user23', 'SCOTT', '2323', 'user', NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 0, 'Ƽ��', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 0, '��������', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 0, '����', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 3000, '�Ϲ� ������', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 3000, 'Ư���� ������', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 3001, '����', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 3001, '����', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 3001, '�޺�', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 3002, '����Ʈī��', SYSDATE);
INSERT INTO categories VALUES(seq_categories_category_no.NEXTVAL, 3002, '������', SYSDATE);

INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'�Ϲ� ������','��ȿ�Ⱓ: �����Ϸκ��� 24���� �̳� ��� ���� ���� ���� ��ȿ�Ⱓ�� �����Ϸκ��� 2���Դϴ�.
�Ǹż���: 1ȸ 8�� ���Ű���
���� �� ���: �����Ϸκ��� 10�� �̳� ��� �����ϸ�, �κ���Ҵ� �Ұ����մϴ�.','20240417',10000, '3003', 100, TO_DATE('2024/04/17 21:15:00', 'YYYY/MM/DD HH24:MI:SS'));
INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'Dolby Cinema ���������',
'��ȿ�Ⱓ: �����Ϸκ��� 24���� �̳� ��� ���� ���� ���� ��ȿ�Ⱓ�� �����Ϸκ��� 2���Դϴ�.
�Ǹż���: 1ȸ 8�� ���Ű���
���� �� ���: �����Ϸκ��� 10�� �̳� ��� �����ϸ�, �κ���Ҵ� �Ұ����մϴ�.','20240417',18000, '3004', 100, TO_DATE('2024/04/17 21:15:00', 'YYYY/MM/DD HH24:MI:SS'));
INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'�� ��Ƽũ ���������','��ȿ�Ⱓ: �����Ϸκ��� 24���� �̳� ��� ���� ���� ���� ��ȿ�Ⱓ�� �����Ϸκ��� 2���Դϴ�.
�Ǹż���: 1ȸ 8�� ���Ű���
���� �� ���: �����Ϸκ��� 10�� �̳� ��� �����ϸ�, �κ���Ҵ� �Ұ����մϴ�.','20240417',15000, '3004',100, TO_DATE('2024/04/17 21:15:00', 'YYYY/MM/DD HH24:MI:SS'));
INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'����L','��������: 1�� 1�� 10�� ��ȿ�Ⱓ: ����Ʈ�� ��ǰ�� 24 ����','20240417', 6000, '3005',1000, TO_DATE('2024/04/17 21:15:00', 'YYYY/MM/DD HH24:MI:SS'));
INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'�ݶ�L','��������: 1�� 1�� 10�� ��ȿ�Ⱓ: ����Ʈ�� ��ǰ�� 24 ����','20240417', 3500, '3006',1000, TO_DATE('2024/04/17 21:15:00', 'YYYY/MM/DD HH24:MI:SS'));
INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'�����޺�','��������: 1�� 1�� 10�� ��ȿ�Ⱓ: ����Ʈ�� ��ǰ�� 24 ����','20240417',15000, '3007',1000, TO_DATE('2024/04/17 21:15:00', 'YYYY/MM/DD HH24:MI:SS'));
INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'CGV��Ĳ��','��ǰ���������� ���� ī�� ��ȿ�Ⱓ: ���� �Ǵ� ���� �����Ϸκ��� 5��','20240417',10000, '3008',100, TO_DATE('2024/04/17 21:15:00', 'YYYY/MM/DD HH24:MI:SS'));
INSERT INTO product VALUES (seq_product_prod_no.NEXTVAL,'�������� Ƽ��','1�� 4�� ����','20240418',20000, '3009',50, TO_DATE('2024/04/18 09:11:00', 'YYYY/MM/DD HH24:MI:SS'));

INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, 'OzjTPmOIAocfyQnas3x8Vo9JDRRnHeKf_280.png', 10000);
INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, 'XxKX38rQAArz5GGaFCs7KwvYyUz5oQFC_280.png', 10001);
INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, 'rxCDUuqHT9RostRRQYeu1mr1knFyHxWr_280.png', 10002);
INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, '8827dc6093994a4ca3b70bce78b44fba.jpg', 10003);
INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, 'c40b844a2e8b4bdc9f0f7131a4262ab6.jpg', 10004);
INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, '9c05d8b90a04441fa151e5cc5f70bf07.jpg', 10005);
INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, '16238872308620.jpg', 10006);
INSERT INTO productImages VALUES (seq_productImages_img_no.NEXTVAL, 'original_ticket_rain.jpg', 10007);


commit;
