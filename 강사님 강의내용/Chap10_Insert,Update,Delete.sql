/* 1. INSERT 
  - 테이블에 데이터를 등록 
  - INSERT 의 기본유형
    . INSERT INTO < 테이블 > (열이름1, 열이름2,....) VALUES (값1, 값2....)
*/

-- 1-1 고객 테이블에 데이터 등록. 
INSERT INTO T_Custmer (CUST_ID, NAME,     PHONE) 
               VALUES (7,       '임창정', '7777-7777')






-- 1-2 모든 컬럼에 데이터를 등록 할 때는 컬럼의 이름 생략 가능. 
INSERT INTO T_Custmer VALUES (8, '박효신', '1981' ,'서울','8888-8888')






SELECT * FROM T_Custmer
SELECT * FROM T_CUSTOMER3

-- 1-3 테이블의 복사. (데이터와 동시에 복사)
SELECT * INTO T_CUSTOMER3 FROM T_Custmer









-- 1-5 SELECT 를 통한 다수 의 데이터 등록. 
INSERT INTO T_CUSTOMER3 (CUST_ID,    NAME , BIRTH, ADDRESS) 
			      SELECT CUST_ID, NAME, BIRTH, ADDRESS
				    FROM T_Custmer
				   WHERE CUST_ID > 3








-- 1-6 변수를 통한 등록
DECLARE @LS_NAME VARCHAR(10) = '난로'
INSERT INTO T_CUSTOMER2(CUST_ID, NAME)
                 VALUES (21, @LS_NAME)










-- 1-7 변수를 통한 등록 2
DECLARE @LS_NAME2 VARCHAR(10) = '황정민'
INSERT INTO T_CUSTOMER2 (CUST_ID, NAME,        BIRTH,   ADDRESS)
				  SELECT CUST_ID, 
				         @LS_NAME2,   
						 BIRTH,   
						 ADDRESS
				    FROM T_Custmer
				   WHERE CUST_ID <= 3










/***** UPDATE 
 - 테이블의 데이터를 수정. 

 - UPDATE 의 기본 유형 
   UPDATE <테이블>
      SET 열이름1 = 값1,
	      열이름2 = 값2,
		  열이름3 = 값3
	WHERE [조건]
*/

-- 사과의 단가를 수정해야 되는 일이 있을때 . 
   UPDATE T_Fruit
      SET PRICE = 4000
	WHERE FRUIT < 15000

-- 숫자 를 더하기 . 
-- 모든 과일의 가격을 현재보다 500원 인상할경우. 
UPDATE T_Fruit
   SET PRICE = PRICE + 500 

UPDATE T_Fruit
   SET PRICE = NULL
 WHERE FRUIT = '사과'

   


/****************** DELETE 
 테이블의 행의 데이터를 삭제. 
*/


DELETE T_CUSTOMER2
 WHERE CUST_ID BETWEEN 10 AND 15


/********** DELETE 와 UPDATE 는 조건을 필수로 확인 해야 한다. */


-- 만약에 데이터 를 변경 해 버렸을 경우 ? 
-- 백업 데이터가 있을때 복원 하는 방법 

-- DELETE , UPDATE , INSERT 를 미리 실행해 보고 확인 한후 승인 할수 있는 방법 ? 

/****************** 트랜잭션 *****************
  . 트랜잭션 (TRANSACTION) 
    - 데이터 갱신 내역 승인 또는 복구  (BEGIN TRAN , COMMIT , ROLLBACK)
	- 데이터의 일관성 
	  . 데이터 관리 시 발생하는 오류사항 10건의 데이터가 갱신(INSERT,UPDATE,DELETE)  될때 
	    중간에 5건쯤에 오류가 발생 하여 트랜잭션을 실행 하지 못할경우. 
	- 트랜잭션의 독립성 (격리성)
	  . 하나의 트랜잭션이 수행되고 있을때 또다른 트랜잭션이 간섭 할 수없다. 

*/

BEGIN TRAN
DELETE T_CUSTOMER2
 where CUST_ID < 10

SELECT * FROM T_CUSTOMER2

-- begin tran 을 원상복구 할 경우.
rollback

-- begin tran 을 승인 할 경우. 
commit



