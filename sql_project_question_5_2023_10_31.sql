-- Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, 
-- projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

-- SQL_final 
SELECT 	
	tppch3y.PP_y1, 
	tppch3y.PP_y2, 
	tppch3y.PP_y3,  
	tppch3y.PAY_1x2 , 
	tppch3y.PRICE_1x2, 
	tppch3y.PAY_2x3, 
	tppch3y.PRICE_2x3, 
	tgdpch.GDP_2x3, 
	CASE 
		WHEN tgdpch.GDP_2x3>2 AND tppch3y.PAY_1x2>2 AND tppch3y.PRICE_1x2>2 THEN 'overall growth'
		WHEN tgdpch.GDP_2x3<=0 AND tppch3y.PAY_1x2<=0 AND tppch3y.PRICE_1x2<=0 THEN 'overall decrese'
		ELSE 'no connection'		
	END AS overall_situation_1x2,
	CASE 
		WHEN tgdpch.GDP_2x3>2 AND tppch3y.PAY_2x3>2 AND tppch3y.PRICE_2x3>2 THEN 'overall growth'
		WHEN tgdpch.GDP_2x3<0 AND tppch3y.PAY_2x3<0 AND tppch3y.PRICE_2x3<0 THEN 'overall decrese'
		ELSE 'no connection'			
	END AS overall_situation_2x3
FROM t_pp_change_3_years tppch3y
JOIN t_gdp_change tgdpch
	ON tppch3y.PP_y3=tgdpch.GDP_y3;

-- auxiliary tables
CREATE OR REPLACE
TABLE t_GDP_change AS 
SELECT 
	 tppf.payroll_year AS GDP_y2, 
	 tppf2.payroll_year AS GDP_y3,
	 ROUND((tppf.GDP *100/tppf2.GDP),2)-100 AS GDP_2x3	
FROM t_iva_dvorakova_project_sql_primary_final tppf
JOIN t_iva_dvorakova_project_sql_primary_final tppf2
	ON tppf.payroll_year=tppf2.payroll_year + 1
	AND tppf.branch_name=tppf2.branch_name 
GROUP BY  tppf.payroll_year;

CREATE OR REPLACE 
TABLE t_PP_change_2_years AS 
SELECT 
	 tppf.payroll_year AS PP_year,  
	 tppf2.payroll_year AS prev_PP_year,
	 ROUND((tppf.avg_pay*100/tppf2.avg_pay),2)-100 AS perc_change_payroll, 
	 ROUND((tppf.avg_price*100/tppf2.avg_price),2)-100 AS perc_change_prices
FROM t_iva_dvorakova_project_sql_primary_final tppf
JOIN t_iva_dvorakova_project_sql_primary_final tppf2
	ON tppf.payroll_year=tppf2.payroll_year+1  
	AND tppf.branch_name=tppf2.branch_name 
GROUP BY  tppf.payroll_year;
	
CREATE OR REPLACE
TABLE t_PP_change_3_years AS 
SELECT 
	tppch2y.PP_year AS PP_y1, 
	tppch2y.prev_PP_year AS PP_y2, 
	tppch2y2.prev_PP_year AS PP_y3, 
	tppch2y.perc_change_payroll AS PAY_1x2,  
	tppch2y.perc_change_prices AS PRICE_1x2, 
	tppch2y2.perc_change_payroll AS PAY_2x3,
	tppch2y2.perc_change_prices AS PRICE_2x3
FROM t_PP_change_2_years tppch2y
LEFT JOIN t_PP_change_2_years tppch2y2
	ON tppch2y.PP_year=tppch2y2.PP_year +1;

-- GDP x Prices/Payroll in the same period
SELECT 	
	tppch3y.PP_y2, 
	tppch3y.PP_y3,  
	tppch3y.PAY_2x3, 
	tppch3y.PRICE_2x3, 
	tgdpch.GDP_2x3, 
	CASE 
		WHEN tgdpch.GDP_2x3>2 AND tppch3y.PAY_2x3>2 AND tppch3y.PRICE_2x3>2 THEN 'overall growth'
		WHEN tgdpch.GDP_2x3<0 AND tppch3y.PAY_2x3<0 AND tppch3y.PRICE_2x3<0 THEN 'overall decrese'
		ELSE 'no connection'			
	END AS overall_situation_2x3
