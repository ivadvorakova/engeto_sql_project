-- Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, 
-- projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

-- SQL_final 

-- auxiliary tables
CREATE OR REPLACE TABLE t_GDP_change AS 
SELECT 
	 t1.payroll_year AS GDP_y2, 
	 t2.payroll_year AS GDP_y3,
	 round((t1.GDP *100 / t2.GDP),2) - 100 AS GDP_2x3	
FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year + 1
	AND t1.branch_name = t2.branch_name 
GROUP BY  t1.payroll_year;


CREATE OR REPLACE TABLE t_PP_change_2_years AS 
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
	
CREATE OR REPLACE TABLE t_PP_change_3_years AS 
SELECT 
	t10.PP_year AS PP_y1, 
	t10.prev_PP_year AS PP_y2, 
	t11.prev_PP_year AS PP_y3, 
	t10.perc_change_payroll AS PAY_1x2,  
	t10.perc_change_prices AS PRICE_1x2, 
	t11.perc_change_payroll AS PAY_2x3,
	t11.perc_change_prices AS PRICE_2x3
FROM t_PP_change_2_years t10
LEFT JOIN t_PP_change_2_years t11
	ON t10.PP_year = t11.PP_year +1;

-- GDP x Prices/Payroll in the same period
SELECT 	
	t15.PP_y2, 
	t15.PP_y3,  
	t15.PAY_2x3, 
	t15.PRICE_2x3, 
	t16.GDP_2x3, 
	CASE 
		WHEN t16.GDP_2x3 > 2 AND t15.PAY_2x3 > 2 AND t15.PRICE_2x3 > 2 THEN 'overall growth'
		WHEN t16.GDP_2x3 < 0 AND t15.PAY_2x3 < 0 AND t15.PRICE_2x3 < 0 THEN 'overall decrese'
		ELSE 'no connection'			
	END AS overall_situation_2x3
FROM t_pp_change_3_years t15
JOIN t_gdp_change t16
	ON t15.PP_y3 = t16.GDP_y3;

-- GDP x Prices/Payroll in next period

SELECT 	
	t15.PP_y1, 
	t15.PP_y2,  
	t15.PAY_1x2 , 
	t15.PRICE_1x2, 
	t16.GDP_2x3, 
	CASE 
		WHEN t16.GDP_2x3 > 2 AND t15.PAY_1x2 > 2 AND t15.PRICE_1x2 > 2 THEN 'overall growth'
		WHEN t16.GDP_2x3 <= 0 AND t15.PAY_1x2 <= 0 AND t15.PRICE_1x2 <= 0 THEN 'overall decrese'
		ELSE 'no connection'		
	END AS overall_situation_1x2
FROM t_pp_change_3_years t15
JOIN t_gdp_change t16
	ON t15.PP_y3 = t16.GDP_y3; 

-- SQL_final 
SELECT 	
	t15.PP_y1, 
	t15.PP_y2, 
	t15.PP_y3,  
	t15.PAY_1x2 , 
	t15.PRICE_1x2, 
	t15.PAY_2x3, 
	t15.PRICE_2x3, 
	t16.GDP_2x3, 
	CASE 
		WHEN t16.GDP_2x3 > 2 AND t15.PAY_1x2 > 2 AND t15.PRICE_1x2 > 2 THEN 'overall growth'
		WHEN t16.GDP_2x3 <= 0 AND t15.PAY_1x2 <= 0 AND t15.PRICE_1x2 <= 0 THEN 'overall decrese'
		ELSE 'no connection'		
	END AS overall_situation_1x2,
	CASE 
		WHEN t16.GDP_2x3 > 2 AND t15.PAY_2x3 > 2 AND t15.PRICE_2x3 > 2 THEN 'overall growth'
		WHEN t16.GDP_2x3 < 0 AND t15.PAY_2x3 < 0 AND t15.PRICE_2x3 < 0 THEN 'overall decrese'
		ELSE 'no connection'			
	END AS overall_situation_2x3
FROM t_pp_change_3_years t15
JOIN t_gdp_change t16
	ON t15.PP_y3 = t16.GDP_y3;



-- SQL_evolution

SELECT 
	 t1.payroll_year, 
	 avg(avg_pay),
	 avg(avg_price), 
	 GDP 
FROM t_iva_dvorakova_project_sql_primary_final t1
GROUP BY t1.payroll_year;

-- tabulka pro růst GDP 

