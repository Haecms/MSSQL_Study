/* 1. INSERT 
  - ���̺� �����͸� ��� 
  - INSERT �� �⺻����
    . INSERT INTO < ���̺� > (���̸�1, ���̸�2,....) VALUES (��1, ��2....)
*/

-- 1-1 �� ���̺� ������ ���. 
INSERT INTO T_Custmer (CUST_ID, NAME,     PHONE) 
               VALUES (7,       '��â��', '7777-7777')






-- 1-2 ��� �÷��� �����͸� ��� �� ���� �÷��� �̸� ���� ����. 
INSERT INTO T_Custmer VALUES (8, '��ȿ��', '1981' ,'����','8888-8888')






SELECT * FROM T_Custmer
SELECT * FROM T_CUSTOMER3

-- 1-3 ���̺��� ����. (�����Ϳ� ���ÿ� ����)
SELECT * INTO T_CUSTOMER3 FROM T_Custmer









-- 1-5 SELECT �� ���� �ټ� �� ������ ���. 
INSERT INTO T_CUSTOMER3 (CUST_ID,    NAME , BIRTH, ADDRESS) 
			      SELECT CUST_ID, NAME, BIRTH, ADDRESS
				    FROM T_Custmer
				   WHERE CUST_ID > 3








-- 1-6 ������ ���� ���
DECLARE @LS_NAME VARCHAR(10) = '����'
INSERT INTO T_CUSTOMER2(CUST_ID, NAME)
                 VALUES (21, @LS_NAME)










-- 1-7 ������ ���� ��� 2
DECLARE @LS_NAME2 VARCHAR(10) = 'Ȳ����'
INSERT INTO T_CUSTOMER2 (CUST_ID, NAME,        BIRTH,   ADDRESS)
				  SELECT CUST_ID, 
				         @LS_NAME2,   
						 BIRTH,   
						 ADDRESS
				    FROM T_Custmer
				   WHERE CUST_ID <= 3










/***** UPDATE 
 - ���̺��� �����͸� ����. 

 - UPDATE �� �⺻ ���� 
   UPDATE <���̺�>
      SET ���̸�1 = ��1,
	      ���̸�2 = ��2,
		  ���̸�3 = ��3
	WHERE [����]
*/

-- ����� �ܰ��� �����ؾ� �Ǵ� ���� ������ . 
   UPDATE T_Fruit
      SET PRICE = 4000
	WHERE FRUIT < 15000

-- ���� �� ���ϱ� . 
-- ��� ������ ������ ���纸�� 500�� �λ��Ұ��. 
UPDATE T_Fruit
   SET PRICE = PRICE + 500 

UPDATE T_Fruit
   SET PRICE = NULL
 WHERE FRUIT = '���'

   


/****************** DELETE 
 ���̺��� ���� �����͸� ����. 
*/


DELETE T_CUSTOMER2
 WHERE CUST_ID BETWEEN 10 AND 15


/********** DELETE �� UPDATE �� ������ �ʼ��� Ȯ�� �ؾ� �Ѵ�. */


-- ���࿡ ������ �� ���� �� ������ ��� ? 
-- ��� �����Ͱ� ������ ���� �ϴ� ��� 

-- DELETE , UPDATE , INSERT �� �̸� ������ ���� Ȯ�� ���� ���� �Ҽ� �ִ� ��� ? 

/****************** Ʈ����� *****************
  . Ʈ����� (TRANSACTION) 
    - ������ ���� ���� ���� �Ǵ� ����  (BEGIN TRAN , COMMIT , ROLLBACK)
	- �������� �ϰ��� 
	  . ������ ���� �� �߻��ϴ� �������� 10���� �����Ͱ� ����(INSERT,UPDATE,DELETE)  �ɶ� 
	    �߰��� 5���뿡 ������ �߻� �Ͽ� Ʈ������� ���� ���� ���Ұ��. 
	- Ʈ������� ������ (�ݸ���)
	  . �ϳ��� Ʈ������� ����ǰ� ������ �Ǵٸ� Ʈ������� ���� �� ������. 

*/

BEGIN TRAN
DELETE T_CUSTOMER2
 where CUST_ID < 10

SELECT * FROM T_CUSTOMER2

-- begin tran �� ���󺹱� �� ���.
rollback

-- begin tran �� ���� �� ���. 
commit



