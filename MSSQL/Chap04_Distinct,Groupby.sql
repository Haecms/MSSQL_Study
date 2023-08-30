/**********************************************************************************
1. ������ �պ� �˻� (DISTINCT)

  - �÷��� �����Ͱ� �ߺ��Ǿ� ���� ��� �ߺ��� �����͸� �պ��Ͽ� �˻�.

-- �츮 ȸ�翡�� �����ϴ� ��� ǰ���� ������ ��Ÿ������.

-- ǰ�� ������ ���̺��� ǰ�� ������ ǥ���ϸ� �ǰڱ���.
*/
SELECT DISTINCT ITEMTYPE
  FROM TB_ItemMASTER

-- ������ KG�� ǰ���� ������ ��ȸ�ϼ���
-- ǰ�񸶽��� ���̺��� BASEUNIT(����)�� KG�� �������� ITEMTYPE(����)�� ���� �� �˻�

SELECT DISTINCT ITEMTYPE
  FROM TB_ItemMaster
 WHERE BASEUNIT = 'KG'


/* ���� �÷��� �պ��� �ƴ� ���� �÷��� �պ��� ����

 -- ������ KG�� ������ ǰ�� ������ â�� �����ּ���.

 ITEMTYPE : ǰ�� ����
 WHCODE : â��.

*/
SELECT DISTINCT ITEMTYPE,
				WHCODE
  FROM TB_ItemMaster
 WHERE BASEUNIT = 'KG'


 -- 1 �츮 ȸ�翡�� �����ϴ� ��� ǰ�� ��ȸ
 SELECT * FROM TB_ItemMaster

 -- 2 �츮 ȸ���� ��� ǰ���� ������ ����Ʈ
 SELECT ITEMTYPE FROM TB_ItemMaster

 -- 3 ǰ���� ������ �����غ��ô�.
 SELECT DISTINCT ITEMTYPE FROM TB_ItemMaster

 -- 4 ������ KG�� ������ ��ȸ
 SELECT DISTINCT ITEMTYPE FROM TB_ItemMaster WHERE BASEUNIT = 'KG'

 -- 5 ������ KG�� ǰ�� ������ ����� �� �ִ� â�� �����ּ���.
 SELECT DISTINCT ITEMTYPE,WHCODE FROM TB_ItemMaster WHERE BASEUNIT = 'KG'


 /************************�ǽ�&*****************************
 ǰ�� ������ ���̺���
 BOXSPEC(����԰�)�� 'DS-PLT'�� �����ϴ� ǰ����� ������ â�� ��Ÿ������.
 */
 SELECT DISTINCT ITEMTYPE,
			     WHCODE
			FROM TB_ItemMaster
		   WHERE BOXSPEC LIKE 'DS-PLT%'

/**********************************************************************************************************************8
2. ������ �պ� �˻� GROUP BY �߿䵵**********
  . GROUP BY ���ǿ� ���� �ش� �÷��� �����͸� ����.
  . * GROUP BY�� ���յ� ������� ��ȸ�������� �ξ� �˻� ����(HAVING)
  . * ���� �Լ��� ����Ͽ� ���� �����͸� ���� �� �� �ִ� ����� ����


-- GROUP BY�� �⺻ ����
-- 1. ǰ�� ������ ���̺��� ITEMTYPE �÷��� ���� �� ����Ʈ �ۼ�
*/
SELECT ITEMTYPE
  FROM TB_ItemMaster

-- 2. GROUP BY�� ���Ͽ� ����.	1. FROM 2. SELECT 3.GROUP BY
  SELECT ITEMTYPE
    FROM TB_ItemMaster
GROUP BY ITEMTYPE      -- X ITEMSPEC
-- * GROUP BY ���� ���� �÷��� ��ȸ�� �� ����.
-- WHERE ���� GROUP BY  --> FROM -> WHERE -> GROUP BY -> SELECT
SELECT ITEMTYPE
  FROM TB_ItemMaster
 WHERE BASEUNIT = 'KG'
 GROUP BY ITEMTYPE


-- GROUP BY ���� ���� �÷��� ��ȸ�� �� ���� ���.
SELECT ITEMCODE,
       WHCODE
  FROM TB_ItemMaster
 WHERE BASEUNIT = 'KG'
GROUP BY ITEMTYPE      -- WHCODE�ִ� ��쿡 ��������

