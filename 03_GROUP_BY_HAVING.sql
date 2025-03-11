/* SELECT 문 해석 순서
 * 
 * 5) SELECT 컬렴명 AS 별칭, 계산식, 함수식
 * 1) FROM 테이블명
 * 2) WHERE 컬럼명 | 함수식 비교연산자 비교값
 * 3) GROUP BY 그룹을 묶을 컬럼명
 * 4) HAVING 그룹함수식 비교연산자 비교값
 * 6) ORDER BY 컬럼명 | 별칭 | 컬럼순번 정렬방식(ASC/DESC) [NULLS FIRST | LAST]
 * 
 */

------------------------------------------------------------------

-- * GROUP BY 절 : 같은 값들이 여러개 기록된 컬럼을 가지고 같은 값들을 하나의 그룹으로 묶음

-- GROUP BY 컬럼명 | 함수식, ...

-- 여러개의 값을 묶어서 하나로 처리할 목적으로 사용함
-- 그룹으로 묶은 값에 대해서 SELECT 절에서 그룹함수를 사용할 수 있다

-- 그룹함수는 단 한개의 결과값만 산출하기 때문에 그룹이 여러개일 경우 오류 발생
-- 여러개의 결과값을 산출하기 위해 그룹함수가 적용된 그룹의 기준을 ORDER BY 절에 기술하여 사용

-- EMPLOYEE 테이블에서 부서코드, 부서별 급여 합 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- DEPT_CODE 컬럼을 그룹으로 묶어, 그 그룹의 급여 합계(SUN(SALARY))를 구함

SELECT * FROM EMPLOYEE;
-- EMPLOYEE 테이블에서 직급코드가 같은 사람의 직급코드, 급여 평균, 인원 수를 직급코드 오름차순으로 조회
SELECT JOB_CODE, ROUND(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- EMPLOYEE 테이블에서 성별과 각 성별 별 인원수, 급여 합을 인원수 오름차순으로 조회
SELECT DECODE(SUBSTR(EMP_NO, INSTR(EMP_NO, '-')+1,1), 1, '남성', 2, '여성') 성별, 
COUNT(*) 인원수, SUM(SALARY) 급여합
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, INSTR(EMP_NO, '-')+1,1), 1, '남성', 2, '여성')
-- GROUP BY에서는 SELECT에서 별칭이 정해지기 전에 먼저 실행되므로 별칭이 사용 불가하다
ORDER BY 인원수; -- SELECT에서 해석이 완료되었기 때문에 별칭 사용 가능

-----------------------------------------------------------------

-- * WHERE 절 GROUP BY 절 혼합하여 사용하기

--> WHERE 절은 각 컬럼값에 대한 조건
--> HAVING 그룹에 대한 조건

-- EMPLOYEE 테이블에서 부서코드가 D5, D6인 부서의
-- 부서코드 ,평균급여, 인원수 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5', 'D6')
GROUP BY DEPT_CODE;

-- EMPLOYEE 테이블에서 2000년도 이후 입사자들의
-- 직급코드, 직급별 급여 합을 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE)>=2000
-- HIRE_DATE>= TO_DATE('2020-01-01')
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-------------------------------------------------------------

-- * 여러 컬럼을 묶어서 그룹으로 지정하는 것이 가능하다 --> 그룹 내 그룹

-- ** GROUP BY 사용 시 주의 사항 **
--> SELECT 문에 GROUP BY 절을 사용하는 경우
-- SELECT절에 명시한 조회하려는 컬럼 중
-- 그룹함수가 적용되지 않은 컬럼을
-- 모두 GROUP BY 절에 작성되어 있어야 한다

-- EMPLOYEE 테이블에서 부서별로 같은 직급인 사원의 인원수 조회
-- 부서코드 오름차순, 직급코드 내림차순으로 정렬
-- 부서코드, 직급코드, 인원수 조회
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE -- 먼저 작성된 컬럼으로 그룹을 나누고 나중에 작성된 컬럼으로 다시 그룹을 분류
ORDER BY DEPT_CODE, JOB_CODE DESC;

------------------------------------------------------------

-- HAVING 절 : 그룹함수로 구해 올 그룹에 대한 조건을 설정할 때 사용
-- HAVING 컬럼명 | 함수식 비교연산자 비교값

-- EMPLOYEE 테이블에서 부서별 평균 급여가 300만원 이상인 부서의
-- 부서코드, 평균급여 조회
-- 부서코드 오름차순
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY)>=3000000;

-- EMPLOYEE 테이블에서 직급별 인원수가 5명 이하인
-- 직급코드, 인원수 조회
-- 직급코드 오름차순 정렬
SELECT JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING COUNT(*)<=5 -- HAVING 절에는 SELECT절에서 사용한 그룹함수가 반드시 작성된다
ORDER BY JOB_CODE;

------------------------------------------------------------

-- 집계 함수(ROLLUP, CUBE)
-- 그룹 별 산출 결과 값의 집계를 계산하는 함수
-- (그룹별로 중간 집계 결과를 추가)
-- GROUP BY 절에서만 사용가능한 함수

-- ROLLUP : GROUP BY 절에서 가장 먼저 작성된 컬럼의 중간 집계를 처리하는 함수
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE) 
ORDER BY 1;

-- CUBE : GROUP BY 절에 작성된 모든 컬럼의 중간 깁계를 처리하는 함수
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE) 
ORDER BY 1;

/* 집합 연산자
 * 
 * - 여러 SELECT의 결과를 하나의 결과로 만드는 연산자
 * 
 * - UNION (합집합) : 두 SELECT 결과를 하나로 합침. 단 중복은 한번만 가능
 * 
 * - INTERSECT (교집합) : 두 SELECT 결과 중 중복되는 부분만 조회
 * 
 * - UNION ALL : UNION + INTERSECT 합집합에서 중복되는 부분 제거 X
 * 
 * - MINUS (차집합) : A에서 A,B 교집합 부분을 저게하고 조회
 * 
 */

-- EMPLOYEE 테이블에서
-- (1번째 SELECT) 부서코드가 'D5'인 사원의 사번, 이름, 부서코드 ,급요조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
-- (2번째 SELECT) 급여가 300만원 초과인 사원의 사번, 이름, 부서코드, 급여조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- (주의사항!) 집합연산자를 사용하기 위한 SELECT문들은 컬럼의 타입, 개수가 모두 동일해야 한다

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, 2020
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 서로 다른 테이블이지만 컬럼의 타입, 개수만 일치하면
-- 집합 연산자 사용 가능하다

SELECT EMP_ID, EMP_NAME FROM EMPLOYEE
UNION
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT; 


