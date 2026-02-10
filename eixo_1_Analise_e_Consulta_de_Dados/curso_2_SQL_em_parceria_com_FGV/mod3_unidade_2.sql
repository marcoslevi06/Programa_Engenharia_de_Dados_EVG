-- Questão 1: Calcule a renda máxima, a média e a mínima dos países enquadrados em cada uma das três classificações de 
-- renda do Banco Mundial (campo wb3income da tabela country) no ano de 2020. 
-- Ordene pela média da renda e utilize a tabela avg_income. Indique se os valores estão de acordo com a classificação.

--High income
--Middle income
--Low income
--wb3income

SELECT 
 	c.wb3income,
	MIN (ai.mean_usd) AS min_usd, 
	AVG (ai.mean_usd) AS avg_usd, 
	MAX (ai.mean_usd) AS max_usd
--	*
FROM avg_income ai 
INNER JOIN country c ON c.country = ai.country
WHERE ai.ref_year = 2020
GROUP BY c.wb3income
;

--Questão 2: Encontre a expectativa de vida média nas oito regiões segundo classificação da Gapminder 
--(campo eight_regions da tabela country) nos anos de 2019 a 2021. Utilize a tabela life_expectancy e ordene por região e ano.
--Indique se há alguma região em que NÃO houve declínio da expectativa de vida nestes três anos.

SELECT
	c.eight_regions, 
	le.ref_year as ano_ref,
	ROUND(AVG(le.tot_years),4) as media_expectativa_vida
--	NULL as div,
--	*
FROM life_expectancy le 
INNER JOIN country c ON c.country = le.country 
WHERE le.ref_year BETWEEN 2019 AND 2021
GROUP BY c.eight_regions, le.ref_year -- Primeiro agrupando pela região, depois agrupando pelo ano.
ORDER BY c.eight_regions ASC, le.ref_year DESC
;


--Questão 3: Consulte a tabela co2_emissions_pc e calcule a soma das emissões de CO2 pelas regiões da classificação 
--do Banco Mundial (campo wb_regions da tabela country) em 2022. Como a tabela co2_emissions_pc traz as emissões per capita,
--não se esqueça de multiplicar a emissão pela população (tabela population) antes de somar.
--Divida o resultado por 109 para convertê-lo em gigatoneladas e arredonde para duas casas decimais. 
--Ordene pelo total de emissões calculado, do maior para o menor.

SELECT
	c.wb_regions,
	ROUND((SUM(p.tot_pop * cep.co2_pc)/1E9), 2) as emissao_gigaTon -- Divide por 10⁹ para ter o valor em GigaToneladas.
--	NULL as div,
--	*
FROM co2_emissions_pc cep 
INNER JOIN country c ON c.country = cep.country
INNER JOIN population p ON p.country = c.country AND p.ref_year = 2022
WHERE cep.ref_year = 2022
GROUP BY c.wb_regions
ORDER BY emissao_gigaTon DESC
;

--Questão 4: Identifique as regiões, conforme a classificação do Banco Mundial (campo wb_regions da tabela country), 
--que em 2010 apresentaram uma média das taxas de mortalidade infantil consideradas baixas, de acordo com o Ministério da Saúde,
--ou seja, inferiores a 20. Para isso, utilize a tabela child_mortality e o campo tot_deaths, aplicando a cláusula HAVING.

SELECT
	c.wb_regions,
	cm.tot_deaths,
	ROUND(AVG(cm.tot_deaths), 4) AS avg_deaths
--*
FROM child_mortality cm 
INNER JOIN country c ON c.country = cm.country
WHERE cm.ref_year = 2010
GROUP BY c.wb_regions
HAVING avg_deaths < 20
;

--Questão 5: Compare a expectativa de vida mínima, média e máxima dos países da América Latina e do Caribe nos anos de 
--1990, 2000, 2010 e 2020. Indique se há alguma evolução ou se algum valor se destaca.
SELECT
	le.ref_year,
	AVG(le.tot_years) as media,
	MIN(le.tot_years) as minimo,
	MAX(le.tot_years) as maximo
--	*
FROM life_expectancy le 
INNER JOIN country c ON c.country = le.country 
WHERE le.ref_year IN(1990, 2000, 2010, 2020)
AND c.wb_regions = "Latin America & Caribbean"
GROUP BY le.ref_year
ORDER BY le.ref_year 
;

--Questão 6: Calcule novamente o PIB per capita médio e a renda per capita média de todos os países no ano de 2019. 
--Agora, você deve segmentar pelas quatro faixas de renda do Banco Mundial (campo wb4income da tabela country).
--Arredonde os resultados para duas casas decimais e ordene a média do PIB em ordem crescente.
--Indique se a classificação do Banco Mundial faz sentido tanto para PIB quanto para renda.

SELECT c.wb4income, 
	ROUND (AVG (gp.gdp_pc), 2) AS avg_gdp_pc, 
	ROUND (AVG (ai.mean_usd),  2) AS avg_mean_usd
FROM gdp_pc gp
INNER JOIN avg_income ai ON gp.country = ai.country 
	AND gp.ref_year = ai.ref_year
INNER JOIN country c ON gp.country = c.country
WHERE gp.ref_year = 2019
GROUP BY c.wb4income
ORDER BY avg_gdp_pc
;

--Questão 7: Calcule novamente a média de diferença de tempo na escola entre homens e mulheres no ano 2000. 
--Agora, você deve segmentar pela renda utilizando o campo wb4income. 
--Ordene pela média e verifique se há correlação entre renda e diferença de tempo na escola entre homens e mulheres.

SELECT c.wb4income, 
	AVG (m.mean_years- w.mean_years) AS avg_diff
FROM men_years_at_school m
INNER JOIN women_years_at_school w ON m.country = w.country 
	AND m.ref_year = w.ref_year
INNER JOIN country c ON m.country = w.country 
WHERE w.ref_year = 2000
GROUP BY c.wb4income
ORDER BY avg_diff
;


--Questão 8: Calcule novamente a média de diferença de tempo na escola entre homens e mulheres no ano 2000, 
--segmentando por região do Banco Mundial (wb_regions).
SELECT c.wb4income, 
	AVG (m.mean_years- w.mean_years) AS avg_diff
FROM men_years_at_school m
JOIN women_years_at_school w ON m.country = w.country 
	AND m.ref_year = w.ref_year
INNER JOIN country c ON m.country = c.country 
WHERE w.ref_year = 2000
GROUP BY c.wb4income
ORDER BY avg_diff