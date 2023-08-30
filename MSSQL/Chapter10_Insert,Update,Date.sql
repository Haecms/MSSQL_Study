/* 1. INSERT
 - ���̺� �����͸� ���
 - INSERT�� �⺻ ����
    . INSERT INTO <���̺�> (���̸�1, ���̸�2,...) VALUES(��1, ��2,...)
*/

-- 1-1 �� ���̺� ������ ���
INSERT INTO T_Customer (CUST_ID,  NAME,		 PHONE) 
			    VALUES (7,		'��â��', '7777-7777')
SELECT * FROM T_Customer
-- 1-2 ��� �÷��� �����͸� ��� �� ���� �÷��� �̸� ���� ����


-- 1-3 ���̺��� ����. (�����Ϳ� ���ÿ� �����Ͽ� ���̺��� �����ϴ� ����)
SELECT * INTO T_CUSTOMER2 FROM T_CUSTOMER

SELECT * FROM T_CUSTOMER2

--1-5 SELECT�� ���� �ټ��� ������ ���.
INSERT INTO T_CUSTOMER2 (CUST_ID,	NAME, BIRTH, ADDRESS)
			     SELECT CUST_ID, NAME, BIRTH, ADDRESS
				   FROM T_Customer
				  WHERE CUST_ID > 3

SELECT * FROM T_CUSTOMER2

-- 1-6 ������ ���� ���
DECLARE @LS_NAME VARCHAR(10) = '�ҷ�'
INSERT INTO T_CUSTOMER2(CUST_ID, NAME) VALUES (20, @LS_NAME)
-- 1-7 ������ ���� ��� 2
INSERT INTO T_CUSTOMER2 (CUST_ID, NAME, BIRTH, ADDRESS)
				 SELECT CUST_ID, NAME, BIRTH, ADDRESS
				   FROM T_Customer
				  WHERE CUST_ID <=3

/******* UPDATE
 - ���̺��� �����͸� ����
 - UPDATE�� �⺻ ����
   UPDATE <���̺�>
      SET ���̸�1 = ��1
	      ���̸�2 = ��2
		  ���̸�3 = ��3
	WHERE [����]
*/

-- ����� �ܰ��� �����ؾ� �Ǵ� ���� ���� ��
SELECT * FROM T_FRUIT

UPDATE T_FRUIT
   SET UNIT_COST = 2500
 WHERE FRUIT = '���'

 --���ڸ� ���ϱ�.
 -- ��� ������ ������ ���纸�� 500�� �λ��� ���
UPDATE T_FRUIT
   SET UNIT_COST += 500


UPDATE T_FRUIT
   SET UNIT_COST = NULL
 WHERE FRUIT = '���'

/************DELETE
  ���̺��� ���� �����͸� ����
*/


DELETE T_CUSTOMER2
 WHERE CUST_ID BETWEEN 13 AND 19

 /********* DELETE�� UPDATE�� ������ �ʼ��� Ȯ�� �ؾ� �Ѵ�. */


 -- ���࿡ �����͸� ������ ������ ���?
 -- ��� �����Ͱ� ���� �� �����ϴ� ���

 -- ����, UPDATE, INSERT�� �̸� �����غ��� Ȯ���� �� ���� �� �� �ִ� ����� ������?
 
/*************************** Ʈ����� *************************
	Ʈ����� (TRANSACTION)
	 - ������ ���� ���� ���� �Ǵ� ���� (BEGIN TRAN, COMMIT, ROLLBACK)
	 - �������� �ϰ����� ������Ű�� ���ؼ�
	   . ������ ���� �� �߻��ϴ� �������� 10���� �����Ͱ� ����(INSERT, UPDATE, DELETE)�� ��
	     �߰��� 5���뿡 ������ �߻��Ͽ� Ʈ������� �������� �� �� ��� 
	 - Ʈ������� ������(�ݸ���)
	   . �ϳ��� Ʈ������� ����ǰ� ���� �� �� �ٸ� Ʈ������� ������ �� ����.
*/
BEGIN TRAN
DELETE T_CUSTOMER2
 WHERE CUST_ID <10

SELECT * FROM T_CUSTOMER2

-- BEGIN TRAN�� ���󺹱� �� ���
ROLLBACK

-- BEGIN TRAN�� ������ ���
COMMIT