FROM t_pp_change_3_years tppch3y
JOIN t_gdp_change tgdpch
	ON tppch3y.PP_y3=tgdpch.GDP_y3;

-- GDP x Prices/Payroll in next period

SELECT 	
	tppch3y.PP_y1, 
	tppch3y.PP_y2,  
	tppch3y.PAY_1x2 , 
	tppch3y.PRICE_1x2, 
	tgdpch.GDP_2x3, 
	CASE 
		WHEN tgdpch.GDP_2x3>2 AND tppch3y.PAY_1x2>2 AND tppch3y.PRICE_1x2>2 THEN 'overall growth'
		WHEN tgdpch.GDP_2x3<=0 AND tppch3y.PAY_1x2<=0 AND tppch3y.PRICE_1x2<=0 THEN 'overall decrese'
		ELSE 'no connection'		
	END AS overall_situation_1x2
FROM t_pp_change_3_years tppch3y
JOIN t_gdp_change tgdpch
	ON tppch3y.PP_y3=tgdpch.GDP_y3; 

-- SQL_final 
SELECT 	
	tppch3y.PP_y1, 
	tppch3y.PP_y2, 
	tppch3y.PP_y3,  
	tppch3y.PAY_1x2 , 
	tppch3y.PRICE_1x2, 
	tppch3y.PAY_2x3, 
	tppch3y.PRICE_2x3, 
	tgdpch.GDP_2x3, 
	CASE 
		WHEN tgdpch.GDP_2x3>2 AND tppch3y.PAY_1x2>2 AND tppch3y.PRICE_1x2>2 THEN 'overall growth'
		WHEN tgdpch.GDP_2x3<=0 AND tppch3y.PAY_1x2<=0 AND tppch3y.PRICE_1x2<=0 THEN 'overall decrese'
		ELSE 'no connection'		
	END AS overall_situation_1x2,
	CASE 
		WHEN tgdpch.GDP_2x3>2 AND tppch3y.PAY_2x3>2 AND tppch3y.PRICE_2x3>2 THEN 'overall growth'
		WHEN tgdpch.GDP_2x3<0 AND tppch3y.PAY_2x3<0 AND tppch3y.PRICE_2x3<0 THEN 'overall decrese'
		ELSE 'no connection'			
	END AS overall_situation_2x3
FROM t_pp_change_3_years tppch3y
JOIN t_gdp_change tgdpch
	ON tppch3y.PP_y3=tgdpch.GDP_y3;


-- SQL_evolution
SELECT 
	 tppf.payroll_year, 
	 AVG(avg_pay),
	 AVG(avg_price), 
	 GDP 
FROM t_iva_dvorakova_project_sql_primary_final tppf
GROUP BY tppf.payroll_year;

-- tabulka pro růst GDP 

CREATE OR REPLACE 
TABLE t_GDP_change AS 
SELECT 
	 tppf.payroll_year AS GDP_y2, 
	 tppf2.payroll_year AS GDP_y3,
	 ROUND((tppf.GDP*100/tppf2.GDP),2)-100 AS GDP_2x3	
FROM t_iva_dvorakova_project_sql_primary_final tppf
JOIN t_iva_dvorakova_project_sql_primary_final tppf2
	ON tppf.payroll_year=tppf2.payroll_year+1
	AND tppf.branch_name=tppf2.branch_name 
GROUP BY tppf.payroll_year;


CREATE OR REPLACE 
TABLE t_PP_change_2_years AS 
SELECT 
	 tppf.payroll_year AS PP_year,  
	 tppf2.payroll_year AS prev_PP_year,
	 ROUND((tppf.avg_pay*100/tppf2.avg_pay),2)-100 AS perc_change_payroll, 
	 ROUND((tppf.avg_price*100/tppf2.avg_price),2)-100 AS perc_change_prices
FROM t_iva_dvorakova_project_sql_primary_final tppf
JOIN t_iva_dvorakova_project_sql_primary_final tppf2
	ON tppf.payroll_year=tppf2.payroll_year + 1
	AND tppf.branch_name=tppf2.branch_name 
GROUP BY  tppf.payroll_year;
	
