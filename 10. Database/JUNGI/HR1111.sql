SELECT * FROM employees;
SELECT last_name, 'is a', job_id from employees;
SELECT last_name ||'is a'|| job_id from employees;

SELECT DISTINCT job_id FROM employees;
SELECT * FROM employees WHERE commission_pct is null;
SELECT * FROM employees WHERE commission_pct is not null;

--Q. employees ���̺��� commission_pct�� null�� ������ ����ϼ���
SELECT COUNT(*) FROM employees WHERE commission_pct is null;

--���� �Լ� Number Function
SELECT MOD(10,3) FROM dual;

-- Employee ID�� Ȧ���ΰ͸�
SELECT * 
FROM employees 
WHERE MOD(employee_id,2) =1;

SELECT ROUND(355.95555,0) FROM dual;
SELECT ROUND(355.95555,2) FROM dual;
SELECT ROUND(355.95555,-1) FROM dual;

SELECT TRUNC(45.5555, 1) FROM dual; 

SELECT last_name, TRUNC(salary/12,2) ���� FROM employees;

--WIDTH BUCKET(������/�ּҰ�/�ִ밪/BUCKET ����)
SELECT WIDTH_BUCKET(92,0,100,10) FROM dual;

SELECT * FROM employees;

SELECT last_name, salary
FROM employees
WHERE LOWER(last_name) = 'seo';

--Q, job id ���ڿ� ���� ���ϼ���
SELECT job_id, LENGTH(job_id) FROM employees;

--SUBSTR(���ڿ�,������ġ,����): 3��° ���ں��� 3�� ���
SELECT SUBSTR('Hello World',3,3) FROM dual;
SELECT SUBSTR('Hello World',-3,3) FROM dual;

-- ���� �� �ش� ��ü�� ���ڸ� ä���.
SELECT LPAD('Hello World',20,'#') FROM dual;
SELECT RPAD('Hello World',20,'#') FROM dual;

--TRIM
SELECT last_name, trim('A' FROM last_name) A���� FROM employees;
SELECT LTRIM('aaaHello Worldaaa','a') FROM dual;
SELECT RTRIM('aaaHello Worldaaa','a') FROM dual;
SELECT LTRIM('  Hello World  ') FROM dual;
SELECT RTRIM('  Hello World  ') FROM dual;
SELECT TRIM('  Hello World  ') FROM dual;

--��¥ ���� �Լ�
SELECT SYSDATE FROM dual;

SELECT * FROM employees;
SELECT last_name, TRUNC((SYSDATE-hire_date)/365.0) �ټӱⰣ FROM employees;

SELECT last_name, ADD_MONTHS(hire_date,6) FROM employees;

--�ش� ��¥�� ���� ���� ������ ��ȯ
SELECT LAST_DAY(SYSDATE) FROM dual;

--������ ����
SELECT last_name, hire_date, LAST_DAY(ADD_MONTHS(hire_date,1)) FROM employees;

--�ش� ��¥�� �������� ��õ� ���Ͽ� �ش��ϴ� ��¥�� ��ȯ
SELECT hire_date, next_day(hire_date,'��') FROM employees;

SELECT last_name, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date),0) FROM employees;

SELECT last_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date,6),2) FROM employees;

--�����Լ� Aggregate Functions  : SUM() AVG() MAX() MIN()
--Q jOb_id ���� �����հ� ������� �ְ��� �������� �ο����� ���
SELECT job_id, SUM(salary), AVG(salary), MAX(salary), MIN(salary)
FROM employees
GROUP BY job_id
HAVING AVG(salary) >= 5000
ORDER BY AVG(salary) DESC;

--���� JOIN
--�����ȣ�� 110�� ����� �μ����� �˰� ���� ���
SELECT * FROM employees WHERE employee_id=110;
SELECT * FROM departments WHERE department_id=100;

SELECT employee_id, department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id AND employee_id = 110;

SELECT employee_id, department_name
FROM employees
JOIN departments on employees.department_id = departments.department_id
WHERE employee_id=110;

--Q ����� 120���� ����� ���, �̸�, ����(job_id) ������ (job_title)�� ���
--join -on , where�� �����ϴ� �� ���� ��� ���
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
SELECT E.employee_id ���, E.last_name �̸�, M.last_name, M.manager_id �μ���
FROM employees E, employees M
WHERE E.employee_id = M.manager_id;

--outer join: ���� ���ǿ� �������� ���ϴ��� �ش� ���� ��Ÿ���� ���� �� ���
SELECT E.employee_id ���, E.last_name �̸�, M.last_name ���, M.manager_id �μ���
FROM employees E, employees M
WHERE E.employee_id = M.manager_id(+);

