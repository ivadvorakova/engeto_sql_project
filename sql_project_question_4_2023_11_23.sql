-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

-- SQL_final
SELECT 
	tpf.payroll_year,  
	tpf2.payroll_year AS prev_year,
	ROUND((AVG(tpf.avg_pay)-AVG(tpf2.avg_pay)),2) AS payroll_change_CZK,
	ROUND((AVG(tpf.avg_price)-AVG(tpf2.avg_price)),2) AS prices_change_CZK,
	ROUND((AVG(tpf.avg_pay)*100/AVG(tpf2.avg_pay)),2)-100 AS percentage_payroll_change,
	ROUND((AVG(tpf.avg_price)*100/AVG(tpf2.avg_price)),2)-100 AS percentage_price_change,
	ROUND(((AVG(tpf.avg_price)*100/AVG(tpf2.avg_price))-100)-((AVG(tpf.avg_pay)*100/AVG(tpf2.avg_pay))-100),2) AS diff,
	CASE
		WHEN ROUND(((AVG(tpf.avg_price)*100/AVG(tpf2.avg_price))-100)-((AVG(tpf.avg_pay)*100/AVG(tpf2.avg_pay))-100),2)>=10 THEN 1
		ELSE 0
	END AS high_increase_flag	
	FROM t_iva_dvorakova_project_sql_primary_final tpf
JOIN t_iva_dvorakova_project_sql_primary_final tpf2
	ON tpf.payroll_year=tpf2.payroll_year + 1
	AND tpf.branch_name=tpf2.branch_name
GROUP BY payroll_year;

-- pro jednotlivé obory
SELECT 
	tpf.branch_name,  
	tpf.payroll_year,  
	tpf2.payroll_year AS prev_year,
	ROUND((AVG(tpf.avg_pay)-AVG(tpf2.avg_pay)),2) AS payroll_change_CZK,
	ROUND((AVG(tpf.avg_price)-AVG(tpf2.avg_price)),2) AS prices_change_CZK,
	ROUND((AVG(tpf.avg_pay)*100/AVG(tpf2.avg_pay)),2)-100 AS percentage_payroll_change,
	ROUND((AVG(tpf.avg_price)*100/AVG(tpf2.avg_price)),2)-100 AS percentage_price_change,
	ROUND(((AVG(tpf.avg_price)*100/AVG(tpf2.avg_price))-100)-((AVG(tpf.avg_pay)*100/AVG(tpf2.avg_pay))-100),2) AS diff,
	CASE
		WHEN ROUND(((AVG(tpf.avg_price)*100/AVG(tpf2.avg_price))-100)-((AVG(tpf.avg_pay)*100/AVG(tpf2.avg_pay))-100),2)>=10 THEN 1
		ELSE 0
	END AS high_increase_flag	
	FROM t_iva_dvorakova_project_sql_primary_final tpf
JOIN t_iva_dvorakova_project_sql_primary_final tpf2
	ON tpf.payroll_year=tpf2.payroll_year + 1
	AND tpf.branch_name=tpf2.branch_name
GROUP BY tpf.branch_name, tpf.payroll_year; 


-- SQL_evolution
-- step_1_average_pay
SELECT 
	tpf.branch_name, 
	tpf.payroll_year, 
	tpf2.payroll_year AS prev_year,
	(tpf.avg_pay *100/tpf2.avg_pay)-100 AS perc_change
FROM t_iva_dvorakova_project_sql_primary_final tpf
JOIN t_iva_dvorakova_project_sql_primary_final tpf2
	ON tpf.payroll_year=tpf2.payroll_year +1
	AND tpf.branch_name=tpf2.branch_name
WHERE tpf.payroll_year=2007
GROUP BY tpf.branch_name, tpf.payroll_year;


-- step_2 average pay difference + %  
SELECT DISTINCT 
	tpf.branch_name, 
	tpf.payroll_year,
	tpf.avg_pay AS avg_pay_1, 
	tpf2.payroll_year AS prev_year,
	tpf2.avg_pay AS avg_pay_2,
	ROUND((tpf.avg_pay-tpf2.avg_pay),2) AS difference,
	ROUND((tpf.avg_pay *100/tpf2.avg_pay),2)- 100 AS perc_change
FROM t_iva_dvorakova_project_SQL_primary_final tpf 
JOIN t_iva_dvorakova_project_SQL_primary_final tpf2
	ON tpf.branch_name=tpf2.branch_name
	AND tpf.payroll_year=tpf2.payroll_year+1
GROUP BY tpf.branch_name, tpf.payroll_year, tpf.avg_pay, tpf2.avg_pay
ORDER BY tpf.branch_name, tpf.payroll_year; 


-- step_3 
SELECT 
	tpf.payroll_year,  
	ROUND(AVG(tpf.avg_pay),2) AS avg_pay_in_year
FROM t_iva_dvorakova_project_sql_primary_final tpf
GROUP BY payroll_year;

SELECT 
	tpf.payroll_year,  
	ROUND(AVG(tpf.avg_price),2) AS avg_price_in_year
FROM t_iva_dvorakova_project_sql_primary_final tpf
GROUP BY payroll_year;


