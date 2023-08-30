/**********************************************************************************
1. 데이터 합병 검색 (DISTINCT)

  - 컬럼의 데이터가 중복되어 있을 경우 중복된 데이터를 합병하여 검색.

-- 우리 회사에서 관리하는 모든 품목의 유형을 나타내세요.

-- 품목 마스터 테이블에서 품목 유형을 표현하면 되겠구나.
*/
SELECT DISTINCT ITEMTYPE
  FROM TB_ItemMASTER

-- 단위가 KG인 품목의 유형을 조회하세요
-- 품목마스터 테이블에서 BASEUNIT(단위)가 KG인 데이터의 ITEMTYPE(유형)을 병합 후 검색

SELECT DISTINCT ITEMTYPE
  FROM TB_ItemMaster
 WHERE BASEUNIT = 'KG'


/* 단일 컬럼의 합병이 아닌 여러 컬럼의 합병의 예시

 -- 단위가 KG을 가지는 품목 유형별 창고를 보여주세요.

 ITEMTYPE : 품목 유형
 WHCODE : 창고.

*/
SELECT DISTINCT ITEMTYPE,
				WHCODE
  FROM TB_ItemMaster
 WHERE BASEUNIT = 'KG'


 -- 1 우리 회사에서 관리하는 모든 품목 조회
 SELECT * FROM TB_ItemMaster

 -- 2 우리 회사의 모든 품목의 유형을 리스트
 SELECT ITEMTYPE FROM TB_ItemMaster

 -- 3 품목의 유형을 병합해봅시다.
 SELECT DISTINCT ITEMTYPE FROM TB_ItemMaster

 -- 4 단위가 KG인 유형만 조회
 SELECT DISTINCT ITEMTYPE FROM TB_ItemMaster WHERE BASEUNIT = 'KG'

 -- 5 단위가 KG인 품목 유형이 적재될 수 있는 창고를 보여주세요.
 SELECT DISTINCT ITEMTYPE,WHCODE FROM TB_ItemMaster WHERE BASEUNIT = 'KG'


 /************************실습&*****************************
 품목 마스터 테이블에서
 BOXSPEC(포장규격)이 'DS-PLT'로 시작하는 품목들의 유형별 창고를 나타내세요.
 */
 SELECT DISTINCT ITEMTYPE,
			     WHCODE
			FROM TB_ItemMaster
		   WHERE BOXSPEC LIKE 'DS-PLT%'

/**********************************************************************************************************************8
2. 데이터 합병 검색 GROUP BY 중요도**********
  . GROUP BY 조건에 따라 해당 컬럼의 데이터를 병합.
  . * GROUP BY로 병합된 결과에서 조회조건으로 두어 검색 가능(HAVING)
  . * 집계 함수를 사용하여 병합 데이터를 연산 할 수 있는 기능을 지원


-- GROUP BY의 기본 유형
-- 1. 품목 마스터 테이블에서 ITEMTYPE 컬럼만 추출 후 리스트 작성
*/
SELECT ITEMTYPE
  FROM TB_ItemMaster

-- 2. GROUP BY를 통하여 병합.	1. FROM 2. SELECT 3.GROUP BY
  SELECT ITEMTYPE
    FROM TB_ItemMaster
GROUP BY ITEMTYPE      -- X ITEMSPEC
-- * GROUP BY 하지 않은 컬럼은 조회할 수 없다.
-- WHERE 절과 GROUP BY  --> FROM -> WHERE -> GROUP BY -> SELECT
SELECT ITEMTYPE
  FROM TB_ItemMaster
 WHERE BASEUNIT = 'KG'
 GROUP BY ITEMTYPE


-- GROUP BY 하지 않은 컬럼은 조회할 수 없는 경우.
SELECT ITEMCODE,
       WHCODE
  FROM TB_ItemMaster
 WHERE BASEUNIT = 'KG'
GROUP BY ITEMTYPE      -- WHCODE넣는 경우에 가능해짐

--[POINT1]
/*************실습***************************************
TB_StockMM : 원자재 재고 테이블
STOCKQTY : 현재 재고 수량
INDATE : 재고 입고 일자

TB_StockMM 테이블에서 
STOCKQTY의 데이터가 1500 이상인 데이터를 가지고
INDATE의 데이터가 '2022-03-01' 부터 '2022-03-31'의 데이터 중
INDATE 별 ITEMCODE 품목을 표현하세요 */
SELECT INDATE,
	   ITEMCODE
  FROM TB_StockMM
 WHERE STOCKQTY >= 1500
   AND INDATE >= '2022-03-01'
   AND INDATE <= '2022-03-31'			-- BETWEEN AND
