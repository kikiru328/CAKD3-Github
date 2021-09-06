빅데이터 기반 AI 응용 솔루션 개발자 전문과정

교과목명 : 데이터베이스 구축 및 활용

- 평가일 : 21.08.13
- 성명 : 김광훈
- 점수 : 83

--Q1. HR EMPLOYEES 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력하세요.
--A. O
SELECT first_name 이름 , salary 연봉 , salary*1.1 연봉인상
FROM employees;

    
--Q2.  2005년 상반기에 입사한 사람들만 출력	
--A.  O      
SELECT hire_date 입사일, first_name 이름
FROM employees
WHERE hire_date between '05/01/01' AND '05/06/30';   

--Q3. 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
--A. O
SELECT first_name 이름, job_id 업무
FROM employees
WHERE job_id in ('SA_MAN','IT_PROG','ST_MAN');
   
--Q4. manager_id 가 101에서 103인 사람만 출력
--A.  O 	
SELECT first_name 이름, manager_id 
FROM employees
WHERE manager_id in (101,102,103);

--Q5. EMPLOYEES 테이블에서 LAST_NAME, HIRE_DATE 및 입사일의 6개월 후 첫 번째 월요일을 출력하세요.
--A. O
SELECT last_name 이름, hire_date 입사일, NEXT_DAY(ADD_MONTHS(hire_date,6),'월') 입사일6개월후 
FROM employees;

--Q6. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 현재일까지의 W_MONTH(근속월수)를 정수로 계산해서 출력하세요.(근속월수 기준 내림차순)
--A. O
SELECT employee_id 직원, last_name 성, salary 연봉, hire_date 입사일, 
TRUNC(months_between(SYSDATE,hire_date))근속월수
FROM employees
ORDER BY hire_date;

--Q7. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 W_YEAR(근속년수)를 계산해서 출력하세요.(근속년수 기준 내림차순)
--A. O
SELECT employee_id 직원, last_name 성, salary 연봉, hire_date 입사일, 
TRUNC(((SYSDATE-hire_date)+1)/365)근속연수
FROM employees
ORDER BY hire_date;

--Q8. EMPLOYEE_ID가 홀수인 직원의 EMPLPYEE_ID와 LAST_NAME을 출력하세요.
--A. O 
SELECT employee_id 직원, last_name 이름
FROM employees
WHERE MOD(employee_id,2)=1;

--Q9. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME 및 M_SALARY(월급)을 출력하세요. 단 월급은 소수점 둘째자리까지만 표현하세요.
--A D
SELECT employee_id 직원, last_name 성, TRUNC(salary/12,2) 월급
FROM employees;

--Q10. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 근속년수를 계산해서 아래사항을 추가한 후에 출력하세요.
--2001년 1월 1일 창업하여 현재까지 20년간 운영되온 회사는 직원의  근속년수에 따라 30 등급으로 나누어  등급에 따라 1000원의 BONUS를 지급.
--내림차순 정렬.    
--A. O
SELECT employee_id 직원, last_name 성, salary 연봉, hire_date 입사일,
WIDTH_BUCKET(hire_date,SYSDATE,'01/01/01',30)*1000 BONUS
FROM employees
ORDER BY hire_date desc;

--Q11. EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.
--A. O
SELECT COUNT(*) 
FROM employees 
WHERE commission_pct is null;

--Q12. EMPLOYEES 테이블에서 deparment_id 가 없는 직원을 추출하여  POSITION을 '신입'으로 출력하세요.
--A. X
SELECT *
FROM employees 
WHERE department_id is null;

--Q13. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력(join~on, where 로 조인하는 두 가지 방법 모두)
--A. O
SELECT employees.employee_id, employees.last_name, employees.job_id, jobs.job_title
FROM employees, jobs
WHERE employees.job_id = jobs.job_id AND employees.employee_id = 120;

SELECT employee_id, last_name, employees.job_id, job_title
FROM employees
JOIN jobs ON employees.job_id = jobs.job_id
WHERE employee_id=120;



--Q14.  employees 테이블에서 이름에 FIRST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--예) Steven King
--A. O
SELECT CONCAT(CONCAT(first_name,' '),last_name) NAME
FROM employees;

--Q15. HR 테이블들을 분석해서 전체 현황을 설명할 수 있는 요약 테이블을 작성하세요. (예 : 부서별 평균 SALARY 순위)
--A.O
SELECT job_id, SUM(salary), AVG(salary), MAX(salary), MIN(salary)
FROM employees
GROUP BY job_id
ORDER BY AVG(salary) DESC;

--Q16. HR EMPLOYEES 테이블에서 escape 옵션을 사용하여 아래와 같이 출력되는 SQL문을 작성하세요.
--job_id 칼럼에서  _을 와일드카드가 아닌 문자로 취급하여 '_A'를 포함하는  모든 행을 출력
--A. O
SELECT job_id
FROM employees
WHERE job_id like '%A_%' escape('A');

--Q17. HR EMPLOYEES 테이블에서 SALARY, LAST_NAME 순으로 올림차순 정렬하여 출력하세요.
--A. O
SELECT *
FROM employees
ORDER BY salary,last_name;

--Q18. Seo라는 사람의 부서명을 출력하세요.
--A.O
SELECT E.last_name,D.department_name
FROM employees E, departments D
WHERE E.last_name = 'Seo' AND
E.department_id = D.department_id;

--Q19. LMEMBERS 데이터에서 고객별 구매금액의 합계를 구한 CUSPUR 테이블을 생성한 후 CUST 테이블과 
--고객번호를 기준으로 결합하여 출력하세요.


X

--Q20.purprd 테이블의 2년간 구매금액을 연간 단위로 분리하여 구매14, 구매15 컬럼을 포함하는 AMT_YEAR 테이블을 
--생성한 후 14년과 15년의 구매금액 차이를 표시하는 증감 컬럼을 추가하여 출력하세요.
--단, 고객번호, 제휴사별로 구매금액 및 증감이 구분되어야 함.
X
