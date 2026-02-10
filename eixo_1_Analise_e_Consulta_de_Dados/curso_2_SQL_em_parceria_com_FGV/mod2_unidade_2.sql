--Questão 1: Pesquise a taxa de mortalidade infantil e de natalidade nos seis menores países da Europa, 
--em termos de extensão territorial (Andorra, Liechtenstein, Malta, Mônaco, San Marino e Vaticano – Holy See), 
--no ano 2000. Utilize as tabelas child_mortality e fertility, nesta ordem, e inclua na consulta os campos tot_deaths e mean_babies. 
--Para isso, utilize a cláusula LEFT JOIN.

SELECT * FROM child_mortality cm ORDER BY cm.tot_deaths DESC LIMIT 6;
SELECT * FROM fertility f ORDER BY f.mean_babies DESC LIMIT 6;

SELECT 
--	*
	c.country as país,
	cm.ref_year as ano_de_referencia,
	cm.tot_deaths as mortalidade_infantil,
	f.mean_babies as taxa_de_natalidade
FROM country c 
	LEFT JOIN child_mortality cm ON c.country = cm.country 	AND cm.ref_year = 2000
	LEFT JOIN fertility f ON c.country = f.country 			AND f.ref_year = 2000
WHERE c.country IN ("Andorra",
					"Liechtenstein",
					"Malta", 
					"Monaco",
					"San Marino",
					"Holy See") -- Holy See corresponde ao Vaticano.
;


--Questão 2: Pesquise novamente a taxa de mortalidade infantil e de natalidade nos seis menores países da Europa, 
--em termos de extensão territorial, no ano 2000, utilizando as tabelas child_mortality e fertility, nesta ordem, e 
--incluindo na consulta os campos tot_deaths e mean_babies. Além disso, inclua a população total dos países. 
--Para isso, execute dois LEFT JOINs.
SELECT 
	cm.country as país,
	cm.ref_year as ano_de_referencia,
	cm.tot_deaths as mortalidade_infantil,
	f.mean_babies as taxa_de_natalidade,
	p.tot_pop as populacao_total
FROM child_mortality cm 
	LEFT JOIN fertility f ON cm.country = f.country AND f.ref_year = 2000
	LEFT JOIN population p ON cm.country = p.country AND p.ref_year = 2000
WHERE cm.country IN ("Andorra",
					"Liechtenstein",
					"Malta", 
					"Monaco",
					"San Marino",
					"Holy See") -- Holy See corresponde ao Vaticano.
AND cm.ref_year = 2000
;

--Questão 3: Pesquise novamente a taxa de mortalidade infantil e de natalidade nos seis menores países da Europa, 
--em termos de extensão territorial, no ano 2000. Agora, você deve executar INNER JOIN entre child_mortality 
--e population e LEFT JOIN entre child_mortality e fertility. Explique se esta operação muda o resultado.

SELECT 
--*
	cm.country as país,
	cm.ref_year as ano_de_referencia,
	cm.tot_deaths as mortalidade_infantil,
	f.mean_babies as taxa_de_natalidade,
	p.tot_pop as populacao_total
FROM child_mortality cm 
INNER JOIN population p ON cm.country = p.country AND p.ref_year = 2000
LEFT JOIN fertility f ON cm.country = f.country AND f.ref_year = 2000
WHERE cm.country IN (
					"Andorra",
					"Liechtenstein",
					"Malta", 
					"Monaco",
					"San Marino",
					"Holy See"	-- Holy See corresponde ao Vaticano.
					) 
AND cm.ref_year = 2000
;


--Questão 4: Pesquise novamente a taxa de mortalidade infantil e de natalidade nos seis menores países da Europa, 
--em termos de extensão territorial, no ano 2000. Agora, você deve inverter a ordem das tabelas: utilize primeiro a
--tabela fertility e, em seguida, child_mortality. Na sequência, utilize a cláusula RIGHT JOIN. 
--Explique se esta operação muda o resultado.
-- Não, mantém-se o mesmo resultado.
SELECT 
    cm.country AS país,
    cm.ref_year AS ano_de_referencia,
    cm.tot_deaths AS mortalidade_infantil,
    f.mean_babies AS taxa_de_natalidade
FROM fertility f
RIGHT JOIN child_mortality cm ON f.country = cm.country AND f.ref_year = cm.ref_year
WHERE cm.country IN ('Andorra', 'Liechtenstein', 'Malta', 'Monaco', 'San Marino', 'Holy See')
  AND cm.ref_year = 2000
;


--Questão 5: Consulte a taxa de mortalidade infantil e de natalidade, no ano 2000, de algumas ilhas caribenhas:
-- Aruba, Cuba, Dominica, Martinica (Martinique) e Porto Rico (Puerto Rico). Use as tabelas fertility e child_mortality. 
-- Observe que é necessário utilizar um FULL JOIN para retornar todos os países na consulta.
SELECT * FROM child_mortality cm WHERE cm.country IN ("Aruba", "Cuba", "Dominica", "Martinique", "Puerto Rico") AND cm.ref_year = 2000;
SELECT * FROM fertility f WHERE f.country IN ("Aruba", "Cuba", "Dominica", "Martinique", "Puerto Rico") AND f.ref_year = 2000;

SELECT *
FROM child_mortality cm 
FULL JOIN fertility f ON cm.country = f.country AND cm.ref_year = f.ref_year
	WHERE(cm.country IN ("Aruba", "Cuba", "Dominica", "Martinique", "Puerto Rico") 
			OR
		f.country IN ("Aruba", "Cuba", "Dominica", "Martinique", "Puerto Rico")
		)
	AND (cm.ref_year = 2000 OR f.ref_year = 2000)
;