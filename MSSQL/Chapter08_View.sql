/*
  - View
	  . 자주 사용되는 SELECT 구문을 미리 만들어 두고
	    테이블처럼 호출하여 사용 할 수 있도록 만든기능.

	  . SQL SERVER의 VIEW는 하나의 테이블로부터 특정컬럼
	    들만 보여주거나 특정 조건에 맞는 행을 보여주는데
		사용 될 수 있으며
		두 개 이상의 테이블을 조인하여 하나의 VIEW로 사용자
		에게 보여주는데 이용 할 수 있다.

	  . VIEW는 기본키를 포함한 데이터를 삽입, 삭제, 수정 작업이 가능하다 *****

	  . 보안상의 이유로 테이블 중 일부 컬럼만 공개하거나
	    갱신 작업을 방지할 때 사용한다.

*/


-- VIEW의 작성

-- 과일가게 일자별 판매, 발주 리스트를 VIEW로 만들고
-- VIEW를 호출하여 데이터를 표현

CREATE VIEW V_FRUIT_ORDERSALES_LIST AS
(

--   VIEW를 통해 표현할 내용
    SELECT	 '판매'                              AS TITLE,
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
SELECT      '발주'	                             AS TITLE,
	        A.ORDERDATE                          AS DATE,
       CASE A.CUSTCODE WHEN 10 THEN '대림'
				       WHEN 20 THEN '삼전'
					   WHEN 30 THEN '하나'
					   WHEN 40 THEN '농협' END   AS CUSTINFO,
	        A.FRUIT                              AS FRUIT,
	        A.AMOUNT                             AS AMOUNT,
			-(A.AMOUNT*B.UNIT_COST)		     AS INOUTPRICE
  FROM T_ORDERLIST A LEFT JOIN T_FRUIT B
							ON A.FRUIT = B.FRUIT
)


-- V_FRUIT_ORDERSALES_LIST 뷰 호출
SELECT DATE 		   AS DATE,
	   SUM(INOUTPRICE) AS DAYPRICE
  FROM V_FRUIT_ORDERSALES_LIST
GROUP BY DATE



/*****************************실습**************************
위에서 만든 V_FRUIT_ORDERSALES_LIST를 이용하여
과일 가게에서 발주 금액이 가장 많았던 업체와 발주 금액을 산출하세요.
*/ 

-- 0. 업체별 발주금액 리스트를 VIEW로 생성해봅시다.
CREATE VIEW V_ORDERPERCUST_PRICE AS
(
	SELECT CSTINFO             AS CSTINFO,
		   SUM(INOUTPRICE)  AS TOTAL_ORDERPRICE
	      FROM V_FRUIT_ORDERSALES_LIST
	     WHERE TITLE = '발주'
	    GROUP BY CSTINFO
)
-- 1. 업체별로 가장 발주 금액이 많은 값을 산출
SELECT *
  FROM V_ORDERPERCUST_PRICE
 WHERE TOTAL_ORDERPRICE = (SELECT MIN(TOTAL_ORDERPRICE) AS MAXPRICE
						    FROM V_ORDERPERCUST_PRICE)




/******** KEY 컬럼을 포함한 VIEW에 DATA 등록 수정 삭제 하는 로직. */

-- VIEW 생성 (고객 정보)
CREATE VIEW V_CUSTOMER AS
(
	SELECT CUST_ID, NAME
	  FROM T_Customer
	 WHERE CUST_ID > 2
)

SELECT *
  FROM V_CUSTOMER

-- VIEW에 데이터 등록
INSERT INTO V_CUSTOMER (CUST_ID, NAME) VALUES(6, '윤종신')

-- 실제로 뷰에 데이터가 등록된 것이 아닌 T_CUSTOMER에 등록됨.
SELECT * FROM T_Customer

-- VIEW 삭제
DROP VIEW V_CUSTOMER



/***********************실습********************************************
 아래 POINT 5를 참조하여
    1. 일자별 총 판매금액을 VIEW로 만들고 (V_DAY_SALELIST)
	2. 일자별 총 발주금액을 VIEW로 생성후 (V_DAY_ORDERLIST)

	생성한 VIEW를 통해 

	판매, 발주 된 전체 내역의 마진을 구하세요.
	
	표현 컬럼 : TOTALMARGIN(총마진)

	UNION을 사용
	JOIN 을 사용
*/
 


 -- [POINT 5] UNION 을 쓰지 않고 JOIN 으로 표현

-- 1.일자 별 총 판매 금액 산출
SELECT A.DATE                 AS DATE,
      SUM(A.AMOUNT * B.UNIT_COST) AS INOUTPRICE
  FROM T_SalesList A LEFT JOIN T_Fruit B 
                     ON A.FRUIT = B.FRUIT
GROUP BY  A.DATE

-- 2. 일자 별 총 발주 금액 산출
SELECT A.ORDERDATE            AS DATE,
      SUM(A.AMOUNT * B.UNIT_COST) AS INOUTPRICE
  FROM T_OrderList A LEFT JOIN T_Fruit B 
                     ON A.FRUIT = B.FRUIT
GROUP BY A.ORDERDATE


-- 3. 총 판매금액 과 총 발주 금액 을 연결.

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

-- 1. 일자 별 총 판매 금액 산출 VIEW 생성
CREATE VIEW V_DAY_SALELIST AS
(
	SELECT A.DATE                 AS DATE,
           SUM(A.AMOUNT * B.UNIT_COST) AS INOUTPRICE
      FROM T_SalesList A LEFT JOIN T_Fruit B 
                     ON A.FRUIT = B.FRUIT
	GROUP BY  A.DATE
)
-- 2. 일자 별 총 발주 금액 산출 VIEW 생성
CREATE VIEW V_DAY_ORDERLIST AS
(
	SELECT A.ORDERDATE            AS DATE,
           SUM(A.AMOUNT * B.UNIT_COST) AS INOUTPRICE
	  FROM T_OrderList A LEFT JOIN T_Fruit B 
                     ON A.FRUIT = B.FRUIT
	GROUP BY A.ORDERDATE
)

-- JOIN 사용
SELECT SUM(MARGINPRICE)					TOTALMARGIN
  FROM	(SELECT ISNULL(A.INOUTPRICE,0) - ISNULL(B.INOUTPRICE,0) MARGINPRICE
		  FROM V_DAY_SALELIST A LEFT JOIN V_DAY_ORDERLIST B
									    ON A.DATE = B.DATE)AA


-- UNION 사용
SELECT SUM(AA.INOUTPRICE) TOTALMARGIN
  FROM (SELECT INOUTPRICE
		  FROM V_DAY_SALELIST 
		
		UNION ALL
		
		SELECT -(INOUTPRICE)
		  FROM V_DAY_ORDERLIST) AA

-- 1. 선생님 UNION 사용
SELECT SUM(INOUTPRICE) AS TOTALMARGIN
FROM (SELECT INOUTPRICE AS INOUTPRICE
	    FROM V_DAY_SALELIST
	  
	  UNION ALL
	  
	  SELECT -INOUTPRICE AS INOUTPRICE
	   FROM V_DAY_ORDERLIST) AA

-- 2. 선생님 JOIN 사용
       SELECT SUM(ISNULL(B.INOUTPRICE,0) - ISNULL(A.INOUTPRICE,0))   PRICE
         FROM V_DAY_ORDERLIST A FULL JOIN V_DAY_SALELIST B
							   ON A.DATE = B.DATE

SELECT *
  FROM V_DAY_SALELIST
UNION ALL
SELECT *
  FROM V_DAY_ORDERLIST


