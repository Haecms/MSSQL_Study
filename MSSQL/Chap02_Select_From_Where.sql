-- 쿼리 편집기 창에 사용할 데이터베이스 변경.
USE MyFirstDataBase

-- 실행은 F5 또는 상단의 초록색 화살표(실행) 클릭
-- 드래그를 통한 블럭 지정 후 선택한 부분만 실행이 가능하다.

/**************************************************************************************************
- SELECT   *****
 . 데이터베이스 내의 테이블에서 원하는 데이터를 추출하는 명령어;
 . 가장 기본적인 SQL 구문이지만 데이터베이스 운영시 중요도가 가장 높은 문법이므로 잘 숙지할 것.

 SELECT [컬럼의 이름 및 데이터 정보]
   FROM [ 테이블 이름
  WHERE [조건]

***************************************************************************************************/
-- 1. 기본적인 SELECT 형식
-- 1) SELECT로만 실행.
	SELECT '안녕하세요'

-- 2) SELECT FROM으로 실행
SELECT * FROM TB_ITEMMASTER
-- * : 애스터리스크란 테이블의 모든 컬럼의 내용을 선택하는 것.


/***************************************************************************************************
2. 틀정 컬럼의 데이터만 조회
  . TB_ITEMMASTER 테이블에서 ITEMCODE(품목), ITEMNAME(품명) 의 정보를 모두 검색하시오. */
  -- *는 아스테리크 모든데이터를 조회?
	SELECT ITEMCODE,
		   ITEMNAME
	  FROM TB_ITEMMASTER;

/*********************************************실습**************************************************
TB_ITEMMASTER 테이블에서 ITEMCODE(품목), WHCODE(창고코드), BASEUNIT(단위), MAKEDATE(생성일시) 컬럼을 조회하는 구문을 작성해 보세요.
*/

SELECT ITEMCODE
	  ,WHCODE
	  ,BASEUNIT
	  ,MAKEDATE
  FROM TB_ITEMMASTER


/*****************************************************************************************************
2. 별칭 주기.
 - 컬럼 또는 테이블에 별칭을 주어 지정한 컬럼의 이름으로 변경하여 조회하는 기능.
 - 기본적으로 AS라는 키워드로 설정할 수 있으면 생략하고 띄워쓰기로도 표현 가능하다.


 ITEMCODE 컬럼을 IT_CD로 나타내고,
 ITEMNAME 컬럼을 IT_NM으로 나타내기.
*/

SELECT ITEMCODE AS IT_CD,
	   ITEMNAME IT_NM
  FROM TB_ITEMMASTER



  /*****************************************************************************************************
  3. WHERE 절
    . 검색 조건을 입력하여 원하는 데이터만 조회한다

	. SQL에서 문자열은 ' 홑따옴표로 정의한다.

  */

 -- 3-1 품목마스터 테이블에서
 -- BASEUNIT 가 'EA'인 모든 컬럼을 검색.
 -- TB_ITEMMASTER(1순위)에서 단위가EA(2순위) SELECT(3순위) / SELECT는 항상 제일 마지막 순위

 SELECT *
  FROM TB_ITEMMASTER
 WHERE BASEUNIT = 'EA'


  -- 3-2 품목마스터 테이블에서
  -- BASEUNIT 가 'EA'인것과 ITEMTYPE(품목유형)이 HALB인 모든 컬럼을 검색하세요.
  
 SELECT *
   FROM TB_ITEMMASTER
  WHERE BASEUNIT = 'EA' 
    AND ITEMTYPE = 'HALB'


-- 3-3 품목마스터 테이블에서
-- ITEMTYPE(품목유형)이 HALB 또는 OM인 모든 컬럼의 데이터 행을 검색하세요.

SELECT *
  FROM TB_ITEMMASTER
 WHERE ITEMTYPE = 'HALB'
    OR ITEMTYPE = 'OM'

SELECT *
  FROM TB_ITEMMASTER
 WHERE (ITEMTYPE = 'HALB' OR ITEMTYPE = 'OM')



 /************주의**********
 컬럼이 다른 검색 조건에 OR이 사용되는 경우
 BASEUNIT가 EA가 아니며 ITEMTYPE이 HALB가 아닌 데이터가 조회될 수 있다.
 */
 SELECT *
   FROM TB_ITEMMASTER
  WHERE BASEUNIT = 'EA'
    OR ITEMTYPE = 'HALB'


	/************실습**********
품목 마스터 테이블에서
WHCODE(창고코드)RK 'WH003'이고 'WH008'인 데이터 중
BASEUNIT가 'KG'인 ITEMCODE, WHCODE, BASEUNIT컬럼을 조회하세요.
*/

SELECT ITEMCODE, WHCODE, BASEUNIT
  FROM TB_ItemMaster
 WHERE (WHCODE = 'WH003' OR WHCODE ='WH008')
   AND BASEUNIT = 'KG'


