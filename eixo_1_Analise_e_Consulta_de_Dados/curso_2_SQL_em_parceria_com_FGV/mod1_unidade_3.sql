-- Unidade 3

--Questão 1: Utilizando a tabela gdp_pc, selecione os países com menor PIB per capita em 2009.
SELECT * 
FROM gdp_pc gp 
WHERE gp.ref_year = 2009
ORDER BY gp.gdp_pc ASC
;

--Questão 2: Utilizando a tabela avg_income, selecione os países com menor renda per capita em 2009.
SELECT *
FROM avg_income ai 
WHERE ai.ref_year = 2009
ORDER BY ai.mean_usd ASC
LIMIT 5;
;

--Questão 3: Utilizando a tabela fertility, encontre os países com maior taxa de natalidade em 2009.
SELECT * FROM fertility f 
WHERE f.ref_year = 2009
ORDER BY f.mean_babies DESC
LIMIT 5
;

--Questão 4: Utilizando a tabela child_mortality, indique os países com a maior taxa de mortalidade infantil em 2009.
SELECT *
FROM child_mortality cm 
WHERE cm.ref_year = 2009
ORDER BY cm.tot_deaths DESC
LIMIT 5
;

--Questão 5: Utilizando a tabela womem_years_at_school, selecione os países com menor tempo médio na escola das mulheres de 25 anos em 2009.
SELECT * 
FROM women_years_at_school wyas 
WHERE wyas.ref_year = 2009
ORDER BY wyas.mean_years ASC
LIMIT 10
;

--Questão 6: Indique se há países em comum nos resultados das questões anteriores.
--Somália e Nigéria.


--Questão 7: Utilizando a tabela gdp_pc, selecione os 6 países com menor PIB per capita em 2009.
SELECT *
FROM gdp_pc gp 
WHERE gp.ref_year = 2009 
ORDER BY gp.gdp_pc ASC
LIMIT 6
;

--Questão 8: Utilizando a tabela life_expectancy, encontre os seis países com a menor expectativa de vida em 2009.
SELECT *
FROM life_expectancy le 
WHERE le.ref_year = 2009
ORDER BY le.tot_years ASC
LIMIT 6
;

--Questão 9: Sem apresentar linhas nulas, indique quais são as categorias do campo wb4income da tabela country.
SELECT DISTINCT(c.wb4income)
FROM country c 
WHERE c.wb4income IS NOT NULL
ORDER BY c.wb4income
;

--Questão 10: Selecione os cinco últimos países distintos, na ordem alfabética, da tabela population.
SELECT DISTINCT (p.country)
FROM population p 
ORDER BY p.country DESC
LIMIT 10
;
