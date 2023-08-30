/* 1. LIKE     *****
   . 데이터를 포함하는 행 조회
   . WHERE 조건에 검색하고자 하는 데이터의 일부만 입력하여 
     해당 조건을 만족시키는 모든 데이터를 조회('%')
   . LIKE + '%' 무엇을 포함하는으로 변신

*/

-- 품목 마스터 테이블에서 ITEMCODE 컬럼의 데이터 중 'E'가 포함된
-- 데이터를 모두 검색하세요.

-- 1) ITEMCODE의 데이터가 E를 포함하면 전부 조회하는 로직
SELECT *
  FROM TB_ItemMaster
 WHERE ITEMCODE LIKE '%E%'

--2) ITEMCODE의 데이터가 E1로 시작하면 조회하라
SELECT *
  FROM TB_ItemMaster
 WHERE ITEMCODE LIKE 'E1%'

--3) ITEMCODE가 E로 끝나는 데이터 조회
SELECT *
  FROM TB_ItemMaster
 WHERE ITEMCODE LIKE '%E'


/*************************************************************************
2. NULL 이 아닌 데이터 조회 및 NULL인 데이터 조회(IS NULL, IS NOT NULL)
   NULL : 데이터가 없고 비어있는 상태, 값 자체가 주어지지 않은 상태.
*/

-- 품목 마스터 테이블에서 MAXSTOCK 컬럼의 데이터가 NULL 처리 된 행을 모두 검색.
SELECT *
  FROM TB_ItemMaster
 WHERE MAXSTOCK IS NULL

 -- 품목마스터 테이블에서 MAXSTOCK 컬럼의 데이터가 NULL이 아닌 행을 모두 검색.
 SELECT *
   FROM TB_ItemMaster
 WHERE MAXSTOCK IS NOT NULL

 //*****************실습**********************************
 품목 마스터에서 
 BOXSPEC 컬럼의 데이터가 '01'로 끝나면서 NULL이 아닌
 PLANTCODE, ITEMCODE, ITEMNAME, BOXSPEC 컬럼의 행을 검색하세요.
 BOXSPEC : 포장단위 규정
 */
 SELECT PLANTCODE,
	    ITEMCODE,
		ITEMNAME,
		BOXSPEC
  FROM TB_ItemMaster
 WHERE BOXSPEC LIKE '%01'
   AND BOXSPEC IS NOT NULL


/**********************************************************************************************
 3. 검색 결과를 정렬. (ORDER BY, ASC, DESC)
  . 테이블에서 검색한 결과를 조건에 따라 정렬하여 나타낸다.
  . 오름 차순의 경우(ASC)를 사용.  * NULL 상태의 값이 최상위에 나타난다.
  . 내림 차순의 경우(DESC)를 사용.

  */

  -- 품목마스터 테이블의 ITEMTYPE = 'HALB'인 (품목 유형이 반제품)
  -- ITEMCODE, ITEMTYPE 컬럼의 데이터를 ITMCODE 컬럼 데이터 기준으로 오름차순하여 조회
  SELECT ITEMCODE,
		 ITEMTYPE
    FROM TB_ItemMaster
   WHERE ITEMTYPE = 'HALB'
ORDER BY ITEMCODE



--** ORDER BY 절에 컬럼이 추가될 경우 왼쪽 부터 순차적으로 우선순위를 가진다.
-- 품목마스터 테이블에서 ITEMTYPE = 'HALB'인 
-- ITEMCODE, ITEMTYPE, WHCODE, BOXSPEC 컬럼을
-- ITEMTYPE의 값이 같다면 WHCODE 순서로, WHCODE 값이 같다면 BOXSPEC 순서로 정렬하세요

  SELECT ITEMCODE,
 	     ITEMTYPE,
 	     WHCODE,
 	     BOXSPEC
    FROM TB_ItemMaster
   WHERE ITEMTYPE = 'HALB'
ORDER BY WHCODE, BOXSPEC

