USE [MyFirstDataBase]
GO
/****** Object:  StoredProcedure [dbo].[SP_MYPROCEDURE_1]    Script Date: 2023-04-26 오후 4:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_MYPROCEDURE_1] -- 프로시져 생성 선언과 이름 선언

-- 아(아규먼트)수(인수)주(주는값)받(받는값은)자매(파라매터)(매개변수)
   ------------------ 파라매터(인자) 설정 부분 ----------------------
	@DATE	VARCHAR(10), -- 일자 라는 변수 선언
	@CUSTID VARCHAR(30)  -- 고객ID

AS
BEGIN
	-- 프로시저가 수행 할 SQL을 나열
	-- 1-1 테이블 삭제하기
	DELETE T_CUSTOMER2;

	--1-2 판매 이력에 판애 이력 등록하기
	INSERT INTO T_SalesList (CUST_ID, FRUIT, PRICE, AMOUNT, DATE)
				     VALUES (@CUSTID, '사과', 3000, 8	  , @DATE)

	--1-3 고객 정보 수정하기.
	UPDATE T_Customer
	   SET NAME = '나얼'
	 WHERE CUST_ID = 3

END