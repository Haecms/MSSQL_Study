/* 1. INSERT
 - 테이블에 데이터를 등록
 - INSERT의 기본 유형
    . INSERT INTO <테이블> (열이름1, 열이름2,...) VALUES(값1, 값2,...)
*/

-- 1-1 고객 테이블에 데이터 등록
INSERT INTO T_Customer (CUST_ID,  NAME,		 PHONE) 
			    VALUES (7,		'임창정', '7777-7777')
SELECT * FROM T_Customer
-- 1-2 모든 컬럼에 데이터를 등록 할 때는 컬럼의 이름 생략 가능


-- 1-3 테이블의 복사. (데이터와 동시에 복사하여 테이블을 생성하는 로직)
SELECT * INTO T_CUSTOMER2 FROM T_CUSTOMER

SELECT * FROM T_CUSTOMER2

--1-5 SELECT를 통한 다수의 데이터 등록.
INSERT INTO T_CUSTOMER2 (CUST_ID,	NAME, BIRTH, ADDRESS)
			     SELECT CUST_ID, NAME, BIRTH, ADDRESS
				   FROM T_Customer
				  WHERE CUST_ID > 3

SELECT * FROM T_CUSTOMER2

-- 1-6 변수를 통한 등록
DECLARE @LS_NAME VARCHAR(10) = '닐로'
INSERT INTO T_CUSTOMER2(CUST_ID, NAME) VALUES (20, @LS_NAME)
-- 1-7 변수를 통한 등록 2
INSERT INTO T_CUSTOMER2 (CUST_ID, NAME, BIRTH, ADDRESS)
				 SELECT CUST_ID, NAME, BIRTH, ADDRESS
				   FROM T_Customer
				  WHERE CUST_ID <=3

/******* UPDATE
 - 테이블의 데이터를 수정
 - UPDATE의 기본 유형
   UPDATE <테이블>
      SET 열이름1 = 값1
	      열이름2 = 값2
		  열이름3 = 값3
	WHERE [조건]
*/

-- 사과의 단가를 수정해야 되는 일이 있을 때
SELECT * FROM T_FRUIT

UPDATE T_FRUIT
   SET UNIT_COST = 2500
 WHERE FRUIT = '사과'

 --숫자를 더하기.
 -- 모든 과일의 가격을 현재보다 500원 인상할 경우
UPDATE T_FRUIT
   SET UNIT_COST += 500


UPDATE T_FRUIT
   SET UNIT_COST = NULL
 WHERE FRUIT = '사과'

/************DELETE
  테이블의 행의 데이터를 삭제
*/


DELETE T_CUSTOMER2
 WHERE CUST_ID BETWEEN 13 AND 19

 /********* DELETE와 UPDATE는 조건을 필수로 확인 해야 한다. */


 -- 만약에 데이터를 변경해 버렸을 경우?
 -- 백업 데이터가 있을 때 복원하는 방법

 -- 삭제, UPDATE, INSERT를 미리 실행해보고 확인한 후 승인 할 수 있는 방법이 없을까?
 
/*************************** 트랜잭션 *************************
	트랜잭션 (TRANSACTION)
	 - 데이터 갱신 내역 승인 또는 복구 (BEGIN TRAN, COMMIT, ROLLBACK)
	 - 데이터의 일관성을 유지시키기 위해서
	   . 데이터 관리 시 발생하는 오류사항 10건의 데이터가 갱신(INSERT, UPDATE, DELETE)될 때
	     중간에 5건쯤에 오류가 발생하여 트랜잭션을 실행하지 못 할 경우 
	 - 트랜잭션의 독립성(격리성)
	   . 하나의 트랜잭션이 수행되고 있을 때 또 다른 트랜잭션이 간섭할 수 없다.
*/
BEGIN TRAN
DELETE T_CUSTOMER2
 WHERE CUST_ID <10

SELECT * FROM T_CUSTOMER2

-- BEGIN TRAN을 원상복구 할 경우
ROLLBACK

-- BEGIN TRAN을 승인할 경우
COMMIT