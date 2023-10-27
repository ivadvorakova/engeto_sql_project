-- Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, 
-- projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

-- změma HDP
-- změna cen + platů v dalším roce 
SELECT *
FROM t_iva_dvorakova_project_sql_primary_final t1;

-- změna HDP v letech 


SELECT 
	 t1.payroll_year, 
	 avg(avg_pay),
	 avg(avg_price), 
	 GDP 
FROM t_iva_dvorakova_project_sql_primary_final t1
GROUP BY t1.payroll_year;





SELECT 
	 t1.payroll_year, 
	 t2.payroll_year AS prev_year,
	 avg(t1.avg_pay) AS avg_payroll,
	 avg(t1.avg_price) AS avg_price, 
	 t1.GDP 
FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year + 1
	AND t1.branch_name = t2.branch_name
GROUP BY t1.payroll_year;

-- změna gdp
SELECT 
	 t1.payroll_year, 
	 t2.payroll_year AS prev_year,
	 round ((t1.avg_pay *100 / t2.avg_pay),2) - 100 AS perc_change_payroll, 
	 round ((t1.avg_price *100 / t2.avg_price),2) - 100 AS perc_change_prices, 
	 round ((t1.GDP *100 / t2.GDP),2) - 100 AS perc_GDP_change
FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year + 1
	AND t1.branch_name = t2.branch_name
GROUP BY t1.payroll_year;

-- druhý join se stejnou tabulkoui s posunutým GDP? 


SELECT 
	 t1.payroll_year, 
	 t2.payroll_year AS prev_year,
	 round ((t1.avg_pay *100 / t2.avg_pay),2) - 100 AS perc_change_payroll, 
	 round ((t1.avg_price *100 / t2.avg_price),2) - 100 AS perc_change_prices, 
	 round ((t1.GDP *100 / t2.GDP),2) - 100 AS perc_GDP_change, 
	 round ((t3.GDP *100 / t2.GDP),2) - 100 AS perc_GDP_change
FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year + 1
	AND t1.branch_name = t2.branch_name
JOIN t_iva_dvorakova_project_sql_primary_final t3
	ON t1.payroll_year = t3.payroll_year + 2
	AND t1.branch_name = t3.branch_name
GROUP BY t1.payroll_year;


SELECT*
FROM t_iva_dvorakova_project_sql_primary_final t1 




SELECT 
	 t1.payroll_year, 
	 t2.payroll_year AS prev_year,
	 (t1.avg_pay *100 / t2.avg_pay) - 100 AS perc_change_payroll, 
	 (t1.avg_price *100 / t2.avg_price) - 100 AS perc_change_prices, 
	 (t1.GDP *100 / t2.GDP) - 100 AS perc_GDP_change, 
	 (t3.GDP *100 / t2.GDP) - 100 AS perc_GDP_change
FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year + 1
	AND t1.branch_name = t2.branch_name
JOIN t_iva_dvorakova_project_sql_primary_final t3
	ON t1.payroll_year = t3.payroll_year + 2
	AND t1.branch_name = t3.branch_name
GROUP BY t1.payroll_year;


SELECT 
	 t1.payroll_year, 
	 t2.payroll_year AS prev_year,
	 (t1.avg_pay *100 / t2.avg_pay) - 100 AS perc_change_payroll, 
	 (t1.avg_price *100 / t2.avg_price) - 100 AS perc_change_prices, 
	 (t1.GDP *100 / t2.GDP) - 100 AS perc_GDP_change, 
	 (t3.GDP *100 / t2.GDP) - 100 AS perc_GDP_change
FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year + 1
	AND t1.branch_name = t2.branch_name
JOIN t_iva_dvorakova_project_sql_primary_final t3
	ON t1.payroll_year = t3.payroll_year + 2
	AND t1.branch_name = t3.branch_name;

CREATE OR REPLACE TABLE t_price_payroll_change AS 
SELECT 
	 t1.payroll_year AS PP_year,  
	 t2.payroll_year AS prev_PP_year,
	 round((t1.avg_pay *100 / t2.avg_pay),2) - 100 AS perc_change_payroll, 
	 round((t1.avg_price *100 / t2.avg_price),2) - 100 AS perc_change_prices
FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year + 1
	AND t1.branch_name = t2.branch_name 
GROUP BY  t1.payroll_year;
	


CREATE OR REPLACE TABLE t_GDP_change AS 
SELECT 
	 t1.payroll_year AS GDP_year, 
	 t2.payroll_year AS prev_GDP_year,
	 round((t1.GDP *100 / t2.GDP),2) - 100 AS perc_GDP_change_prev_prev_year	
FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year + 1
	AND t1.branch_name = t2.branch_name 
GROUP BY  t1.payroll_year;



SELECT *
FROM t_price_payroll_change t5; 

SELECT *
FROM t_gdp_change t6;

SELECT *
FROM t_price_payroll_change t5
JOIN t_gdp_change t6
	ON t5.PP_year = t6.GDP_year +1;
	
-- ještě přidat změnu cen a mezd ve stejném roce, kdy se mění HDP 