GROUP BY INDATE, ITEMCODE



--K[POINT3]
/* GROUP BY 결과에서 재 검색하는 로직 HAVING

품목 마스터 테이블에서 
MAXSTOCK이 10을 초과하는 데이터 중에
ITEMTYPE 별 INSPFLAG를 나타내고
INSPFLAG가 I인 데이터를 표현하세요.
*/

-- 품목 중에 최대 적재량이 10초과하는 품목의 유형별 검사 여부를 나타내세요.(단 검사여부는 'I' 인것)
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT
SELECT ITEMTYPE,
       INSPFLAG
  FROM TB_ItemMaster
 WHERE MAXSTOCK > 10
 GROUP BY ITEMTYPE, INSPFLAG
   HAVING INSPFLAG = 'I'



 -- 주의 * HAVING을 통해서 조건을 넣을 컬럼은 반드시 GROUP BY된 상태여야 한다.
 SELECT ITEMTYPE,
       INSPFLAG
  FROM TB_ItemMaster
 WHERE MAXSTOCK > 10
 GROUP BY ITEMTYPE, INSPFLAG
   HAVING ITEMCODE = 'I'     --XXXX

/*******************************여기서 잠깐!!****************************************************/
SELECT INDATE,
	   ITEMCODE
  FROM TB_StockMM
 WHERE STOCKQTY >= 1500
   AND INDATE >= '2022-03-01'
   AND INDATE <= '2022-03-31'			-- BETWEEN AND
GROUP BY INDATE, ITEMCODE
--의 내용은 아래와 같다
SELECT DISTINCT INDATE, ITEMCODE
           FROM TB_StockMM
		  WHERE STOCKQTY >= 1500
		    AND INDATE BETWEEN '2022-03-01' AND '2022-03-31'


-- 그렇다면 왜 GROUP BY를 사용할까?

/***********************************************************************************************

3. 집계 함수
 - 특정 컬럼의 여러 행에 있는 데이터를 연산 후 하나의 결과를 반환하는 함수.

 . SUM() : 병합하는 컬럼의 데이터를 모두 합한다.
 . MIN() : 병합하는 컬럼의 데이터 중 최솟값을 나타낸다.
 . MAX() : 병합하는 컬럼의 데이터 중 최댓값을 나타낸다.
 . COUNT() : 병합하는 컬럼의 행 갯수를 나타낸다.
 . AVG() : 병합하는 컬럼의 데이터들의 평균을 나타낸다.
 */


-- 품목 마스터 테이블에서 ITEMTYPE가 FERT인 데이터의 UNITCOST 합을 구하세요
-- UNITCOST : 단가.
SELECT SUM(UNITCOST)
  FROM TB_ItemMaster
 WHERE ITEMTYPE = 'FERT'

 SELECT UNITCOST
   FROM TB_ItemMaster
 WHERE ITEMTYPE = 'FERT'


-- COUNT() 함수 : 행의 갯수
SELECT COUNT(*) --AS 아무거나 적으면 이름 지어줌
  FROM TB_ItemMaster


-- AVG() 함수 : 평균
-- TB_StockMM : 원자재 재고 테이블
-- 원자재 재고의 평균 수량을 나타내세요.
SELECT AVG(STOCKQTY)
  FROM TB_StockMM


-- MAX(), MIN()
-- 데이터들 중에 최댓값과 최솟값.
SELECT MAX(UNITCOST)
  FROM TB_ItemMaster
 -- 품목 중 단가가 가장 높은 금액

 SELECT MIN(UNITCOST)
  FROM TB_ItemMaster
   -- 품목 중 단가가 가장 낮은 금액



-- 집계 함수를 혼용하여 사용할 경우
-- 품목 마스터에서 품목 유형 별 단가의 총 합과 최솟값을 조회
SELECT ITEMTYPE,
       COUNT(*)      AS ITEMCNT,
	   SUM(UNITCOST) AS COSTSUM,
	   MIN(UNITCOST) AS COSTMIN
  FROM TB_ItemMaster
  GROUP BY ITEMTYPE
 
-- GROUP BY 하는 김에 품목 유형별로 COUNT : 행의 갯수, SUM : 총합, MIN : 최솟값
-- 을 구해서 같이 보여줄게.