--Union(������) INTERSECT(������) MNINUS(������) UNIONALL(��ġ�°ͱ��� ����)
SELECT first_name �̸�, salary �޿�
FROM employees
WHERE salary <5000;

SELECT first_name �̸�, salary �޿� FROM employees
WHERE salary < 5000
UNION
SELECT first_name �̸�, salary �޿� FROM employees
WHERE hire_date < '02/01/01';

SELECT first_name �̸�, salary �޿� FROM employees
WHERE salary > 20000
UNION
SELECT first_name �̸�, salary �޿� FROM employees
WHERE hire_date < '02/01/01';

--all ���� ������ �� ������ ���� ������ �˻� ������� ��� ��ġ�ϸ� ��
--Q, 100�� �μ��� ������ ����� �޿����� �� ���� �޿��� �޴� ����� ���
SELECT last_name, salary
FROM employees
WHERE salary > ALL(SELECT salary FROM employees WHERE department_id = 100);

--any ���� ������ �� ������ ���� ������ �˻� ����� �ϳ� �̻� ��ġ�ϸ� ��
SELECT last_name, salary FROM employees WHERE salary > any;

--����
--2005�� ���Ŀ� �Ի��� ������ ���, �̸�, �Ի���, �μ���(department_name),������ (job_title)�� ���
SELECT E.employee_id, E.last_name, hire_date, department_name, job_title
FROM employees E, departments D, jobs J
WHERE hire_date > '05/01/01'
ORDER BY hire_date;

--WHERE E.department_id = D>department_id AND E.job_id = J.job_id AND hire_date >='05/01/01'

--job_titlem, department_name���� ��� ������ ���� �� ����ϼ���
SELECT job_title ������, department_name �μ���, ROUND(AVG(salary)) "��� ����"
FROM employees E, departments D, jobs J
WHERE E.department_id = D.department_id AND E.job_id = J.job_id
GROUP BY job_title, department_name;

--Q ��պ��� ���� �޿��� �޴� ���� �˻� �� ����ϼ���
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--Q. last_name�� king�� ������ last_name, hire_date, department_id�� ����ϼ���
SELECT last_name, hire_date, department_id
FROM employees
WHERE LOWER(last_name) = 'king';

--���, �̸�, ����, ����ϼ���. ��, ������ �Ʒ� ���ؿ� ����
--salary > 20000 then '��ǥ�̻�'
--salary > 15000 then '��ǥ�̻�'
--salary > 10000 then '��ǥ�̻�'
--salary > 5000 then '��ǥ�̻�'
--salary > 3000 then '��ǥ�̻�'
--������ '���'

SELECT employee_id ���, last_name �̸�,
CASE WHEN salary > 20000 THEN '��ǥ�̻�'
     WHEN salary > 15000 THEN '�̻�'
     WHEN salary > 10000 THEN '����'
     WHEN salary > 5000 THEN '����'
     WHEN salary > 3000 THEN '�븮'
     ELSE '���'
     END AS ����
FROM employees;

-- employees ���̺�� ���� last_name, salary, �ְ����� ����ϼ���.
-- ��, �ְ� ������ first_value - over�� ���Ѵ�.
SELECT last_name, salary, FIRST_VALUE(salary) OVER(ORDER BY salary DESC) �ְ���
FROM employees;

--�μ��� ���� ������ ����ϼ���
SELECT last_name, salary, job_id, RANK() OVER(PARTITION BY job_id ORDER BY salary DESC) "���� ����"
FROM employees
ORDER BY job_id;

--employees ���̺��� employee_id�� salary �� �����ؼ� employee_salary ���̺��� �����ϼ���
CREATE TABLE employees_salary
AS SELECT employee_id, salary
FROM employees;
SELECT * FROM employees_salary;
--employee_salary ���̺� first_name, last_name �÷��� �߰��ϼ���
ALTER TABLE employees_salary ADD(first_name VARCHAR2(40) , last_name VARCHAR2(40));
--last_name�� name���� �����ϼ���
ALTER TABLE employees_salary RENAME COLUMN last_name To name;

--employees_salary ���̺��� emnployee_id�� �⺻Ű�� �����ϰ� CONSTRAINT_NAME�� ES_PK�� ���� �� ����ϼ���
ALTER TABLE employees_salary ADD CONSTRAINT ES_PK PRIMARY KEY(employee_id);
--employee_salary ���̺��� employee_id�� CONSTRANINT_NAME�� ���� �� ���� ���θ� Ȯ���ϼ���
ALTER TABLE employees_salary DROP CONSTRAINT ES_PK;