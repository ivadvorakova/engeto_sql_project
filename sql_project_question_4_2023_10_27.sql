-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

SELECT *
FROM t_iva_dvorakova_project_sql_primary_final;

-- průměrná mzda v jednotlivých letech 
SELECT 
	t1.branch_name, 
	t1.payroll_year, 
	t2.payroll_year AS prev_year,
	(t1.avg_pay *100 / t2.avg_pay) - 100 AS perc_change
FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year +1
	AND t1.branch_name = t2.branch_name
WHERE t1.payroll_year = 2007
GROUP BY t1.branch_name ,
	t1.payroll_year;



-- jak rostou mzdy po letech 

SELECT DISTINCT 
	t1.branch_name, 
	t1.payroll_year,
	t1.avg_pay AS avg_pay_1, 
	t2.payroll_year AS prev_year,
	t2.avg_pay AS avg_pay_2,
	round ((t1.avg_pay - t2.avg_pay), 2) AS difference,
	round ((t1.avg_pay *100 / t2.avg_pay),2) - 100 AS perc_change
FROM t_iva_dvorakova_project_SQL_primary_final t1 
JOIN t_iva_dvorakova_project_SQL_primary_final t2
	ON t1.branch_name = t2.branch_name
	AND t1.payroll_year = t2.payroll_year +1
GROUP BY t1.branch_name, 
	t1.payroll_year,
	t1.avg_pay, 
	t2.avg_pay
ORDER BY t1.branch_name, t1.payroll_year; 

SELECT DISTINCT 
	t1.branch_name, 
	t1.payroll_year,
	t2.payroll_year AS prev_year,
	(t1.avg_pay - t2.avg_pay) AS difference
FROM t_iva_dvorakova_project_SQL_primary_final t1 
JOIN t_iva_dvorakova_project_SQL_primary_final t2
	ON t1.branch_name = t2.branch_name
	AND t1.payroll_year = t2.payroll_year +1
ORDER BY branch_name, payroll_year; 
	


SELECT DISTINCT
	t1.price_year, 
	(t1.avg_price * 100 / t2.avg_price) - 100 AS percentage_change
FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2 
	ON t1.name = t2.name 
	AND t1.price_year = t2.price_year +1
ORDER BY price_year;



-- jen seznam průměrných roční mezd / cen potravin za všechny dostupné hodnoty
SELECT 
	t1.payroll_year,  
	round (avg(t1.avg_pay), 2) AS avg_pay_in_year
FROM t_iva_dvorakova_project_sql_primary_final t1
GROUP BY payroll_year;

SELECT 
	t1.payroll_year,  
	round (avg(t1.avg_price), 2) AS avg_price_in_year
FROM t_iva_dvorakova_project_sql_primary_final t1
GROUP BY payroll_year;

-- join se stejnou tabulkou na zjištění meziročního růstu 

SELECT 
	t1.payroll_year,  
	round ((t1.avg_pay - t2.avg_pay), 2) AS difference_payroll,
	round ((t1.avg_pay *100 / t2.avg_pay),2) - 100 AS perc_change_payroll
FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year + 1
	AND t1.branch_name = t2.branch_name
GROUP BY payroll_year;


SELECT 
	t1.payroll_year,  
	round ((t1.avg_price - t2.avg_price), 2) AS difference_prices,
	round ((t1.avg_price *100 / t2.avg_price),2) - 100 AS perc_change_prices
FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year + 1
	AND t1.branch_name = t2.branch_name
GROUP BY payroll_year;


-- spojení dohromady
SELECT 
	t1.payroll_year,  
	round ((t1.avg_pay - t2.avg_pay), 2) AS difference_payroll,
	round ((t1.avg_price - t2.avg_price), 2) AS difference_prices,
	round ((t1.avg_pay *100 / t2.avg_pay),2) - 100 AS perc_change_payroll, 
	round ((t1.avg_price *100 / t2.avg_price),2) - 100 AS perc_change_prices
FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year + 1
	AND t1.branch_name = t2.branch_name
GROUP BY payroll_year;


-- přidání rozdílu mezi růstem cen x mezd 
SELECT 
	t1.payroll_year,  
	t2.payroll_year AS prev_year,
	round ((t1.avg_pay - t2.avg_pay), 2) AS difference_payroll,
	round ((t1.avg_price - t2.avg_price), 2) AS difference_prices,
	round ((t1.avg_pay *100 / t2.avg_pay),2) - 100 AS perc_change_payroll, 
	round ((t1.avg_price *100 / t2.avg_price),2) - 100 AS perc_change_prices,
	round (((t1.avg_price *100 / t2.avg_price) - 100) - ((t1.avg_pay *100 / t2.avg_pay) - 100),2) AS diff_rustu,
	CASE
		WHEN round (((t1.avg_price *100 / t2.avg_price) - 100) - ((t1.avg_pay *100 / t2.avg_pay) - 100),2) >= 10 THEN 1
		ELSE 0
	END AS high_increase_flag	
	FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year + 1
	AND t1.branch_name = t2.branch_name
GROUP BY payroll_year;

-- lepší názvy sloupců
SELECT 
	t1.payroll_year,  
	t2.payroll_year AS prev_year,
	round ((t1.avg_pay - t2.avg_pay), 2) AS payroll_change_CZK,
	round ((t1.avg_price - t2.avg_price), 2) AS prices_change_CZK,
	round ((t1.avg_pay *100 / t2.avg_pay),2) - 100 AS percentage_payroll_change,
	round ((t1.avg_price *100 / t2.avg_price),2) - 100 AS percentage_price_change,
	round (((t1.avg_price *100 / t2.avg_price) - 100) - ((t1.avg_pay *100 / t2.avg_pay) - 100),2) AS diff_rustu,
	CASE
		WHEN round (((t1.avg_price *100 / t2.avg_price) - 100) - ((t1.avg_pay *100 / t2.avg_pay) - 100),2) >= 10 THEN 1
		ELSE 0
	END AS high_increase_flag	
	FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year + 1
	AND t1.branch_name = t2.branch_name
GROUP BY payroll_year;

-- kdyby nás to zajímalo pro jednotlivé obory 
SELECT 
	t1.branch_name,  
	t1.payroll_year,  
	t2.payroll_year AS prev_year,
	round ((t1.avg_pay - t2.avg_pay), 2) AS payroll_change_CZK,
	round ((t1.avg_price - t2.avg_price), 2) AS prices_change_CZK,
	round ((t1.avg_pay *100 / t2.avg_pay),2) - 100 AS percentage_payroll_change,
	round ((t1.avg_price *100 / t2.avg_price),2) - 100 AS percentage_price_change,
	round (((t1.avg_price *100 / t2.avg_price) - 100) - ((t1.avg_pay *100 / t2.avg_pay) - 100),2) AS diff_rustu,
	CASE
		WHEN round (((t1.avg_price *100 / t2.avg_price) - 100) - ((t1.avg_pay *100 / t2.avg_pay) - 100),2) >= 10 THEN 1
		ELSE 0
	END AS high_increase_flag	
	FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year + 1
	AND t1.branch_name = t2.branch_name
GROUP BY t1.branch_name, 
		t1.payroll_year;







