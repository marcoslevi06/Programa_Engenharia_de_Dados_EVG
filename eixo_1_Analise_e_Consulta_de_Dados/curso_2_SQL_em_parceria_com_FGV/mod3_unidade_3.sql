
--Questão 1: Calcule qual é o país da África com maior PIB per capita em 2019.
SELECT * FROM gdp_pc gp ;

SELECT 
	*
FROM gdp_pc gp 
WHERE gp.country IN (
		SELECT c.country 
		FROM country c WHERE c.four_regions = "africa"
	)
AND gp.ref_year = 2019
ORDER BY gp.gdp_pc DESC
LIMIT 1
;


--Questão 2: 
--	a.Calcule novamente a expectativa de vida mínima, média e máxima dos países da América Latina e do Caribe em 1990
-- bem como identifique o país com a menor expectativa de vida nessa região no mesmo ano.

--"Latin America & Caribbean" 
--SELECT  * FROM country c ;

SELECT
	le.country, MIN(le.tot_years) as valor, "minimo" as categoria
--	*
FROM life_expectancy le 
WHERE le.ref_year = 2019
AND le.country IN (
	SELECT c.country FROM country c WHERE c.wb_regions = "Latin America & Caribbean" 
	)
	UNION
SELECT 
	le.country, MAX(le.tot_years) as valor, "maximo" as categoria 
FROM life_expectancy le 
WHERE le.country IN (
	SELECT c.country FROM country c WHERE c.wb_regions = "Latin America & Caribbean"
	)
AND le.ref_year = 2019
	UNION
SELECT 
	"media_regial" as country, ROUND(AVG(le.tot_years), 2) as valor, "media" as categoria 
FROM life_expectancy le 
WHERE le.country IN (
	SELECT c.country FROM country c WHERE c.wb_regions = "Latin America & Caribbean"
	)
AND le.ref_year = 2019
;

--b. Repita a consulta para 2010, incluindo também o valor de tot_years. 
--Indique se o país com a menor expectativa de vida permanece o mesmo.
--Além disso, verifique se há alguma explicação para uma queda tão acentuada na expectativa de vida.
SELECT
	le.country, MIN(le.tot_years) as valor, "minimo" as categoria
--	*
FROM life_expectancy le 
WHERE le.ref_year = 2010
AND le.country IN (
	SELECT c.country FROM country c WHERE c.wb_regions = "Latin America & Caribbean" 
	)
	UNION
SELECT 
	le.country, MAX(le.tot_years) as valor, "maximo" as categoria 
FROM life_expectancy le 
WHERE le.country IN (
	SELECT c.country FROM country c WHERE c.wb_regions = "Latin America & Caribbean"
	)
AND le.ref_year = 2010
	UNION
SELECT 
	"media_regial" as country, ROUND(AVG(le.tot_years), 2) as valor, "media" as categoria 
FROM life_expectancy le 
WHERE le.country IN (
	SELECT c.country FROM country c WHERE c.wb_regions = "Latin America & Caribbean"
	)
AND le.ref_year = 2010
;

-- Questão 3: Após calcular novamente a média da diferença no tempo de escolaridade entre homens e mulheres no ano 2000, 
-- segmentando por região do Banco Mundial (wb_regions), execute uma única consulta com subqueries que 
-- retorne o nome da região com a maior média de diferença no tempo de escolaridade entre os gêneros.

-- 1. Calcular a média da diferença entre homens e mulheres em 2000. 
-- 2. Agrupar por região.
-- 3. Pegar a região com a maior média.

SELECT
	table_tamp.regiao,
	table_tamp.media_dif 
FROM (
	SELECT
		c.wb_regions as regiao,
		AVG(m.mean_years - w.mean_years) as media_dif
	FROM men_years_at_school m
	INNER JOIN women_years_at_school w ON w.country = m.country AND W.ref_year = m.ref_year 
	INNER JOIN country c ON c.country = w.country
	WHERE m.ref_year = 2000
	GROUP BY c.wb_regions 
	) as table_tamp
ORDER BY table_tamp.media_dif DESC 
LIMIT 1
;



--Questão 4: Liste o país com a menor renda média per capita diária da Europa em 2020. 
--Use a tabela avg_income e o campo four_regions da tabela country igual a europe.


SELECT ai1.country 
FROM avg_income ai1
JOIN country c1 ON ai1.country = c1.country 
WHERE ai1.ref_year = 2020
AND c1.four_regions = 'europe'
AND ai1.mean_usd = (
	SELECT MIN (ai.mean_usd) AS "min"
	FROM avg_income ai
	JOIN country c ON ai.country = c.country 
	WHERE ai.ref_year = 2020
	AND c.four_regions = 'europe'
);

--Questão 5: Indique quais países da região da América Latina e do Caribe, de acordo com a classificação 
--do Banco Mundial (campo wb_regions da tabela country), apresentaram, em 2000, 
--uma diferença de tempo na escola entre homens e mulheres menor do que a do Brasil no mesmo ano, 
--significando que, nesses países, as mulheres passaram mais tempo na escola do que os homens. 
--Utilize EXISTS para realizar a consulta.

SELECT *
FROM (
	SELECT m.country, m.mean_years - w.mean_years AS diff
	FROM men_years_at_school m
	JOIN women_years_at_school w ON m.country = w.country 
		AND m.ref_year = w.ref_year
	JOIN country c ON m.country = c.country 
	WHERE w.ref_year = 2000
	AND c.wb_regions = 'Latin America & Caribbean'
) t1
WHERE EXISTS
(SELECT *
FROM (
	SELECT m.country, m.mean_years - w.mean_years AS diff
	FROM men_years_at_school m
	JOIN women_years_at_school w ON m.country = w.country 
		AND m.ref_year = w.ref_year
	JOIN country c ON m.country = c.country 
	WHERE w.ref_year = 2000
	AND c.wb_regions = 'Latin America & Caribbean'
	GROUP BY m.country
	) t2
	WHERE t1.diff < t2.diff <	
	AND t2.wb_regions = 'Brazil');
