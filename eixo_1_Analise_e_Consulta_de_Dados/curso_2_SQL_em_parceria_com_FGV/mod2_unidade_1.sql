-- Módulo 02

--Questão 1: Utilizando a tabela country, o campo four_regions igual a asia e a tabela man_years_at_school, 
--encontre os cinco países asiáticos cujos homens de 25 anos passaram menos tempo na escola em 2009.
SELECT * 
FROM country c
INNER JOIN men_years_at_school myas ON c.country = myas.country
WHERE c.four_regions = "asia"
AND myas.ref_year = 2009
ORDER BY myas.mean_years ASC
LIMIT 5
;

--Questão 2: Utilizando o campo wb3income e o campo wb_regions da tabela country, além da tabela avg_income, 
--liste os 10 países de maior renda per capita diária no ano de 1985, além da região e da classificação de três rendas, 
--ambos do Banco Mundial.
SELECT
c.country, c.four_regions, c.wb3income, c.wb_regions, ai.mean_usd
FROM country c
INNER JOIN avg_income ai ON ai.country = c.country
WHERE ai.ref_year = 1985
ORDER BY ai.mean_usd DESC
LIMIT 10
;

--Questão 3: Selecione, apenas para o Brasil, os dados de renda per capita diária, PIB, população, mortalidade infantil, 
--fertilidade e expectativa de vida, abrangendo o período de 1900 a 2020, a cada 10 anos (1900, 1910, 1920, ..., 2020).

SELECT 
	c.country as país,
	gp.gdp_pc as pib_per_capita,
	p.tot_pop as populacao,
	cm.tot_deaths as mortalidade_infantil,
	f.mean_babies as fertilidade,
	le.tot_years as expectativa_de_vida
FROM country c 
	INNER JOIN gdp_pc gp ON c.country = gp.country
	INNER JOIN population p ON c.country = p.country
	INNER JOIN child_mortality cm ON c.country = cm.country 
	INNER JOIN fertility f ON c.country = f.country 
	INNER JOIN life_expectancy le ON c.country = le.country 
WHERE c.country = "Brazil"
	AND gp.ref_year BETWEEN 1900 AND 2020
	AND gp.ref_year % 10 = 0      -- Defino o intervalo de tempo a ser buscado. 
	AND gp.ref_year = p.ref_year  -- Aqui amarro a equivalência entre os anos de PIB e População.
	AND gp.ref_year = cm.ref_year -- Aqui amarro a equivalência entre os anos de PIB e mortalidade infantil.
	AND gp.ref_year = f.ref_year --  Aqui amarro a equivalência entre os anos de PIB e fertilidade. 
	AND gp.ref_year = le.ref_year -- Aqui amarro a equivalência entre os anos de PIB e expectativa de vida.
;

--Questão 4: A partir da tabela country, com o campo four_regions igual a asia, e da tabela man_years_at_school, 
--encontre os cinco países asiáticos cujos homens de 25 anos passaram menos tempo na escola em 2009, 
--utilizando a cláusula NATURAL JOIN. Confira se os resultados foram iguais aos obtidos na questão 1.

--As respostas foram semelhantes, mas ele não trouxe novamente a coluna "country", presente na consulta com INNER. Isso utilizando o SELECT *
--para outros campos pedidos de modo explícito, ele traz o mesmo resultado.
SELECT * 
FROM country c
NATURAL JOIN men_years_at_school myas
WHERE c.four_regions = "asia"
AND myas.ref_year = 2009
ORDER BY myas.mean_years ASC
LIMIT 5
;


--Questão 5: Selecione, apenas para o Brasil, os dados de renda per capita diária, PIB, população, mortalidade infantil, 
--fertilidade e expectativa de vida, abrangendo o período de 1900 a 2020, a cada 10 anos (1900, 1910, 1920, ..., 2020), 
--utilizando a cláusula NATURAL JOIN. Confira se os resultados foram iguais aos obtidos na questão 3.
-- Ambas retornam o mesmo resultado.
SELECT 
	c.country as país,
	gp.gdp_pc as pib_per_capita,
	p.tot_pop as populacao,
	cm.tot_deaths as mortalidade_infantil,
	f.mean_babies as fertilidade,
	le.tot_years as expectativa_de_vida
FROM country c 
	NATURAL JOIN gdp_pc gp 
	NATURAL JOIN population p 
	NATURAL JOIN child_mortality cm
	NATURAL JOIN fertility f 
	NATURAL JOIN life_expectancy le
WHERE c.country = "Brazil"
	AND gp.ref_year BETWEEN 1900 AND 2020
	AND gp.ref_year % 10 = 0      -- Defino o intervalo de tempo a ser buscado. 
	AND gp.ref_year = p.ref_year  -- Aqui amarro a equivalência entre os anos de PIB e População.
	AND gp.ref_year = cm.ref_year -- Aqui amarro a equivalência entre os anos de PIB e mortalidade infantil.
	AND gp.ref_year = f.ref_year --  Aqui amarro a equivalência entre os anos de PIB e fertilidade. 
	AND gp.ref_year = le.ref_year -- Aqui amarro a equivalência entre os anos de PIB e expectativa de vida.
;