CREATE OR REPLACE 
TABLE t_PP_change_3_years AS 
SELECT 
	tppch2y.PP_year AS PP_y1, 
	tppch2y.prev_PP_year AS PP_y2, 
	tppch2y2.prev_PP_year AS PP_y3, 
	tppch2y.perc_change_payroll AS PAY_1x2,  
	tppch2y.perc_change_prices AS PRICE_1x2, 
	tppch2y2.perc_change_payroll AS PAY_2x3,
	tppch2y2.perc_change_prices AS PRICE_2x3
FROM t_PP_change_2_years tppch2y
LEFT JOIN t_PP_change_2_years tppch2y2
	ON tppch2y.PP_year=tppch2y2.PP_year +1;

SELECT *
FROM t_GDP_change; 

SELECT *
FROM t_PP_change_3_years;


SELECT *
FROM t_pp_change_3_years tppch3y
JOIN t_gdp_change tgdpch
	ON tppch3y.PP_y3=tgdpch.GDP_y3; 

-- porovnání růst HDP/růst cen a mezd ve stejém období 

SELECT 	
	tppch3y.PP_y2, 
	tppch3y.PP_y3,  
	tppch3y.PAY_2x3, 
	tppch3y.PRICE_2x3, 
	tgdpch.GDP_2x3, 
	CASE 
		WHEN tgdpch.GDP_2x3>2 AND tppch3y.PAY_2x3>2 AND tppch3y.PRICE_2x3>2 THEN 'overall growth'
		WHEN tgdpch.GDP_2x3<0 AND tppch3y.PAY_2x3<0 AND tppch3y.PRICE_2x3<0 THEN 'overall decrese'
		ELSE 'no connection'			
	END AS overall_situation_2x3
FROM t_pp_change_3_years tppch3y
JOIN t_gdp_change tgdpch
	ON tppch3y.PP_y3=tgdpch.GDP_y3;


-- porovnání růst HDP/růst cen a mezd v dalším období 
SELECT 	
	tppch3y.PP_y1, 
	tppch3y.PP_y2,  
	tppch3y.PAY_1x2 , 
	tppch3y.PRICE_1x2, 
	tgdpch.GDP_2x3, 
	CASE 
		WHEN tgdpch.GDP_2x3>2 AND tppch3y.PAY_1x2>2 AND tppch3y.PRICE_1x2>2 THEN 'overall growth'
		WHEN tgdpch.GDP_2x3<= 0 AND tppch3y.PAY_1x2<=0 AND tppch3y.PRICE_1x2<=0 THEN 'overall decrese'
		ELSE 'no connection'		
	END AS overall_situation_1x2
FROM t_pp_change_3_years tppch3y
JOIN t_gdp_change tgdpch
	ON tppch3y.PP_y3=tgdpch.GDP_y3; 

-- vše dohromady 

SELECT 	
	tppch3y.PP_y1, 
	tppch3y.PP_y2, 
	tppch3y.PP_y3,  
	tppch3y.PAY_1x2 , 
	tppch3y.PRICE_1x2, 
	tppch3y.PAY_2x3, 
	tppch3y.PRICE_2x3, 
	tgdpch.GDP_2x3, 
	CASE 
		WHEN tgdpch.GDP_2x3>2 AND tppch3y.PAY_1x2>2 AND tppch3y.PRICE_1x2>2 THEN 'overall growth'
		WHEN tgdpch.GDP_2x3<=0 AND tppch3y.PAY_1x2<=0 AND tppch3y.PRICE_1x2<=0 THEN 'overall decrese'
		ELSE 'no connection'		
	END AS overall_situation_1x2,
	CASE 
		WHEN tgdpch.GDP_2x3>2 AND tppch3y.PAY_2x3>2 AND tppch3y.PRICE_2x3>2 THEN 'overall growth'
		WHEN tgdpch.GDP_2x3<0 AND tppch3y.PAY_2x3<0 AND tppch3y.PRICE_2x3<0 THEN 'overall decrese'
		ELSE 'no connection'			
	END AS overall_situation_2x3
FROM t_pp_change_3_years tppch3y
JOIN t_gdp_change tgdpch
	ON tppch3y.PP_y3=tgdpch.GDP_y3;

