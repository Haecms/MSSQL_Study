/*********************************************************************
왼쪽 개체탐색기
MyFirstDataBase

--> c드라이브에서 강의파일 첫번 째 엑셀파일 켜기 --> excel파일이랑 테이블 순서가 안맞아 --> 엑셀파일 순서 맞게 변화 시켜서(연도가 c에가고 번호가 맨마지막으로 가게)
--> dbo.T_Customer
--> 오른쪽 클릭 상위 200개 파일 편집
--> 복사 후 데이터베이스 테이블에 붙여넣기
 

 -->dbo. T.salesList
 --> 오른쪽 클릭 디자인--> CUST_ID, FRUIT, PRICE, AMOUNT, DATE 각각 칸 변경후
 --> 오른쪽 클릭 상위 200개 파일 편집 --> 엑셀 T_SalesList 값 복사 붙여넣기

*/
/***********************************************************************************************************************************************

1. 테이블 간 데이터 연결 및 조회 (Join)

  JOIN : 둘 이상의 테이블을 연결 해서 데이터를 검색하는 방법
		 테이블을 서로 연결 하기 위해서는 !!하나 이상의 컬럼을 공유!!하고 있어야한다.
  
    ON : 두 테이블을 연결 할 기준 칼럼 설정 및 연결 테이블의 조건 기술

 - JOIN의 종류
  .  내부 조인 (INNER JOIN)  : JOIN (디폴트 값으로 --> 대부분의 JOIN 이 INNER JOIN을 의미한다)
							 : 둘 이상의 테이블이 연결 되었을 때 반드시 두테이블에 동시에!! 값이 존재!! 해야한다.
							   하나의 테이블이라도 데이터가 없을 경우 데이터가 표현되지 않는다.

  .  외부 조인 (OUTER JOIN)  : (LEFT JOIN, RIGHT JOIN, FULL JOIN) --> 종류
							   둘 이상의 테이블이 연결 되었을 경우
							   하나의 테이블에 데이터가 없더라도 일단은 데이터가 표현이 되는 조인

***** */

/* 

   T_Customer : 고객 (SUB)
   T_SalesList : 판매이력 (MAIN TABLE)
   --> 메인 테이블에 고객정보를 서브로 가져와서 합쳐지는(JOIN)되는 

   T_Customer 테이블과 T_SalesList 테이블 에서
   각각 고객 ID, 고객이름, 판매일자, 과일 , 판매 수량을 표현하세요

*/

-- 명시적으로 JOIN과 ON을 써서 표현하는 방법

SELECT * FROM T_Customer	
SELECT * FROM T_SalesList	

SELECT A.CUST_ID,   -- 판매테이블이 MAIN이니 메인에 있는 A테이블 ID를 쓰는 것이 낫다.
	   B.NAME,
	   A.DATE,
	   A.FRUIT,
	   A.AMOUNT
  FROM T_SalesList A JOIN T_Customer B   -- 판매이력 테이블을 A라고 이름 붙이고// 고객 테이블을 B
			  ON A.CUST_ID = B.CUST_ID	 -- JOIN과 ON은 세트 --> ON(연결조건기술) : A의 고객ID 항목과 B의 고객 ID 항목을 연결하여 JOIN 하겠다.


SELECT A.*,B.*
  FROM T_SalesList A JOIN T_Customer B
					   ON A.CUST_ID =B.CUST_ID



SELECT B.CUST_ID,   -- 고객테이블을 Main으로 두고 싶을 때 // 위의 값과 결과 값은 똑같지만  '어떤 테이블이 메인이냐' 라는 주는 느낌이 다르다.
	   A.NAME,
	   B.DATE,
	   B.FRUIT,
	   B.AMOUNT
  FROM T_Customer A JOIN T_SalesList B   
			  ON A.CUST_ID = B.CUST_ID	


