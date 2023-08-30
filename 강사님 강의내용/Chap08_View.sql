/*
	-View 
	  . ���� ���Ǵ� SELECT ������ �̸� ����� �ΰ� 
	    ���̺� ó�� ȣ���Ͽ� ��� �� �� �ֵ��� ������.

	  . SQL SERVER �� VIEW �� �ϳ��� ���̺�κ��� Ư���÷�
	    �鸸 �����ְų� Ʊ�� ���ǿ� �´� ���� �����ִµ�
		��� �ɼ� ������
		�ΰ� �̻��� ���̺��� �����Ͽ� �ϳ��� VIEW �� �����
		���� �����ִµ� �̿� �� �� �ִ�.
	  
	  . VIEW �� �⺻Ű �� ������ �����͸� ����, ����, ���� �۾��� ���� ***

	  . ���Ȼ��� ������ ���̺� �� �Ϻ� �÷��� ���� �ϰų� 
	    ���� �۾��� ���� �Ҷ� ����Ѵ�.  

*/


-- VIEW �� �ۼ�

-- ���ϰ��� ���ں� �Ǹ�, ���� ����Ʈ�� VIEW �� ����� 
-- VIEW �� ȣ���Ͽ� �����͸� ǥ��

CREATE VIEW V_FRUIT_ORDERSALE_LIST AS
(

--  VIEW �� ���� ǥ���� ����. 
SELECT '�Ǹ�'              AS TITLE
	   ,A.DATE              AS DATE
       ,B.NAME              AS CSTINFO
	   ,A.FURIT             AS FRUIT
	   ,A.AMOUNT            AS AMONT
	   ,A.AMOUNT * C.PRICE	AS INOUTPRICE
   FROM T_SalesList A JOIN T_Custmer B
						ON A.CUST_ID = B.CUST_ID
					  JOIN T_Fruit C 
					    ON A.FURIT = C.FRUIT
UNION ALL
SELECT '����'								   AS TITLE
	  ,A.ORDERDATE							   AS DATE
      ,CASE CUSTCODE WHEN '10' THEN '�븲'
				     WHEN '20' THEN '����'
					 WHEN '30' THEN '�ϳ�'
					 WHEN '40' THEN '����' END AS CUSTINFO
	  ,A.FRUIT								   AS FRUIT
	  ,A.AMOUNT								   AS AMOUNT
	  ,-(A.AMOUNT * B.PRICE)				   AS INOUTPRICE
  FROM T_ORDERLIST A LEFT JOIN T_Fruit B
							ON A.FRUIT = B.FRUIT )


-- V_FRUIT_ORDERSALE_LIST �� ȣ��
  SELECT DATE            AS DATE,
		 SUM(INOUTPRICE) AS DAYPRICE
    FROM V_FRUIT_ORDERSALE_LIST
GROUP BY DATE




/*************************************************** �ǽ� **************************
������ ����V_FRUIT_ORDERSALE_LIST �� �̿��Ͽ�
���ϰ��� ���� ���� �ݾ��� ���� ���Ҵ� ��ü �� ���� �ݾ��� �����ϼ���.
*/

-- 0. ��ü�� ���ֱݾ� ����Ʈ VIEW �� ����
	CREATE VIEW V_ORDERPERCUST_PRICE AS 
	(
	   SELECT CSTINFO          AS CSTINFO,
	   	       SUM(INOUTPRICE) AS TOTL_ORDERPRICE
	     FROM V_FRUIT_ORDERSALE_LIST
	    WHERE TITLE = '����'
	 GROUP BY CSTINFO
	) 

-- 1. ��ü���� ���� ���� �ݾ��� ���� ���� ����
SELECT * 
  FROM V_ORDERPERCUST_PRICE
 WHERE TOTL_ORDERPRICE = (SELECT MIN(TOTL_ORDERPRICE) AS MAXPRICE
							 FROM V_ORDERPERCUST_PRICE)



	 
/***** KEY �÷��� ������ VIEW �� DATA ��� ���� ����. */

-- VIEW ���� (�� ����)
CREATE VIEW V_CUSTOMER AS
(
	SELECT CUST_ID, NAME
	  FROM T_Custmer 
	 WHERE CUST_ID > 2
)

SELECT * FROM V_CUSTOMER

-- VIEW �� ������ ���
INSERT INTO V_CUSTOMER (CUST_ID, NAME) VALUES(6,'������')

-- ���� �� �� �� �����Ͱ� ��� �� ���� �ƴ� T_CUSTOMER �� ��ϵ�.
SELECT * FROM T_Custmer

-- VIEW ����
DROP VIEW V_CUSTOMER
				


/******************** �ǽ� ************************
 
�Ʒ� point 5  �� �����Ͽ� 
	1. ���ں� �� �Ǹűݾ� �� view �� ����� (V_DAY_SALELIST)
	2. ���ں� �� ���ֱݾ� �� view �� ������ (V_DAY_ORDERLIST)

	������ VIEW �� ���� 
	�Ǹ� , ���� �� ��ü ������ ������ ���ϼ���. 
	
	ǥ�� �÷� : TOTALMARGIN(�Ѹ���)
	
	UNION �� ���
	JOIN  �� ���
	*/


-- [POINT 5]

-- 1.���� �� �� �Ǹ� �ݾ� ���� VIEW ����
CREATE VIEW V_DAY_SALELIST AS 
(
	SELECT A.DATE                 AS DATE,
	      SUM(A.AMOUNT * B.PRICE) AS INOUTPRICE
	  FROM T_SalesList A LEFT JOIN T_Fruit B 
								ON A.FURIT = B.FRUIT
	GROUP BY  A.DATE 
)



-- 2. ���� �� �� ���� �ݾ� ����
CREATE VIEW V_DAY_ORDERLIST AS
(
	SELECT A.ORDERDATE            AS DATE,
	      SUM(A.AMOUNT * B.PRICE) AS INOUTPRICE
	  FROM T_OrderList A LEFT JOIN T_Fruit B 
								ON A.FRUIT = B.FRUIT
	GROUP BY A.ORDERDATE
)


-- 3. UNION �� �̿��ؼ� �� ����. 

SELECT SUM(INOUTPRICE) AS TOTALMARGIN
  FROM (SELECT INOUTPRICE AS INOUTPRICE
		  FROM V_DAY_SALELIST
		
		UNION ALL
		
		SELECT -INOUTPRICE AS INOUTPRICE
		  FROM V_DAY_ORDERLIST) AA 

-- 4. JOIN �� �̿��ؼ� �� ���� 
SELECT * FROM V_DAY_SALELIST
SELECT * FROM V_DAY_ORDERLIST

	SELECT SUM(ISNULL(B.INOUTPRICE,0) - ISNULL(A.INOUTPRICE,0))
	  FROM V_DAY_ORDERLIST A FULL JOIN  V_DAY_SALELIST B
								   ON A.DATE = B.DATE

	SELECT *
	  FROM V_DAY_SALELIST A FULL JOIN  V_DAY_ORDERLIST B
								   ON A.DATE = B.DATE