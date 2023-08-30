/* ���� ���� (���� ����) �߿䵵 ******* 7����
  - ���� �ȿ� ����
  - �Ϲ������� SELECT��
			    FROM ��
			   WHERE ��
	�� ���ȴ�.

	���� : SQL ���� �ȿ��� �����ϰ� �ٸ� SQL ������ �����
	       ����� �� �ִ�.
	���� : ������ ����������.


	1. ���������� ��ȣ�� ���μ� ����Ѵ�.
	2. ���������� ���� �� �Ǵ� ���� �� �� �����ڿ� �Բ� ��� ����
	3. �������������� ORDER BY ������ ����� �� ����.
*/

/***********************************************************************************************/
-- ���� ������ ���� ������ ��ȸ (WHERE ��)
/*
	TB_StockMMrec : ���� ��� ����� �̷�
	TB_ItemMaster : ǰ���� ����Ʈ(ǰ�� ������)
	PONO          : ���縦 ������ ��ȣ

   ���� ��� ����� �̷� ���̺��� PONO ��'PO202106270001'�� ITEMCODE��
   ������ 
   ǰ�� ������ ���̺��� ��ȸ�Ͽ� 
   ITEMCODE, ITEMNAME, ITEMTYPE CARTYPE �÷����� �����͸� �˻��ϼ���*/

-- 1. ���� ��ȣ�� ���� ǰ���ڵ忡 ���� ���� ǰ�� �����Ϳ��� ��ȸ
SELECT ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE
  FROM TB_ItemMaster
 WHERE ITEMCODE = (SELECT ITEMCODE
					  FROM TB_StockMMrec
					 WHERE PONO = 'PO202106270001')

-- 2. ���� ��ȣ�� ����ǰ�� �ڵ带 ������ ���� ǰ�� �����Ϳ��� ��ȸ
SELECT ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE
  FROM TB_ItemMaster
 WHERE ITEMCODE <> (SELECT ITEMCODE
					  FROM TB_StockMMrec
					 WHERE PONO = 'PO202106270001')
-- 3. �԰� �� ǰ�� �ڵ� ������ �ִ� ������ ǰ�� �ڵ� ������ ǰ�� �����Ϳ��� ��ȸ
SELECT ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE
  FROM TB_ItemMaster
 WHERE ITEMCODE IN (SELECT DISTINCT ITEMCODE
					  FROM TB_StockMMrec  -- ��������� �ϸ� �� �� ���� �������� ���� 2�� �̻��� ����
					 WHERE INOUTFLAG = 'I'
					   AND ITEMCODE IS NOT NULL)

-- 4. �������� �������� ǰ�� �ڵ带 ������ ǰ�� ������ ���� ��ȸ.
SELECT ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE
  FROM TB_ItemMaster
 WHERE ITEMCODE NOT IN (SELECT DISTINCT ITEMCODE
					  FROM TB_StockMMrec 
					 WHERE INOUTFLAG = 'I'
					   AND ITEMCODE IS NOT NULL)

-- WHERE ���ǿ� '=' �����ڰ� ���� ��� �������� ������ ������ �� ����. 
--		�������� ������ ������ ��� 'IN', 'NOT IN'�� ����ؾ� �Ѵ�.
/************�ǽ�**********
TB_StockMMrec : ���� ���� �̷� ���̺�
 ITEMCODE : ǰ�� �ڵ�
 INOUTQTY : ���� ����
 CARTYPE  : ����
INOUTFLAG : ��/�� ����(I:�԰�)

���� �����̷� ���̺���
ITEMCODE�� ���� ������ �ְ�
INOUTQTY�� 1000�� �̻��̸鼭
INOUTFLAG�� I�� ITEMCODE ����Ʈ�� �����ϰ�
ITEMCODE ���� ������ ǰ�񸶽��Ϳ���
ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE �������� ��ȸ�� ������.
*/
SELECT ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE
  FROM TB_ItemMaster
 WHERE ITEMCODE IN (SELECT ITEMCODE
					  FROM TB_StockMMrec
					 WHERE INOUTFLAG = 'I'
					   AND ITEMCODE IS NOT NULL
					   AND INOUTQTY >= 1000)

/* ���� ������ ���� ����
TB_STOCKMM : ���� ��� ���̺�
TB_StockMMrec : ���� ���� �̷� ���̺�
TB_ITEMMASTER : ǰ�� ������(ǰ�� ����Ʈ)

MATLOTNO : ���� LOT NO(������ ��������)

���� ��� ���̺��� STOCKQTY�� 3000���� ū MATLOTNO�� ������
���� ��� �̷� ���̺��� ITEMCODE�� ã�Ƴ��� �ش� ǰ�� ���� ������ 
ǰ�� �����Ϳ��� ��ȸ�Ͽ� 
ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE �÷����� �˻�
*/
-- �� ��
SELECT ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE
  FROM TB_ItemMaster
 WHERE ITEMCODE IN (SELECT ITEMCODE
					  FROM TB_StockMMrec
				     WHERE MATLOTNO IN(SELECT MATLOTNO
									     FROM TB_StockMM
									    WHERE STOCKQTY > 3000))