-- JOIN : T_Customer 테이블을 기준으로 조회 하지만, T_SalesLiST 테이블에 
--		  T_Customer Table 5번 이수에 대한 데이터가 있지만 // T_SalesList에서 CUST_ID 5번인 이수가 구매한 내력이 없으므로 
--		  아까 위에 적힌 내부조인에서의 특징
--        둘 이상의 테이블이 연결 되었을 때 반드시 두테이블에 동시에!! 값이 존재!! 해야한다. // 하나의 테이블이라도 데이터가 없을 경우 없는 데이터가 표현되지 않는다.
--		  따라서 JOIN된 테이블 결과 값에 CUST_ID 5번인 이수에 대한 내용이 표현되지 않는다.


-- JOIN 테이블을 하위쿼리로 작성하여 연결
-- . 조회를 원하는 데이터가 가공된 임시 테이블 형태로 조인문을 완성하는
SELECT *
  FROM T_Customer A JOIN (SELECT CUST_ID,
								 FRUIT,
								 DATE
							FROM T_SalesList
							WHERE DATE < '2022-12-02') B
					  ON A.CUST_ID = B.CUST_ID


/***** OUTER JOIN ******************************************
1. LEFT JOIN
  . 왼쪽에 있는 테이블의 데이터를 기준으로 오른쪽에 있는 테이블의
    데이터를 검색 및 연결하고, 데이터가 없을 경우 NULL로 표시 된다.
*/

-- 고객 별로 판매 이력을 조회해 보세요
-- ISNULL부분을 CASE WHEN으로 변경해서 표현해보세요
SELECT A.CUST_ID,
	   A.NAME,
	   ISNULL(B.FRUIT, '판매이력없음') AS FRUIT,
	   ISNULL(B.AMOUNT,'0') AS AMOUNT,
	   B.DATE
  FROM T_Customer A LEFT JOIN T_SalesList B
						   ON A.CUST_ID = B.CUST_ID

SELECT A.CUST_ID,
	   A.NAME,
	   CASE WHEN B.FRUIT IS NULL THEN '판매이력없음'
								 ELSE B.FRUIT END    AS FRUIT,
	   CASE WHEN B.AMOUNT IS NULL THEN 0
								  ELSE B.AMOUNT END  AS AMOUNT,
	   B.DATE
  FROM T_Customer A LEFT JOIN T_SalesList B
						   ON A.CUST_ID = B.CUST_ID
 -- 내가 해볼거 WHERE에 케이스 가능할까
 SELECT A.CUST_ID,
	   A.NAME,
	   B.FRUIT,
	   B.AMOUNT,
	   B.DATE
  FROM T_Customer A LEFT JOIN T_SalesList B
						   ON A.CUST_ID = B.CUST_ID
 WHERE B.FRUIT = CASE WHEN B.FRUIT IS NULL THEN '판매이력없음'
										   ELSE B.FRUIT END
   OR B.AMOUNT = CASE WHEN B.AMOUNT IS NULL THEN 0
											ELSE B.AMOUNT END


-- 왼쪽 테이블을 LEFT JOIN을 써서 판매이력테이블로  만들어놓고 비교
SELECT A.CUST_ID,	
	   B.NAME,
	   A.FRUIT,
	   A.AMOUNT
  FROM T_SalesList A LEFT JOIN T_Customer B
							ON A.CUST_ID = B.CUST_ID

-- RIGHT JOIN
-- 오른쪽에 있는 테이블의 데이터를 기준으로 왼쪽에 있는 테이블의
-- 데이터를 검색하고 왼쪽 테이블 데이터가 없을경우 NULL

-- 고객별 판매현황, (고객이 판매 이력이 없어도 데이터는 나와야 한다.)
-- 판매 현황별 고객 정보(판매이력에 없는 고객은 나타낼 필요가 없다)

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


-- 묵시적 표현법 JOIN
-- JOIN 문을 쓰지 않고 테이블을 나열 후 WHERE 절에 참조컬럼 연결하는 방식
SELECT *
  FROM T_Customer A , T_SalesList B		-- JOIN을 쓰지 않고 콤마를 사용함
 WHERE A.CUST_ID = B.CUST_ID			-- WHERE절에 ON 형식처럼 어느 부분이 연결되는지 표현해줘야 함
   AND B.DATE > '2020-01-01'


