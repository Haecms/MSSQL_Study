/*********************************************************************
���� ��üŽ����
MyFirstDataBase

--> c����̺꿡�� �������� ù�� ° �������� �ѱ� --> excel�����̶� ���̺� ������ �ȸ¾� --> �������� ���� �°� ��ȭ ���Ѽ�(������ c������ ��ȣ�� �Ǹ��������� ����)
--> dbo.T_Customer
--> ������ Ŭ�� ���� 200�� ���� ����
--> ���� �� �����ͺ��̽� ���̺� �ٿ��ֱ�
 

 -->dbo. T.salesList
 --> ������ Ŭ�� ������--> CUST_ID, FRUIT, PRICE, AMOUNT, DATE ���� ĭ ������
 --> ������ Ŭ�� ���� 200�� ���� ���� --> ���� T_SalesList �� ���� �ٿ��ֱ�

*/
/***********************************************************************************************************************************************

1. ���̺� �� ������ ���� �� ��ȸ (Join)

  JOIN : �� �̻��� ���̺��� ���� �ؼ� �����͸� �˻��ϴ� ���
		 ���̺��� ���� ���� �ϱ� ���ؼ��� !!�ϳ� �̻��� �÷��� ����!!�ϰ� �־���Ѵ�.
  
    ON : �� ���̺��� ���� �� ���� Į�� ���� �� ���� ���̺��� ���� ���

 - JOIN�� ����
  .  ���� ���� (INNER JOIN)  : JOIN (����Ʈ ������ --> ��κ��� JOIN �� INNER JOIN�� �ǹ��Ѵ�)
							 : �� �̻��� ���̺��� ���� �Ǿ��� �� �ݵ�� �����̺� ���ÿ�!! ���� ����!! �ؾ��Ѵ�.
							   �ϳ��� ���̺��̶� �����Ͱ� ���� ��� �����Ͱ� ǥ������ �ʴ´�.

  .  �ܺ� ���� (OUTER JOIN)  : (LEFT JOIN, RIGHT JOIN, FULL JOIN) --> ����
							   �� �̻��� ���̺��� ���� �Ǿ��� ���
							   �ϳ��� ���̺� �����Ͱ� ������ �ϴ��� �����Ͱ� ǥ���� �Ǵ� ����

***** */

/* 

   T_Customer : �� (SUB)
   T_SalesList : �Ǹ��̷� (MAIN TABLE)
   --> ���� ���̺� �������� ����� �����ͼ� ��������(JOIN)�Ǵ� 

   T_Customer ���̺�� T_SalesList ���̺� ����
   ���� �� ID, ���̸�, �Ǹ�����, ���� , �Ǹ� ������ ǥ���ϼ���

*/

-- ��������� JOIN�� ON�� �Ἥ ǥ���ϴ� ���

SELECT * FROM T_Customer	
SELECT * FROM T_SalesList	

SELECT A.CUST_ID,   -- �Ǹ����̺��� MAIN�̴� ���ο� �ִ� A���̺� ID�� ���� ���� ����.
	   B.NAME,
	   A.DATE,
	   A.FRUIT,
	   A.AMOUNT
  FROM T_SalesList A JOIN T_Customer B   -- �Ǹ��̷� ���̺��� A��� �̸� ���̰�// �� ���̺��� B
			  ON A.CUST_ID = B.CUST_ID	 -- JOIN�� ON�� ��Ʈ --> ON(�������Ǳ��) : A�� ��ID �׸�� B�� �� ID �׸��� �����Ͽ� JOIN �ϰڴ�.


SELECT A.*,B.*
  FROM T_SalesList A JOIN T_Customer B
					   ON A.CUST_ID =B.CUST_ID



SELECT B.CUST_ID,   -- �����̺��� Main���� �ΰ� ���� �� // ���� ���� ��� ���� �Ȱ�����  '� ���̺��� �����̳�' ��� �ִ� ������ �ٸ���.
	   A.NAME,
	   B.DATE,
	   B.FRUIT,
	   B.AMOUNT
  FROM T_Customer A JOIN T_SalesList B   
			  ON A.CUST_ID = B.CUST_ID	


