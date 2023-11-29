-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

-- SQL_final 

SELECT 
	tpf.name, 
	ROUND(AVG((tpf.avg_price * 100/tpf2.avg_price) - 100), 2) AS average_annual_change
FROM t_iva_dvorakova_project_sql_primary_final tpf 
JOIN t_iva_dvorakova_project_sql_primary_final tpf2  
	ON tpf.name=tpf2.name 
	AND tpf.price_year=tpf2.price_year +1
GROUP BY tpf.name
ORDER BY AVG((tpf.avg_price*100/tpf2.avg_price) - 100) ASC;

-- SQL_evolution

SELECT 
	tpf.name,
	tpf.price_year,  
	tpf.avg_price 
FROM t_iva_dvorakova_project_sql_primary_final tpf
GROUP BY tpf.name, tpf.price_year ;
	
SELECT DISTINCT 
	tpf.name, 
	tpf.price_year, 
	tpf.avg_price, 
	tpf2.price_year AS prev_year,
	tpf2.avg_price, 
	(tpf.avg_price*100/tpf2.avg_price)- 100 AS percentage_change_in_year
FROM t_iva_dvorakova_project_sql_primary_final tpf 
JOIN t_iva_dvorakova_project_sql_primary_final tpf2 
	ON tpf.name=tpf2.name 
	AND tpf.price_year=tpf2.price_year +1
ORDER BY tpf.name, tpf.price_year;
	
SELECT 
	tpf.name, 
	ROUND(AVG((tpf.avg_price*100/tpf2.avg_price)-100),2) AS average_annual_change
FROM t_iva_dvorakova_project_sql_primary_final tpf 
JOIN t_iva_dvorakova_project_sql_primary_final tpf2  
	ON tpf.name=tpf2.name 
	AND tpf.price_year=tpf2.price_year+1
GROUP BY tpf.name
ORDER BY AVG((tpf.avg_price*100/tpf2.avg_price) - 100) ASC;