/***************다중 JOIN
 . 참조 할 데이터가 여러 테이블에 있을 때
   기준 테이블과 참조 테이블과의 다중 JOIN으로 데이터를 표현할 수 있다.
*/

-- 과일의 판매 현황을 
-- 판매일자, 고객이름, 연락처, 판매과일, 과일단가, 판매개수 판매금액으로 나타내세요.
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
					 JOIN T_FRUIT C					-- 밑에 ON이 아직 안 적혔다는 가정하에 C테이블이 A테이블과 이어졌는지 B테이블과 이어졌는지 모름
					   ON A.FRUIT = C.FRUIT			-- A테이블과 C테이블이 연결됐다는걸 적었기에 C의 JOIN은 A가 됨.


/***********************실습*******************************
TB_StockMMrec : 자재 입출 이력 테이블
INOUTFLAG : 입고 유형, I : 입고
TB_ItemMaster : 품목 마스터
ITEMTYPE : 품목 유형, ROH : 원자재

자재 입출 이력 테이블(A) 에서 ITEMCODE가 NULL이 아니고,
INOUTFLAG가 I 중
품목 마스터 테이블에서(B) ITEMTYPE이 'ROH'인 것의
A.INOUTDATE, A.INOUTSEQ, A.MATLOTNO, A.ITEMCODE, B.ITEMNAME의 정보를 나타내세요.
  - 공유 컬럼 A.ITEMCODE, B.ITEMCODE
  */
SELECT A.INOUTDATE,
	   A.INOUTSEQ,
	   A.MATLOTNO,
	   A.ITEMCODE,
	   B.ITEMNAME
  FROM TB_StockMMrec A LEFT JOIN TB_ItemMaster B
						 ON A.ITEMCODE = B.ITEMCODE
						AND B.ITEMTYPE = 'ROH'  -- (1) 이렇게 하면 5개 나옴 / JOIN하기 전에 데이터를 필터링
 WHERE A.ITEMCODE IS NOT NULL
   AND A.INOUTFLAG = 'I'
   --AND B.ITEMTYPE = 'ROH'					    -- (2) 이렇게 하면 3개 나옴 / JOIN 이후에 완성된 데이터를 필터링

/* 이유
품목 마스터 ITETYPE = 'ROH' 조건을 추가 시
자재 입고이력 테이블의 ITEMCODE 컬럼에 NULL 상태인 행이 있을 경우
1. JOIN 구문에 조건을 줄 때에는 LEFT JOIN으로 인하여
   자재입고입출 이력 중 ITEMCODE가 표현되고
2. WHERE절에 조건을 줄 때에는 LEFT JOIN으로 나온 결과 
   이후에 조건이 적용되므로 필터링되어 표현됨 */

/***********************************실습*************************************
 고객 별 과일의 총 계산 금액 구하기
 고객ID, 고객 명, 과일 이름, 과일별 총 계산 금액
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

-- 풀이 1
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

-- 풀이 2
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

/*************************실습*************************************

총 구매 금액이 가장 큰 고객을 표현하세요.
(ID, 고객이름, 고객주소, 고객연락처, 총 구매 금액)

최대의 금액이 여러 사람일 경우 어떻게 반환하는지

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


-- 2번 방법
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


/************************실습*********************
2022-12-01 일부터 2022-12-31(월간)
까지 가장 많이 팔린 과일의 종류와 판매 수량을 구하세요.

과일이름, 판매수량
* 단 판매 수량이 같은 과일은 N개의 행으로 표현할 것
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

-- 선생님

DECLARE @LI_MAXAMOUNT1 INT,
		@LS_STARTDATE VARCHAR(10) = '2022-12-01', -- 첫째 날짜 마지막 날짜 메서드?
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

/**************************실습*******************************************88
 고객별 총 구매 금액이 12만원(120000)이 넘는 고객의 내역을 검색조회하세요.
 (고객ID, 고객 이름, 총 구매 금액)
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


-- 위 내용을 SUM 집계함수 한번만 써서 표현해보세요.

/*******************************************************************************************************************
3. UNION / UNION ALL
 . 다수의 검색 내역(행)을 합치는 기능.
 . 조회한 다수의 SELECT 결과를 하나로 합치고 싶을 때 (UNION)을 사용.

 UNION : 중복되는 행은 하나만 표시.
 UNION ALL : 중복을 제거하지 않고 모두 표시.

 ***** 합쳐질 조회문의 데이터 컬럼은 형식과 갯수가 일치 해야한다.
*/

