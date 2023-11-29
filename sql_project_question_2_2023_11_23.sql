 -- Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
 
 -- SQL_final 
 
SELECT 
	payroll_year, 
	name, 
	ROUND(AVG(avg_pay), 0) AS avg_payroll,
	ROUND(avg_price,2),
	ROUND((AVG(avg_pay)/avg_price), 0) AS how_much_can_be_bought
FROM t_iva_dvorakova_project_sql_primary_final 
WHERE name IN ('Mléko polotučné pasterované','Chléb konzumní kmínový')
	AND price_year IN ('2006','2018')
GROUP BY payroll_year, name, avg_price;

 -- pro jednotlivá odvětví
 SELECT 
	branch_name, 
	payroll_year, 
	ROUND(avg_pay,0),  
	name, 
	ROUND(avg_price,2),
	ROUND((AVG(avg_pay) / avg_price), 0) AS how_much_can_be_bought
FROM t_iva_dvorakova_project_sql_primary_final 
WHERE name IN ('Mléko polotučné pasterované','Chléb konzumní kmínový')
	AND price_year IN ('2006','2018')
GROUP BY branch_name, payroll_year, avg_pay, name, avg_price;

 -- SQL_evolution
 
 SELECT 
 	MAX(price_year), 
 	MIN(price_year)
 FROM t_iva_dvorakova_project_sql_primary_final;

SELECT DISTINCT 
	name
FROM t_iva_dvorakova_project_sql_primary_final;
 
SELECT 
	branch_name, 
	payroll_year, 
	ROUND(avg_pay,0),  
	name, 
	ROUND(avg_price,2), 
	ROUND((AVG(avg_pay) / avg_price), 0) AS how_much_can_be_bought
FROM t_iva_dvorakova_project_sql_primary_final 
WHERE name IN ('Mléko polotučné pasterované','Chléb konzumní kmínový')
	AND price_year IN ('2006','2018')
GROUP BY branch_name, payroll_year,	avg_pay, name, avg_price;

SELECT 
	payroll_year, 
	name, 
	ROUND(avg_price,2), 
	ROUND((AVG(avg_pay) / avg_price), 0) AS how_much_can_be_bought
FROM t_iva_dvorakova_project_sql_primary_final 
WHERE name IN ('Mléko polotučné pasterované','Chléb konzumní kmínový')
	AND price_year IN ('2006','2018')
GROUP BY payroll_year, name, avg_price;



