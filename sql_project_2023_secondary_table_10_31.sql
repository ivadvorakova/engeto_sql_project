-- SQL_final 

CREATE OR REPLACE 
TABLE t_iva_dvorakova_project_sql_secondary_final
SELECT 
	c.country,
	e.population,  
	e.YEAR,
	e.GDP, 
	e.gini 
FROM countries c 
LEFT JOIN economies e
	ON c.country=e.country
WHERE continent='Europe'
	AND YEAR>=2006
	AND YEAR<=2018
ORDER BY country, YEAR;

SELECT *
FROM economies e;

SELECT *
FROM countries c; 