--[POINT1]
/*************�ǽ�***************************************
TB_StockMM : ������ ��� ���̺�
STOCKQTY : ���� ��� ����
INDATE : ��� �԰� ����

TB_StockMM ���̺��� 
STOCKQTY�� �����Ͱ� 1500 �̻��� �����͸� ������
INDATE�� �����Ͱ� '2022-03-01' ���� '2022-03-31'�� ������ ��
INDATE �� ITEMCODE ǰ���� ǥ���ϼ��� */
SELECT INDATE,
	   ITEMCODE
  FROM TB_StockMM
 WHERE STOCKQTY >= 1500
   AND INDATE >= '2022-03-01'
   AND INDATE <= '2022-03-31'			-- BETWEEN AND
GROUP BY INDATE, ITEMCODE



--K[POINT3]
/* GROUP BY ������� �� �˻��ϴ� ���� HAVING

ǰ�� ������ ���̺��� 
MAXSTOCK�� 10�� �ʰ��ϴ� ������ �߿�
ITEMTYPE �� INSPFLAG�� ��Ÿ����
INSPFLAG�� I�� �����͸� ǥ���ϼ���.
*/

-- ǰ�� �߿� �ִ� ���緮�� 10�ʰ��ϴ� ǰ���� ������ �˻� ���θ� ��Ÿ������.(�� �˻翩�δ� 'I' �ΰ�)
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT
SELECT ITEMTYPE,
       INSPFLAG
  FROM TB_ItemMaster
 WHERE MAXSTOCK > 10
 GROUP BY ITEMTYPE, INSPFLAG
   HAVING INSPFLAG = 'I'



 -- ���� * HAVING�� ���ؼ� ������ ���� �÷��� �ݵ�� GROUP BY�� ���¿��� �Ѵ�.
 SELECT ITEMTYPE,
       INSPFLAG
  FROM TB_ItemMaster
 WHERE MAXSTOCK > 10
 GROUP BY ITEMTYPE, INSPFLAG
   HAVING ITEMCODE = 'I'     --XXXX

/*******************************���⼭ ���!!****************************************************/
SELECT INDATE,
	   ITEMCODE
  FROM TB_StockMM
 WHERE STOCKQTY >= 1500
   AND INDATE >= '2022-03-01'
   AND INDATE <= '2022-03-31'			-- BETWEEN AND
GROUP BY INDATE, ITEMCODE
--�� ������ �Ʒ��� ����
SELECT DISTINCT INDATE, ITEMCODE
           FROM TB_StockMM
		  WHERE STOCKQTY >= 1500
		    AND INDATE BETWEEN '2022-03-01' AND '2022-03-31'


-- �׷��ٸ� �� GROUP BY�� ����ұ�?

/***********************************************************************************************

3. ���� �Լ�
 - Ư�� �÷��� ���� �࿡ �ִ� �����͸� ���� �� �ϳ��� ����� ��ȯ�ϴ� �Լ�.

 . SUM() : �����ϴ� �÷��� �����͸� ��� ���Ѵ�.
 . MIN() : �����ϴ� �÷��� ������ �� �ּڰ��� ��Ÿ����.
 . MAX() : �����ϴ� �÷��� ������ �� �ִ��� ��Ÿ����.
 . COUNT() : �����ϴ� �÷��� �� ������ ��Ÿ����.
 . AVG() : �����ϴ� �÷��� �����͵��� ����� ��Ÿ����.
 */


-- ǰ�� ������ ���̺��� ITEMTYPE�� FERT�� �������� UNITCOST ���� ���ϼ���
-- UNITCOST : �ܰ�.
SELECT SUM(UNITCOST)
  FROM TB_ItemMaster
 WHERE ITEMTYPE = 'FERT'

 SELECT UNITCOST
   FROM TB_ItemMaster
 WHERE ITEMTYPE = 'FERT'


-- COUNT() �Լ� : ���� ����
SELECT COUNT(*) --AS �ƹ��ų� ������ �̸� ������
  FROM TB_ItemMaster


-- AVG() �Լ� : ���
-- TB_StockMM : ������ ��� ���̺�
-- ������ ����� ��� ������ ��Ÿ������.
SELECT AVG(STOCKQTY)
  FROM TB_StockMM


-- MAX(), MIN()
-- �����͵� �߿� �ִ񰪰� �ּڰ�.
SELECT MAX(UNITCOST)
  FROM TB_ItemMaster
 -- ǰ�� �� �ܰ��� ���� ���� �ݾ�

 SELECT MIN(UNITCOST)
  FROM TB_ItemMaster
   -- ǰ�� �� �ܰ��� ���� ���� �ݾ�



