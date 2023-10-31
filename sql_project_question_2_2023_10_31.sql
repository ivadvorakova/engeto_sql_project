 -- Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
 
 -- SQL_final 
 -- pro jednotlivá odvětví
 SELECT 
	branch_name, 
	payroll_year, 
	avg_pay,  
	name, 
	avg_price, 
	round ((avg_pay / avg_price), 0) AS how_much_can_be_bought
FROM t_iva_dvorakova_project_sql_primary_final 
WHERE name IN ('Mléko polotučné pasterované','Chléb konzumní kmínový')
	AND price_year IN ('2006','2018')
GROUP BY branch_name, 
	payroll_year, 
	avg_pay,  
 	name, 
	avg_price;

-- celkově
SELECT 
	payroll_year, 
	name, 
	avg_price, 
	round ((avg_pay / avg_price), 0) AS how_much_can_be_bought
FROM t_iva_dvorakova_project_sql_primary_final 
WHERE name IN ('Mléko polotučné pasterované','Chléb konzumní kmínový')
	AND price_year IN ('2006','2018')
GROUP BY  
	payroll_year, 
	name, 
	avg_price;

 -- SQL_evolution
 
SELECT *
FROM t_iva_dvorakova_project_sql_primary_final;

 SELECT 
 	max (price_year), 
 	min (price_year)
 FROM t_iva_dvorakova_project_sql_primary_final;

SELECT DISTINCT 
	name
FROM t_iva_dvorakova_project_sql_primary_final;
 
SELECT 
	branch_name, 
	payroll_year, 
	avg_pay,  
	name, 
	avg_price, 
	round ((avg_pay / avg_price), 0) AS how_much_can_be_bought
FROM t_iva_dvorakova_project_sql_primary_final 
WHERE name IN ('Mléko polotučné pasterované','Chléb konzumní kmínový')
	AND price_year IN ('2006','2018')
GROUP BY branch_name, 
	payroll_year, 
	avg_pay,  
	name, 
	avg_price;


SELECT 
	payroll_year, 
	name, 
	avg_price, 
	round ((avg_pay / avg_price), 0) AS how_much_can_be_bought
FROM t_iva_dvorakova_project_sql_primary_final 
WHERE name IN ('Mléko polotučné pasterované','Chléb konzumní kmínový')
	AND price_year IN ('2006','2018')
GROUP BY  
	payroll_year, 
	name, 
	avg_price;


