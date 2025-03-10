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

-- LIKE : 비교하려는 값이 특정한 패턴을 만족시키면 조회하는 연산자
-- [작성법]
-- WHERE 컬럼명 LIKE '패턴이 적용된 값';

-- LIKE 의 패턴을 나타내는 문자
-- '%' : 포함
-- '_' : 글자수

-- '%' 예시
-- 'A%' : A로 시작하는 문자열
-- '%A' : A로 끝나는 문자열
-- '%A%' : A를 포함하는 문자열

-- '_' 예시
-- 'A_' : A로 시작하는 두글자 문자열
-- '____A' (언더바 4개) : A로 끝나는 5글자 문자열
-- '__A__' : 3번째 문자가 A인 5글자 문자열
-- '_____' : 5글자 문자열

-- EMPLOYEE 테이블에서 성이 '전'인 사원

SELECT EMP_ID, EMP_NAME 
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- EMPLOYEE 테이블에서 전화번호가 010로 시작하지 않는 사원

SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- EMPLOYEE 테이블에서 EMAIL의 _앞의 글자가 세글자인 사원만
-- 이름, 이메일 조회

SELECT * FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL 
FROM EMPLOYEE 
WHERE EMAIL LIKE '___^_%' ESCAPE '^';

-- ESCAPE 문자
-- ESCAPE 문자 뒤에 작성된 _는 일반문자로 탈출한다는 뜻
-- #, ^

-- 연습문제

-- EMPLOYEE 테이블에서
-- 이메일 '_' 앞이 4글자 이면서
-- 부서코드가 'D9' 또는 'D6'이고 --> AND가 OR보다 우선순위 높다
-- 입사일이 1990-01-01 ~ 2000-12-31 DLRH
-- 급여가 270만원 이상인 사원의
-- 사번, 이름, 이메일, 부서코드, 입사일, 급여조회

SELECT EMP_ID, EMP_NAME, EMAIL, DEPT_CODE, HIRE_DATE, SALARY
FROM EMPLOYEE
WHERE EMAIL LIKE '____^_%' ESCAPE '^' 
AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6')
AND HIRE_DATE BETWEEN '1990-01-01' AND '2000-12-31'
AND SALARY >= 2700000;

-- 연산자 우선순위

/*
 * 1. 산술 연산자 ( + - * /)
 * 2. 연결 연산자 ( || )
 * 3. 비교 연산자 ( < <= > >= = != <>)
 * 4. IS NULL / IS NOT NULL, LIKE, IN / NOT IN
 * 5. BETWEEN AND / NOT BETWEEN AND
 * 6. NOT (논리연사자)
 * 7. AND
 * 8. OR
 */

/*
 * IN 연산자
 * 
 * 비교하려는 값과 목록에 작성된 값 중
 * 일치하는 것이 있으면 조회하는 연산자
 * 
 * [작성법]
 * WHERE 컬럼명 IN(값1, 값2, 값3...)
 * 
 * WHERE 컬럼명 = '갑1' OR 컬럼명 = '값2' OR 컬럼명 = '값3'... 과 동일한 의미
 * 
 */

-- EMPLOYEE 테이블에서
-- 부서코드가 D1, D6, D9인 사원의
-- 사번, 이름, 부서코드 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IN('D1','D6','D9');

-- NOT IN
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN('D1','D6','D9') -- DEPT_CODE가 NULL인 사원은 미포함되어 나왔다
OR DEPT_CODE IS NULL; 

-----------------------------------------------------------

/*
 * NULL 처리 연산자
 * 
 * JAVA 에서 NULL : 참조하는 객체가 없음
 * DB 에서 NULL : 컬럼에 값이 없음
 * 
 */ 

-- EMPLOYEE 테이블에서 보너스가 있는 사원의 이름, 보너스 조회

SELECT EMP_NAME, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-----------------------------------------------------------

/*
 * ORDER BY 절
 * 
 * SELECT 문의 조회 결과(RESULT SET)을 정렬할 때 사용하는 구문
 * 
 * SELECT 문 해석 시 가장 마지막에 해석된다
 */

-- EMPLOYEE 테이블
-- 급여 오름 차순으로
-- 사번, 이름, 급여 조회

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY; -- ASC라는 오름차순 함수가 기본값으로 적용된다. 내림차순은 DESC

-- EMPLOYEE 테이블에서
-- 급여가 200만원 이상인 사원의
-- 사번, 이름, 급여 조회
-- 단, 급여 내림 차순으로 조회

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 2000000
ORDER BY 1 DESC; -- 컬럼의 순서로 컬럼명 대체 가능

-- 입사일 순서대로 이름, 입사일 조회

SELECT EMP_NAME 이름, HIRE_DATE 입사일
FROM EMPLOYEE
ORDER BY 입사일;

-- 부서코드 오름차순 정렬 후 급여 내림차순 정렬

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
ORDER BY DEPT_CODE, SALARY DESC;
