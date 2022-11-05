
SELECT id, name as 'Ф.И.О.', ROUND(datediff(now(),working_start)/365-0.5) as 'Стаж'  FROM employees.employees;
SELECT id, name as 'Ф.И.О.', ROUND(datediff(now(),working_start)/365-0.5) as 'Стаж'  FROM employees.employees limit 3;
SELECT employees.id FROM employees JOIN departments on department_id=departments.id where departments.name='водители';
SELECT id FROM employees.work_results WHERE Q1='E' or Q2='E' or Q3='E' or Q4='E';
SELECT MAX(pay_level) FROM employees.employees;
SELECT name FROM employees.departments ORDER BY size DESC LIMIT 1;
SELECT * FROM employees.employees ORDER BY datediff(now(),working_start) DESC;
SELECT level,AVG(pay_level) FROM employees.employees GROUP BY level;
SELECT level,AVG(pay_level) FROM employees.employees GROUP BY level;
ALTER TABLE employees.employees ADD bonus INT(2) AFTER pay_level;

SELECT *, 
 (CASE  WHEN `Q1`='A' THEN '0.2'  WHEN `Q1`='B' THEN '0.1' WHEN `Q1`='C' THEN '0' WHEN `Q1`='D' THEN '-0.1' WHEN `Q1`='E' THEN '-0.2' END) +
 (CASE  WHEN `Q2`='A' THEN '0.2'  WHEN `Q2`='B' THEN '0.1' WHEN `Q2`='C' THEN '0' WHEN `Q2`='D' THEN '-0.1' WHEN `Q2`='E' THEN '-0.2' END) +
 (CASE  WHEN `Q3`='A' THEN '0.2'  WHEN `Q3`='B' THEN '0.1' WHEN `Q3`='C' THEN '0' WHEN `Q3`='D' THEN '-0.1' WHEN `Q3`='E' THEN '-0.2' END) +
 (CASE  WHEN `Q4`='A' THEN '0.2'  WHEN `Q4`='B' THEN '0.1' WHEN `Q4`='C' THEN '0' WHEN `Q4`='D' THEN '-0.1' WHEN `Q4`='E' THEN '-0.2' END) as bonus
FROM employees.work_results;