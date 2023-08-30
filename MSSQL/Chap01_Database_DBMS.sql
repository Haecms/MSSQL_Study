/***********************************************************************************************
1���� . Database ������ ����.

1. DBMS ?? (Database Management System)
 . �� �뷮�� ������ ������ ü�������� �����ϴ� �ý���(�߿� �츮�� MSSQL Server�� ������)
 . �� ����ϴ°�? �ΰ��� ����� ���� ��� ������ ����(SNS, ������ ������ �̷�, �����ڷ� ��)
                  �� ������ȭ �Ͽ� �����ϰ� ü�������� ������ �� �ֵ��� �����ִ� �ý���
 . SQULSERVER,	ORACLE,	 MYSQL,	 MARIADB

							  ���
  �����Ͷ�? (�߻����� ���� ----------> ������)
    . �ǻ�Ȱ�� �߻��� ��� ������ ���ȭ�Ͽ� ���� �Ǵ� ������ ���·� ����ص� �ڷ�.

2.  SSMS�� �����ΰ�?
 .  MSSQL DBMS�� �����ͺ��̽��� ���� �����ϰ� ������ �� �ֵ��� �����ִ� TOOL(����)

3.  SQL�̶� �����ΰ�? (Structured Query Language) ������ ���Ǿ�.(������ ���̽��� �˾Ƶ�� ���)
   . DBMS�� ����ڰ� ���ϴ� �����͸� ������ �� �ֵ��� �ְ��޴� ���.
   . ���� ��� DBMS�� ǥ�� SQL������ �������� �� DBMS���� Ư���� ����� �����Ѵ�.
     �׷��� ���̴� ũ�� �ʴ�.

4. �̹� ������ ���̽� �������� �н��� ��ǥ
  . SSMS ���� �̿��Ͽ� SQL �� �ۼ��ϰ� DBMS�� ������ �� �ִ� ���� ����� �н��Ѵ�.

5. TABLE �̶�?
  . ��� ���� ��ġ������ �̿��� ���� ����(����)�� ���� �����͸� �׷�ȭ �Ͽ� �����ϴ� DBMS�� �ּ� ����.

6. ��( = �÷� / �ʵ�)
  . �� �̸��� ���̺� ������ �ߺ����� �ʰ� �����ؾ��Ѵ�. (���̵�, ȸ���̸�, �ּ�, ��ǰ�̸�, ���� ��)
  . ���̺��� ������ ��ǥ�� �� �ִ� �Ӽ��� ����.

7. ��( = �ο� / ���ڵ�)
  . ���̺��� ��ϵ� �����͸� ��� ��.
  . �÷� �Ӽ��� �´� �ǹ��ִ� �����͵��� �� �ִ� �ϳ��� ����.

8. �⺻Ű
  . �� ���� ��ǥ�ϴ� ������ �÷��� ���Ѵ�.
  . �⺻Ű �÷��� ���� �����ʹ� �ߺ��Ǿ� ��� �� �� ����. (ex. �ߺ� ID)
  . Null�� ����� �� ����.

9. ����Ʈ���� ������Ʈ
  . �ǻ�Ȱ�� ���Ǵ� �������� �ý���ȭ �Ͽ� ����� �������̽��� �����ϴ� ����.

10. �����ͺ��̽� �𵨸�
  . �����м� �ܰ� ���Ŀ� �����ؾ��ϴ� �����ͺ��̽� ���� ���� �ܰ�.
  . ������Ʈ�� �����ϸ鼭 �����м� �� �ý��� ���� �ܰ迡�� ȿ�������� �����͸� ������ �� �ֵ���
    ������ ü��ȭ�ϰ� �׷�ȭ�Ͽ� �׷�ȭ�� �����͸� ���̺��� �����ϸ鼭 
	���̺� ���� ������踦 �����ϴ� ��.
   * ���ǿ� �����ϴ� �������� ��� ȿ�������� �����ͺ��̽� ���̺��� ��� ������ ���ΰ��� �����ϴ�
     ����


************************************************************************************************/
SELECT * FROM T_FruitSaleExcel

-- �ּ� ó���ϴ� ��� 1
/*

���� �� �ּ�ó��

*/

/** �ǽ�

�ŷ�ó ���� ���̺��� ����̴ϴ�.
���̺��� �̸��� TB_CusT��� �ϰ�
������ �����ʹ� (�÷�)�� 
  . �ŷ�ó �ڵ�(CUST_CODE) - PK VARCHAR(30)
  , �ŷ�ó ��(CUST_NAME)     VARCHAR(40) NOT NULL
  . �ŷ�ó �ּ�(CUST_ADDRESS) VARCHAR(100)
  . ��ǥ�� (CEO)			 VARCHAR(30)
�����ϼ���.

**/

-- �����ͺ��̽� ���̾�׷� ���� ���� �ο�
ALTER AUTHORIZATION ON DATABASE:: MyFirstDataBase TO [sa]