-- * 조회 대상에 없는 컬럼의 데이터 정렬 조건 추가하기
-- 데이터를 확인 할 수 없지만 ORDER BY의 순서대로 정렬 된다.


-- 품목마스터 테이블에서 ITEMTYPE = 'HALB'인
-- ITEMTYPE, WHCODE, BOXSPEC 컬럼을 
-- ITEMCODE 순서대로 정렬하라. (두 바퀴 타게 됨)
  SELECT ITEMTYPE,
	     WHCODE,
	     BOXSPEC
    FROM TB_ItemMaster
   WHERE ITEMTYPE = 'HALB'
ORDER BY ITEMCODE

-- ** 역 순으로 정렬하기 DESC
-- 품목마스터 테이블에서 ITEMCODE, ITEMNAME 컬럼을 조회하는데
-- ITEMCODE 컬럼데이터 역순으로 (내림차순) 조회
SELECT *
  FROM TB_ItemMaster
ORDER BY ITEMCODE DESC


/* 오름차순과 내림차순을 혼용하여 사용하는 예
   
   품목마스터 테이블에 있는 모든 데이터 중에
   ITEMTYPE는 오름차순으로, WHCODE는 내림차순으로, INSPFLAG는 오름차순으로 정렬 */
SELECT ITEMCODE, ITEMTYPE, WHCODE, INSPFLAG
  FROM TB_ItemMaster
ORDER BY ITEMTYPE ASC, WHCODE DESC, INSPFLAG


/***************실습**************
 품목 마스터 테이블에서 
 MATERIALGRAD 컬럼의 값이 NULL이고
 CARTYPE 컬럼의 값이 MD, RB TL 이 아니면서
 ITEMCODE 컬럼 값이 '001'을 포함하고
 UNITCOST 컬럼 값이 0인 행의 
 모든 컬럼
 ITEMNAME 컬럼 기준 내림차순 WHCODE컬럼기준 오름차순으로 검색
 MATERIALGRADE : 자재 등급.
 CARTYPE : 차종
 UNITCOST : 단가
 ITEMCODE : 품번
 ITEMNAME : 품명
*/
SELECT *
  FROM TB_ItemMaster
 WHERE CARTYPE NOT IN ('MD','RB','TL') -- WHERE CARTYPE <> 'MD' AND CARTYPE <> 'RB' AND CARTYPE <> 'TL'
   AND ITEMCODE LIKE '%001%'
   AND UNITCOST = 0
   AND MATERIALGRADE IS NULL
ORDER BY ITEMNAME DESC, WHCODE


/*******************************************************************************************************************
4. 검색된 데이터 중에 조회된 행의 상위 N 개의 데이터를 표현. TOP
*/

-- 품목 마스터 테이블에서 최대 적재량의 값을 가지고 있고
-- MAXSTOCK컬럼의 값이 제일 큰 품목의 코드를 검색하세요. 
SELECT TOP(1) ITEMCODE
  FROM TB_ItemMaster
 WHERE MAXSTOCK IS NOT NULL
ORDER BY MAXSTOCK DESC


-- 상위 10개의 데이터를 조회할 때는 
SELECT TOP(10) *
  FROM TB_ItemMaster
ORDER BY MAXSTOCK DESC


/*****************실습**************************
  TB_StockMMrec (자재 입출 이력 테이블)
  INOUTFLAG : 입고 1, 출고 0
  INOUTQTY : 입출 수량

  TB_StockMMrec 테이블에서 INOUTFLAG가 'O'인 데이터 중.
  INOUTDATE가 가장 최근 발생한 상위 10개 품목의 
  ITEMCODE, INOUTQTY를 조회하세요
  * 자재 출고 이력 중 가장 최근 출고 이력
  */
SELECT TOP(10) ITEMCODE,
			   INOUTQTY
		  FROM TB_StockMMrec
		 WHERE INOUTFLAG = 'O'
	  ORDER BY INOUTDATE DESC