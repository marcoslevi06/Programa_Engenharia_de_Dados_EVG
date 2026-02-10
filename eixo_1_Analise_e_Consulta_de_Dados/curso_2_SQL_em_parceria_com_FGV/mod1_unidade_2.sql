-- UNIDADE 02 - OPERADORES ESPECIAIS E LÓGICOS.

-- Operadores lógicos or, and e not.
-- operadores is null, between, in e like, específicos do SQL.

-- Questão 01: Indique se há linhas com valores nulos no campo gdp_pc na tabela gdp_pc.
SELECT 
* 
FROM  gdp_pc gp
WHERE gp.gdp_pc IS NULL
;

-- Questão 02: Na tabela child_mortality, indique se há linhas com valores nulos no campo tot_deaths.
SELECT *
FROM child_mortality cm 
WHERE cm.tot_deaths IS NULL
;

-- Questão 03: Segundo o Ministério da Saúde, as taxas de mortalidade infantil (TMI) são classificadas em altas (50 ou mais), médias (20-49) e baixas (menos de 20). Utilizando a tabela child_mortality e o campo tot_deaths, encontre todos os países que alcançaram taxas de mortalidade baixas com uma variação de 5%, ou seja, com valor de 20±5%. Indique em que ano o Brasil atingiu essa TMI.
-- 5% é o equivalente há 5/100 = 0.05
SELECT *
FROM child_mortality cm 
WHERE cm.tot_deaths BETWEEN 20 - (20 * 0.05) AND 20 + (20 * 0.05) -- Betwen usa intervalo fechado, ou seja, dados inclusos.
AND cm.country = "Brazil"
;

-- Questão 04: Utilizando a tabela life_expectancy e o campo tot_years, indique qual a expectativa de vida do brasileiro nos anos de 2019 a 2023. Liste os valores, observe o que ocorreu e comente as prováveis causas.
SELECT *
FROM life_expectancy le 
WHERE le.ref_year BETWEEN 2019 AND 2023
AND le.country = "Brazil"
;

-- Questão 05: Utilizando a tabela population, selecione os países cuja população ultrapassou 200 milhões de habitantes em 2023. Use notação científica para representar a população na consulta e indique a população de cada país selecionado nos resultados.
SELECT *
FROM population p
WHERE p.tot_pop > (2e8) -- 200.000.00- Equivale a 2 * 10⁸
AND p.ref_year = 2023
;


-- Questão 06: Utilizando a tabela co2_emissions_pc, indique as emissões de CO2 no Brasil, na China e nos Estados Unidos, de 2019 a 2021. Compartilhe as suas observações sobre a pesquisa.
SELECT * 
FROM co2_emissions_pc cep 
WHERE cep.country in ("Brazil", "China", "USA")
AND cep.ref_year BETWEEN 2019 and 2021
;

-- Questão 07: Utilizando a tabela country, selecione os países europeus de renda média baixa. Use a classificação Gapminder de oito regiões geográficas (campo eight_regions com valor europe_east e europe_west), para verificar os países, e a classificação de quatro faixas de renda do Banco Mundial (campo wb4income com o valor Lower middle income), para verificar a renda. Indique se todos os países são do leste europeu.
SELECT 
* 
FROM country c 
WHERE c.wb4income = "Lower middle income"
AND c.eight_regions IN ("europe_east", "europe_west") 
;

-- Questão 08: Utilizando a tabela co2_emissions_pc e o operador IN, indique as emissões de CO2 no Brasil, na China e nos Estados Unidos, de 2019 a 2021. Compartilhe as suas observações sobre a pesquisa.
SELECT *
FROM co2_emissions_pc pc
WHERE pc.country in ("Brazil", "USA", "China") 
AND pc.ref_year BETWEEN 2019 AND 2021
;

-- Questão 09: Utilizando a tabela country e o operador IN, selecione os países europeus de renda média baixa. Use a classificação Gapminder de 8 regiões geográficas (campo eight_regions com valor europe_east e europe_west), para verificar os países, e a classificação de 4 faixas de renda do Banco Mundial (campo wb4income com o valor Lower middle income), para verificar a renda. Indique se todos os países são do leste europeu.
SELECT 
    country, 
    eight_regions, 
    wb4income 
FROM country c 
WHERE c.wb4income = 'Lower middle income'
  AND c.eight_regions IN ('europe_east', 'europe_west');


-- Questão 10: Utilizando a tabela country, selecione os países do continente asiático segundo a classificação de oito regiões (coluna eight_regions). Além da coluna country, traga as colunas eight_regions e wb_regions para comparação.
SELECT 
    country, 
    eight_regions, 
    wb_regions 
FROM country c 
WHERE c.eight_regions IN ('asia_east', 'asia_west', 'south_asia', 'central_asia')
ORDER BY eight_regions, country;


-- Questão 11: Pesquise os países das Américas, segundo a classificação do Banco Mundial (coluna wb_regions), utilizando o operador LIKE.
SELECT 
    country, 
    wb_regions 
FROM country c 
WHERE c.wb_regions LIKE '%America%'
ORDER BY wb_regions, country;
