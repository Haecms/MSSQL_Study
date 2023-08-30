/* 1. LIKE     *****
   . �����͸� �����ϴ� �� ��ȸ
   . WHERE ���ǿ� �˻��ϰ��� �ϴ� �������� �Ϻθ� �Է��Ͽ� 
     �ش� ������ ������Ű�� ��� �����͸� ��ȸ('%')
   . LIKE + '%' ������ �����ϴ����� ����

*/

-- ǰ�� ������ ���̺��� ITEMCODE �÷��� ������ �� 'E'�� ���Ե�
-- �����͸� ��� �˻��ϼ���.

-- 1) ITEMCODE�� �����Ͱ� E�� �����ϸ� ���� ��ȸ�ϴ� ����
SELECT *
  FROM TB_ItemMaster
 WHERE ITEMCODE LIKE '%E%'

--2) ITEMCODE�� �����Ͱ� E1�� �����ϸ� ��ȸ�϶�
SELECT *
  FROM TB_ItemMaster
 WHERE ITEMCODE LIKE 'E1%'

--3) ITEMCODE�� E�� ������ ������ ��ȸ
SELECT *
  FROM TB_ItemMaster
 WHERE ITEMCODE LIKE '%E'


/*************************************************************************
2. NULL �� �ƴ� ������ ��ȸ �� NULL�� ������ ��ȸ(IS NULL, IS NOT NULL)
   NULL : �����Ͱ� ���� ����ִ� ����, �� ��ü�� �־����� ���� ����.
*/

-- ǰ�� ������ ���̺��� MAXSTOCK �÷��� �����Ͱ� NULL ó�� �� ���� ��� �˻�.
SELECT *
  FROM TB_ItemMaster
 WHERE MAXSTOCK IS NULL

 -- ǰ�񸶽��� ���̺��� MAXSTOCK �÷��� �����Ͱ� NULL�� �ƴ� ���� ��� �˻�.
 SELECT *
   FROM TB_ItemMaster
 WHERE MAXSTOCK IS NOT NULL

 //*****************�ǽ�**********************************
 ǰ�� �����Ϳ��� 
 BOXSPEC �÷��� �����Ͱ� '01'�� �����鼭 NULL�� �ƴ�
 PLANTCODE, ITEMCODE, ITEMNAME, BOXSPEC �÷��� ���� �˻��ϼ���.
 BOXSPEC : ������� ����
 */
 SELECT PLANTCODE,
	    ITEMCODE,
		ITEMNAME,
		BOXSPEC
  FROM TB_ItemMaster
 WHERE BOXSPEC LIKE '%01'
   AND BOXSPEC IS NOT NULL


/**********************************************************************************************
 3. �˻� ����� ����. (ORDER BY, ASC, DESC)
  . ���̺��� �˻��� ����� ���ǿ� ���� �����Ͽ� ��Ÿ����.
  . ���� ������ ���(ASC)�� ���.  * NULL ������ ���� �ֻ����� ��Ÿ����.
  . ���� ������ ���(DESC)�� ���.

  */

  -- ǰ�񸶽��� ���̺��� ITEMTYPE = 'HALB'�� (ǰ�� ������ ����ǰ)
  -- ITEMCODE, ITEMTYPE �÷��� �����͸� ITMCODE �÷� ������ �������� ���������Ͽ� ��ȸ
  SELECT ITEMCODE,
		 ITEMTYPE
    FROM TB_ItemMaster
   WHERE ITEMTYPE = 'HALB'
ORDER BY ITEMCODE



--** ORDER BY ���� �÷��� �߰��� ��� ���� ���� ���������� �켱������ ������.
-- ǰ�񸶽��� ���̺��� ITEMTYPE = 'HALB'�� 
-- ITEMCODE, ITEMTYPE, WHCODE, BOXSPEC �÷���
-- ITEMTYPE�� ���� ���ٸ� WHCODE ������, WHCODE ���� ���ٸ� BOXSPEC ������ �����ϼ���

  SELECT ITEMCODE,
 	     ITEMTYPE,
 	     WHCODE,
 	     BOXSPEC
    FROM TB_ItemMaster
   WHERE ITEMTYPE = 'HALB'
