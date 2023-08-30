/*
	-View 
	  . 자주 사용되는 SELECT 구문을 미리 만들어 두고 
	    테이블 처럼 호출하여 사용 할 수 있도록 만든기능.

	  . SQL SERVER 의 VIEW 는 하나의 테이블로부터 특정컬럼
	    들만 보여주거나 튿정 조건에 맞는 행을 보여주는데
		사용 될수 있으며
		두개 이상의 테이블을 조인하여 하나의 VIEW 로 사용자
		에게 보여주는데 이용 할 수 있다.
	  
	  . VIEW 는 기본키 를 포함한 데이터를 삽입, 삭제, 수정 작업이 가능 ***

	  . 보안상의 이유로 테이블 중 일부 컬럼만 공개 하거나 
	    갱신 작업을 방지 할때 사용한다.  

*/


-- VIEW 의 작성

-- 과일가게 일자별 판매, 발주 리스트를 VIEW 로 만들고 
-- VIEW 를 호출하여 데이터를 표현

CREATE VIEW V_FRUIT_ORDERSALE_LIST AS
(

--  VIEW 를 통해 표현할 내용. 
SELECT '판매'              AS TITLE
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
SELECT '발주'								   AS TITLE
	  ,A.ORDERDATE							   AS DATE
      ,CASE CUSTCODE WHEN '10' THEN '대림'
				     WHEN '20' THEN '삼전'
					 WHEN '30' THEN '하나'
					 WHEN '40' THEN '농협' END AS CUSTINFO
	  ,A.FRUIT								   AS FRUIT
	  ,A.AMOUNT								   AS AMOUNT
	  ,-(A.AMOUNT * B.PRICE)				   AS INOUTPRICE
  FROM T_ORDERLIST A LEFT JOIN T_Fruit B
							ON A.FRUIT = B.FRUIT )


-- V_FRUIT_ORDERSALE_LIST 뷰 호출
  SELECT DATE            AS DATE,
		 SUM(INOUTPRICE) AS DAYPRICE
    FROM V_FRUIT_ORDERSALE_LIST
GROUP BY DATE




/*************************************************** 실습 **************************
위에서 만든V_FRUIT_ORDERSALE_LIST 를 이용하여
과일가게 에서 발주 금액이 가장 많았던 업체 과 발주 금액을 산출하세요.
*/

-- 0. 업체별 발주금액 리스트 VIEW 로 생성
	CREATE VIEW V_ORDERPERCUST_PRICE AS 
	(
	   SELECT CSTINFO          AS CSTINFO,
	   	       SUM(INOUTPRICE) AS TOTL_ORDERPRICE
	     FROM V_FRUIT_ORDERSALE_LIST
	    WHERE TITLE = '발주'
	 GROUP BY CSTINFO
	) 

-- 1. 업체별로 가장 발주 금액이 많은 값을 산출
SELECT * 
  FROM V_ORDERPERCUST_PRICE
 WHERE TOTL_ORDERPRICE = (SELECT MIN(TOTL_ORDERPRICE) AS MAXPRICE
							 FROM V_ORDERPERCUST_PRICE)



	 
/***** KEY 컬럼을 포함한 VIEW 에 DATA 등록 수정 삭제. */

-- VIEW 생성 (고객 정보)
CREATE VIEW V_CUSTOMER AS
(
	SELECT CUST_ID, NAME
	  FROM T_Custmer 
	 WHERE CUST_ID > 2
)

SELECT * FROM V_CUSTOMER

-- VIEW 에 데이터 등록
INSERT INTO V_CUSTOMER (CUST_ID, NAME) VALUES(6,'윤종신')

-- 실제 로 뷰 에 데이터가 등록 된 것이 아닌 T_CUSTOMER 에 등록됨.
SELECT * FROM T_Custmer

-- VIEW 삭제
DROP VIEW V_CUSTOMER
				


/******************** 실습 ************************
 
아래 point 5  를 참조하여 
	1. 일자별 총 판매금액 을 view 로 만들고 (V_DAY_SALELIST)
	2. 일자별 총 발주금액 을 view 로 생성후 (V_DAY_ORDERLIST)

	생성한 VIEW 를 통해 
	판매 , 발주 된 전체 내역의 마진을 구하세요. 
	
	표현 컬럼 : TOTALMARGIN(총마진)
	
	UNION 을 사용
	JOIN  을 사용
	*/


-- [POINT 5]

-- 1.일자 별 총 판매 금액 산출 VIEW 생성
CREATE VIEW V_DAY_SALELIST AS 
(
	SELECT A.DATE                 AS DATE,
	      SUM(A.AMOUNT * B.PRICE) AS INOUTPRICE
	  FROM T_SalesList A LEFT JOIN T_Fruit B 
								ON A.FURIT = B.FRUIT
	GROUP BY  A.DATE 
)



-- 2. 일자 별 총 발주 금액 산출
CREATE VIEW V_DAY_ORDERLIST AS
(
	SELECT A.ORDERDATE            AS DATE,
	      SUM(A.AMOUNT * B.PRICE) AS INOUTPRICE
	  FROM T_OrderList A LEFT JOIN T_Fruit B 
								ON A.FRUIT = B.FRUIT
	GROUP BY A.ORDERDATE
)


-- 3. UNION 을 이용해서 총 마진. 

SELECT SUM(INOUTPRICE) AS TOTALMARGIN
  FROM (SELECT INOUTPRICE AS INOUTPRICE
		  FROM V_DAY_SALELIST
		
		UNION ALL
		
		SELECT -INOUTPRICE AS INOUTPRICE
		  FROM V_DAY_ORDERLIST) AA 

-- 4. JOIN 을 이용해서 총 마진 
SELECT * FROM V_DAY_SALELIST
SELECT * FROM V_DAY_ORDERLIST

	SELECT SUM(ISNULL(B.INOUTPRICE,0) - ISNULL(A.INOUTPRICE,0))
	  FROM V_DAY_ORDERLIST A FULL JOIN  V_DAY_SALELIST B
								   ON A.DATE = B.DATE

	SELECT *
	  FROM V_DAY_SALELIST A FULL JOIN  V_DAY_ORDERLIST B
								   ON A.DATE = B.DATE