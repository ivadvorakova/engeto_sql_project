-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

-- SQL_final 

SELECT 
	t1.name, 
	round (avg((t1.avg_price * 100 / t2.avg_price) - 100), 2) AS average_annual_change
FROM t_iva_dvorakova_project_sql_primary_final t1 
JOIN t_iva_dvorakova_project_sql_primary_final t2  
	ON t1.name = t2.name 
	AND t1._year = t2._year +1
GROUP BY t1.name
ORDER BY avg((t1.avg_price * 100 / t2.avg_price) - 100) ASC;

-- SQL_evolution

SELECT *
FROM t_iva_dvorakova_project_sql_primary_final t1;

SELECT 
	t1.name,
	t1.`_year`,  
	t1.avg_price 
FROM t_iva_dvorakova_project_sql_primary_final t1
GROUP BY t1.name,
	t1.`_year` ;
	
SELECT DISTINCT 
	t1.name, 
	t1.`_year`, 
	t1.avg_price, 
	t2.`_year` AS prev_year,
	t2.avg_price, 
	(t1.avg_price * 100 / t2.avg_price) - 100 AS percentage_change_in_year
FROM t_iva_dvorakova_project_sql_primary_final t1 
JOIN t_iva_dvorakova_project_sql_primary_final t2 
	ON t1.name = t2.name 
	AND t1._year = t2._year +1
ORDER BY t1.name, 
	t1.`_year`;
	
SELECT 
	t1.name, 
	round (avg((t1.avg_price * 100 / t2.avg_price) - 100), 2) AS average_annual_change
FROM t_iva_dvorakova_project_sql_primary_final t1 
JOIN t_iva_dvorakova_project_sql_primary_final t2  
	ON t1.name = t2.name 
	AND t1._year = t2._year +1
GROUP BY t1.name
ORDER BY avg((t1.avg_price * 100 / t2.avg_price) - 100) ASC;




