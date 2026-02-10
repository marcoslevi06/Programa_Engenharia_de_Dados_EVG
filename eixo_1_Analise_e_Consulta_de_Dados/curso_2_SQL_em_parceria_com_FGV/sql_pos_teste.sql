-- Pós teste: 

-- Questão 01:
SELECT * FROM gdp_pc gp 
WHERE gp.ref_year = 2020
AND gp.country LIKE "%67800%";

-- Questão 02:
SELECT 
	* 
FROM 
	(
	SELECT 
		ROUND(AVG(cep.co2_pc), 3) as media
	FROM co2_emissions_pc cep 
		INNER JOIN country c ON c.country = cep.country AND c.wb_regions = "Latin America & Caribbean"
		WHERE cep.ref_year = 2010
	) as tab_temp
;

-- Questão 05:
SELECT
	MAX(p."Close"),
--	MIN(p."Close"),
	*
FROM petrobras p
WHERE p.date BETWEEN "2008-09-15" AND "2009-12-31"
;


-- Questão 07:
SELECT * FROM country c ;

SELECT 
	c.wb_regions, c.country, le.tot_years
FROM life_expectancy le 
INNER JOIN country c ON c.country = le.country 
WHERE le.ref_year = 1975
--GROUP BY c.wb_regions
ORDER BY c.wb_regions, le.tot_years DESC
;

-- Questão 08:

SELECT 
    c.wb_regions AS regiao,
    ROUND(AVG(cm.tot_deaths), 2) AS media_mortalidade,
    ROUND(AVG(g.gdp_pc), 2) AS media_pib_pc
FROM country c
LEFT JOIN child_mortality cm 
    ON c.country = cm.country 
    AND cm.ref_year = 2020
LEFT JOIN gdp_pc g 
    ON c.country = g.country 
    AND g.ref_year = 2020
WHERE cm.tot_deaths IS NOT NULL 
  AND g.gdp_pc IS NOT NULL
GROUP BY c.wb_regions
ORDER BY media_mortalidade DESC
;

-- Questão 09:

SELECT 
    c.wb3income AS classificacao_renda,
    c.country AS pais,
    f.mean_babies AS taxa_natalidade
FROM country c
JOIN fertility f ON c.country = f.country
WHERE f.ref_year = 2018
  AND c.wb3income IS NOT NULL
  AND f.mean_babies = (
    SELECT MIN(f2.mean_babies)
    FROM country c2
    JOIN fertility f2 ON c2.country = f2.country
    WHERE c2.wb3income = c.wb3income
      AND f2.ref_year = 2018
  )
ORDER BY f.mean_babies ASC;