-- JOIN : T_Customer ���̺��� �������� ��ȸ ������, T_SalesLiST ���̺� 
--		  T_Customer Table 5�� �̼��� ���� �����Ͱ� ������ // T_SalesList���� CUST_ID 5���� �̼��� ������ ������ �����Ƿ� 
--		  �Ʊ� ���� ���� �������ο����� Ư¡
--        �� �̻��� ���̺��� ���� �Ǿ��� �� �ݵ�� �����̺� ���ÿ�!! ���� ����!! �ؾ��Ѵ�. // �ϳ��� ���̺��̶� �����Ͱ� ���� ��� ���� �����Ͱ� ǥ������ �ʴ´�.
--		  ���� JOIN�� ���̺� ��� ���� CUST_ID 5���� �̼��� ���� ������ ǥ������ �ʴ´�.


-- JOIN ���̺��� ���������� �ۼ��Ͽ� ����
-- . ��ȸ�� ���ϴ� �����Ͱ� ������ �ӽ� ���̺� ���·� ���ι��� �ϼ��ϴ�
SELECT *
  FROM T_Customer A JOIN (SELECT CUST_ID,
								 FRUIT,
								 DATE
							FROM T_SalesList
							WHERE DATE < '2022-12-02') B
					  ON A.CUST_ID = B.CUST_ID


/***** OUTER JOIN ******************************************
1. LEFT JOIN
  . ���ʿ� �ִ� ���̺��� �����͸� �������� �����ʿ� �ִ� ���̺���
    �����͸� �˻� �� �����ϰ�, �����Ͱ� ���� ��� NULL�� ǥ�� �ȴ�.
*/

-- �� ���� �Ǹ� �̷��� ��ȸ�� ������
-- ISNULL�κ��� CASE WHEN���� �����ؼ� ǥ���غ�����
SELECT A.CUST_ID,
	   A.NAME,
	   ISNULL(B.FRUIT, '�Ǹ��̷¾���') AS FRUIT,
	   ISNULL(B.AMOUNT,'0') AS AMOUNT,
	   B.DATE
  FROM T_Customer A LEFT JOIN T_SalesList B
						   ON A.CUST_ID = B.CUST_ID

SELECT A.CUST_ID,
	   A.NAME,
	   CASE WHEN B.FRUIT IS NULL THEN '�Ǹ��̷¾���'
								 ELSE B.FRUIT END    AS FRUIT,
	   CASE WHEN B.AMOUNT IS NULL THEN 0
								  ELSE B.AMOUNT END  AS AMOUNT,
	   B.DATE
  FROM T_Customer A LEFT JOIN T_SalesList B
						   ON A.CUST_ID = B.CUST_ID
 -- ���� �غ��� WHERE�� ���̽� �����ұ�
 SELECT A.CUST_ID,
	   A.NAME,
	   B.FRUIT,
	   B.AMOUNT,
	   B.DATE
  FROM T_Customer A LEFT JOIN T_SalesList B
						   ON A.CUST_ID = B.CUST_ID
 WHERE B.FRUIT = CASE WHEN B.FRUIT IS NULL THEN '�Ǹ��̷¾���'
										   ELSE B.FRUIT END
   OR B.AMOUNT = CASE WHEN B.AMOUNT IS NULL THEN 0
											ELSE B.AMOUNT END


-- ���� ���̺��� LEFT JOIN�� �Ἥ �Ǹ��̷����̺��  �������� ��
SELECT A.CUST_ID,	
	   B.NAME,
	   A.FRUIT,
	   A.AMOUNT
  FROM T_SalesList A LEFT JOIN T_Customer B
							ON A.CUST_ID = B.CUST_ID

-- RIGHT JOIN
-- �����ʿ� �ִ� ���̺��� �����͸� �������� ���ʿ� �ִ� ���̺���
-- �����͸� �˻��ϰ� ���� ���̺� �����Ͱ� ������� NULL

-- ���� �Ǹ���Ȳ, (���� �Ǹ� �̷��� ��� �����ʹ� ���;� �Ѵ�.)
-- �Ǹ� ��Ȳ�� �� ����(�Ǹ��̷¿� ���� ���� ��Ÿ�� �ʿ䰡 ����)

-- RIGHT JOIN
SELECT B.CUST_ID,
	   B.NAME,
	   A.FRUIT,
	   A.AMOUNT
  FROM T_SalesList A RIGHT JOIN T_Customer B
							ON A.CUST_ID = B.CUST_ID