-- UNION (중복되는 데이터는 제외하고 표현한다.)
-- 비교하는 테이블 뿐만 아니라 자신의 테이블 안에서도 중복이 일어난다면 제외함
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

-- * UNION은 중복된 데이터를 제외하고 합쳐서 표현한다.

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


  ------------ 타이틀 표현하기.
  SELECT '판매'     AS TITLE,
		 DATE       AS DATE,
         CUST_ID    AS CSTINFO,
	     FRUIT      AS FRUIT,
	     AMOUNT     AS AMOUNT
  FROM T_SalesList
UNION ALL
SELECT '발주'	   AS TITLE,
	   ORDERDATE   AS DATE,
       CUSTCODE    AS CUSTINFO,
	   FRUIT       AS FRUIT,
	   AMOUNT      AS AMOUNT
  FROM T_ORDERLIST
  ORDER BY DATE



  /***********실습*************************
   위 결과에서
   판매이력 관련 고객 ID에 따른 이름을 표현하고
   발주이력 관련 거래처 관련업체명을 표현
   고객 ID T_Customer에서 가져오고
   거래처 명은 10:대림, 20:삼전, 30:하나, 40:농협으로 표현하세요
   1 : 이승기 2: 김범수 3: 윤종신  4 : 조해찬
  */
    SELECT	 '판매'                              AS TITLE,
			  DATE                               AS DATE,
              B.NAME                             AS CSTINFO,
	          FRUIT                              AS FRUIT,
	          AMOUNT                             AS AMOUNT
  FROM T_SalesList A LEFT JOIN T_Customer B
					        ON A.CUST_ID = B.CUST_ID
UNION ALL
SELECT      '발주'	                         AS TITLE,
	        ORDERDATE                        AS DATE,
       CASE CUSTCODE WHEN 10 THEN '대림'
				     WHEN 20 THEN '삼전'
					 WHEN 30 THEN '하나'
					 WHEN 40 THEN '농협' END AS CUSTINFO,
	        FRUIT                            AS FRUIT,
	        AMOUNT                           AS AMOUNT
  FROM T_ORDERLIST
  ORDER BY DATE





/*************************실습*************************************
발주내역과 주문내역에
각각 과일의 판매금액(수량*단가)와
주문(발주) 금액 (발주수량*단가)를 추가하여 보여주세요
* 컬럼 이름은 INOUTPRICE
  발주 된 금액은 (-)로 표현
*/
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
  ORDER BY DATE

  /***************************실습*****************
두가지 방법으로 과일 가게의 일자 별 마진 금액을 산출하세요.
 1 : UNION을 사용하여 마진 금액 표기
 2 : UNION을 사용하지 않고 마진 금액 표기
 
 마진금액 : 판매한 총금액 - 발주금액

 . 표현 할 컬럼 : DATE(일자), MARGIN_DATE(마진금액)
 */
 -- 1 UNION 그대로 사용하는 방법
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




 -- 1 UNION 그대로 사용하는 방법 (2)
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
  FROM ( SELECT	 '판매'									 AS TITLE,
				 A.DATE								 AS DATE,
				 SUM(A.AMOUNT*C.UNIT_COST)			     AS IPGO
		  FROM T_SalesList A LEFT JOIN T_Customer B
							        ON A.CUST_ID = B.CUST_ID
							 LEFT JOIN T_FRUIT C
									ON A.FRUIT = C.FRUIT
	  GROUP BY A.DATE) A LEFT JOIN (SELECT      '발주'									 AS TITLE,
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


-- [POINT 5] UNION을 쓰지 않고 JOIN으로 표현합시다.
-- 1. 일자 별 총 판매 금액을 산출


--2. 일자 별 총 발주 금액 산출


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
