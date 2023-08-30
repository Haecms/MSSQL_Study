/* 하위 쿼리 (서브 쿼리) 중요도 ******* 7개임
  - 쿼리 안에 쿼리
  - 일반적으로 SELECT절
			    FROM 절
			   WHERE 절
	에 사용된다.

	장점 : SQL 구문 안에서 유연하게 다른 SQL 구문을 만들어
	       사용할 수 있다.
	단점 : 쿼리가 복잡해진다.


	1. 서브쿼리는 괄호로 감싸서 사용한다.
	2. 서브쿼리는 단일 행 또는 복수 행 비교 연산자와 함께 사용 가능
	3. 서브쿼리에서는 ORDER BY 구문은 사용할 수 없다.
*/

/***********************************************************************************************/
-- 서브 쿼리를 통한 데이터 조회 (WHERE 절)
/*
	TB_StockMMrec : 자재 재고 입출고 이력
	TB_ItemMaster : 품목의 리스트(품목 마스터)
	PONO          : 자재를 발주한 번호

   자재 재고 입출고 이력 테이블에서 PONO 가'PO202106270001'인 ITEMCODE의
   정보를 
   품목 마스터 테이블에서 조회하여 
   ITEMCODE, ITEMNAME, ITEMTYPE CARTYPE 컬럼으로 데이터를 검색하세요*/

-- 1. 발주 번호의 단일 품목코드에 대한 내용 품목 마스터에서 조회
SELECT ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE
  FROM TB_ItemMaster
 WHERE ITEMCODE = (SELECT ITEMCODE
					  FROM TB_StockMMrec
					 WHERE PONO = 'PO202106270001')

-- 2. 발주 번호의 단일품목 코드를 제외한 내용 품목 마스터에서 조회
SELECT ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE
  FROM TB_ItemMaster
 WHERE ITEMCODE <> (SELECT ITEMCODE
					  FROM TB_StockMMrec
					 WHERE PONO = 'PO202106270001')
-- 3. 입고 및 품목 코드 정보가 있는 복수의 품목 코드 정보를 품목 마스터에서 조회
SELECT ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE
  FROM TB_ItemMaster
 WHERE ITEMCODE IN (SELECT DISTINCT ITEMCODE
					  FROM TB_StockMMrec  -- 여기까지만 하면 안 됨 하위 쿼리에서 값이 2개 이상이 나옴
					 WHERE INOUTFLAG = 'I'
					   AND ITEMCODE IS NOT NULL)

-- 4. 하위쿼리 복수개의 품목 코드를 제외한 품목 마스터 내용 조회.
SELECT ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE
  FROM TB_ItemMaster
 WHERE ITEMCODE NOT IN (SELECT DISTINCT ITEMCODE
					  FROM TB_StockMMrec 
					 WHERE INOUTFLAG = 'I'
					   AND ITEMCODE IS NOT NULL)

-- WHERE 조건에 '=' 연산자가 있을 경우 복수개의 조건을 대입할 수 없다. 
--		복수개의 조건을 대입할 경우 'IN', 'NOT IN'을 사용해야 한다.
/************실습**********
TB_StockMMrec : 자재 입출 이력 테이블
 ITEMCODE : 품목 코드
 INOUTQTY : 입출 수량
 CARTYPE  : 차종
INOUTFLAG : 입/출 구분(I:입고)

자재 입출이력 테이블에서
ITEMCODE가 값을 가지고 있고
INOUTQTY가 1000개 이상이면서
INOUTFLAG가 I인 ITEMCODE 리스트를 병합하고
ITEMCODE 관련 정보를 품목마스터에서
ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE 내역으로 조회해 보세요.
*/
SELECT ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE
  FROM TB_ItemMaster
 WHERE ITEMCODE IN (SELECT ITEMCODE
					  FROM TB_StockMMrec
					 WHERE INOUTFLAG = 'I'
					   AND ITEMCODE IS NOT NULL
					   AND INOUTQTY >= 1000)

/* 하위 쿼리의 하위 쿼리
TB_STOCKMM : 자재 재고 테이블
TB_StockMMrec : 자재 입출 이력 테이블
TB_ITEMMASTER : 품목 마스터(품목 리스트)

MATLOTNO : 자재 LOT NO(수량의 묶음단위)

자재 재고 테이블에서 STOCKQTY가 3000보다 큰 MATLOTNO의 값으로
자재 재고 이력 테이블에서 ITEMCODE를 찾아내고 해당 품목에 대한 정보를 
품목 마스터에서 조회하여 
ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE 컬럼으로 검색
*/
-- 내 답
SELECT ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE
  FROM TB_ItemMaster
 WHERE ITEMCODE IN (SELECT ITEMCODE
					  FROM TB_StockMMrec
				     WHERE MATLOTNO IN(SELECT MATLOTNO
									     FROM TB_StockMM
									    WHERE STOCKQTY > 3000))