-- LEFT JOIN
SELECT A.CUST_ID,
	   A.NAME,
	   B.FRUIT,
	   B.AMOUNT
  FROM T_Customer A LEFT JOIN T_SalesList B
							ON A.CUST_ID = B.CUST_ID


-- ������ ǥ���� JOIN
-- JOIN ���� ���� �ʰ� ���̺��� ���� �� WHERE ���� �����÷� �����ϴ� ���
SELECT *
  FROM T_Customer A , T_SalesList B		-- JOIN�� ���� �ʰ� �޸��� �����
 WHERE A.CUST_ID = B.CUST_ID			-- WHERE���� ON ����ó�� ��� �κ��� ����Ǵ��� ǥ������� ��
   AND B.DATE > '2020-01-01'


/***************���� JOIN
 . ���� �� �����Ͱ� ���� ���̺� ���� ��
   ���� ���̺�� ���� ���̺���� ���� JOIN���� �����͸� ǥ���� �� �ִ�.
*/

-- ������ �Ǹ� ��Ȳ�� 
-- �Ǹ�����, ���̸�, ����ó, �ǸŰ���, ���ϴܰ�, �ǸŰ��� �Ǹűݾ����� ��Ÿ������.
SELECT A.DATE                                     AS DATE,
	   B.NAME                                     AS NAME,
	   B.ADDRESS                                  AS ADDRESS,
	   A.FRUIT                                    AS FRUIT,
	   C.UNIT_COST                                AS UNIT_COST,
	   A.AMOUNT                                   AS AMOUNT,
	   CASE WHEN A.PRICE IS NULL THEN C.UNIT_COST * A.AMOUNT
								 ELSE A.PRICE END AS TOTALPRICE
  FROM T_SalesList A JOIN T_Customer B
					   ON A.CUST_ID = B.CUST_ID
					 JOIN T_FRUIT C					-- �ؿ� ON�� ���� �� �����ٴ� �����Ͽ� C���̺��� A���̺�� �̾������� B���̺�� �̾������� ��
					   ON A.FRUIT = C.FRUIT			-- A���̺�� C���̺��� ����ƴٴ°� �����⿡ C�� JOIN�� A�� ��.


/***********************�ǽ�*******************************
TB_StockMMrec : ���� ���� �̷� ���̺�
INOUTFLAG : �԰� ����, I : �԰�
TB_ItemMaster : ǰ�� ������
ITEMTYPE : ǰ�� ����, ROH : ������

���� ���� �̷� ���̺�(A) ���� ITEMCODE�� NULL�� �ƴϰ�,
INOUTFLAG�� I ��
ǰ�� ������ ���̺���(B) ITEMTYPE�� 'ROH'�� ����
A.INOUTDATE, A.INOUTSEQ, A.MATLOTNO, A.ITEMCODE, B.ITEMNAME�� ������ ��Ÿ������.
  - ���� �÷� A.ITEMCODE, B.ITEMCODE
  */
SELECT A.INOUTDATE,
	   A.INOUTSEQ,
	   A.MATLOTNO,
	   A.ITEMCODE,
	   B.ITEMNAME
  FROM TB_StockMMrec A LEFT JOIN TB_ItemMaster B
						 ON A.ITEMCODE = B.ITEMCODE
						AND B.ITEMTYPE = 'ROH'  -- (1) �̷��� �ϸ� 5�� ���� / JOIN�ϱ� ���� �����͸� ���͸�
 WHERE A.ITEMCODE IS NOT NULL
   AND A.INOUTFLAG = 'I'
   --AND B.ITEMTYPE = 'ROH'					    -- (2) �̷��� �ϸ� 3�� ���� / JOIN ���Ŀ� �ϼ��� �����͸� ���͸�

/* ����
ǰ�� ������ ITETYPE = 'ROH' ������ �߰� ��
���� �԰��̷� ���̺��� ITEMCODE �÷��� NULL ������ ���� ���� ���
1. JOIN ������ ������ �� ������ LEFT JOIN���� ���Ͽ�
   �����԰����� �̷� �� ITEMCODE�� ǥ���ǰ�
2. WHERE���� ������ �� ������ LEFT JOIN���� ���� ��� 
   ���Ŀ� ������ ����ǹǷ� ���͸��Ǿ� ǥ���� */

