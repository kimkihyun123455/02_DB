-- SQL(Structured Query Langauge, 구조적 질의 언어)
-- 데이터베이스와 상호작용을 하기 위해 사용하는 표준 언어
-- 데이터의 조회, 삽입, 수정, 삭제 등을 진행할 수 있다

/*
 * SELECT (DML 또는 DQL) : 조회   
 * 
 * -데이터를 조회(SELECT)하면 조건에 맞는 행들이 조회됨.
 * 이 때, 조회된 행들의 집합을 "RESULT SET"라고 한다
 * 
 * -RESULT SET은 0개 이상의 행을 포함할 수 있다.
 * 조건에 맞는 행이 없는 경우 == 0
 * 
 */

-- [작성법]
-- SELECT 컬럼명 FROM 테이블명;
-- 테이블의 특정 컬럼을 조회하겠다.

SELECT * FROM EMPLOYEE;
-- "*" : ALL, 전부
-- EMPLOYEE 테이블의 모든 컬럼을 조회하겠다

-- EMPLOYEE 테이블에서 사번, 직원이름, 휴대전화번호 컬럼만 조회

SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE;

------------------------------------------------

-- <칼럼 값 산술연산>
-- 칼럼값 : 데이블 내 한칸(==한 셀)에 작성된 값(DATA)

-- EMPLOYEE 테이블에서 모든 사원의 사번, 이름, 급여 ,연봉 조회

SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 FROM EMPLOYEE;

SELECT EMP_NAME + 10 FROM EMPLOYEE;
-- 산술 연산은 숫자 타입(NUMBER TYPE)만 가능하다

SELECT '같음' FROM DUAL WHERE 1 = '1';
-- 문자열은 ''로 나타내고 동일은 = 로 표기한다
-- NUMBER 타입인 1과 문자열인 '1'이 같다라고 인식중
-- DUAL : ORACLE에서 사용하는 더브 테이블
-- 더미테이블이란? 실제 데이터를 저장하는게 아닌, 임시 계산이나 테스트 목적으로 사용하는 가상 테이블

-- 문자열 타입이어도 저장된 값이 숫자면 자동으로 형변환이 되어 연산이 가능하다
SELECT EMP_ID + 10 FROM EMPLOYEE;

-----------------------------------------------------------

-- 날짜(DATE) 타입 조회

-- EMPLOYEE 테이블에서 이름, 입사일, 오늘 날짜 조회
SELECT EMP_NAME, HIRE_DATE, SYSDATE FROM EMPLOYEE;
-- 2025-03-07 15:47:26.000
-- SYSDATE : 시스템상의 현재 시간을 나타내는 상수

SELECT SYSDATE FROM DUAL;
-- DUAL(DUmmy tAbLe)

-- 날짜 + 산술연산 (+, -)
SELECT SYSDATE -1, SYSDATE, SYSDATE +1
FROM DUAL;
-- 날짜에 +/- 연산 시 일 단위로 계산이 진행된다

---------------------------------------------

-- 컬럼 별칭 지정
/*
 * 컬럼명 AS 별칭 : 별칭 띄어쓰기 X, 특수문자 X, 문자만 가능
 * 
 * 컬렴명 AS "별칭" : 별칭 띄어쓰기 가능, 특수문자 가능, 문자도 가능
 * 
 * AS 생략 가능
 * 
 */



SELECT SYSDATE -1 "하루 전", SYSDATE AS 현재시간, SYSDATE + 1 AS "내일"
FROM DUAL;

-----------------------------------------------------------

-- JAVA 리터럴 : 값 자체를 의미
-- DB 리터럴 : 임의로 지정한 값을 기존 테이블에 존재하는 값처럼 사용하는 것.
--> (필수) DB의 리터럴 표기법 '' 
SELECT EMP_NAME, SALARY, '원 입니다' FROM EMPLOYEE;

-----------------------------------------------------------

-- DISTINCT : 조회 시 컬럼에 포함된 중복 값을 한번만 표기
-- 주의사항 1) DISTINCT 구문은 SELECT 마다 딱 한번씩만 작성이 가능하다
-- 주의사항 2) DISTINCT 구문은 SELECT 제일 앞에 작성되어야 한다.

SELECT DISTINCT DEPT_CODE, JOB_CODE FROM EMPLOYEE;

-----------------------------------------------------------

-- 해석순서
-- 3. SELECT 절 : SELECT 컬럼명
-- 1. FROM 절 : FROM 테이블명
-- 2. WHERE 절(조건절) : WHERE 컬럼명 연산자 값;
-- 4. ORDER BY 절 : ORDER BY 컬럼명 | 별칭 | 컬럼 순서 [ASC | DESC | NULLS FIRST | LAST]

-- EMPLOYEE 테이블에서 급여가 300만원 초과인 사원의
-- 사번, 이름, 급여, 부서코드를 조회해라.

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE 
FROM EMPLOYEE 
WHERE SALARY  > 3000000;

-- 비교 연산자 : < , > , <= , >= , = , != , <>(같지않다)
-- 대입 연산자 : :=

-- EMPLOYEE 테이블에서 
-- 부서코드가 'D9'인 사원의
-- 사번, 이름, 부서코드, 직급코드를 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE DEPT_CODE = 'D9';

-----------------------------------------------------------------------------

-- 논리 연산자 (AND, OR)

-- EMPLOYEE 테이블에서
-- 급여가 300만원 미만 또는 500만원 이상이 ㄴ사원의
--사번, 이름, 급여, 전화번호 조회

SELECT EMP_ID, EMP_NAME, SALARY, PHONE 
FROM EMPLOYEE 
WHERE SALARY < 3000000 OR SALARY >= 5000000;

-- 논리 연산자 (AND, OR)

-- EMPLOYEE 테이블에서
-- 급여가 300만원 이상 500만원 미만인 사원의
--사번, 이름, 급여, 전화번호 조회

SELECT EMP_ID, EMP_NAME, SALARY, PHONE
FROM EMPLOYEE
WHERE SALARY>=3000000 AND SALARY<5000000;

-- BETWEEN A AND B : A 이상 B 이하

SELECT EMP_ID, EMP_NAME, SALARY, PHONE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3000000 AND 6000000;

-- NOT 연산자 사용 가능 BETWEEN 앞에 작성

SELECT EMP_ID, EMP_NAME, SALARY, PHONE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3000000 AND 6000000;

-- 날짜에 BETWEEN 이용해보기

SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '1990-01-01' AND '1999-12-31';

------------------------------------------------------