-- ���� �Լ��� ȥ���Ͽ� ����� ���
-- ǰ�� �����Ϳ��� ǰ�� ���� �� �ܰ��� �� �հ� �ּڰ��� ��ȸ
SELECT ITEMTYPE,
       COUNT(*)      AS ITEMCNT,
	   SUM(UNITCOST) AS COSTSUM,
	   MIN(UNITCOST) AS COSTMIN
  FROM TB_ItemMaster
  GROUP BY ITEMTYPE
 
-- GROUP BY �ϴ� �迡 ǰ�� �������� COUNT : ���� ����, SUM : ����, MIN : �ּڰ�
-- �� ���ؼ� ���� �����ٰ�.


-- ���� �Լ��� ����� ����� ��ȸ ����(HAVING)

  SELECT ITEMTYPE      AS ITEMTYPE,
         COUNT(*)      AS ROWCNT,
	     SUM(UNITCOST) AS SUM_COST,
	     MIN(UNITCOST) AS MIN_COST
    FROM TB_ItemMaster
GROUP BY ITEMTYPE
  HAVING COUNT(*)>100 

-- GROUP BY �� ���յ� ����� HAVING ���ſ� �����Լ��� ����� ���.
-- GROUP BY �� ������� ���� �÷��� ����� �� �ִ�.

/*
	UNITCOST : �ܰ�
	ITEMTYPE : ǰ������

	ǰ�񸶽��� ���̺��� UNITCOST�� 10 �̻��� �����͸� ���� �� ��.
	ITEMTYPE ���� UNITCOST�� ���� 100�� �ʰ��ϴ� ����
	ITEMTYPE, UNITCOST�� ��, UNITCOST�� �ִ��� ��Ÿ���ÿ�
�߰� * ���ı����� �ܰ��� �� ������������ ��Ÿ������.
*/
SELECT ITEMTYPE,
	   SUM(UNITCOST) SUMCOST,
	   MAX(UNITCOST) MAXCOST
  FROM TB_ItemMaster
 WHERE UNITCOST >= 10
GROUP BY ITEMTYPE
HAVING SUM(UNITCOST)>100
ORDER BY SUMCOST

/* �����ͺ��̽��� ó�� ����.
 ************** FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY ����.************8
 1. ǰ�񸶽��Ϳ��� UNITCOST�� 10 �̻��� �� ���� (WHERE)
 2. 1���� ����� �����Ϳ��� ITEMTYPE�÷��� ���� ó��. (GROUP BY)
 3. 2�� ������ �����ϸ鼭 UNITCOST�� ���� 100�ʰ��ϴ� �� ����(HAVING)
 4. 3���� ����� �÷� ITEMTYPE�� ǥ���ϰ�
    3���� ����� �÷��� �������� UNITCOST �����Լ� SUM ���� - SUM_UNITCOST
	3���� ����� �÷��� �������� UNITCOST �����Լ� MAX ���� - MAX_UNITCOST
 5. 4���� �Ϸ�� �����͸� ����(ORDER BY) - 4���� �Ϸ�� ������ ���̺��� �÷��� �������� ����
 */
  SELECT ITEMTYPE,
         SUM(UNITCOST) SUM_UNITCOST,
 		 MAX(UNITCOST) MAX_UNITCOST
    FROM TB_ItemMaster
   WHERE UNITCOST >=10
GROUP BY ITEMTYPE, UNITCOST
  HAVING UNITCOST > 100

/*
  ����?
  �Ʒ� SQL�� �� ������ �ȵɱ�?
  STOCKQTY�� ���� ū ���� ã�Ƴ� ����� �Һи���
  �� ���� ����� �����Ƿ� ó������ �ʴ´�.
*/


/*******************************����************************************************
�����Լ��� GROUP BY�� �Բ� ����� ��� ȿ���� ũ��.
���� �Լ��� ��� ������ ������� ���� ��� GROUP BY / DISTINCT�� ū ���̰� ����.
*/

-- [POINT 3]
/***************�ǽ�
TB_STOCKMMREC : ���� ��� ���� �̷�
INOUTFLAG     : ���� ����    I : �԰�

TB_STOCKMMREC  ���̺��� ������ �� INOUTFLAG�� 'I'�̰�
INOUTQTY �� 1000���� ū ������ ����
INOUTDATE �� WHCODE�� Ƚ���� ��Ÿ����
INOUTDATE �������� �������� ��ȸ �ϼ���.

2. ���� Ƚ���� 2�� �̻��� �����͸� ��ȸ�� ������
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