/***********************************�ǽ�*************************************
 �� �� ������ �� ��� �ݾ� ���ϱ�
 ��ID, �� ��, ���� �̸�, ���Ϻ� �� ��� �ݾ�
 */
 SELECT  C.CUST_ID	 AS CUST_ID,
		 A.FRUIT  	 AS FRUIT,
		 SUM(AMOUNT) AS EP_SALECNT,
		 SUM(A.AMOUNT * B.UNIT_COST) AS TOTALPRICE
   FROM T_SalesList A JOIN T_FRUIT B
					    ON A.FRUIT = B.FRUIT
					  JOIN T_Customer C
						ON A.CUST_ID = C.CUST_ID
GROUP BY C.CUST_ID, A.FRUIT
ORDER BY CUST_ID

-- Ǯ�� 1
SELECT A.CUST_ID,
	   A.FRUIT,
	   A.AMOUNT * B.UNIT_COST AS TOTALPRICE
  FROM (SELECT  CUST_ID	    AS CUST_ID,
    		    FRUIT  	    AS FRUIT,
    		    SUM(AMOUNT) AS AMOUNT
          FROM T_SalesList A
      GROUP BY CUST_ID, FRUIT) A LEFT JOIN T_FRUIT B
									  ON A.FRUIT = B.FRUIT
ORDER BY A.CUST_ID

-- Ǯ�� 2
SELECT A.CUST_ID,
       C.NAME,
	   B.FRUIT,
	   SUM(A.AMOUNT)			 AS AMOUNT,
	   SUM(A.AMOUNT*B.UNIT_COST) AS TOTALPRICE
  FROM T_SalesList A LEFT JOIN T_FRUIT B
							ON A.FRUIT = B.FRUIT
						  JOIN T_CUSTOMER C
						    ON A.CUST_ID = C.CUST_ID
GROUP BY A.CUST_ID , C.NAME, B.FRUIT
ORDER BY CUST_ID

/*************************�ǽ�*************************************

�� ���� �ݾ��� ���� ū ���� ǥ���ϼ���.
(ID, ���̸�, ���ּ�, ������ó, �� ���� �ݾ�)

�ִ��� �ݾ��� ���� ����� ��� ��� ��ȯ�ϴ���

*******************************************************/
SELECT
	   A.CUST_ID                 AS CUST_ID,
       C.NAME                    AS NAME   ,
	   C.ADDRESS                 AS ADDRESS,
	   C.PHONE                   AS PHONE  ,
	   SUM(A.AMOUNT*B.UNIT_COST) AS TOTALPRICE
FROM T_SalesList A LEFT JOIN T_FRUIT B
			ON A.FRUIT = B.FRUIT
		  JOIN T_CUSTOMER C
		    ON A.CUST_ID = C.CUST_ID
GROUP BY A.CUST_ID, C.NAME, C.ADDRESS, C.PHONE
ORDER BY TOTALPRICE DESC


-- 2�� ���
DECLARE @LI_MAXPRICEW INT

SELECT @LI_MAXPRICEW = MAX(AA.TOTAL_PRICE)
  FROM (SELECT SUM(A.AMOUNT * B.UNIT_COST) AS TOTAL_PRICE
		  FROM T_SalesList A JOIN T_FRUIT B
							   ON A.FRUIT = B.FRUIT		
							 JOIN T_Customer C
							   ON A.CUST_ID = C.CUST_ID
		GROUP BY A.CUST_ID) AA

SELECT C.CUST_ID                 AS CUST_ID,
       C.NAME                    AS NAME   ,
	   C.ADDRESS                 AS ADDRESS,
	   C.PHONE                   AS PHONE  ,
	   SUM(A.AMOUNT*B.UNIT_COST) AS TOTALPRICE
 FROM T_SalesList A JOIN T_FRUIT B
					  ON A.FRUIT = B.FRUIT
					JOIN T_CUSTOMER C
					  ON A.CUST_ID = C.CUST_ID
GROUP BY C.CUST_ID, C.NAME, C.ADDRESS, C.PHONE
HAVING SUM(A.AMOUNT * B.UNIT_COST) = @LI_MAXPRICEW