-- 집계 함수를 사용한 결과의 조회 조건(HAVING)

  SELECT ITEMTYPE      AS ITEMTYPE,
         COUNT(*)      AS ROWCNT,
	     SUM(UNITCOST) AS SUM_COST,
	     MIN(UNITCOST) AS MIN_COST
    FROM TB_ItemMaster
GROUP BY ITEMTYPE
  HAVING COUNT(*)>100 

-- GROUP BY 로 병합된 결과의 HAVING 조거에 집계함수를 사용할 경우.
-- GROUP BY 에 명시하지 않은 컬럼을 사용할 수 있다.

/*
	UNITCOST : 단가
	ITEMTYPE : 품목유형

	품목마스터 테이블에서 UNITCOST가 10 이상인 데이터를 가진 행 중.
	ITEMTYPE 별로 UNITCOST의 합이 100을 초과하는 행의
	ITEMTYPE, UNITCOST의 합, UNITCOST의 최댓값을 나타내시오
추가 * 정렬기준은 단가의 합 오름차순으로 나타내세요.
*/
SELECT ITEMTYPE,
	   SUM(UNITCOST) SUMCOST,
	   MAX(UNITCOST) MAXCOST
  FROM TB_ItemMaster
 WHERE UNITCOST >= 10
GROUP BY ITEMTYPE
HAVING SUM(UNITCOST)>100
ORDER BY SUMCOST

/* 데이터베이스의 처리 절차.
 ************** FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY 순서.************8
 1. 품목마스터에서 UNITCOST가 10 이상인 행 추출 (WHERE)
 2. 1에서 추출된 데이터에서 ITEMTYPE컬럼을 병합 처리. (GROUP BY)
 3. 2의 내용을 병합하면서 UNITCOST의 합이 100초과하는 행 추출(HAVING)
 4. 3에서 추출된 컬럼 ITEMTYPE을 표현하고
    3에서 추출된 컬럼을 기준으로 UNITCOST 집계함수 SUM 실행 - SUM_UNITCOST
	3에서 추출된 컬럼을 기준으로 UNITCOST 집계함수 MAX 실행 - MAX_UNITCOST
 5. 4에서 완료된 데이터를 정렬(ORDER BY) - 4에서 완료된 데이터 테이블의 컬럼을 기준으로 정렬
 */
  SELECT ITEMTYPE,
         SUM(UNITCOST) SUM_UNITCOST,
 		 MAX(UNITCOST) MAX_UNITCOST
    FROM TB_ItemMaster
   WHERE UNITCOST >=10
GROUP BY ITEMTYPE, UNITCOST
  HAVING UNITCOST > 100

/*
  문제?
  아래 SQL은 왜 수행이 안될까?
  STOCKQTY가 가장 큰 값을 찾아낼 대상이 불분명함
  즉 비교할 대상이 없으므로 처리되지 않는다.
*/


/*******************************정리************************************************
집계함수는 GROUP BY와 함께 사용할 경우 효과가 크다.
집계 함수의 결과 조건을 사용하지 않을 경우 GROUP BY / DISTINCT는 큰 차이가 없다.
*/

-- [POINT 3]
/***************실습
TB_STOCKMMREC : 자재 재고 입출 이력
INOUTFLAG     : 입출 여부    I : 입고

TB_STOCKMMREC  테이블의 데이터 중 INOUTFLAG가 'I'이고
INOUTQTY 가 1000보다 큰 데이터 행을
INOUTDATE 별 WHCODE의 횟수로 나타내고
INOUTDATE 기준으로 오름차순 조회 하세요.

2. 입출 횟수가 2개 이상인 데이터만 조회해 보세요
*/
SELECT INOUTDATE,
       WHCODE,
	   COUNT(WHCODE) AS CNT_WHCODE
  FROM TB_StockMMrec
 WHERE INOUTFLAG = 'I'
   AND INOUTQTY > 1000
GROUP BY INOUTDATE, WHCODE
  HAVING COUNT(WHCODE) >= 2
ORDER BY INOUTDATE

SELECT INOUTDATE,
       WHCODE,
	   COUNT(*) AS CNT_WHCODE
  FROM TB_StockMMrec
 WHERE INOUTFLAG = 'I'
   AND INOUTQTY > 1000
GROUP BY INOUTDATE, WHCODE
  HAVING COUNT(*) >= 2
ORDER BY INOUTDATE


