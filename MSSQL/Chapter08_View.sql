/*
  - View
	  . ���� ���Ǵ� SELECT ������ �̸� ����� �ΰ�
	    ���̺�ó�� ȣ���Ͽ� ��� �� �� �ֵ��� ������.

	  . SQL SERVER�� VIEW�� �ϳ��� ���̺�κ��� Ư���÷�
	    �鸸 �����ְų� Ư�� ���ǿ� �´� ���� �����ִµ�
		��� �� �� ������
		�� �� �̻��� ���̺��� �����Ͽ� �ϳ��� VIEW�� �����
		���� �����ִµ� �̿� �� �� �ִ�.

	  . VIEW�� �⺻Ű�� ������ �����͸� ����, ����, ���� �۾��� �����ϴ� *****

	  . ���Ȼ��� ������ ���̺� �� �Ϻ� �÷��� �����ϰų�
	    ���� �۾��� ������ �� ����Ѵ�.

*/


-- VIEW�� �ۼ�

-- ���ϰ��� ���ں� �Ǹ�, ���� ����Ʈ�� VIEW�� �����
-- VIEW�� ȣ���Ͽ� �����͸� ǥ��

CREATE VIEW V_FRUIT_ORDERSALES_LIST AS
(

--   VIEW�� ���� ǥ���� ����
    SELECT	 '�Ǹ�'                              AS TITLE,
			  A.DATE                             AS DATE,
              B.NAME                             AS CSTINFO,
	          C.FRUIT                            AS FRUIT,
	          A.AMOUNT                           AS AMOUNT,
			  A.AMOUNT*C.UNIT_COST			     AS INOUTPRICE
  FROM T_SalesList A LEFT JOIN T_Customer B
					        ON A.CUST_ID = B.CUST_ID
					 LEFT JOIN T_FRUIT C
							ON A.FRUIT = C.FRUIT
UNION ALL
SELECT      '����'	                             AS TITLE,
	        A.ORDERDATE                          AS DATE,
       CASE A.CUSTCODE WHEN 10 THEN '�븲'
				       WHEN 20 THEN '����'
					   WHEN 30 THEN '�ϳ�'
					   WHEN 40 THEN '����' END   AS CUSTINFO,
	        A.FRUIT                              AS FRUIT,
	        A.AMOUNT                             AS AMOUNT,
			-(A.AMOUNT*B.UNIT_COST)		     AS INOUTPRICE
  FROM T_ORDERLIST A LEFT JOIN T_FRUIT B
							ON A.FRUIT = B.FRUIT
)


-- V_FRUIT_ORDERSALES_LIST �� ȣ��
SELECT DATE 		   AS DATE,
	   SUM(INOUTPRICE) AS DAYPRICE
  FROM V_FRUIT_ORDERSALES_LIST
GROUP BY DATE



/*****************************�ǽ�**************************
������ ���� V_FRUIT_ORDERSALES_LIST�� �̿��Ͽ�
���� ���Կ��� ���� �ݾ��� ���� ���Ҵ� ��ü�� ���� �ݾ��� �����ϼ���.
*/ 

-- 0. ��ü�� ���ֱݾ� ����Ʈ�� VIEW�� �����غ��ô�.
CREATE VIEW V_ORDERPERCUST_PRICE AS
(
	SELECT CSTINFO             AS CSTINFO,
		   SUM(INOUTPRICE)  AS TOTAL_ORDERPRICE
	      FROM V_FRUIT_ORDERSALES_LIST
	     WHERE TITLE = '����'
	    GROUP BY CSTINFO
)
-- 1. ��ü���� ���� ���� �ݾ��� ���� ���� ����
SELECT *
  FROM V_ORDERPERCUST_PRICE
 WHERE TOTAL_ORDERPRICE = (SELECT MIN(TOTAL_ORDERPRICE) AS MAXPRICE
						    FROM V_ORDERPERCUST_PRICE)




/******** KEY �÷��� ������ VIEW�� DATA ��� ���� ���� �ϴ� ����. */

-- VIEW ���� (�� ����)
CREATE VIEW V_CUSTOMER AS
(
	SELECT CUST_ID, NAME
	  FROM T_Customer
	 WHERE CUST_ID > 2
)

SELECT *
  FROM V_CUSTOMER

-- VIEW�� ������ ���
INSERT INTO V_CUSTOMER (CUST_ID, NAME) VALUES(6, '������')

-- ������ �信 �����Ͱ� ��ϵ� ���� �ƴ� T_CUSTOMER�� ��ϵ�.
SELECT * FROM T_Customer

-- VIEW ����
DROP VIEW V_CUSTOMER