/************************�ǽ�*********************
2022-12-01 �Ϻ��� 2022-12-31(����)
���� ���� ���� �ȸ� ������ ������ �Ǹ� ������ ���ϼ���.

�����̸�, �Ǹż���
* �� �Ǹ� ������ ���� ������ N���� ������ ǥ���� ��
*/
DECLARE @LI_MAXAMOUNT INT

SELECT @LI_MAXAMOUNT = MAX(AA.TOTAL_AMOUNT)
  FROM (  SELECT SUM(A.AMOUNT) AS TOTAL_AMOUNT
            FROM T_SalesList A JOIN T_FRUIT B
		            			 ON A.FRUIT = B.FRUIT
		     AND A.DATE >= '2022-12-01' AND A.DATE<= '2022-12-31'
	    GROUP BY A.FRUIT) AA


SELECT A.FRUIT,
	   SUM(A.AMOUNT) AS AMOUNT
  FROM T_SalesList A JOIN T_FRUIT B
					  ON A.FRUIT = B.FRUIT
					 AND A.DATE >= '2022-12-01' AND A.DATE <= '2022-12-31'
GROUP BY A.FRUIT
HAVING SUM(A.AMOUNT) = @LI_MAXAMOUNT

-- ������

DECLARE @LI_MAXAMOUNT1 INT,
		@LS_STARTDATE VARCHAR(10) = '2022-12-01', -- ù° ��¥ ������ ��¥ �޼���?
		@LS_ENDDATE   VARCHAR(10) = '2022-12-31'

SELECT @LI_MAXAMOUNT1 = MAX(AA.TOTAL_AMOUNT)
  FROM (  SELECT SUM(A.AMOUNT) AS TOTAL_AMOUNT
            FROM T_SalesList A JOIN T_FRUIT B
		            			 ON A.FRUIT = B.FRUIT
		     AND A.DATE >= @LS_STARTDATE AND A.DATE<= @LS_ENDDATE
	    GROUP BY A.FRUIT) AA

SELECT A.FRUIT,
	   SUM(A.AMOUNT) AS AMOUNT
  FROM T_SalesList A JOIN T_FRUIT B
					  ON A.FRUIT = B.FRUIT
					 AND A.DATE >= @LS_STARTDATE AND A.DATE <= @LS_ENDDATE
GROUP BY A.FRUIT
HAVING SUM(A.AMOUNT) = @LI_MAXAMOUNT1

/**************************�ǽ�*******************************************88
 ���� �� ���� �ݾ��� 12����(120000)�� �Ѵ� ���� ������ �˻���ȸ�ϼ���.
 (��ID, �� �̸�, �� ���� �ݾ�)
*/
SELECT *
  FROM(SELECT A.CUST_ID,
			  B.NAME,
	          SUM(C.UNIT_COST*A.AMOUNT) AS TOTAL_PRICE
         FROM T_SalesList A JOIN T_Customer B
					          ON A.CUST_ID = B.CUST_ID
					        JOIN T_FRUIT C
					          ON A.FRUIT = C.FRUIT
     GROUP BY A.CUST_ID, B.NAME) AA
WHERE AA.TOTAL_PRICE>120000


-- �� ������ SUM �����Լ� �ѹ��� �Ἥ ǥ���غ�����.

/*******************************************************************************************************************
3. UNION / UNION ALL
 . �ټ��� �˻� ����(��)�� ��ġ�� ���.
 . ��ȸ�� �ټ��� SELECT ����� �ϳ��� ��ġ�� ���� �� (UNION)�� ���.

 UNION : �ߺ��Ǵ� ���� �ϳ��� ǥ��.
 UNION ALL : �ߺ��� �������� �ʰ� ��� ǥ��.

 ***** ������ ��ȸ���� ������ �÷��� ���İ� ������ ��ġ �ؾ��Ѵ�.
*/

-- UNION (�ߺ��Ǵ� �����ʹ� �����ϰ� ǥ���Ѵ�.)
-- ���ϴ� ���̺� �Ӹ� �ƴ϶� �ڽ��� ���̺� �ȿ����� �ߺ��� �Ͼ�ٸ� ������
SELECT DATE       AS DATE,
       CUST_ID    AS CSTINFO,
	   FRUIT      AS FRUIT,
	   AMOUNT     AS AMOUNT
  FROM T_SalesList
