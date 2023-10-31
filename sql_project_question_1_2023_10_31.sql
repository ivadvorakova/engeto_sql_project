-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

-- SQL_final 

SELECT *
FROM t_iva_dvorakova_project_sql_primary_final t;

SELECT DISTINCT 
	t1.branch_name, 
	t1.payroll_year, 
	t2.payroll_year AS prev_year, 
	(t1.avg_pay - t2.avg_pay) AS diffence, 
	CASE 
		WHEN (t1.avg_pay - t2.avg_pay) > 0 THEN 'increase'
		ELSE 'decrease'
	END AS increase_decrease_flag	
FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.branch_name = t2.branch_name 
	AND t1.payroll_year = t2.payroll_year +1
ORDER BY t1.branch_name, payroll_year;

