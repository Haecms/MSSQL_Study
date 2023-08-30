
-- VIEW(���κ� ���� �� �ݾ�)
CREATE VIEW V_TOTALPRICE AS
(
  SELECT A.CUST_ID				   AS CUST_ID,
	     B.NAME					   AS NAME,
	     SUM(A.AMOUNT*C.UNIT_COST) AS PURCHASE
    FROM TB_SALELIST A JOIN TB_CUST B
					     ON A.CUST_ID = B.CUST_ID
					   JOIN T_FRUIT C
					     ON A.FRUIT = C.FRUIT
   WHERE A.DATE BETWEEN '2022-12-01' AND '2022-12-06'
GROUP BY A.CUST_ID, B.NAME
)

-- �ݾ��� �ְ�� ���� ���� ��� ���� ����
DECLARE @LI_MAX INT

SELECT @LI_MAX = MAX(PURCHASE)
  FROM V_TOTALPRICE

-- ���� �ݾ��� ���� ū ���� �����ߴ� ��� �̷�
SELECT A.CUST_ID              AS CUST_ID,
	   AA.NAME                AS NAME,
	   A.DATE                 AS DATE,
	   A.FRUIT                AS FRUIT,
	   A.AMOUNT               AS AMOUNT,
	   A.AMOUNT * C.UNIT_COST AS EACH_PRICE
  FROM TB_SALELIST A JOIN V_TOTALPRICE AA
				   	   ON A.CUST_ID = AA.CUST_ID
				   	 JOIN T_FRUIT C
				   	   ON A.FRUIT = C.FRUIT
 WHERE AA.PURCHASE = @LI_MAX
   AND A.DATE BETWEEN '2022-12-01' AND '2022-12-06'


