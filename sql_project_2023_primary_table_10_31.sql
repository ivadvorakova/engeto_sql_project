-- Úvodní tabulka t_iva_dvorakova_project_SQL_primary_final

-- uživatelské jméno na discordu: dvorakovic.iva

-- SQL_final

CREATE OR REPLACE 
TABLE t_iva_dvorakova_project_SQL_primary_final AS 
SELECT *
FROM t_iva_dvorakova_payroll_table t1
JOIN t_iva_dvorakova_price_table t2
	ON t1.payroll_year=t2.price_year; 

-- payroll + price tables:

CREATE OR REPLACE
TABLE t_iva_dvorakova_payroll_table AS 
SELECT 
	cp.industry_branch_code, 
	cp.payroll_year, 
	cpib.name AS branch_name,
	AVG(cp.value) AS avg_pay
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code  = cpib.code
WHERE value_type_code=5958
	AND unit_code=200
	AND calculation_code=200
	AND cp.industry_branch_code IS NOT NULL
GROUP BY cp.industry_branch_code, 
	cp.payroll_year, 
	cpib.name;

CREATE OR REPLACE table t_iva_dvorakova_price_table AS
SELECT
	prc.name, 
	YEAR (pr.date_from) AS price_year, 
	AVG(pr.value) AS avg_price,
	e.GDP 
FROM czechia_price pr
LEFT JOIN czechia_price_category prc	
	ON pr.category_code = prc.code
LEFT JOIN economies e 
	ON e.`year`=YEAR(pr.date_from)
	WHERE e.country='Czech Republic'
GROUP BY prc.name, 
	price_year;



-- SQL_evolution

SELECT *
FROM czechia_payroll cp;

SELECT 
	COUNT(calculation_code)
FROM czechia_payroll cp
WHERE calculation_code=200;

SELECT 
	COUNT(calculation_code)
FROM czechia_payroll cp
WHERE calculation_code=100;

SELECT *
FROM czechia_payroll_calculation;

SELECT *
FROM czechia_payroll_calculation;

SELECT *
FROM czechia_payroll_industry_branch;

SELECT *
FROM czechia_payroll_unit;

SELECT *
FROM czechia_payroll_value_type;

SELECT *
FROM czechia_payroll cp;

SELECT *
FROM countries c;

SELECT *
FROM economies e
WHERE country='Czech Republic';

SELECT *
FROM czechia_price_category; 

SELECT *
FROM czechia_price;

SELECT 
	e.country,
	e.gdp, 
	YEAR AS year_GDP
FROM economies e
WHERE country='Czech Republic';

SELECT *
FROM t_iva_dvorakova_payroll_table_2; 

CREATE OR REPLACE
TABLE t_iva_dvorakova_payroll_table AS 
SELECT 
	cp.industry_branch_code, 
	cp.payroll_year, 
	cpib.name AS branch_name,
	AVG(cp.value) AS avg_pay
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code  = cpib.code
WHERE value_type_code=5958
	AND unit_code=200
	AND calculation_code=200
	AND cp.industry_branch_code IS NOT NULL
GROUP BY cp.industry_branch_code, 
	cp.payroll_year, 
	cpib.name;

CREATE OR REPLACE
TABLE t_iva_dvorakova_price_table AS
SELECT
	prc.name, 
	YEAR (pr.date_from) AS _year, 
	AVG(pr.value) AS avg_price,
	e.GDP 
FROM czechia_price pr
LEFT JOIN czechia_price_category prc	
	ON pr.category_code = prc.code
LEFT JOIN economies e 
	ON e.`year`=YEAR (pr.date_from)
	WHERE e.country='Czech Republic'
GROUP BY prc.name, 
	_year;

SELECT *
FROM t_iva_dvorakova_project_SQL_primary_final;

SELECT *
FROM t_iva_dvorakova_price_table;

SELECT *
FROM t_iva_dvorakova_payroll_table;































