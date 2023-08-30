/* 저장 프로시져
  . 쿼리문들의 집합으로, 수행하고자 하는 쿼리를 데이터베이스에 등록 후 
    원하는 결과를 여러 쿼리를 거쳐서 일괄적으로 처리 할 때 사용. 

  - 장점 
    1. 성능의 향상 
	   . 첫 실행 이후 캐시메모리에 등록이 되고 두번째 부터는 메모리에 있는 내용을 수행하므로 
	     SQL 구문을 매번 실행 하는것 보다 프로세스 가 향상된다. 
	
	
	2. 유지보시 및 재활용이 용이
	   . 응용프로그램 코드 에서 sql 문을 수정하지 않아도 된다. 
	   . 한번 만들어 두면 메서드 처럼 재사용이 용이.
	3. 보안 
	   . db 서버에 저장해 두어 임의 사용자로인한 sql 변질을 막을수있다. 
	
	
	4. 클라이언트 부하 절감 
	   . 응용프로그램에서 sql 실행시 문자열 이 네트워크 상으로 전달 되는 부하를 줄일수 있다.
*/

-- 프로시저 만들기. 

CREATE PROCEDURE SP_MYPROCEDURE_1  -- 프로시져 생성 선언과 이름 선언.
   
   ------------------  파라매터 설정 부분 ----------------
   @DATE    VARCHAR(10), --  일자 
   @CUSTID  VARCHAR(30)  --  고개ID

AS
BEGIN
	-- 프로시저가 수행 할 SQL 을 나열
	 
	--1-1 테이블 삭제하기 .
	DELETE T_CUSTOMER2;

	--1-2 판매 이력 에 판매 이력 등록하기 .
	INSERT INTO T_SalesList (CUST_ID, FURIT,   PRICE, AMOUNT,DATE)
					  VALUES(3,      '사과',  3000,  8,     @DATE)

	-- 1-3 고객 정보 수정 하기 .
	UPDATE T_Custmer
	   SET NAME = '뉴진스'
	 WHERE CUST_ID = 3

END



SELECT * FROM T_CUSTOMER2; -- 삭제될 데이터.
SELECT * FROM T_SalesList WHERE DATE = '2023-04-26' -- 신규로 등록되어야 하는 행. 
SELECT * FROM T_Custmer WHERE CUST_ID = 3 -- 변경되어야 하는 고객 이름.


EXEC SP_MYPROCEDURE_1 '2023-04-26',10