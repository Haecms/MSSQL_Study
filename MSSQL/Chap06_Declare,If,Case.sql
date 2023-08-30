/***************************************************************************************************************************
1. ���� ������ ������ �����ϰ� ����ϴ� ���

-- DECLARE @[������][������Ÿ��](ũ��) */

-- ������ ������ ���� �ݵ�� @�� �տ� �־�� �Ѵ�.

--1) ������ ���� ����
DECLARE @LS_VALUE VARCHAR(10);

--2) ������ ���� ����
DECLARE @LI_VALUE INT;

--2-1) ���� ����
DECLARE @LS_VALUE2 VARCHAR(20),
		@LI_VALUE2 INT;

--3) ������ ������ ���/����. (SET)
SET @LS_VALUE = '�ȳ��ϼ���';
SET @LI_VALUE = 20;

--4) ������ ������ ���/���� (SELECT)
SELECT @LS_VALUE = '�ȳ��ϼ���',
	   @LI_VALUE = 20;

SELECT @LS_VALUE, @LI_VALUE

/****************************************************************************************
2. �б⹮(If��)
 . ���ǿ� ���� ������ �帧�� �����ϴ� ���ɹ� */

DECLARE @LS_MESSAGE VARCHAR(30), -- �޼����� ��� ����
        @LI_INVALUE INT			 -- �ԷµǴ� ���ڰ� ��� ����

SET @LI_INVALUE = 500;

IF(@LI_INVALUE > 900)
BEGIN 
	SET @LS_MESSAGE = '900���� Ů�ϴ�.';
END
ELSE IF (@LI_INVALUE <=900 AND @LI_INVALUE > 400)
BEGIN
	SET @LS_MESSAGE = '400���� ũ�� 900���� �Դϴ�.';
END
ELSE
BEGIN
	SET @LS_MESSAGE = '400 �����Դϴ�';
END

SELECT @LS_MESSAGE;


/************************************************************************************************8
3. �б⹮(CASE WHEN THEN END)
 . ����� ���¿� ���� ���̳� ������ �ٸ��� �����ϴ� �б⹮

 1. CASE [�񱳴��] WHEN [����] THEN[���] END
   - ������ �� ���� �ټ��� ���ǿ� ���� ����� ǥ���� ���.

 2. CASE WHEN [�񱳴��, �񱳿�����, ����] THEN[���] END
   - �ټ��� �� ���� �ټ��� ���ǿ� ���� ����� ǥ���� ���. */

-- 1) ��ȸ�� SELECT���� ���Ǵ� CASE WHEN��
-- 1-1) CASE [�񱳴��] WHEN [����] THEN[���] END

SELECT INOUTFLAG,
	   CASE INOUTFLAG WHEN 'I' THEN '�԰�' 
	   			      WHEN 'O' THEN '���'
					  WHEN 'IN' THEN '�԰�' 
	   			      WHEN 'OUT' THEN '���'
	   			      ELSE 'X' END			AS INOUTFLAG
  FROM TB_StockMMrec

-- 1-2) CASE WHEN [�񱳴��, �񱳿�����, ����] THEN [���] END			- ���ؼ� �����͸� ǥ���� ��
		
		SELECT  ITEMCODE,
				STOCKQTY,
				CASE WHEN STOCKQTY <= 0 THEN '��� ����'
					 WHEN STOCKQTY > 0 AND STOCKQTY <=1000 THEN '�������'
					 ELSE '����ʰ�' END STOCKSTATUS
		  FROM TB_StockMM

-- 2) ���Ǻο� ���Ǵ� CASE WHEN										- ��ȸ�Ǵ� ��� ��ü�� �ٸ��� �ٲ� �� ����
-- 2-1
DECLARE @LI_STOCKQTY INT;

SET @LI_STOCKQTY = 500;

   SELECT *
     FROM TB_StockMM
	WHERE MATLOTNO = CASE @LI_STOCKQTY WHEN 1700 THEN 'LT_R2021082012481881'
									   ELSE 'LOTR2021070817274225' END
	
-- 2-2

DECLARE @LI_CNT INT;
SET @LI_CNT = 100;

SELECT *
  FROM TB_StockMM
 WHERE 1 = CASE WHEN @LI_CNT = 100 THEN 1
	    		ELSE 0 END


 /*************************************************************************************************************
  4. NULL ó���� ���� ���ϴ� �����ͷ� ��ȯ�ϱ�.(ISNULL) */

  /* TB_StockMMrec : ���� ���� �̷� ���̺�
  
	 ���� ���� �̷� ���̺����� 
	 PLANTCODE, INOUTDATE, INOUTSEQ, ITEMCODE �÷��� �����͸� �˻��ϰ�
	 ITEMCODE�� NULL�� ��� X�� ǥ���ϼ���. */

SELECT PLANTCODE,
       INOUTDATE,
	   INOUTSEQ,
	   ISNULL(ITEMCODE, 'X') AS ITCD  --�������ڵ忡 ���� �ִٸ� X�� ����ó���ؼ� ��Ÿ����
  FROM TB_StockMMrec



-- NULL ó���� �÷� ������ ��ȸ�ϱ�
SELECT ITEMCODE,
	   ITEMNAME,
	   LOCCODE
  FROM TB_ItemMaster
 WHERE ISNULL(LOCCODE,'') LIKE '%%' -- ��ȸ�� �� �Ǵµ� LIKE '%%'�� ��ȸ�����ϰ� ��

 SELECT ITEMCODE,
	    ITEMNAME,
	    LOCCODE
   FROM TB_ItemMaster
  WHERE ITEMCODE LIKE '%%'