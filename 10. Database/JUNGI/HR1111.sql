SELECT * FROM employees;
SELECT last_name, 'is a', job_id from employees;
SELECT last_name ||'is a'|| job_id from employees;

SELECT DISTINCT job_id FROM employees;
SELECT * FROM employees WHERE commission_pct is null;
SELECT * FROM employees WHERE commission_pct is not null;

--Q. employees 테이블에서 commission_pct의 null값 갯수를 출력하세요
SELECT COUNT(*) FROM employees WHERE commission_pct is null;

--숫자 함수 Number Function
SELECT MOD(10,3) FROM dual;

-- Employee ID가 홀수인것만
SELECT * 
FROM employees 
WHERE MOD(employee_id,2) =1;

SELECT ROUND(355.95555,0) FROM dual;
SELECT ROUND(355.95555,2) FROM dual;
SELECT ROUND(355.95555,-1) FROM dual;

SELECT TRUNC(45.5555, 1) FROM dual; 

SELECT last_name, TRUNC(salary/12,2) 월급 FROM employees;

--WIDTH BUCKET(지정값/최소값/최대값/BUCKET 갯수)
SELECT WIDTH_BUCKET(92,0,100,10) FROM dual;

SELECT * FROM employees;

SELECT last_name, salary
FROM employees
WHERE LOWER(last_name) = 'seo';

--Q, job id 문자열 길이 구하세요
SELECT job_id, LENGTH(job_id) FROM employees;

--SUBSTR(문자열,시작위치,갯수): 3번째 문자부터 3개 출력
SELECT SUBSTR('Hello World',3,3) FROM dual;
SELECT SUBSTR('Hello World',-3,3) FROM dual;

-- 정렬 후 해당 위체에 문자를 채운다.
SELECT LPAD('Hello World',20,'#') FROM dual;
SELECT RPAD('Hello World',20,'#') FROM dual;

--TRIM
SELECT last_name, trim('A' FROM last_name) A삭제 FROM employees;
SELECT LTRIM('aaaHello Worldaaa','a') FROM dual;
SELECT RTRIM('aaaHello Worldaaa','a') FROM dual;
SELECT LTRIM('  Hello World  ') FROM dual;
SELECT RTRIM('  Hello World  ') FROM dual;
SELECT TRIM('  Hello World  ') FROM dual;

--날짜 관련 함수
SELECT SYSDATE FROM dual;

SELECT * FROM employees;
SELECT last_name, TRUNC((SYSDATE-hire_date)/365.0) 근속기간 FROM employees;

SELECT last_name, ADD_MONTHS(hire_date,6) FROM employees;

--해당 날짜가 속한 월의 말일을 반환
SELECT LAST_DAY(SYSDATE) FROM dual;

--다음달 말일
SELECT last_name, hire_date, LAST_DAY(ADD_MONTHS(hire_date,1)) FROM employees;

--해당 날짜를 기준으로 명시된 요일에 해당하는 날짜를 반환
SELECT hire_date, next_day(hire_date,'월') FROM employees;

SELECT last_name, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date),0) FROM employees;

SELECT last_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date,6),2) FROM employees;

--집합함수 Aggregate Functions  : SUM() AVG() MAX() MIN()
--Q jOb_id 별로 연봉합계 연봉평균 최고연봉 최저연봉 인원수를 출력
SELECT job_id, SUM(salary), AVG(salary), MAX(salary), MIN(salary)
FROM employees
GROUP BY job_id
HAVING AVG(salary) >= 5000
ORDER BY AVG(salary) DESC;

--조인 JOIN
--사원번호가 110인 사원의 부서명을 알고 싶은 경우
SELECT * FROM employees WHERE employee_id=110;
SELECT * FROM departments WHERE department_id=100;

SELECT employee_id, department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id AND employee_id = 110;

SELECT employee_id, department_name
FROM employees
JOIN departments on employees.department_id = departments.department_id
WHERE employee_id=110;

--Q 사번이 120번인 사람의 사번, 이름, 업무(job_id) 업무명 (job_title)을 출력
--join -on , where로 조인하는 두 가지 방법 모두
SELECT employees.employee_id, employees.last_name, employees.job_id, jobs.job_title
FROM employees, jobs
WHERE employees.job_id = jobs.job_id AND employees.employee_id = 120;

SELECT employee_id, last_name, employees.job_id, job_title
FROM employees
JOIN jobs ON employees.job_id = jobs.job_id
WHERE employee_id=120;

SELECT employee_id, job_title, department_name
FROM employees, jobs, departments
WHERE employees.job_id = jobs.job_id
AND employees.department_id = departments.department_id;

