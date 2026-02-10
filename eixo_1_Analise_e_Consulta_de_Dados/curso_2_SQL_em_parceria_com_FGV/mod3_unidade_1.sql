--Questão 1: Calcule o preço médio das ações, nomeando este campo como mean, e a amplitude diária de variação, 
--que será chamada de range, para o período de 20 de fevereiro de 2020 a 20 de março de 2020. Mostre apenas os dados 
--dos dias com variação positiva. O preço médio pode ser calculado utilizando a fórmula (Close + Open)/2, 
--enquanto a amplitude de variação é obtida por meio da diferença Close - Open.

SELECT 
	p.Date,
	p."Open" ,
	p."Close" ,
	p."Close" - p."Open" as range,
	(p."Close" + p."Open")/2 as mean
FROM petrobras p 
WHERE p.Date BETWEEN "2020-02-20" AND "2020-03-20"
--AND range > 0
AND p."Close" - p."Open" > 0
;

--Questão 2: Identifique os países da África nos quais as mulheres possuem pelo menos um ano a mais de escolaridade do que os 
--homens durante o período de 2001 a 2010. Apresente apenas os nomes dos países, sem repetições.

SELECT 
	myas.country,
	myas.ref_year,
	wyas.mean_years as mean_woman_years,
	myas.mean_years as mean_men_years,
	(wyas.mean_years - myas.mean_years) as dif_mean_years
FROM women_years_at_school wyas 
INNER JOIN men_years_at_school myas ON wyas.country = myas.country AND wyas.ref_year = myas.ref_year
INNER JOIN country c ON wyas.country = c.country AND c.four_regions = "africa"
	WHERE wyas.ref_year BETWEEN 2001 and 2010
	AND (mean_woman_years - mean_men_years > 1)
	GROUP BY wyas.country
;


--Questão 3: Consulte novamente a taxa de mortalidade infantil do Brasil em porcentagem, 
--sem utilizar o operador IN para listar os anos, mas realizando um cálculo que inclua o período de 1910 a 2020 
--em intervalos de 10 anos.

SELECT 
*
FROM child_mortality cm 
WHERE cm.country = "Brazil"
AND cm.ref_year % 10 = 0
AND cm.ref_year BETWEEN 1910 AND 2020
;

--Questão 4: Indique a expectativa de vida mínima, média e máxima dos países da América Latina e do Caribe em 1990. 
--Use a tabela life_expectancy para encontrar os valores e o campo wb_regions com o valor Latin America & Caribbean 
--para definir a região.

SELECT
--	*
	MAX(le.tot_years) as max,
	MIN(le.tot_years) as min,
	AVG(le.tot_years) as media
FROM life_expectancy le 
INNER JOIN country c ON c.country = le.country AND c.wb_regions = "Latin America & Caribbean"
WHERE le.ref_year = 1990
;

--Questão 5: Calcule o PIB per capita médio e a renda per capita média dos países no ano de 2019. 
--Utilize as tabelas avg_income e gdp_pc, e arredonde o resultado para duas casas decimais.


SELECT 
	ROUND(AVG(ai.mean_usd), 2) as renda_media,
	ROUND(AVG(gp.gdp_pc), 2) as pib_per_capita
FROM avg_income ai 
INNER JOIN gdp_pc gp ON gp.country = ai.country AND gp.ref_year = 2019
WHERE ai.ref_year = 2019
;

--Questão 6: Calcule a média de diferença de tempo na escola entre homens e mulheres no ano 2000. 
--Utilize as tabelas men_years_at_school e women_years_at_school.

SELECT 
	wyas.mean_years as media_mulheres,
	myas.mean_years as media_homens,
	(myas.mean_years - wyas.mean_years) as dif_homens_mulheres,
	ROUND(AVG(myas.mean_years - wyas.mean_years), 4) as media_diferenca
FROM women_years_at_school wyas 
INNER JOIN men_years_at_school myas ON myas.country = wyas.country AND myas.ref_year = wyas.ref_year 
WHERE wyas.ref_year = 2000
;