CREATE OR REPLACE TABLE t_GDP_change AS 
SELECT 
	 t1.payroll_year AS GDP_y2, 
	 t2.payroll_year AS GDP_y3,
	 round((t1.GDP *100 / t2.GDP),2) - 100 AS GDP_2x3	
FROM t_iva_dvorakova_project_sql_primary_final t1
JOIN t_iva_dvorakova_project_sql_primary_final t2
	ON t1.payroll_year = t2.payroll_year + 1
	AND t1.branch_name = t2.branch_name 
GROUP BY  t1.payroll_year;


CREATE OR REPLACE TABLE t_PP_change_2_years AS 
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
	
CREATE OR REPLACE TABLE t_PP_change_3_years AS 
SELECT 
	t10.PP_year AS PP_y1, 
	t10.prev_PP_year AS PP_y2, 
	t11.prev_PP_year AS PP_y3, 
	t10.perc_change_payroll AS PAY_1x2,  
	t10.perc_change_prices AS PRICE_1x2, 
	t11.perc_change_payroll AS PAY_2x3,
	t11.perc_change_prices AS PRICE_2x3
FROM t_PP_change_2_years t10
LEFT JOIN t_PP_change_2_years t11
	ON t10.PP_year = t11.PP_year +1;

SELECT *
FROM t_GDP_change; 

SELECT *
FROM t_PP_change_3_years;


SELECT *
FROM t_pp_change_3_years t15
JOIN t_gdp_change t16
	ON t15.PP_y3 = t16.GDP_y3; 

-- porovnání růst HDP/růst cen a mezd ve stejém období 

SELECT 	
	t15.PP_y2, 
	t15.PP_y3,  
	t15.PAY_2x3, 
	t15.PRICE_2x3, 
	t16.GDP_2x3, 
	CASE 
		WHEN t16.GDP_2x3 > 2 AND t15.PAY_2x3 > 2 AND t15.PRICE_2x3 > 2 THEN 'overall growth'
		WHEN t16.GDP_2x3 < 0 AND t15.PAY_2x3 < 0 AND t15.PRICE_2x3 < 0 THEN 'overall decrese'
		ELSE 'no connection'			
	END AS overall_situation_2x3
FROM t_pp_change_3_years t15
JOIN t_gdp_change t16
	ON t15.PP_y3 = t16.GDP_y3;


-- porovnání růst HDP/růst cen a mezd v dalším období 
SELECT 	
	t15.PP_y1, 
	t15.PP_y2,  
	t15.PAY_1x2 , 
	t15.PRICE_1x2, 
	t16.GDP_2x3, 
	CASE 
		WHEN t16.GDP_2x3 > 2 AND t15.PAY_1x2 > 2 AND t15.PRICE_1x2 > 2 THEN 'overall growth'
		WHEN t16.GDP_2x3 <= 0 AND t15.PAY_1x2 <= 0 AND t15.PRICE_1x2 <= 0 THEN 'overall decrese'
		ELSE 'no connection'		
	END AS overall_situation_1x2
FROM t_pp_change_3_years t15
JOIN t_gdp_change t16
	ON t15.PP_y3 = t16.GDP_y3; 

-- vše dohromady 

SELECT 	
	t15.PP_y1, 
	t15.PP_y2, 
	t15.PP_y3,  
	t15.PAY_1x2 , 
	t15.PRICE_1x2, 
	t15.PAY_2x3, 
	t15.PRICE_2x3, 
	t16.GDP_2x3, 
	CASE 
		WHEN t16.GDP_2x3 > 2 AND t15.PAY_1x2 > 2 AND t15.PRICE_1x2 > 2 THEN 'overall growth'
		WHEN t16.GDP_2x3 <= 0 AND t15.PAY_1x2 <= 0 AND t15.PRICE_1x2 <= 0 THEN 'overall decrese'
		ELSE 'no connection'		
	END AS overall_situation_1x2,
	CASE 
		WHEN t16.GDP_2x3 > 2 AND t15.PAY_2x3 > 2 AND t15.PRICE_2x3 > 2 THEN 'overall growth'
		WHEN t16.GDP_2x3 < 0 AND t15.PAY_2x3 < 0 AND t15.PRICE_2x3 < 0 THEN 'overall decrese'
		ELSE 'no connection'			
	END AS overall_situation_2x3
FROM t_pp_change_3_years t15
JOIN t_gdp_change t16
	ON t15.PP_y3 = t16.GDP_y3;