--SELF JOIN
SELECT E.employee_id 사번, E.last_name 이름, M.last_name, M.manager_id 부서장
FROM employees E, employees M
WHERE E.employee_id = M.manager_id;

--outer join: 조인 조건에 만족하지 못하더라도 해당 행을 나타내고 싶을 때 사용
SELECT E.employee_id 사번, E.last_name 이름, M.last_name 사원, M.manager_id 부서장
FROM employees E, employees M
WHERE E.employee_id = M.manager_id(+);

--Union(합집합) INTERSECT(교집합) MNINUS(차집합) UNIONALL(겹치는것까지 포함)
SELECT first_name 이름, salary 급여
FROM employees
WHERE salary <5000;

SELECT first_name 이름, salary 급여 FROM employees
WHERE salary < 5000
UNION
SELECT first_name 이름, salary 급여 FROM employees
WHERE hire_date < '02/01/01';

SELECT first_name 이름, salary 급여 FROM employees
WHERE salary > 20000
UNION
SELECT first_name 이름, salary 급여 FROM employees
WHERE hire_date < '02/01/01';

--all 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과값과 모두 일치하면 참
--Q, 100번 부서의 구성원 모두의 급여보다 더 많은 급여를 받는 사원을 출력
SELECT last_name, salary
FROM employees
WHERE salary > ALL(SELECT salary FROM employees WHERE department_id = 100);

--any 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 하나 이상 일치하면 참
SELECT last_name, salary FROM employees WHERE salary > any;

--과제
--2005년 이후에 입사한 직원의 사번, 이름, 입사일, 부서명(department_name),업무명 (job_title)을 출력
SELECT E.employee_id, E.last_name, hire_date, department_name, job_title
FROM employees E, departments D, jobs J
WHERE hire_date > '05/01/01'
ORDER BY hire_date;

--WHERE E.department_id = D>department_id AND E.job_id = J.job_id AND hire_date >='05/01/01'

--job_titlem, department_name별로 평균 연봉을 구한 후 출력하세요
SELECT job_title 업무명, department_name 부서명, ROUND(AVG(salary)) "평균 연봉"
FROM employees E, departments D, jobs J
WHERE E.department_id = D.department_id AND E.job_id = J.job_id
GROUP BY job_title, department_name;

--Q 평균보다 많은 급여를 받는 직원 검색 후 출력하세요
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--Q. last_name이 king인 직원의 last_name, hire_date, department_id를 출력하세요
SELECT last_name, hire_date, department_id
FROM employees
WHERE LOWER(last_name) = 'king';

--사번, 이름, 집급, 출력하세요. 단, 직급은 아래 기준에 의함
--salary > 20000 then '대표이사'
--salary > 15000 then '대표이사'
--salary > 10000 then '대표이사'
--salary > 5000 then '대표이사'
--salary > 3000 then '대표이사'
--나머지 '사원'

SELECT employee_id 사번, last_name 이름,
CASE WHEN salary > 20000 THEN '대표이사'
     WHEN salary > 15000 THEN '이사'
     WHEN salary > 10000 THEN '부장'
     WHEN salary > 5000 THEN '과장'
     WHEN salary > 3000 THEN '대리'
     ELSE '사원'
     END AS 직급
FROM employees;

-- employees 테이블로 부터 last_name, salary, 최고연봉을 출력하세요.
-- 단, 최고 연봉은 first_value - over로 구한다.
SELECT last_name, salary, FIRST_VALUE(salary) OVER(ORDER BY salary DESC) 최고연봉
FROM employees;

--부서별 연봉 순위를 출력하세요
SELECT last_name, salary, job_id, RANK() OVER(PARTITION BY job_id ORDER BY salary DESC) "연봉 순위"
FROM employees
ORDER BY job_id;

--employees 테이블에서 employee_id와 salary 만 추출해서 employee_salary 테이블을 생성하세요
CREATE TABLE employees_salary
AS SELECT employee_id, salary
FROM employees;
SELECT * FROM employees_salary;
--employee_salary 테이블에 first_name, last_name 컬럼을 추가하세요
ALTER TABLE employees_salary ADD(first_name VARCHAR2(40) , last_name VARCHAR2(40));
--last_name을 name으로 변경하세요
ALTER TABLE employees_salary RENAME COLUMN last_name To name;

--employees_salary 테이블의 emnployee_id에 기본키를 적용하고 CONSTRAINT_NAME을 ES_PK로 지정 후 출력하세요
ALTER TABLE employees_salary ADD CONSTRAINT ES_PK PRIMARY KEY(employee_id);
--employee_salary 테이블의 employee_id에 CONSTRANINT_NAME을 삭제 후 삭제 여부를 확인하세요
ALTER TABLE employees_salary DROP CONSTRAINT ES_PK;