-- JOIN se stejnou tabulkou na zjištění meziročního růstu 
SELECT 
	tpf.payroll_year,
	ROUND((AVG(tpf.avg_pay)-AVG(tpf2.avg_pay)),2) AS difference_payroll,
	ROUND((AVG(tpf.avg_pay)*100/AVG(tpf2.avg_pay)),2)-100 AS perc_change_payroll
FROM t_iva_dvorakova_project_sql_primary_final tpf
JOIN t_iva_dvorakova_project_sql_primary_final tpf2
	ON tpf.payroll_year=tpf2.payroll_year+1
	AND tpf.branch_name=tpf2.branch_name
GROUP BY tpf.payroll_year;

SELECT 
	tpf.payroll_year,  
	ROUND((AVG(tpf.avg_price)-AVG(tpf2.avg_price)),2) AS difference_prices,
	ROUND((AVG(tpf.avg_price)*100/AVG(tpf2.avg_price)),2)-100 AS perc_change_prices
FROM t_iva_dvorakova_project_sql_primary_final tpf
JOIN t_iva_dvorakova_project_sql_primary_final tpf2
	ON tpf.payroll_year=tpf2.payroll_year+1
	AND tpf.branch_name=tpf2.branch_name
GROUP BY tpf.payroll_year;  


-- step_4
SELECT 
	tpf.payroll_year, 
	tpf2.payroll_year as prev_year,
	ROUND((AVG(tpf.avg_pay)-AVG(tpf2.avg_pay)),2) AS difference_payroll,
	ROUND((AVG(tpf.avg_price)-AVG(tpf2.avg_price)),2) AS difference_prices,
	ROUND((AVG(tpf.avg_pay)*100/AVG(tpf2.avg_pay)),2)-100 AS perc_change_payroll, 
	ROUND((AVG(tpf.avg_price)*100/AVG(tpf2.avg_price)),2)-100 AS perc_change_prices
FROM t_iva_dvorakova_project_sql_primary_final tpf
JOIN t_iva_dvorakova_project_sql_primary_final tpf2
	ON tpf.payroll_year=tpf2.payroll_year+1
	AND tpf.branch_name=tpf2.branch_name
GROUP BY payroll_year;


-- step_5
SELECT 
	tpf.payroll_year,  
	tpf2.payroll_year AS prev_year,
	ROUND((AVG(tpf.avg_pay)-AVG(tpf2.avg_pay)),2) AS payroll_change_CZK,
	ROUND((AVG(tpf.avg_price)-AVG(tpf2.avg_price)),2) AS prices_change_CZK,
	ROUND((AVG(tpf.avg_pay)*100/AVG(tpf2.avg_pay)),2)-100 AS percentage_payroll_change,
	ROUND((AVG(tpf.avg_price)*100/AVG(tpf2.avg_price)),2)-100 AS percentage_price_change,
	ROUND(((AVG(tpf.avg_price)*100/AVG(tpf2.avg_price))-100)-((AVG(tpf.avg_pay)*100/AVG(tpf2.avg_pay))-100),2) AS diff,
	CASE
		WHEN ROUND(((AVG(tpf.avg_price)*100/AVG(tpf2.avg_price))-100)-((AVG(tpf.avg_pay)*100/AVG(tpf2.avg_pay))-100),2)>=10 THEN 1
		ELSE 0
	END AS high_increase_flag	
	FROM t_iva_dvorakova_project_sql_primary_final tpf
JOIN t_iva_dvorakova_project_sql_primary_final tpf2
	ON tpf.payroll_year=tpf2.payroll_year+1
	AND tpf.branch_name=tpf2.branch_name
GROUP BY payroll_year;

SELECT 
	tpf.branch_name,  
	tpf.payroll_year,  
	tpf2.payroll_year AS prev_year,
	ROUND((AVG(tpf.avg_pay)-AVG(tpf2.avg_pay)),2) AS payroll_change_CZK,
	ROUND((AVG(tpf.avg_price)-AVG(tpf2.avg_price)),2) AS prices_change_CZK,
	ROUND((AVG(tpf.avg_pay)*100/AVG(tpf2.avg_pay)),2)-100 AS percentage_payroll_change,
	ROUND((AVG(tpf.avg_price)*100/AVG(tpf2.avg_price)),2)-100 AS percentage_price_change,
	ROUND(((AVG(tpf.avg_price)*100/AVG(tpf2.avg_price))-100)-((AVG(tpf.avg_pay)*100/ AVG(tpf2.avg_pay))-100),2) AS diff,
	CASE
		WHEN ROUND(((AVG(tpf.avg_price)*100/AVG(tpf2.avg_price))-100)-((AVG(tpf.avg_pay)*100/AVG(tpf2.avg_pay))-100),2)>=10 THEN 1
		WHEN ROUND(((AVG(tpf.avg_price)*100/AVG(tpf2.avg_price))-100)-((AVG(tpf.avg_pay)*100/AVG(tpf2.avg_pay))-100),2)<=-10 THEN 1
		ELSE 0
	END AS high_increase_flag	
	FROM t_iva_dvorakova_project_sql_primary_final tpf
JOIN t_iva_dvorakova_project_sql_primary_final tpf2
	ON tpf.payroll_year=tpf2.payroll_year+1
	AND tpf.branch_name=tpf2.branch_name
GROUP BY tpf.branch_name, tpf.payroll_year; 

