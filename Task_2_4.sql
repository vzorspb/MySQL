# Фамилия сотрудника с самой высокой зарплатой
SELECT name FROM employees.employees ORDER BY pay_level desc LIMIT 1 ;
# Фамилии сотрудников в алфавитном порядке
SELECT name FROM employees.employees ORDER BY name;
# Рассчитайте редний стаж для каждого уровня сотрудников
SELECT level as 'Уровень', ROUND(SUM(datediff(now(),working_start)/365-0.5)/count(level)) as 'Средний_стаж' FROM employees.employees group by level;
# Выведите фамилию сотрудника и название отдела в котором он работает
SELECT employees.name, departments.name FROM employees.employees JOIN departments on employees.department_id=departments.id;
# Выведите название отдела и фамилию сотрудника с самой высокой зарплатой в данном отделе и саму зарплату также.
SELECT departments.name, employees.name, employees.pay_level FROM employees.employees JOIN departments on employees.department_id=departments.id WHERE (`department_id`, `pay_level`) in 
(SELECT department_id, max(pay_level) FROM employees.employees GROUP BY department_id);
# Выведите название отдела, сотрудники которого получат наибольшую премию по итогам года. Как рассчитать премию можно узнать в последнем задании предыдущей домашней работы
SET @id=
(SELECT department_id FROM employees as t1 JOIN
(SELECT employee_id, 
 (CASE  WHEN `Q1`='A' THEN '0.2'  WHEN `Q1`='B' THEN '0.1' WHEN `Q1`='C' THEN '0' WHEN `Q1`='D' THEN '-0.1' WHEN `Q1`='E' THEN '-0.2' END) +
 (CASE  WHEN `Q2`='A' THEN '0.2'  WHEN `Q2`='B' THEN '0.1' WHEN `Q2`='C' THEN '0' WHEN `Q2`='D' THEN '-0.1' WHEN `Q2`='E' THEN '-0.2' END) +
 (CASE  WHEN `Q3`='A' THEN '0.2'  WHEN `Q3`='B' THEN '0.1' WHEN `Q3`='C' THEN '0' WHEN `Q3`='D' THEN '-0.1' WHEN `Q3`='E' THEN '-0.2' END) +
 (CASE  WHEN `Q4`='A' THEN '0.2'  WHEN `Q4`='B' THEN '0.1' WHEN `Q4`='C' THEN '0' WHEN `Q4`='D' THEN '-0.1' WHEN `Q4`='E' THEN '-0.2' END) as bonus
FROM employees.work_results
) as t2 ON t1.id=t2.employee_id ORDER BY t2.bonus DESC LIMIT 1);
SELECT name FROM departments WHERE id = @id;
# Проиндексируйте зарплаты сотрудников с учетом коэффициента премии. 
# Для сотрудников с коэффициентом премии больше 1.2 – размер индексации составит 20%, 
# для сотрудников с коэффициентом премии от 1 до 1.2 размер индексации составит 10%. 
# Для всех остальных сотрудников индексация не предусмотрена.
ALTER TABLE `employees`.`employees` 
CHANGE COLUMN `bonus` `bonus` DECIMAL(5,2) NULL DEFAULT NULL ;
ALTER TABLE `employees`.`employees` 
ADD COLUMN `salary_index` DECIMAL(5,2) NULL AFTER `pay_level`;
CREATE TEMPORARY TABLE `tmp_table` AS
(SELECT t1.id, t2.bonus FROM employees as t1 JOIN
(SELECT employee_id, 
 (CASE  WHEN `Q1`='A' THEN '0.2'  WHEN `Q1`='B' THEN '0.1' WHEN `Q1`='C' THEN '0' WHEN `Q1`='D' THEN '-0.1' WHEN `Q1`='E' THEN '-0.2' END) +
 (CASE  WHEN `Q2`='A' THEN '0.2'  WHEN `Q2`='B' THEN '0.1' WHEN `Q2`='C' THEN '0' WHEN `Q2`='D' THEN '-0.1' WHEN `Q2`='E' THEN '-0.2' END) +
 (CASE  WHEN `Q3`='A' THEN '0.2'  WHEN `Q3`='B' THEN '0.1' WHEN `Q3`='C' THEN '0' WHEN `Q3`='D' THEN '-0.1' WHEN `Q3`='E' THEN '-0.2' END) +
 (CASE  WHEN `Q4`='A' THEN '0.2'  WHEN `Q4`='B' THEN '0.1' WHEN `Q4`='C' THEN '0' WHEN `Q4`='D' THEN '-0.1' WHEN `Q4`='E' THEN '-0.2' END) as bonus
FROM employees.work_results
) as t2 ON t1.id=t2.employee_id);
UPDATE employees a, tmp_table b SET a.bonus=b.bonus+1 WHERE a.id=b.id;
DROP TABLE `tmp_table`;
UPDATE employees.employees SET salary_index = pay_level * 1.2 WHERE bonus >= 1.2;
UPDATE employees.employees SET salary_index = pay_level * 1.1 WHERE bonus >= 1.1 and bonus < 1.2;
UPDATE employees.employees SET salary_index = pay_level WHERE bonus < 1.1;