-- ������ ��
-- 1. ���� ��� ���̺��� 3000���� ū LOTNO ã��
SELECT MATLOTNO
  FROM TB_StockMM
 WHERE STOCKQTY > 3000

-- 2. ��� �̷� ���̺��� LOTNO�� �̷�
SELECT ITEMCODE
  FROM TB_StockMMrec
 WHERE MATLOTNO = (SELECT MATLOTNO
 		             FROM TB_StockMM
 		            WHERE STOCKQTY > 3000)
--3 2���� ��ȸ�� ǰ���� ������ ��ȸ
SELECT ITEMCODE, ITEMNAME, ITEMTYPE, CARTYPE
  FROM TB_ItemMaster
 WHERE ITEMCODE IN (SELECT ITEMCODE
					  FROM TB_StockMMrec
				     WHERE MATLOTNO = (SELECT MATLOTNO
									     FROM TB_StockMM
									    WHERE STOCKQTY > 3000))


/***********************************************************************************************/
-- ���� ������ ���� ������ ��ȸ (WHERE ��)

/*
	���� ��� ���̺��� ITEMCODE, INDATE, MATLOTNO �÷��� �����͸� �˻��ϰ�
	���� ��� �����̷� ���̺��� ���� ��� ���̺��� ��ȸ�� MATLOTNO �÷��� �����͸� �����ϰ�
	INOUTFLAG = 'OUT'�� �����͸� ������ INOUTDATE �÷��� ��ȸ�϶�!!
	���� �����ִ� �ֵ��� ������ڸ� �˰�ʹ� �̸��̾�!
*/

-- [POINT 4]
SELECT ITEMCODE,
	   INDATE,
	   MATLOTNO,
	   (SELECT INOUTDATE  FROM TB_StockMMrec   WHERE MATLOTNO = A.MATLOTNO AND INOUTFLAG = 'OUT') AS INDATE
  FROM TB_StockMM A

-- ���� �ܰ�
-- 1.
SELECT ITEMCODE,
	   INDATE,
	   MATLOTNO
  FROM TB_StockMM

-- 2. ���� ����

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
-- 3. ���� ����

SELECT ITEMCODE,
	   INDATE,
	   MATLOTNO
  FROM TB_StockMM
-- ����� �������� ����� �ϳ��� ���δ�.
-- ***** ���� : ������ �Ǵ� ���̺� TB_StockMM���� 1�� ��ȸ ���� ��
--				SUB ���� 9�� ����ǹǷ� �� 10���� �˻��� ����Ǳ⿡ ������!



/*******************************************************************************************************************
-- ���� ���� (FROM)
  . FROM ���� ���� ���̺� ��ġ�� ���̺� ����ó�� �ӽ� ���̺�� ������ �����͸� ������ �ۼ��� �� �ִ�.
  . ������ �����͸� ���̺� �������� ����� �� �ִ�.
  . ���̺��� ��������(��ȣ) �ڿ��� �ݵ�� �ӽ����̺��� �̸��� �ο��ؾ��Ѵ�.
*/

SELECT *						-- WHCODE�� ���� �ȵ�
  FROM (SELECT ITEMCODE,
        	   ITEMNAME,
        	   ITEMTYPE,
        	   BASEUNIT
          FROM TB_ItemMaster
         WHERE ITEMTYPE = 'FERT') AS TB_TEMP

-- POINT 3�� �ǽ� ��������
-- COUNT ���� �Լ��� �ѹ��� ����ؼ� ���� ����� ���� �������� �ۼ�

  SELECT INOUTDATE,
   	     WHCODE,
   	     COUNT(*) AS CNT
    FROM TB_StockMMrec
   WHERE INOUTFLAG = '1'
     AND INOUTQTY > 1000
GROUP BY INOUTDATE, WHCODE
  HAVING COUNT(*) >= 2
ORDER BY INOUTDATE

-- ���� ����� HAVING�� ���� �ʰ� ���� ����� ����� ����
-- �����Լ��� �ѹ��� ����ϴ� ���

-- 1. ��ü �������� ���� ���� ����.
   SELECT INOUTDATE,
	      WHCODE,
	      COUNT(*) AS CNT
     FROM TB_StockMMrec
    WHERE INOUTFLAG = 'I'
      AND INOUTQTY > 1000
GROUP BY INOUTDATE, WHCODE

-- 2. ����� ����� �ӽ����̺�� FROM���� ���������� ����Ͽ� ��ȸ

SELECT *
  FROM(SELECT INOUTDATE,
              WHCODE,
              COUNT(*) AS CNT
         FROM TB_StockMMrec
        WHERE INOUTFLAG = 'I'
          AND INOUTQTY > 1000
     GROUP BY INOUTDATE, WHCODE) A
  WHERE CNT >=2