UNION
SELECT ORDERDATE AS DATE,
       CUSTCODE AS CUSTINFO,
	   FRUIT     AS FRUIT,
	   AMOUNT    AS AMOUNT
  FROM T_ORDERLIST


SELECT ORDERDATE AS DATE,
       CUSTCODE AS CUSTINFO,
	   FRUIT     AS FRUIT,
	   AMOUNT    AS AMOUNT,
	   COUNT(*)
  FROM T_ORDERLIST
GROUP BY ORDERDATE, CUSTCODE, FRUIT, AMOUNT

-- * UNION�� �ߺ��� �����͸� �����ϰ� ���ļ� ǥ���Ѵ�.

-- **********************************************************************
-- UNION ALL
SELECT DATE       AS DATE,
       CUST_ID    AS CSTINFO,
	   FRUIT      AS FRUIT,
	   AMOUNT     AS AMOUNT
  FROM T_SalesList
UNION ALL
SELECT ORDERDATE AS DATE,
       CUSTCODE AS CUSTINFO,
	   FRUIT     AS FRUIT,
	   AMOUNT    AS AMOUNT
  FROM T_ORDERLIST


  ------------ Ÿ��Ʋ ǥ���ϱ�.
  SELECT '�Ǹ�'     AS TITLE,
		 DATE       AS DATE,
         CUST_ID    AS CSTINFO,
	     FRUIT      AS FRUIT,
	     AMOUNT     AS AMOUNT
  FROM T_SalesList
UNION ALL
SELECT '����'	   AS TITLE,
	   ORDERDATE   AS DATE,
       CUSTCODE    AS CUSTINFO,
	   FRUIT       AS FRUIT,
	   AMOUNT      AS AMOUNT
  FROM T_ORDERLIST
  ORDER BY DATE



  /***********�ǽ�*************************
   �� �������
   �Ǹ��̷� ���� �� ID�� ���� �̸��� ǥ���ϰ�
   �����̷� ���� �ŷ�ó ���þ�ü���� ǥ��
   �� ID T_Customer���� ��������
   �ŷ�ó ���� 10:�븲, 20:����, 30:�ϳ�, 40:�������� ǥ���ϼ���
   1 : �̽±� 2: ����� 3: ������  4 : ������
  */
    SELECT	 '�Ǹ�'                              AS TITLE,
			  DATE                               AS DATE,
              B.NAME                             AS CSTINFO,
	          FRUIT                              AS FRUIT,
	          AMOUNT                             AS AMOUNT
  FROM T_SalesList A LEFT JOIN T_Customer B
					        ON A.CUST_ID = B.CUST_ID
UNION ALL
SELECT      '����'	                         AS TITLE,
	        ORDERDATE                        AS DATE,
       CASE CUSTCODE WHEN 10 THEN '�븲'
				     WHEN 20 THEN '����'
					 WHEN 30 THEN '�ϳ�'
					 WHEN 40 THEN '����' END AS CUSTINFO,
	        FRUIT                            AS FRUIT,
	        AMOUNT                           AS AMOUNT
  FROM T_ORDERLIST
  ORDER BY DATE





/*************************�ǽ�*************************************
���ֳ����� �ֹ�������
���� ������ �Ǹűݾ�(����*�ܰ�)��
�ֹ�(����) �ݾ� (���ּ���*�ܰ�)�� �߰��Ͽ� �����ּ���
* �÷� �̸��� INOUTPRICE
  ���� �� �ݾ��� (-)�� ǥ��
*/
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
  ORDER BY DATE

  /***************************�ǽ�*****************
�ΰ��� ������� ���� ������ ���� �� ���� �ݾ��� �����ϼ���.
 1 : UNION�� ����Ͽ� ���� �ݾ� ǥ��
 2 : UNION�� ������� �ʰ� ���� �ݾ� ǥ��
 
 �����ݾ� : �Ǹ��� �ѱݾ� - ���ֱݾ�

 . ǥ�� �� �÷� : DATE(����), MARGIN_DATE(�����ݾ�)
 */
 -- 1 UNION �״�� ����ϴ� ���
