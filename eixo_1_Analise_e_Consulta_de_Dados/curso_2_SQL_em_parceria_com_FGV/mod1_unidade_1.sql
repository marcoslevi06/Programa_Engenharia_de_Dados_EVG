
-- Selecione todas as colunas e linhas de uma determinada tabela.
SELECT * 	
	FROM co2_emissions_pc cep 
	WHERE cep.country = "Brazil"
;

-- Tipos de Data.
-- Data simples: '2000-01-01'
-- Data Tempo: '23:12:15.123'
-- timestamp: '2023-12-01 23:12:15.123'

-- Operadores.
-- <> ou != (Ambos os formatos equivalem a DIFERENTE DE)

SELECT 
	p.country as país,
	p.ref_year as ano_referencia,
	p.tot_pop as populacao_total
FROM population p 
WHERE p.tot_pop > 100000000 -- População maior que 100 milhões.
--LIMIT 5
;


-- QUESTÕES UNIDADE 01.
-- Questão 01: Selecione, da tabela co2_emissions_pc, todos os países e anos cuja emissão seja igual a 0,2. Observe que os dados estão no formato americano, no qual o . (ponto) é o separador de decimais. Indique se os países Guatemala e Lituânia estão na lista.
SELECT 
	cep.country as pais,
	cep.ref_year as ano_referencia,
	cep.co2_pc as emissao_co2
FROM co2_emissions_pc cep 
WHERE cep.co2_pc = 0.2
AND cep.country in ("Guatemala", "Lithuania")
;

-- Questão 02: Selecione, da tabela country, a classificação de quatro e oito regiões e das quatro categorias de renda do Banco Mundial para o Brasil.
SELECT 
	c.country,
	c.four_regions,
	c.eight_regions,
	c.wb4income
FROM country c
WHERE c.country = "Brazil"
;

-- Questão 03: Selecione, da tabela country, o nome de todos os países com a classificação de renda do Banco Mundial em três níveis (coluna wb3income) igual a Middle income. Indique se a China, a Indonésia e a Malásia estão na lista.
SELECT *
FROM country c 
WHERE c.wb3income = "Middle income"
--AND c.country IN ("China")
;

-- Questão 04: Selecione, da tabela gdp_pc, o PIB per capita dos países no ano de 2017. Indique qual o valor de Mônaco.
SELECT 
*
FROM gdp_pc gp 
WHERE gp.ref_year = 2017
AND gp.country = "Monaco"
;


-- Questão 05: Selecione, da tabela life_expectancy, os países e anos de referência cuja expectativa de vida ao nascer era de 36.5 anos. Indique quais foram os anos em que os nascidos no Chile tinham esta expectativa de vida.
SELECT 
*
FROM life_expectancy le 
WHERE le.tot_years = 36.5
AND le.country = "Chile"
;

-- Questão 06: Utilizando a tabela petrobras e o campo Close para fazer a sua pesquisa, indique qual o preço de fechamento das ações da Petrobras no dia 8 de dezembro de 2022.
SELECT * 
FROM petrobras p 
WHERE p.Date = "2022-12-08" 
;

-- Questão 07: Utilizando a tabela gdp_pc, indique qual país tem PIB per capita menor do que 400 dólares.
SELECT 
*
FROM gdp_pc gp 
WHERE gp.gdp_pc < 400 -- PIB
;

-- Questão 08: Utilizando a tabela life_expectancy, indique os dois países que têm projeção de expectativa de vida acima de 94 anos.
SELECT *
FROM life_expectancy le 
WHERE le.tot_years > 94
;

-- Questão 09: Selecione todas as linhas da tabela petrobras com o valor de Close diferente de Adj Close. Indique se este evento aconteceu no dia 16 de agosto de 2000.
SELECT * 
FROM petrobras p 
WHERE p."Adj Close" <> p."Close" 
AND p.Date = "2000-08-16"
;