-- 선생님 답
-- 1. 자재 재고 테이블에서 3000보다 큰 LOTNO 찾기
SELECT MATLOTNO
  FROM TB_StockMM
 WHERE STOCKQTY > 3000

-- 2. 재고 이력 테이블에서 LOTNO의 이력
SELECT ITEMCODE
  FROM TB_StockMMrec
 WHERE MATLOTNO = (SELECT MATLOTNO
 		             FROM TB_StockMM
 		            WHERE STOCKQTY > 3000)
--3 2에서 조회된 품목의 정보를 조회
SELECT ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE
  FROM TB_ItemMaster
 WHERE ITEMCODE IN (SELECT ITEMCODE
					  FROM TB_StockMMrec
				     WHERE MATLOTNO = (SELECT MATLOTNO
									     FROM TB_StockMM
									    WHERE STOCKQTY > 3000))


/***********************************************************************************************/
-- 서브 쿼리를 통한 데이터 조회 (WHERE 절)

/*
	자재 재고 테이블에서 ITEMCODE, INDATE, MATLOTNO 컬럼의 데이터를 검색하고
	자재 재고 입출이력 테이블에서 자재 재고 테이블에서 조회한 MATLOTNO 컬럼의 데이터를 포함하고
	INOUTFLAG = 'OUT'인 데이터를 가지는 INOUTDATE 컬럼을 조회하라!!
	재고로 잡혀있는 애들의 출고일자를 알고싶다 이말이야!
*/

-- [POINT 4]
SELECT ITEMCODE,
	   INDATE,
	   MATLOTNO,
	   (SELECT INOUTDATE  FROM TB_StockMMrec   WHERE MATLOTNO = A.MATLOTNO AND INOUTFLAG = 'OUT') AS INDATE
  FROM TB_StockMM A

-- 수행 단계
-- 1.
SELECT ITEMCODE,
	   INDATE,
	   MATLOTNO
  FROM TB_StockMM

-- 2. 수행 로직

SELECT INOUTDATE  FROM TB_StockMMrec   WHERE MATLOTNO = 'LTROH1438534870001' AND INOUTFLAG = 'OUT' 
/*
LTROH1438534870001
LTROH2130262570001
LTROH1459097100001
LTROH1132574030001
LTROH1650200500001
LT_R2021082012481881
LOTR2021070817274225
LTROH2134195800002
LTROH1556377070001
*/
-- 3. 수행 로직

SELECT ITEMCODE,
	   INDATE,
	   MATLOTNO
  FROM TB_StockMM
-- 결과에 서브쿼리 결과를 하나씩 붙인다.
-- ***** 주의 : 기준이 되는 테이블 TB_StockMM에서 1번 조회 실행 후
--				SUB 쿼리 9번 실행되므로 총 10번의 검색이 실행되기에 위험함!



/*******************************************************************************************************************
-- 하위 쿼리 (FROM)
  . FROM 절에 오는 테이블 위치에 테이블 형식처럼 임시 테이블로 가공된 데이터를 쿼리로 작성할 수 있다.
  . 가공한 데이터를 테이블 형식으로 사용할 수 있다.
  . 테이블의 묶음단위(괄호) 뒤에는 반드시 임시테이블의 이름을 부여해야한다.
*/

SELECT *						-- WHCODE는 오면 안됨
  FROM (SELECT ITEMCODE,
        	   ITEMNAME,
        	   ITEMTYPE,
        	   BASEUNIT
          FROM TB_ItemMaster
         WHERE ITEMTYPE = 'FERT') AS TB_TEMP

-- POINT 3의 실습 내용으로
-- COUNT 집계 함수를 한번만 사용해서 같은 결과를 내는 서브쿼리 작성

  SELECT INOUTDATE,
   	     WHCODE,
   	     COUNT(*) AS CNT
    FROM TB_StockMMrec
   WHERE INOUTFLAG = '1'
     AND INOUTQTY > 1000
GROUP BY INOUTDATE, WHCODE
  HAVING COUNT(*) >= 2
ORDER BY INOUTDATE

-- 위의 결과를 HAVING을 쓰지 않고 같은 결과로 만들어 보기
-- 집계함수를 한번만 사용하는 방법

-- 1. 전체 데이터의 집계 수량 산출.
   SELECT INOUTDATE,
	      WHCODE,
	      COUNT(*) AS CNT
     FROM TB_StockMMrec
    WHERE INOUTFLAG = 'I'
      AND INOUTQTY > 1000
GROUP BY INOUTDATE, WHCODE

-- 2. 산출된 결과를 임시테이블로 FROM절의 서브쿼리로 사용하여 조회

SELECT *
  FROM(SELECT INOUTDATE,
              WHCODE,
              COUNT(*) AS CNT
         FROM TB_StockMMrec
        WHERE INOUTFLAG = 'I'
          AND INOUTQTY > 1000
     GROUP BY INOUTDATE, WHCODE) A
  WHERE CNT >=2
