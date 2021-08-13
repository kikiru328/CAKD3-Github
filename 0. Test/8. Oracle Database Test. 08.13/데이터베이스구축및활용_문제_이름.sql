������ ��� AI ���� �ַ�� ������ ��������

������� : �����ͺ��̽� ���� �� Ȱ��

- ���� : 21.08.13
- ���� : �豤��
- ���� : 83

--Q1. HR EMPLOYEES ���̺��� �̸�, ����, 10% �λ�� ������ ����ϼ���.
--A. O
SELECT first_name �̸� , salary ���� , salary*1.1 �����λ�
FROM employees;

    
--Q2.  2005�� ��ݱ⿡ �Ի��� ����鸸 ���	
--A.  O      
SELECT hire_date �Ի���, first_name �̸�
FROM employees
WHERE hire_date between '05/01/01' AND '05/06/30';   

--Q3. ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
--A. O
SELECT first_name �̸�, job_id ����
FROM employees
WHERE job_id in ('SA_MAN','IT_PROG','ST_MAN');
   
--Q4. manager_id �� 101���� 103�� ����� ���
--A.  O 	
SELECT first_name �̸�, manager_id 
FROM employees
WHERE manager_id in (101,102,103);

--Q5. EMPLOYEES ���̺��� LAST_NAME, HIRE_DATE �� �Ի����� 6���� �� ù ��° �������� ����ϼ���.
--A. O
SELECT last_name �̸�, hire_date �Ի���, NEXT_DAY(ADD_MONTHS(hire_date,6),'��') �Ի���6������ 
FROM employees;

--Q6. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �����ϱ����� W_MONTH(�ټӿ���)�� ������ ����ؼ� ����ϼ���.(�ټӿ��� ���� ��������)
--A. O
SELECT employee_id ����, last_name ��, salary ����, hire_date �Ի���, 
TRUNC(months_between(SYSDATE,hire_date))�ټӿ���
FROM employees
ORDER BY hire_date;

--Q7. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� W_YEAR(�ټӳ��)�� ����ؼ� ����ϼ���.(�ټӳ�� ���� ��������)
--A. O
SELECT employee_id ����, last_name ��, salary ����, hire_date �Ի���, 
TRUNC(((SYSDATE-hire_date)+1)/365)�ټӿ���
FROM employees
ORDER BY hire_date;

--Q8. EMPLOYEE_ID�� Ȧ���� ������ EMPLPYEE_ID�� LAST_NAME�� ����ϼ���.
--A. O 
SELECT employee_id ����, last_name �̸�
FROM employees
WHERE MOD(employee_id,2)=1;

--Q9. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME �� M_SALARY(����)�� ����ϼ���. �� ������ �Ҽ��� ��°�ڸ������� ǥ���ϼ���.
--A D
SELECT employee_id ����, last_name ��, TRUNC(salary/12,2) ����
FROM employees;

--Q10. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �ټӳ���� ����ؼ� �Ʒ������� �߰��� �Ŀ� ����ϼ���.
--2001�� 1�� 1�� â���Ͽ� ������� 20�Ⱓ ��ǿ� ȸ��� ������  �ټӳ���� ���� 30 ������� ������  ��޿� ���� 1000���� BONUS�� ����.
--�������� ����.    
--A. O
SELECT employee_id ����, last_name ��, salary ����, hire_date �Ի���,
WIDTH_BUCKET(hire_date,SYSDATE,'01/01/01',30)*1000 BONUS
FROM employees
ORDER BY hire_date desc;

--Q11. EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.
--A. O
SELECT COUNT(*) 
FROM employees 
WHERE commission_pct is null;

--Q12. EMPLOYEES ���̺��� deparment_id �� ���� ������ �����Ͽ�  POSITION�� '����'���� ����ϼ���.
--A. X
SELECT *
FROM employees 
WHERE department_id is null;

--Q13. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���(join~on, where �� �����ϴ� �� ���� ��� ���)
--A. O
SELECT employees.employee_id, employees.last_name, employees.job_id, jobs.job_title
FROM employees, jobs
WHERE employees.job_id = jobs.job_id AND employees.employee_id = 120;

SELECT employee_id, last_name, employees.job_id, job_title
FROM employees
JOIN jobs ON employees.job_id = jobs.job_id
WHERE employee_id=120;



--Q14.  employees ���̺��� �̸��� FIRST_NAME�� LAST_NAME�� �ٿ��� 'NAME' �÷������� ����ϼ���.
--��) Steven King
--A. O
SELECT CONCAT(CONCAT(first_name,' '),last_name) NAME
FROM employees;

--Q15. HR ���̺���� �м��ؼ� ��ü ��Ȳ�� ������ �� �ִ� ��� ���̺��� �ۼ��ϼ���. (�� : �μ��� ��� SALARY ����)
--A.O
SELECT job_id, SUM(salary), AVG(salary), MAX(salary), MIN(salary)
FROM employees
GROUP BY job_id
ORDER BY AVG(salary) DESC;

--Q16. HR EMPLOYEES ���̺��� escape �ɼ��� ����Ͽ� �Ʒ��� ���� ��µǴ� SQL���� �ۼ��ϼ���.
--job_id Į������  _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����Ͽ� '_A'�� �����ϴ�  ��� ���� ���
--A. O
SELECT job_id
FROM employees
WHERE job_id like '%A_%' escape('A');

--Q17. HR EMPLOYEES ���̺��� SALARY, LAST_NAME ������ �ø����� �����Ͽ� ����ϼ���.
--A. O
SELECT *
FROM employees
ORDER BY salary,last_name;

--Q18. Seo��� ����� �μ����� ����ϼ���.
--A.O
SELECT E.last_name,D.department_name
FROM employees E, departments D
WHERE E.last_name = 'Seo' AND
E.department_id = D.department_id;

--Q19. LMEMBERS �����Ϳ��� ���� ���űݾ��� �հ踦 ���� CUSPUR ���̺��� ������ �� CUST ���̺�� 
--����ȣ�� �������� �����Ͽ� ����ϼ���.


X

--Q20.purprd ���̺��� 2�Ⱓ ���űݾ��� ���� ������ �и��Ͽ� ����14, ����15 �÷��� �����ϴ� AMT_YEAR ���̺��� 
--������ �� 14��� 15���� ���űݾ� ���̸� ǥ���ϴ� ���� �÷��� �߰��Ͽ� ����ϼ���.
--��, ����ȣ, ���޻纰�� ���űݾ� �� ������ ���еǾ�� ��.
X