/***************************************************************************************
4. 관계 연산자의 사용
  . 검색 조건에 시작과 종료에(범위) 대한 정보를 입력하여 원하는 결과를 조회
    보통은 기간이나 숫자를 검색하지만 문자의 정렬기준도 검색가능하고
	때에 따라서는 시간 단위도 검색이 가능합니다.
*/

 -- ** 기간 관계 연산 검색
 -- 특정 문자 데이터의 기간이 설정 되어있는 값에 시작과 종료를 조건으로 검색할 수 있다.
 -- EDITDATE : 사용자가 수정하는 일시!!!

 SELECT *
   FROM TB_ItemMaster
  WHERE EDITDATE >= '2020-08-01'
    AND EDITDATE <= '2023-01-01'

-- 수 를 입력한 관계 연산
-- MAXSTOCK = 품목 별로 최대 적재량(최대 재고량)
SELECT *
  FROM TB_ItemMaster
 WHERE MAXSTOCK > 10
   AND MAXSTOCK <= 20

SELECT *
  FROM TB_ItemMaster
 WHERE MAXSTOCK > '10'
   AND MAXSTOCK <= '20'


-- ** 문자 관계 연산 검색
-- INSPFLAG : 수입검사 여부(검사를 할건지 안 할건지 관리하는)
SELECT *
  FROM TB_ItemMaster
 WHERE INSPFLAG = 'U'

-- 검사 여부가 U가 아닌 값을 모두 검색
SELECT *
  FROM TB_ItemMaster
 WHERE INSPFLAG <> 'U'

SELECT *
  FROM TB_ItemMaster
 WHERE MAXSTOCK <> 10


-- ** INSPFLAG 컬럼이 B부터 U까지의 값을 가진 내역을 조회

SELECT *
  FROM TB_ItemMaster
 WHERE INSPFLAG > 'A'
   AND INSPFLAG < 'V'

-- ***** BETWEEN 관계 연산자 절.
-- * 초과와 미만의 범위는 설정할 수 없다.
-- 품목 마스터 테이블에서 MAXSTOCK이 10이상 20이하인 데이터를 모두 검색하라
SELECT *
  FROM TB_ItemMaster
 WHERE MAXSTOCK BETWEEN 10 AND 20


 /** 실습 **
 WHCODE : 참고 코드,UNITCOST : 단가, INSPFLAG : 검사여부
 PLANTCODE : 공장코드

 품목 마스터 테이블에서 
 WHCODE가 WH002부터 WH005이며
 UNITCOST 1000을 초과하는 값을 가지고
 INSPFLAG가 I가 아닌 데이터 행의 
 PLANTCODE, ITEMCODE, WHCODE, UNITCOST, INSPFLAG 컬럼을 조회하세요 */

 SELECT PLANTCODE, ITEMCODE, WHCODE , UNITCOST, INSPFLAG
   FROM TB_ItemMaster
 WHERE WHCODE BETWEEN 'WH002' AND 'WH005'
   AND INSPFLAG <> 'I'
   AND UNITCOST > 1000



/*****************************************************************************************************
5. 특정 컬럼 검색 조건을 N개로 지정하여 조회(IN, NOT IN) - 빈도수가 많음***
   - 특정 컬럼이 포함하고 있는 데이터 중 검색하고자 하는 조건이 많을 때 사용.
*/
/*
    품목 마스터 테이블에서 
    ITEMCODE 와 ITEMTYPE, MAXSTOCK 컬럼을 조회하는데.
    MAXSTOCK의 수가 1 이상 3000 이하인 것 중에
    ITEMTYPE이 'FERT' 'HALB' 인 데이터만 조회

	FERT = 완제품 , HALB = 반제품(생산중인 것)
*/
SELECT ITEMCODE,
       ITEMTYPE,
	   MAXSTOCK
  FROM TB_ItemMaster
 WHERE MAXSTOCK BETWEEN 1 AND 3000
   AND ITEMTYPE IN ('FERT', 'HALB') -- AND (ITEMTYPE = 'FERT' OR ITEMTYPE = 'HALB')


/* 컬럼의 데이터 중 특정 데이터를 제외하고 검색 NOT IN

	품목 마스터에서
	ITEMCODE, ITEMTYPE, MAXSTOCK 컬럼을 조회하는데
	MAXSTOCK 의 수가 1이상 3000이하이고
	ITEMTYPE 이 'FERT', 'HALB'가 아닌 데이터만 조회 
*/
SELECT ITEMCODE,
	   ITEMTYPE,
	   MAXSTOCK
  FROM TB_ItemMaster
 WHERE MAXSTOCK BETWEEN 1 AND 3000
   AND (ITEMTYPE <> 'FERT' AND ITEMTYPE <> 'HALB') -- AND ITEMTYPE NOT IN ('FERT', 'HALB')

/* 실습 **********************************************
	품목 마스터 테이블에서
	CARTYPE 컬럼의 값이 TL, LM이고
	WHCODE 컬럼의 값이 WH004~WH007 사이에 있는 것 중
	ITEMTYPE이 HALB가 아닌
	ITEMCODE, ITEMNAME, ITEMTYPE, WHCODE, CARTYPE 컬럼의 데이터를 모두 검색하세요

	CARTYPE : 차종
*/
SELECT ITEMCODE,
       ITEMNAME,
	   ITEMTYPE,
	   WHCODE,
	   CARTYPE
  FROM TB_ItemMaster
 WHERE WHCODE BETWEEN 'WH004' AND 'WH007'
   AND ITEMTYPE <> 'HALB'
   AND CARTYPE IN ('TL','LM')
   
   