/***********************�ǽ�********************************************
 �Ʒ� POINT 5�� �����Ͽ�
    1. ���ں� �� �Ǹűݾ��� VIEW�� ����� (V_DAY_SALELIST)
	2. ���ں� �� ���ֱݾ��� VIEW�� ������ (V_DAY_ORDERLIST)

	������ VIEW�� ���� 

	�Ǹ�, ���� �� ��ü ������ ������ ���ϼ���.
	
	ǥ�� �÷� : TOTALMARGIN(�Ѹ���)

	UNION�� ���
	JOIN �� ���
*/
 


 -- [POINT 5] UNION �� ���� �ʰ� JOIN ���� ǥ��

-- 1.���� �� �� �Ǹ� �ݾ� ����
SELECT A.DATE                 AS DATE,
      SUM(A.AMOUNT * B.UNIT_COST) AS INOUTPRICE
  FROM T_SalesList A LEFT JOIN T_Fruit B 
                     ON A.FRUIT = B.FRUIT
GROUP BY  A.DATE

-- 2. ���� �� �� ���� �ݾ� ����
SELECT A.ORDERDATE            AS DATE,
      SUM(A.AMOUNT * B.UNIT_COST) AS INOUTPRICE
  FROM T_OrderList A LEFT JOIN T_Fruit B 
                     ON A.FRUIT = B.FRUIT
GROUP BY A.ORDERDATE


-- 3. �� �Ǹűݾ� �� �� ���� �ݾ� �� ����.

SELECT AA.DATE,
      (ISNULL(AA.INOUTPRICE,0) - ISNULL(BB.INOUTPRICE,0)) AS TOTALMARGIN
  FROM (SELECT A.DATE                 AS DATE,
             SUM(A.AMOUNT * B.UNIT_COST) AS INOUTPRICE
         FROM T_SalesList A LEFT JOIN T_Fruit B 
                            ON A.FRUIT = B.FRUIT
       GROUP BY  A.DATE) AA LEFT JOIN (SELECT A.ORDERDATE            AS DATE,
                                      SUM(A.AMOUNT * B.UNIT_COST) AS INOUTPRICE
                                  FROM T_OrderList A LEFT JOIN T_Fruit B 
                                                     ON A.FRUIT = B.FRUIT
                                GROUP BY A.ORDERDATE ) BB
                            ON AA.DATE = BB.DATE

-- 1. ���� �� �� �Ǹ� �ݾ� ���� VIEW ����
CREATE VIEW V_DAY_SALELIST AS
(
	SELECT A.DATE                 AS DATE,
           SUM(A.AMOUNT * B.UNIT_COST) AS INOUTPRICE
      FROM T_SalesList A LEFT JOIN T_Fruit B 
                     ON A.FRUIT = B.FRUIT
	GROUP BY  A.DATE
)
-- 2. ���� �� �� ���� �ݾ� ���� VIEW ����
CREATE VIEW V_DAY_ORDERLIST AS
(
	SELECT A.ORDERDATE            AS DATE,
           SUM(A.AMOUNT * B.UNIT_COST) AS INOUTPRICE
	  FROM T_OrderList A LEFT JOIN T_Fruit B 
                     ON A.FRUIT = B.FRUIT
	GROUP BY A.ORDERDATE
)

-- JOIN ���
SELECT SUM(MARGINPRICE)					TOTALMARGIN
  FROM	(SELECT ISNULL(A.INOUTPRICE,0) - ISNULL(B.INOUTPRICE,0) MARGINPRICE
		  FROM V_DAY_SALELIST A LEFT JOIN V_DAY_ORDERLIST B
									    ON A.DATE = B.DATE)AA


-- UNION ���
SELECT SUM(AA.INOUTPRICE) TOTALMARGIN
  FROM (SELECT INOUTPRICE
		  FROM V_DAY_SALELIST 
		
		UNION ALL
		
		SELECT -(INOUTPRICE)
		  FROM V_DAY_ORDERLIST) AA

-- 1. ������ UNION ���
SELECT SUM(INOUTPRICE) AS TOTALMARGIN
FROM (SELECT INOUTPRICE AS INOUTPRICE
	    FROM V_DAY_SALELIST
	  
	  UNION ALL
	  
	  SELECT -INOUTPRICE AS INOUTPRICE
	   FROM V_DAY_ORDERLIST) AA

-- 2. ������ JOIN ���
       SELECT SUM(ISNULL(B.INOUTPRICE,0) - ISNULL(A.INOUTPRICE,0))   PRICE
         FROM V_DAY_ORDERLIST A FULL JOIN V_DAY_SALELIST B
							   ON A.DATE = B.DATE

SELECT *
  FROM V_DAY_SALELIST
UNION ALL
SELECT *
  FROM V_DAY_ORDERLIST