SELECT AA.DATE,								
	   SUM(AA.INOUTPRICE)						
 FROM (SELECT A.DATE                             AS DATE,
		      SUM(A.AMOUNT * C.UNIT_COST)	     AS INOUTPRICE
		 FROM T_SalesList A LEFT JOIN T_Customer B
					          ON A.CUST_ID = B.CUST_ID
					   LEFT JOIN T_FRUIT C
						      ON A.FRUIT = C.FRUIT
		GROUP BY A.DATE

    UNION ALL

	SELECT  A.ORDERDATE                        AS DATE,
			SUM(-(A.AMOUNT * B.UNIT_COST))		   AS INOUTPRICE
      FROM T_ORDERLIST A LEFT JOIN T_FRUIT B
							ON A.FRUIT = B.FRUIT
    GROUP BY A.ORDERDATE) AA
GROUP BY AA.DATE




 -- 1 UNION �״�� ����ϴ� ��� (2)
 SELECT *
   FROM (	SELECT	  A.DATE                             AS DATE,
						  A.AMOUNT*C.UNIT_COST			     AS INOUTPRICE
			  FROM T_SalesList A LEFT JOIN T_Customer B
								        ON A.CUST_ID = B.CUST_ID
								 LEFT JOIN T_FRUIT C
										ON A.FRUIT = C.FRUIT
			UNION ALL
			SELECT      A.ORDERDATE                          AS DATE,
						-(A.AMOUNT*B.UNIT_COST)		     AS INOUTPRICE
			  FROM T_ORDERLIST A LEFT JOIN T_FRUIT B
										ON A.FRUIT = B.FRUIT
			  ORDER BY DATE) AA





 -- 2 
SELECT A.DATE,
	   CASE WHEN A.IPGO IS NULL THEN 0
									     ELSE A.IPGO END+CASE WHEN B.BALJU IS NULL THEN 0
										 ELSE B.BALJU END								AS MARGIN_DATE
  FROM ( SELECT	 '�Ǹ�'									 AS TITLE,
				 A.DATE								 AS DATE,
				 SUM(A.AMOUNT*C.UNIT_COST)			     AS IPGO
		  FROM T_SalesList A LEFT JOIN T_Customer B
							        ON A.CUST_ID = B.CUST_ID
							 LEFT JOIN T_FRUIT C
									ON A.FRUIT = C.FRUIT
	  GROUP BY A.DATE) A LEFT JOIN (SELECT      '����'									 AS TITLE,
									     A.ORDERDATE								 AS DATE,
										 SUM(-(A.AMOUNT*B.UNIT_COST))		         AS BALJU
								   FROM T_ORDERLIST A LEFT JOIN T_FRUIT B
											    			 ON A.FRUIT = B.FRUIT
							   GROUP BY A.ORDERDATE) B
														     ON A.DATE = B.DATE
/* WHERE A.IPGO = CASE WHEN A.IPGO IS NULL THEN 0
									     ELSE A.IPGO END
    OR B.BALJU = CASE WHEN B.BALJU IS NULL THEN 0
										 ELSE B.BALJU END
										 */
ORDER BY A.DATE


-- [POINT 5] UNION�� ���� �ʰ� JOIN���� ǥ���սô�.
-- 1. ���� �� �� �Ǹ� �ݾ��� ����


--2. ���� �� �� ���� �ݾ� ����


SELECT AA.DATE,
	   (ISNULL(AA.INOUTPRICE,0) - ISNULL(BB.INOUTPRICE,0))     AS MARGIN_DATE
  FROM (SELECT A.DATE				       AS DATE,
	   SUM(A.AMOUNT * B.UNIT_COST) AS INOUTPRICE
  FROM T_SalesList A LEFT JOIN T_FRUIT B
							ON A.FRUIT = B.FRUIT
GROUP BY A.DATE) AA LEFT JOIN (SELECT A.ORDERDATE				AS DATE,
									  SUM(A.AMOUNT * B.UNIT_COST) AS INOUTPRICE
								  FROM T_OrderList A LEFT JOIN T_FRUIT B
															ON A.FRUIT = B.FRUIT
								GROUP BY A.ORDERDATE) BB
															ON AA.DATE = BB.DATE