ORDER BY WHCODE, BOXSPEC

-- * ��ȸ ��� ���� �÷��� ������ ���� ���� �߰��ϱ�
-- �����͸� Ȯ�� �� �� ������ ORDER BY�� ������� ���� �ȴ�.


-- ǰ�񸶽��� ���̺��� ITEMTYPE = 'HALB'��
-- ITEMTYPE, WHCODE, BOXSPEC �÷��� 
-- ITEMCODE ������� �����϶�. (�� ���� Ÿ�� ��)
  SELECT ITEMTYPE,
	     WHCODE,
	     BOXSPEC
    FROM TB_ItemMaster
   WHERE ITEMTYPE = 'HALB'
ORDER BY ITEMCODE

-- ** �� ������ �����ϱ� DESC
-- ǰ�񸶽��� ���̺��� ITEMCODE, ITEMNAME �÷��� ��ȸ�ϴµ�
-- ITEMCODE �÷������� �������� (��������) ��ȸ
SELECT *
  FROM TB_ItemMaster
ORDER BY ITEMCODE DESC


/* ���������� ���������� ȥ���Ͽ� ����ϴ� ��
   
   ǰ�񸶽��� ���̺� �ִ� ��� ������ �߿�
   ITEMTYPE�� ������������, WHCODE�� ������������, INSPFLAG�� ������������ ���� */
SELECT ITEMCODE, ITEMTYPE, WHCODE, INSPFLAG
  FROM TB_ItemMaster
ORDER BY ITEMTYPE ASC, WHCODE DESC, INSPFLAG


/***************�ǽ�**************
 ǰ�� ������ ���̺��� 
 MATERIALGRAD �÷��� ���� NULL�̰�
 CARTYPE �÷��� ���� MD, RB TL �� �ƴϸ鼭
 ITEMCODE �÷� ���� '001'�� �����ϰ�
 UNITCOST �÷� ���� 0�� ���� 
 ��� �÷�
 ITEMNAME �÷� ���� �������� WHCODE�÷����� ������������ �˻�
 MATERIALGRADE : ���� ���.
 CARTYPE : ����
 UNITCOST : �ܰ�
 ITEMCODE : ǰ��
 ITEMNAME : ǰ��
*/
SELECT *
  FROM TB_ItemMaster
 WHERE CARTYPE NOT IN ('MD','RB','TL') -- WHERE CARTYPE <> 'MD' AND CARTYPE <> 'RB' AND CARTYPE <> 'TL'
   AND ITEMCODE LIKE '%001%'
   AND UNITCOST = 0
   AND MATERIALGRADE IS NULL
ORDER BY ITEMNAME DESC, WHCODE


/*******************************************************************************************************************
4. �˻��� ������ �߿� ��ȸ�� ���� ���� N ���� �����͸� ǥ��. TOP
*/

-- ǰ�� ������ ���̺��� �ִ� ���緮�� ���� ������ �ְ�
-- MAXSTOCK�÷��� ���� ���� ū ǰ���� �ڵ带 �˻��ϼ���. 
SELECT TOP(1) ITEMCODE
  FROM TB_ItemMaster
 WHERE MAXSTOCK IS NOT NULL
ORDER BY MAXSTOCK DESC


-- ���� 10���� �����͸� ��ȸ�� ���� 
SELECT TOP(10) *
  FROM TB_ItemMaster
ORDER BY MAXSTOCK DESC


/*****************�ǽ�**************************
  TB_StockMMrec (���� ���� �̷� ���̺�)
  INOUTFLAG : �԰� 1, ��� 0
  INOUTQTY : ���� ����

  TB_StockMMrec ���̺��� INOUTFLAG�� 'O'�� ������ ��.
  INOUTDATE�� ���� �ֱ� �߻��� ���� 10�� ǰ���� 
  ITEMCODE, INOUTQTY�� ��ȸ�ϼ���
  * ���� ��� �̷� �� ���� �ֱ� ��� �̷�
  */
SELECT TOP(10) ITEMCODE,
			   INOUTQTY
		  FROM TB_StockMMrec
		 WHERE INOUTFLAG = 'O'
	  ORDER BY INOUTDATE DESC