
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

SELECT t4.*, t5.level_hi,t5.level_med,t5.level_low FROM
(
SELECT 
	t1.department_id,
	t2.name as Название_отдела, 
	t3.name as Руководитель,
	COUNT(t2.name) as Количество_сотрудников,
	ROUND(AVG(datediff(now(),t1.working_start))/365+0.5) as Средний_стаж,
	SUM(t1.pay_level) as зп_до_индексации,
    SUM(t1.salary_index) as зп_после_индексации
FROM employees.employees as t1 JOIN employees.departments t2 ON t1.department_id=t2.id JOIN employees t3 on t3.id=t2.chief_id
GROUP BY t1.department_id
) as t4 JOIN 
(
SELECT department_id, SUM(level_hi) as level_hi, SUM(level_med) as level_med, SUM(level_low) as level_low FROM
(
 SELECT department_id, COUNT(level) as level_hi, 0 as level_med, 0 as level_low FROM employees WHERE level='hi' GROUP BY department_id
 UNION
 SELECT department_id, 0 as level_hi, COUNT(level) as level_med, 0 as level_low FROM employees WHERE level='med' GROUP BY department_id
UNION
 SELECT department_id, 0 as level_hi, 0 as level_med, COUNT(level) as level_low FROM employees WHERE level='low' GROUP BY department_id
) as t6 GROUP BY department_id
)as t5 ON t5.department_id = t4.department_id;
 