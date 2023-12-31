/***********************************************************************************************
1일차 . Database 개념의 이해.

1. DBMS ?? (Database Management System)
 . 대 용량의 데이터 집합을 체계적으로 관리하는 시스템(중에 우리는 MSSQL Server을 선택함)
 . 왜 사용하는가? 인간이 만들어 내는 모든 종류의 정보(SNS, 물건을 구입한 이력, 보안자료 등)
                  를 데이터화 하여 저장하고 체계적으로 관리할 수 있도록 도와주는 시스템
 . SQULSERVER,	ORACLE,	 MYSQL,	 MARIADB

							  기록
  데이터란? (추상적인 정보 ----------> 데이터)
    . 실생활에 발생한 모든 정보를 기록화하여 문서 또는 파일의 형태로 기록해둔 자료.

2.  SSMS란 무엇인가?
 .  MSSQL DBMS의 데이터베이스를 보다 유용하게 관리할 수 있도록 도와주는 TOOL(도구)

3.  SQL이란 무엇인가? (Structured Query Language) 구조적 질의어.(데이터 베이스가 알아듣는 언어)
   . DBMS와 사용자가 원하는 데이터를 관리할 수 있도록 주고받는 언어.
   . 거의 모든 DBMS가 표준 SQL문법을 따르지만 각 DBMS만의 특별한 용법이 존재한다.
     그러나 차이는 크지 않다.

4. 이번 데이터 베이스 수업에서 학습할 목표
  . SSMS 툴을 이용하여 SQL 언어를 작성하고 DBMS가 수행할 수 있는 관리 방법을 학습한다.

5. TABLE 이란?
  . 행과 열의 위치정보를 이용해 같은 정보(목적)를 가진 데이터를 그룹화 하여 저장하는 DBMS의 최소 단위.

6. 열( = 컬럼 / 필드)
  . 열 이름은 테이블 내에서 중복되지 않고 고유해야한다. (아이디, 회원이름, 주소, 제품이름, 가격 등)
  . 테이블의 내용을 대표할 수 있는 속성의 집합.

7. 행( = 로우 / 레코드)
  . 테이블에 등록될 데이터를 담는 곳.
  . 컬럼 속성에 맞는 의미있는 데이터들이 모여 있는 하나의 집합.

8. 기본키
  . 각 행을 대표하는 유일한 컬럼을 말한다.
  . 기본키 컬럼에 들어가는 데이터는 중복되어 등록 될 수 없다. (ex. 중복 ID)
  . Null을 등록할 수 없다.

9. 소프트웨어 프로젝트
  . 실생활에 사용되는 정보들을 시스템화 하여 사용자 인터페이스를 제공하는 과정.

10. 데이터베이스 모델링
  . 업무분석 단계 이후에 수행해야하는 데이터베이스 구성 고민 단계.
  . 프로젝트를 착수하면서 업무분석 및 시스템 설계 단계에서 효율적으로 데이터를 관리할 수 있도록
    업무를 체계화하고 그룹화하여 그룹화된 데이터를 테이블로 구성하면서 
	테이블 간의 상관관계를 설정하는 일.
   * 현실에 존재하는 정보들을 어떻게 효율적으로 데이터베이스 테이블에 담아 관리할 것인가를 고민하는
     과정


************************************************************************************************/
SELECT * FROM T_FruitSaleExcel

-- 주석 처리하는 방법 1
/*

다중 행 주석처리

*/

/** 실습

거래처 관리 테이블을 만들겁니다.
테이블의 이름은 TB_CusT라고 하고
관리할 데이터는 (컬럼)을 
  . 거래처 코드(CUST_CODE) - PK VARCHAR(30)
  , 거래처 명(CUST_NAME)     VARCHAR(40) NOT NULL
  . 거래처 주소(CUST_ADDRESS) VARCHAR(100)
  . 대표자 (CEO)			 VARCHAR(30)
생성하세요.

**/

-- 데이터베이스 다이어그램 생성 권한 부여
ALTER AUTHORIZATION ON DATABASE:: MyFirstDataBase TO [sa]